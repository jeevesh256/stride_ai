import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressHistoryScreen extends StatelessWidget {
  const ProgressHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Progress History',
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Performance Graph
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Monthly Progress',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 20),
                              FlSpot(1, 22),
                              FlSpot(2, 25),
                              FlSpot(3, 22),
                              FlSpot(4, 28),
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
          const SizedBox(height: 24),

          // Past Attempts
          Text(
            'Past Attempts',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _PastAttemptCard(
            testName: 'Sit-ups',
            result: '28 reps',
            date: 'Today',
            improvement: '+3 from last attempt',
            isImproved: true,
          ),
          _PastAttemptCard(
            testName: 'Sit-ups',
            result: '25 reps',
            date: '2 days ago',
            improvement: '+3 from last attempt',
            isImproved: true,
          ),
          _PastAttemptCard(
            testName: 'Sit-ups',
            result: '22 reps',
            date: '5 days ago',
            improvement: '-2 from last attempt',
            isImproved: false,
          ),
          _PastAttemptCard(
            testName: 'Vertical Jump',
            result: '45 cm',
            date: '1 week ago',
            improvement: 'First attempt',
            isImproved: true,
          ),
        ],
      ),
    );
  }
}

class _PastAttemptCard extends StatelessWidget {
  final String testName;
  final String result;
  final String date;
  final String improvement;
  final bool isImproved;

  const _PastAttemptCard({
    required this.testName,
    required this.result,
    required this.date,
    required this.improvement,
    required this.isImproved,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testName,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: GoogleFonts.montserrat(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  result,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  improvement,
                  style: GoogleFonts.montserrat(
                    color: isImproved ? Colors.green : Colors.red,
                    fontSize: 12,
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
