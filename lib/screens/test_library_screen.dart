import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'test_execution_screen.dart';

class TestLibraryScreen extends StatelessWidget {
  const TestLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tests = [
      TestInfo(
        name: 'Sit-ups',
        description: 'Test your core strength with proper form',
        icon: Icons.fitness_center,
      ),
      TestInfo(
        name: 'Vertical Jump',
        description: 'Measure your explosive leg power',
        icon: Icons.height,
      ),
      TestInfo(
        name: 'Shuttle Run',
        description: 'Test your agility and speed',
        icon: Icons.directions_run,
      ),
      TestInfo(
        name: 'Endurance Run',
        description: '12-minute Cooper test for cardiovascular fitness',
        icon: Icons.timer,
      ),
    ];

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

class TestInfo {
  final String name;
  final String description;
  final IconData icon;

  TestInfo({
    required this.name,
    required this.description,
    required this.icon,
  });
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
              builder: (context) => TestExecutionScreen(test: test),
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
                test.name,
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
