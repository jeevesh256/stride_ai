import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/test_activity.dart';

class ActivityService {
  static const String _storageKey = 'test_activities';
  static final ActivityService _instance = ActivityService._internal();
  
  factory ActivityService() => _instance;
  ActivityService._internal();

  Future<void> addActivity(TestActivity activity) async {
    final prefs = await SharedPreferences.getInstance();
    final activities = await getActivities();
    activities.insert(0, activity);
    
    // Keep only last 10 activities
    if (activities.length > 10) {
      activities.removeLast();
    }
    
    await prefs.setString(_storageKey, jsonEncode(
      activities.map((a) => a.toJson()).toList(),
    ));
  }

  Future<List<TestActivity>> getActivities() async {
    final prefs = await SharedPreferences.getInstance();
    final String? activitiesJson = prefs.getString(_storageKey);
    
    if (activitiesJson == null) return [];
    
    final List<dynamic> decoded = jsonDecode(activitiesJson);
    return decoded
        .map((json) => TestActivity.fromJson(json))
        .toList();
  }

  String getAchievement(int reps, String testType) {
    if (reps >= 30) return 'Elite';
    if (reps >= 25) return 'Advanced';
    if (reps >= 20) return 'Intermediate';
    if (reps >= 15) return 'Beginner';
    return 'Novice';
  }
}
