import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sport_detail_screen.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: sportCategories.length,
      itemBuilder: (context, index) {
        final sport = sportCategories[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SportDetailScreen(sport: sport),
            ),
          ),
          child: Card(
            elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  sport.icon,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 8),
                Text(
                  sport.name,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${sport.tests.length} tests',
                  style: GoogleFonts.montserrat(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

final sportCategories = [
  SportCategory(
    name: 'Athletics',
    icon: Icons.directions_run,
    tests: [
      'One-foot Balance Test',
      '20m/30m Sprint Test',
      'Standing Long Jump',
      'Vertical Jump Test',
      '40m/50m Obstacle Run',
      '5-Step Bounding',
      'Chest Pass Test',
      '1.6km Endurance Run',
      'Sit-ups Test', // Added sit-ups test
    ],
  ),
  SportCategory(
    name: 'Archery',
    icon: Icons.gps_fixed,
    tests: [
      'Stance Analysis',
      'Draw Form Check',
      'Release Technique',
      'Aim Stability Test',
    ],
  ),
  SportCategory(
    name: 'Badminton',
    icon: Icons.sports_tennis,
    tests: [
      'Service Form',
      'Smash Power Analysis',
      'Footwork Pattern',
      'Drop Shot Accuracy',
    ],
  ),
  SportCategory(
    name: 'Basketball',
    icon: Icons.sports_basketball,
    tests: [
      'Jump Shot Form',
      'Dribbling Skills',
      'Free Throw Analysis',
      'Layup Technique',
      'Defense Stance',
    ],
  ),
  SportCategory(
    name: 'Cycling',
    icon: Icons.pedal_bike,
    tests: [
      'Pedaling Efficiency',
      'Posture Analysis',
      'Sprint Power Test',
      'Endurance Check',
    ],
  ),
  SportCategory(
    name: 'Football',
    icon: Icons.sports_soccer,
    tests: [
      'Ball Control',
      'Shooting Technique',
      'Passing Accuracy',
      'Sprint Speed',
      'Dribbling Skills',
    ],
  ),
  SportCategory(
    name: 'Hockey',
    icon: Icons.sports_hockey,
    tests: [
      'Stick Handling',
      'Shot Power',
      'Passing Accuracy',
      'Running Form',
      'Defense Position',
    ],
  ),
  SportCategory(
    name: 'Kabaddi',
    icon: Icons.sports_martial_arts,
    tests: [
      'Raid Technique',
      'Defense Stance',
      'Chain Movement',
      'Escape Analysis',
      'Tackle Form',
    ],
  ),
];

class SportCategory {
  final String name;
  final IconData icon;
  final List<String> tests;

  const SportCategory({
    required this.name,
    required this.icon,
    required this.tests,
  });
}

