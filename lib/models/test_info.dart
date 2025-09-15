import 'package:flutter/material.dart';

class TestInfo {
  final String title;
  final String description;
  final String difficulty;
  final Duration duration;
  final List<String> equipment;
  final String category;
  final IconData icon; // Add icon field

  const TestInfo({
    required this.title,
    required this.description,
    required this.difficulty,
    required this.duration,
    required this.equipment,
    required this.category,
    required this.icon,
  });
}
