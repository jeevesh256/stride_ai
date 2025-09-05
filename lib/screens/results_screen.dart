import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'test_library_screen.dart';
import 'dashboard_screen.dart';

class ResultsScreen extends StatelessWidget {
  final TestInfo test;
  final int reps;
  final Duration duration;

  const ResultsScreen({
    super.key,
    required this.test,
    required this.reps,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Results',
          style: GoogleFonts.montserrat(),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Summary card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Great job! 🎉',
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'You did $reps ${test.name} in ${duration.inMinutes} min',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Above average for your age group',
                      style: GoogleFonts.montserrat(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Performance graph
            SizedBox(
              height: 200,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progress',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: LineChart(
                          LineChartData(
                            gridData: const FlGridData(show: false),
                            titlesData: const FlTitlesData(show: false),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  const FlSpot(0, 20),
                                  const FlSpot(1, 22),
                                  const FlSpot(2, 25),
                                  const FlSpot(3, 22),
                                  FlSpot(4, reps.toDouble()),
                                ],
                                isCurved: true,
                                color: Theme.of(context).colorScheme.primary,
                                barWidth: 4,
                                dotData: const FlDotData(show: false),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TestLibraryScreen(),
                        ),
                      );
                    },
                    child: const Text('Try Again'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardScreen(),
                        ),
                      );
                    },
                    child: const Text('Done'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
