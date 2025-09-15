import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/user.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  static const String _fileName = 'users.json';
  static const String _currentUserFile = 'current_user.json';
  static User? currentUser;
  final _userController = StreamController<User?>.broadcast();
  Stream<User?> get userStream => _userController.stream;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  Future<List<User>> _readUsers() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        return [];
      }
      final contents = await file.readAsString();
      final List<dynamic> jsonList = json.decode(contents);
      return jsonList.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> _writeUsers(List<User> users) async {
    final file = await _localFile;
    final jsonList = users.map((user) => user.toJson()).toList();
    await file.writeAsString(json.encode(jsonList));
  }

  Future<void> initializeCurrentUser() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_currentUserFile');

      if (await file.exists()) {
        final contents = await file.readAsString();
        final userData = json.decode(contents);
        currentUser = User.fromJson(userData);
        _userController.add(currentUser);
      }
    } catch (e) {
      print('Error loading current user: $e');
    }
  }

  Future<void> _saveCurrentUser(User user) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_currentUserFile');
      await file.writeAsString(json.encode(user.toJson()));
    } catch (e) {
      print('Error saving current user: $e');
    }
  }

  Future<bool> login(String email, String password) async {
    final users = await _readUsers();
    final user = users.firstWhere(
      (u) => u.email == email && u.password == password,
      orElse: () => User(email: '', password: '', name: ''),
    );
    if (user.email.isNotEmpty) {
      currentUser = user;
      await _saveCurrentUser(user); // Save current user
      _userController.add(user);
      return true;
    }
    return false;
  }

  Future<bool> register(User user) async {
    final users = await _readUsers();
    if (users.any((u) => u.email == user.email)) {
      return false;
    }
    users.add(user);
    await _writeUsers(users);
    return true;
  }

  Future<void> updateUser(User user) async {
    final users = await _readUsers();
    final index = users.indexWhere((u) => u.email == user.email);
    if (index != -1) {
      users[index] = user;
      await _writeUsers(users);
      currentUser = user;
      _userController.add(user);
    }
  }

  void logout() async {
    currentUser = null;
    _userController.add(null);
    // Delete the current user file
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_currentUserFile');
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Error deleting current user: $e');
    }
  }

  void dispose() {
    _userController.close();
  }
}
