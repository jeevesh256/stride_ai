import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  _navigateToOnboarding() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Text(
              'Stride AI',
              style: GoogleFonts.montserrat(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            // Tagline
            Text(
              'Test. Track. Improve.',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
