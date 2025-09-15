import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/test_info.dart';
import '../models/test_details.dart';
import 'test_library_screen.dart';
import 'test_execution_screen.dart';

class TestInstructionsScreen extends StatelessWidget {
  final TestInfo test;

  const TestInstructionsScreen({super.key, required this.test});

  TestDetails _getTestDetails(String testName) {
    // Example for a sprint test
    return TestDetails(
      prerequisites: [
        'Clear running space of at least 30 meters',
        'Proper running shoes',
        'Warm-up completed',
      ],
      instructions: [
        'Set up camera at side angle',
        'Mark start and finish points',
        'Begin in athletic stance',
        'Sprint at maximum effort',
        'Maintain form through finish',
      ],
      commonMistakes: [
        'Starting too upright',
        'Not driving arms properly',
        'Looking down while running',
        'Decelerating before finish',
      ],
      tips: [
        'Focus on explosive first steps',
        'Keep your core engaged',
        'Drive knees high',
        'Maintain relaxed upper body',
      ],
      progressionSteps: [
        'Master proper form at 50% speed',
        'Practice acceleration phase',
        'Work on maintaining top speed',
        'Add resistance training',
      ],
    );
  }

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
              // Add SAI context
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.verified, 
                        color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Official SAI Assessment Test',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
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
                  onPressed: () => _startTest(context),
                  icon: const Icon(Icons.play_arrow),
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

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_right, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item,
                  style: GoogleFonts.montserrat(fontSize: 16),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  void _startTest(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestExecutionScreen(test: test),
      ),
    );
  }

  Widget _buildVideoSetupInstructions(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.videocam, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Camera Setup',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSetupStep(
              icon: Icons.height,
              text: 'Place your phone at waist height (about 3-4 feet from ground)',
            ),
            _buildSetupStep(
              icon: Icons.straighten,
              text: 'Keep 8-10 feet distance from the camera',
            ),
            _buildSetupStep(
              icon: Icons.brightness_5,
              text: 'Ensure good lighting, avoid backlighting',
            ),
            _buildSetupStep(
              icon: Icons.visibility,
              text: 'Full body should be visible in frame',
            ),
            _buildSetupStep(
              icon: Icons.smartphone,
              text: 'Use a stable surface or tripod for the phone',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetupStep({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.montserrat(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestInstructions(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.assignment, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Test Instructions',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInstructionStep('1. ${_getFirstInstruction()}'),
            _buildInstructionStep('2. ${_getSecondInstruction()}'),
            _buildInstructionStep('3. ${_getThirdInstruction()}'),
          ],
        ),
      ),
    );
  }

  String _getFirstInstruction() {
    switch (test.category) {
      case 'Athletics':
        return 'Stand sideways to the camera for better form analysis';
      case 'Basketball':
        return 'Position yourself at a 45-degree angle to the camera';
      case 'Football':
        return 'Face the camera directly for ball control exercises';
      default:
        return 'Position yourself according to the on-screen guide';
    }
  }

  String _getSecondInstruction() {
    switch (test.category) {
      case 'Athletics':
        return 'Ensure your full running path is visible in frame';
      case 'Basketball':
        return 'Keep the basket and your full body in frame';
      case 'Football':
        return 'Mark your practice area within camera view';
      default:
        return 'Make sure your movements stay in frame';
    }
  }

  String _getThirdInstruction() {
    switch (test.category) {
      case 'Athletics':
        return 'Perform the action at your natural speed';
      case 'Basketball':
        return 'Complete the motion in a controlled manner';
      case 'Football':
        return 'Maintain consistent speed throughout the drill';
      default:
        return 'Follow the AI guidance during the test';
    }
  }
}