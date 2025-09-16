import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/test_info.dart';
import 'test_instructions_screen.dart';

class TestLibraryScreen extends StatelessWidget {
  const TestLibraryScreen({super.key});

  static final List<TestInfo> tests = [
    TestInfo(
      title: 'Push-up Form Analysis',
      description: 'Analyze your push-up form for optimal performance',
      category: 'upper_body',
      difficulty: 'Intermediate',
      duration: Duration(minutes: 5),
      equipment: ['Camera'],
      icon: Icons.fitness_center,
    ),
    TestInfo(
      title: 'Core Stability Test',
      description: 'Measure your core strength and stability',
      category: 'core',
      difficulty: 'Intermediate',
      duration: Duration(minutes: 5),
      equipment: ['Camera'],
      icon: Icons.accessibility_new,
    ),
    TestInfo(
      title: 'Squat Form Analysis',
      description: 'Analyze your squat form for optimal performance',
      category: 'lower_body',
      difficulty: 'Intermediate',
      duration: Duration(minutes: 5),
      equipment: ['Camera'],
      icon: Icons.fitness_center,
    ),
    TestInfo(
      title: 'Agility Test',
      description: 'Measure your agility and quick movements',
      category: 'agility',
      difficulty: 'Advanced',
      duration: Duration(minutes: 10),
      equipment: ['Camera', 'Cones'],
      icon: Icons.speed,
    ),
    TestInfo(
      title: 'Endurance Test',
      description: 'Measure your cardiovascular endurance',
      category: 'cardiovascular',
      difficulty: 'Advanced',
      duration: Duration(minutes: 15),
      equipment: ['Camera'],
      icon: Icons.monitor_heart,
    ),
    TestInfo(
      title: 'One-foot Balance Test',
      description: 'Measure balance with eyes open and closed (Standing Stork)',
      category: 'balance',
      difficulty: 'Beginner',
      duration: Duration(minutes: 2),
      equipment: ['Camera', 'Timer'],
      icon: Icons.balance,
    ),
    TestInfo(
      title: 'Sprint Test',
      description: 'U14: 20m Sprint / U16: 30m Sprint',
      category: 'speed',
      difficulty: 'Intermediate',
      duration: Duration(minutes: 5),
      equipment: ['Camera', 'Timer', 'Cones'],
      icon: Icons.directions_run,
    ),
    TestInfo(
      title: 'Standing Long Jump',
      description: 'Measure explosive leg power through horizontal jump',
      category: 'power',
      difficulty: 'Intermediate',
      duration: Duration(minutes: 5),
      equipment: ['Camera', 'Measuring Tape'],
      icon: Icons.horizontal_distribute,
    ),
    TestInfo(
      title: 'Vertical Jump Test',
      description: 'Measure vertical jumping ability and power',
      category: 'power',
      difficulty: 'Intermediate',
      duration: Duration(minutes: 5),
      equipment: ['Camera', 'Measuring Device'],
      icon: Icons.vertical_align_top,
    ),
    TestInfo(
      title: 'Obstacle Run',
      description: 'U14: 40m / U16: 50m obstacle course',
      category: 'agility',
      difficulty: 'Advanced',
      duration: Duration(minutes: 10),
      equipment: ['Camera', 'Timer', 'Cones', 'Obstacles'],
      icon: Icons.sports_score,
    ),
    TestInfo(
      title: '5-Step Bounding',
      description: 'Measure explosive power through consecutive jumps',
      category: 'power',
      difficulty: 'Advanced',
      duration: Duration(minutes: 5),
      equipment: ['Camera', 'Measuring Tape'],
      icon: Icons.moving,
    ),
    TestInfo(
      title: 'Chest Pass Test',
      description: 'U14: Girls 1kg/Boys 2kg, U16: Girls 2kg/Boys 3kg',
      category: 'strength',
      difficulty: 'Intermediate',
      duration: Duration(minutes: 5),
      equipment: ['Camera', 'Medicine Ball', 'Measuring Tape'],
      icon: Icons.sports_basketball,
    ),
    TestInfo(
      title: '1.6km Endurance Run',
      description: 'Measure cardiovascular endurance',
      category: 'cardiovascular',
      difficulty: 'Advanced',
      duration: Duration(minutes: 20),
      equipment: ['Camera', 'Timer', 'Track'],
      icon: Icons.timer,
    ),
    TestInfo(
      title: 'Sit-ups Test',
      description: 'Maximum sit-ups in 1 minute to measure core endurance',
      category: 'core',
      difficulty: 'Intermediate',
      duration: Duration(minutes: 3),
      equipment: ['Camera', 'Timer', 'Exercise Mat'],
      icon: Icons.fitness_center,
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