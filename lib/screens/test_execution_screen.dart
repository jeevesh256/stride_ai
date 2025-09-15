import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'dart:math' as math;
import '../models/test_info.dart';
import 'results_screen.dart';
import 'main_layout.dart';

class TestExecutionScreen extends StatefulWidget {
  final TestInfo test;

  const TestExecutionScreen({super.key, required this.test});

  @override
  State<TestExecutionScreen> createState() => _TestExecutionScreenState();
}

class _TestExecutionScreenState extends State<TestExecutionScreen> with SingleTickerProviderStateMixin {
  CameraController? _cameraController;
  bool _isTestRunning = false;
  bool _isCameraInitialized = false;
  bool _isCalibrating = false;
  int _counter = 0;
  String _formFeedback = 'Position yourself in frame and tap the green button to start';
  late AnimationController _calibrationController;
  int _calibrationTimeLeft = 10;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _formFeedback = _getInitialInstructions();
    _calibrationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
      setState(() {
        _calibrationTimeLeft = 10 - (_calibrationController.value * 10).floor();
      });
    });
  }

  @override
  void dispose() {
    _calibrationController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  String _getInitialInstructions() {
    return 'Position yourself in frame and tap the green button to start';
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;
      _cameraController = CameraController(
        firstCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _cameraController?.initialize();
      if (!mounted) return;
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  Future<void> _startCalibration() async {
    setState(() {
      _isCalibrating = true;
      _formFeedback = 'Calibrating...';
    });

    _calibrationController.forward(from: 0).then((_) {
      if (mounted) {
        setState(() {
          _isCalibrating = false;
          _isTestRunning = true;
          _counter = 0;
          _formFeedback = 'Starting...';
        });
        _startCountingTimer();
      }
    });
  }

  void _startTest() {
    if (!_isCameraInitialized) return;
    _startCalibration();
  }

  void _startCountingTimer() {
    // Simple timer-based counting for demo purposes
    Future.delayed(const Duration(seconds: 2), () {
      if (_isTestRunning) {
        setState(() {
          _counter++;
          _formFeedback = 'Rep $_counter completed!';
        });
        _startCountingTimer();
      }
    });
  }

  void _stopTest() async {
    setState(() {
      _isTestRunning = false;
    });
    
    if (!mounted) return;
    
    // Navigate to results screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          test: widget.test,
          reps: _counter,
          duration: const Duration(minutes: 1),
        ),
      ),
    ).then((_) {
      // After results screen is dismissed, navigate back to main layout
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainLayout()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized || _cameraController == null || !_cameraController!.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CameraPreview(_cameraController!),

          if (_isCalibrating)
            AnimatedBuilder(
              animation: _calibrationController,
              builder: (context, child) {
                return CustomPaint(
                  size: Size.infinite,
                  painter: CalibrationPainter(
                    progress: _calibrationController.value,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              },
            ),

          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _isCalibrating ? 'Calibrating: $_calibrationTimeLeft' : 'Count: $_counter',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _formFeedback,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    FloatingActionButton.large(
                      onPressed: _isTestRunning ? _stopTest : _startTest,
                      backgroundColor: _isTestRunning ? Colors.red : Colors.green,
                      child: Icon(
                        _isTestRunning ? Icons.stop : Icons.play_arrow,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalibrationPainter extends CustomPainter {
  final double progress;
  final Color color;

  CalibrationPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * 0.4;
    
    // Draw the calibration circle
    canvas.drawCircle(center, radius, paint);

    // Draw the progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      2 * math.pi * progress,
      false,
      progressPaint,
    );

    // Draw corner markers
    final markerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    const markerLength = 20.0;
    const padding = 40.0;

    // Top-left marker
    canvas.drawLine(
      Offset(padding, padding),
      Offset(padding + markerLength, padding),
      markerPaint,
    );
    canvas.drawLine(
      Offset(padding, padding),
      Offset(padding, padding + markerLength),
      markerPaint,
    );

    // Top-right marker
    canvas.drawLine(
      Offset(size.width - padding, padding),
      Offset(size.width - padding - markerLength, padding),
      markerPaint,
    );
    canvas.drawLine(
      Offset(size.width - padding, padding),
      Offset(size.width - padding, padding + markerLength),
      markerPaint,
    );

    // Bottom-left marker
    canvas.drawLine(
      Offset(padding, size.height - padding),
      Offset(padding + markerLength, size.height - padding),
      markerPaint,
    );
    canvas.drawLine(
      Offset(padding, size.height - padding),
      Offset(padding, size.height - padding - markerLength),
      markerPaint,
    );

    // Bottom-right marker
    canvas.drawLine(
      Offset(size.width - padding, size.height - padding),
      Offset(size.width - padding - markerLength, size.height - padding),
      markerPaint,
    );
    canvas.drawLine(
      Offset(size.width - padding, size.height - padding),
      Offset(size.width - padding, size.height - padding - markerLength),
      markerPaint,
    );
  }

  @override
  bool shouldRepaint(CalibrationPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
