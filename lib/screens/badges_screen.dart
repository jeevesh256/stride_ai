import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final badges = [
      Badge(
        name: 'First Test',
        description: 'Completed your first fitness test',
        icon: Icons.stars,
        isUnlocked: true,
      ),
      Badge(
        name: '100 Sit-ups Total',
        description: 'Reached 100 total sit-ups across all attempts',
        icon: Icons.fitness_center,
        isUnlocked: true,
      ),
      Badge(
        name: '1 Month Streak',
        description: 'Tested consistently for a month',
        icon: Icons.local_fire_department,
        isUnlocked: false,
      ),
      Badge(
        name: 'All-rounder',
        description: 'Completed all types of tests',
        icon: Icons.sports_score,
        isUnlocked: false,
      ),
      Badge(
        name: 'Record Breaker',
        description: 'Beat your personal best 3 times',
        icon: Icons.emoji_events,
        isUnlocked: false,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Badges',
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: badges.length,
        itemBuilder: (context, index) {
          return _BadgeCard(badge: badges[index]);
        },
      ),
    );
  }
}

class Badge {
  final String name;
  final String description;
  final IconData icon;
  final bool isUnlocked;

  Badge({
    required this.name,
    required this.description,
    required this.icon,
    required this.isUnlocked,
  });
}

class _BadgeCard extends StatelessWidget {
  final Badge badge;

  const _BadgeCard({required this.badge});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              badge.icon,
              size: 48,
              color: badge.isUnlocked
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              badge.name,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              badge.description,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            if (!badge.isUnlocked) ...[
              const SizedBox(height: 8),
              Icon(
                Icons.lock,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
