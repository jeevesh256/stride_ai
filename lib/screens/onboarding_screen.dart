import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashboard_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Choose Test',
      description: 'Select from a variety of fitness tests to measure your performance',
      icon: Icons.fitness_center,
    ),
    OnboardingPage(
      title: 'Perform',
      description: 'Follow the instructions and perform the test while we track you',
      icon: Icons.sports_gymnastics,
    ),
    OnboardingPage(
      title: 'Get Feedback',
      description: 'Receive instant feedback and tips to improve your form',
      icon: Icons.analytics,
    ),
    OnboardingPage(
      title: 'Track Progress',
      description: 'Monitor your improvement over time and earn achievements',
      icon: Icons.trending_up,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip button
                  TextButton(
                    onPressed: () => _navigateToDashboard(),
                    child: Text(
                      'Skip',
                      style: GoogleFonts.montserrat(),
                    ),
                  ),
                  // Dots indicator
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  // Next/Done button
                  TextButton(
                    onPressed: () {
                      if (_currentPage == _pages.length - 1) {
                        _navigateToDashboard();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      _currentPage == _pages.length - 1 ? 'Done' : 'Next',
                      style: GoogleFonts.montserrat(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            page.icon,
            size: 100,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 32),
          Text(
            page.title,
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDashboard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final IconData icon;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
  });
}
