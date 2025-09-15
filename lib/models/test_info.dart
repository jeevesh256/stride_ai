import 'package:flutter/material.dart';

class TestInfo {
  final String title;
  final String type;
  final String description;
  final String instructions;
  final IconData icon;

  const TestInfo({
    required this.title,
    required this.type,
    required this.description,
    required this.instructions,
    this.icon = Icons.fitness_center,
  });
}
