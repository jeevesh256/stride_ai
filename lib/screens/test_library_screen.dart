import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/test_info.dart';
import 'test_instructions_screen.dart';

class TestLibraryScreen extends StatelessWidget {
  const TestLibraryScreen({super.key});

  static const List<TestInfo> tests = [
    TestInfo(
      title: 'Push-ups',
      type: 'upper_body',
      description: 'Test your upper body strength',
      instructions: 'Do as many push-ups as you can with proper form',
    ),
    TestInfo(
      title: 'Sit-ups',
      type: 'core',
      description: 'Test your core strength',
      instructions: 'Do as many sit-ups as you can in 1 minute',
    ),
    TestInfo(
      title: 'Vertical Jump',
      type: 'lower_body',
      description: 'Measure your explosive leg power',
      instructions: 'Jump as high as you can from a standing start',
    ),
    TestInfo(
      title: 'Shuttle Run',
      type: 'agility',
      description: 'Test your agility and speed',
      instructions: 'Run back and forth between two points as quickly as possible',
    ),
    TestInfo(
      title: 'Endurance Run',
      type: 'cardiovascular',
      description: '12-minute Cooper test for cardiovascular fitness',
      instructions: 'Run as far as possible in 12 minutes',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test Library',
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0, // Changed for better fit
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: tests.length,
        itemBuilder: (context, index) {
          return _TestCard(test: tests[index]);
        },
      ),
    );
  }
}

class _TestCard extends StatelessWidget {
  final TestInfo test;

  const _TestCard({required this.test});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TestInstructionsScreen(test: test),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                test.icon,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                test.title,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Flexible(
                child: Text(
                  test.description,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
