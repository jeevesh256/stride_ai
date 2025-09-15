import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/test_info.dart';
import 'test_library_screen.dart';
import 'test_execution_screen.dart';

class TestInstructionsScreen extends StatelessWidget {
  final TestInfo test;

  const TestInstructionsScreen({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          test.title, // Changed from test.name
          style: GoogleFonts.montserrat(),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  test.icon,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'How to perform this test',
                style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildInstructionsForTest(test.title), // Changed from test.name
              const SizedBox(height: 24),
              Text(
                'Camera Setup Instructions',
                style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildCameraSetupInstructions(),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestExecutionScreen(test: test),
                      ),
                    );
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Start Test'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionsForTest(String testName) {
    switch (testName) {
      case 'Sit-ups':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInstructionStep('1. Lie on your back with knees bent and feet flat on the floor.'),
            _buildInstructionStep('2. Place your hands behind your head with fingers interlaced.'),
            _buildInstructionStep('3. Engage your core and lift your upper body toward your knees.'),
            _buildInstructionStep('4. Lower back down in a controlled motion.'),
            _buildInstructionStep('5. Repeat until the test is complete.'),
          ],
        );
      case 'Vertical Jump':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInstructionStep('1. Stand with feet shoulder-width apart facing the camera.'),
            _buildInstructionStep('2. Bend your knees and swing arms backward.'),
            _buildInstructionStep('3. Explosively jump as high as you can while swinging arms up.'),
            _buildInstructionStep('4. Land softly with bent knees.'),
            _buildInstructionStep('5. Rest 10-15 seconds between attempts.'),
          ],
        );
      case 'Shuttle Run':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInstructionStep('1. Set up two lines 10 meters apart.'),
            _buildInstructionStep('2. Start behind one line facing the other line.'),
            _buildInstructionStep('3. Run to the opposite line and touch it with your hand.'),
            _buildInstructionStep('4. Turn and run back to the starting line.'),
            _buildInstructionStep('5. Continue back and forth until the test is complete.'),
          ],
        );
      case 'Endurance Run':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInstructionStep('1. Find an open space where you can run continuously.'),
            _buildInstructionStep('2. Set the timer for 12 minutes.'),
            _buildInstructionStep('3. Run as far as possible within the time limit.'),
            _buildInstructionStep('4. Maintain a steady pace throughout the test.'),
            _buildInstructionStep('5. The app will track your distance and speed.'),
          ],
        );
      default:
        return Text(
          'Follow the on-screen instructions during the test.',
          style: GoogleFonts.montserrat(fontSize: 16),
        );
    }
  }

  Widget _buildCameraSetupInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInstructionStep('1. Place your phone on a stable surface or use a tripod.'),
        _buildInstructionStep('2. Position the camera 6-8 feet (2-2.5 meters) away from you.'),
        _buildInstructionStep('3. Ensure your full body is visible in the frame.'),
        _buildInstructionStep('4. Make sure the area is well-lit without strong backlighting.'),
        _buildInstructionStep('5. Clear the area of any obstacles or tripping hazards.'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber, width: 1),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.amber[700]),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'For the most accurate results, wear form-fitting clothes and ensure the camera can see your movements clearly.',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionStep(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: GoogleFonts.montserrat(fontSize: 16),
      ),
    );
  }
}