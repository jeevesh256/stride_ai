import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'test_library_screen.dart';
import 'results_screen.dart';

class TestExecutionScreen extends StatefulWidget {
  final TestInfo test;

  const TestExecutionScreen({super.key, required this.test});

  @override
  State<TestExecutionScreen> createState() => _TestExecutionScreenState();
}

class _TestExecutionScreenState extends State<TestExecutionScreen> {
  late CameraController _cameraController;
  late final PoseDetector _poseDetector;
  bool _isTestRunning = false;
  int _counter = 0;
  String _formFeedback = '';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _poseDetector = PoseDetector(
      options: PoseDetectorOptions(
        mode: PoseDetectionMode.stream,
        model: PoseDetectionModel.accurate,
      ),
    );
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _cameraController.initialize();
    if (!mounted) return;
    setState(() {});
  }

  void _startTest() {
    setState(() {
      _isTestRunning = true;
      _counter = 0;
      _formFeedback = 'Starting...';
    });
    _processCameraImage();
  }

  void _stopTest() {
    setState(() {
      _isTestRunning = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          test: widget.test,
          reps: _counter,
          duration: const Duration(minutes: 1),
        ),
      ),
    );
  }

  Future<void> _processCameraImage() async {
    if (!_isTestRunning) return;

    final image = await _cameraController.takePicture();
    final inputImage = InputImage.fromFilePath(image.path);
    final poses = await _poseDetector.processImage(inputImage);

    if (poses.isNotEmpty) {
      // Process pose for the specific test type
      _processPose(poses.first);
    }

    if (mounted && _isTestRunning) {
      await Future.delayed(const Duration(milliseconds: 100));
      _processCameraImage();
    }
  }

  void _processPose(Pose pose) {
    // Example implementation for sit-ups
    if (widget.test.name == 'Sit-ups') {
      final leftHip = pose.landmarks[PoseLandmarkType.leftHip];
      final leftShoulder = pose.landmarks[PoseLandmarkType.leftShoulder];

      if (leftHip != null && leftShoulder != null) {
        final angle = _calculateAngle(leftHip, leftShoulder);
        if (angle > 45) {
          setState(() {
            _formFeedback = '✅ Good form!';
            _counter++;
          });
        } else {
          setState(() {
            _formFeedback = '❌ Raise upper body more';
          });
        }
      }
    }
  }

  double _calculateAngle(PoseLandmark point1, PoseLandmark point2) {
    // Simplified angle calculation for demo
    return (point2.y - point1.y).abs() * 90;
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Camera preview
          CameraPreview(_cameraController),

          // Counter overlay
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Count: $_counter',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // Form feedback
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 100),
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
          ),

          // Start/Stop button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: FloatingActionButton.large(
                onPressed: _isTestRunning ? _stopTest : _startTest,
                backgroundColor: _isTestRunning ? Colors.red : Colors.green,
                child: Icon(_isTestRunning ? Icons.stop : Icons.play_arrow),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
