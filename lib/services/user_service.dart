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

  Future<bool> login(String email, String password) async {
    final users = await _readUsers();
    final user = users.firstWhere(
      (u) => u.email == email && u.password == password,
      orElse: () => User(email: '', password: '', name: ''),
    );
    if (user.email.isNotEmpty) {
      currentUser = user;
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

  void logout() {
    currentUser = null;
    _userController.add(null);
  }

  void dispose() {
    _userController.close();
  }
}
