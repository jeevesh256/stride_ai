import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/sports_screen.dart';

class TestProgressService {
  static final TestProgressService _instance = TestProgressService._internal();
  factory TestProgressService() => _instance;
  TestProgressService._internal();

  static const String _storageKey = 'completed_tests';

  Future<void> markTestComplete(String sport, String testName) async {
    final prefs = await SharedPreferences.getInstance();
    final completed = await getCompletedTests();
    
    if (!completed.containsKey(sport)) {
      completed[sport] = [];
    }
    if (!(completed[sport] as List).contains(testName)) {
      completed[sport].add(testName);
    }
    
    await prefs.setString(_storageKey, jsonEncode(completed));
  }

  Future<Map<String, dynamic>> getCompletedTests() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_storageKey);
    return data != null ? jsonDecode(data) : {};
  }

  Future<double> getSportProgress(String sportName) async {
    final completed = await getCompletedTests();
    if (!completed.containsKey(sportName)) return 0.0;
    
    final completedTests = (completed[sportName] as List).length;
    final totalTests = sportCategories.firstWhere(
      (s) => s.name == sportName,
      orElse: () => SportCategory(name: '', icon: Icons.error, tests: []),
    ).tests.length;
    
    return totalTests > 0 ? completedTests / totalTests : 0.0;
  }

  Future<bool> isTestCompleted(String sport, String testName) async {
    final completed = await getCompletedTests();
    return completed.containsKey(sport) && 
           (completed[sport] as List).contains(testName);
  }
}
