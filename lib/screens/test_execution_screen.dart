import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'test_library_screen.dart';
import 'results_screen.dart';
import 'main_layout.dart';

class TestExecutionScreen extends StatefulWidget {
  final TestInfo test;

  const TestExecutionScreen({super.key, required this.test});

  @override
  State<TestExecutionScreen> createState() => _TestExecutionScreenState();
}

class _TestExecutionScreenState extends State<TestExecutionScreen> {
  CameraController? _cameraController;
  bool _isTestRunning = false;
  bool _isCameraInitialized = false;
  int _counter = 0;
  String _formFeedback = 'Position yourself in frame and tap the green button to start';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _formFeedback = _getInitialInstructions();
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

  void _startTest() {
    if (!_isCameraInitialized) return;
    setState(() {
      _isTestRunning = true;
      _counter = 0;
      _formFeedback = 'Starting...';
    });
    _startCountingTimer();
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

  void _stopTest() {
    setState(() {
      _isTestRunning = false;
    });
    // First navigate to results screen
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
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
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
