import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'test_library_screen.dart';
import '../services/activity_service.dart';
import '../models/test_activity.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ActivityService _activityService = ActivityService();
  List<TestActivity> _activities = [];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    final activities = await _activityService.getActivities();
    setState(() {
      _activities = activities;
    });
  }

  Color _getColorForAchievement(String achievement) {
    if (achievement.contains('Elite')) return Colors.purple;
    if (achievement.contains('Advanced')) return Colors.blue;
    if (achievement.contains('Above')) return Colors.green;
    if (achievement.contains('Good')) return Colors.orange;
    return Colors.red;
  }

  String _getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} mins ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _loadActivities();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Welcome Athlete 👋',
                  style: GoogleFonts.montserrat(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Track your fitness journey',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // Quick action button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TestLibraryScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.fitness_center),
                    label: const Text('Start New Test'),
                  ),
                ),
                const SizedBox(height: 32),

                // Weekly Summary Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weekly Summary',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildSummaryItem('Tests\nCompleted', '4', Icons.check_circle),
                            _buildSummaryItem('Active\nMinutes', '45', Icons.timer),
                            _buildSummaryItem('Personal\nBests', '2', Icons.emoji_events),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Recent Activity Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent Activity',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const CollapsibleActivityList(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Weekly Progress Chart
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weekly Progress',
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
                                horizontalInterval: 5,
                                verticalInterval: 1,
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 22,
                                    interval: 1,
                                    getTitlesWidget: (value, meta) {
                                      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                                      if (value >= 0 && value < days.length) {
                                        return Text(
                                          days[value.toInt()],
                                          style: GoogleFonts.montserrat(fontSize: 12),
                                        );
                                      }
                                      return const Text('');
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 5,
                                    reservedSize: 35,
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
                              maxY: 35,
                              borderData: FlBorderData(show: true),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: const [
                                    FlSpot(0, 15),
                                    FlSpot(1, 18),
                                    FlSpot(2, 16),
                                    FlSpot(3, 20),
                                    FlSpot(4, 25),
                                    FlSpot(5, 22),
                                    FlSpot(6, 28),
                                  ],
                                  isCurved: true,
                                  color: Theme.of(context).colorScheme.primary,
                                  barWidth: 3,
                                  dotData: FlDotData(
                                    show: true,
                                    getDotPainter: (spot, percent, barData, index) {
                                      return FlDotCirclePainter(
                                        radius: 4,
                                        color: Theme.of(context).colorScheme.primary,
                                        strokeWidth: 2,
                                        strokeColor: Colors.white,
                                      );
                                    },
                                  ),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  ),
                                ),
                              ],
                              lineTouchData: LineTouchData(
                                enabled: true,
                                touchTooltipData: LineTouchTooltipData(
                                  tooltipBgColor: Colors.black87,
                                  tooltipRoundedRadius: 8,
                                  showOnTopOfTheChartBoxArea: true,
                                  getTooltipItems: (touchedSpots) {
                                    return touchedSpots.map((touchedSpot) {
                                      return LineTooltipItem(
                                        '${touchedSpot.y.toInt()} reps',
                                        GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }).toList();
                                  },
                                ),
                              ),
                            ),
                          ),
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
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 32),
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
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class CollapsibleActivityList extends StatefulWidget {
  const CollapsibleActivityList({super.key});

  @override
  State<CollapsibleActivityList> createState() => _CollapsibleActivityListState();
}

class _CollapsibleActivityListState extends State<CollapsibleActivityList> {
  final ActivityService _activityService = ActivityService();
  List<TestActivity> _activities = [];
  bool _showAll = false;

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    final activities = await _activityService.getActivities();
    setState(() {
      _activities = activities;
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayedActivities = _showAll 
        ? _activities 
        : _activities.take(5).toList();

    return Column(
      children: [
        if (_activities.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'No activities yet',
              style: GoogleFonts.montserrat(color: Colors.grey),
            ),
          )
        else ...[
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayedActivities.length,
            itemBuilder: (context, index) {
              final activity = displayedActivities[index];
              return ListTile(
                leading: const Icon(Icons.fitness_center),
                title: Text(
                  activity.title,
                  style: GoogleFonts.montserrat(),
                ),
                subtitle: Text(
                  '${activity.reps} reps - ${activity.achievement}',
                  style: GoogleFonts.montserrat(),
                ),
                trailing: Text(
                  '${activity.time.day}/${activity.time.month}/${activity.time.year}',
                  style: GoogleFonts.montserrat(),
                ),
              );
            },
          ),
          if (_activities.length > 5)
            FilledButton(
              onPressed: () {
                setState(() {
                  _showAll = !_showAll;
                });
              },
              child: Text(
                _showAll ? 'Show Less' : 'Show More',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ],
    );
  }
}


