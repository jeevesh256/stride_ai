import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'test_library_screen.dart';
import 'dashboard_screen.dart';
import '../models/test_info.dart';
import '../models/test_activity.dart';
import '../services/activity_service.dart';
import '../services/test_progress_service.dart';

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

  String _getPerformanceLevel(int reps) {
    // Example thresholds - should be adjusted per exercise type and age group
    if (reps >= 30) return 'Elite';
    if (reps >= 25) return 'Advanced';
    if (reps >= 20) return 'Intermediate';
    if (reps >= 15) return 'Beginner';
    return 'Novice';
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case 'Elite':
        return Colors.purple;
      case 'Advanced':
        return Colors.blue;
      case 'Intermediate':
        return Colors.green;
      case 'Beginner':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  Future<void> _saveActivity() async {
    final activity = TestActivity(
      title: test.title,
      reps: reps,
      achievement: _getPerformanceLevel(reps),
      time: DateTime.now(),
      testType: test.category,
    );
    await ActivityService().addActivity(activity);
    await TestProgressService().markTestComplete(test.category, test.title);
  }

  @override
  Widget build(BuildContext context) {
    final performanceLevel = _getPerformanceLevel(reps);
    final levelColor = _getLevelColor(performanceLevel);

    return Scaffold(
      appBar: AppBar(
        title: Text('Test Results', style: GoogleFonts.montserrat()),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Performance Summary Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Test Complete! 🎉',
                        style: GoogleFonts.montserrat(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatCard('Reps', '$reps', Icons.fitness_center),
                          _buildStatCard('Time',
                              '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}', Icons.timer),
                          _buildStatCard('Pace', '${(reps / duration.inMinutes).toStringAsFixed(1)}/min', Icons.speed),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Performance Level Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Performance Analysis',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: levelColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: levelColor),
                            ),
                            child: Text(
                              performanceLevel,
                              style: GoogleFonts.montserrat(
                                color: levelColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildPerformanceTable(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Progress Graph
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progress History',
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
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: true,
                              horizontalInterval: 10,
                              verticalInterval: 1,
                            ),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 10,
                                  reservedSize: 40,
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 1,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      'Test ${value.toInt() + 1}',
                                      style: GoogleFonts.montserrat(fontSize: 10),
                                    );
                                  },
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            minY: 0,
                            maxY: 50,
                            borderData: FlBorderData(show: true),
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
                                dotData: FlDotData(show: true),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Tips Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Improvement Tips',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTipItem('Focus on maintaining proper form throughout the exercise'),
                      _buildTipItem('Try to increase your pace while keeping good form'),
                      _buildTipItem('Rest 48 hours between intense training sessions'),
                      _buildTipItem('Consider supplementary exercises to improve overall strength'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TestLibraryScreen(),
                        ),
                      ),
                      child: const Text('Try Again'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      onPressed: () async {
                        await _saveActivity();
                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DashboardScreen(),
                            ),
                          );
                        }
                      },
                      child: const Text('Finish'),
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

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.montserrat(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          children: [
            Text('Level', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
            Text('Reps', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
          ],
        ),
        _buildTableRow('Elite', '30+'),
        _buildTableRow('Advanced', '25-29'),
        _buildTableRow('Intermediate', '20-24'),
        _buildTableRow('Beginner', '15-19'),
        _buildTableRow('Novice', '<15'),
      ],
    );
  }

  TableRow _buildTableRow(String level, String reps) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(level, style: GoogleFonts.montserrat()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(reps, style: GoogleFonts.montserrat()),
        ),
      ],
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.tips_and_updates, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(tip, style: GoogleFonts.montserrat()),
          ),
        ],
      ),
    );
  }
}
