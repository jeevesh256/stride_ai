import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/test_info.dart';
import 'sport_detail_screen.dart';
import 'results_screen.dart';

class TestCompletionScreen extends StatelessWidget {
  final TestInfo test;
  final int reps;
  final Duration duration;

  const TestCompletionScreen({
    super.key,
    required this.test,
    required this.reps,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                size: 100,
                color: Colors.green,
              ),
              const SizedBox(height: 24),
              Text(
                'Great Job!',
                style: GoogleFonts.montserrat(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You\'ve completed ${test.title}',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestExecutionScreen(test: test),
                        ),
                      ),
                      child: const Text('Try Again'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultsScreen(
                            test: test,
                            reps: reps,
                            duration: duration,
                          ),
                        ),
                      ),
                      child: const Text('View Results'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
