import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'test_execution_screen.dart';
import '../models/test_info.dart';
import 'sports_screen.dart';

class SportDetailScreen extends StatelessWidget {
  final SportCategory sport;

  const SportDetailScreen({super.key, required this.sport});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          sport.name,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sport.tests.length,
        itemBuilder: (context, index) {
          final test = sport.tests[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: Icon(sport.icon),
              title: Text(
                test,
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TestExecutionScreen(
                      test: TestInfo(
                        title: test,
                        description: 'Detailed analysis of $test performance',
                        difficulty: 'Intermediate',
                        duration: const Duration(minutes: 5),
                        equipment: const ['Camera'],
                        category: sport.name,
                        icon: sport.icon, // Add icon from sport category
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
