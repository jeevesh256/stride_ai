import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'test_instructions_screen.dart'; // Changed import
import '../models/test_info.dart';
import 'sports_screen.dart';
import '../services/test_progress_service.dart';

class SportDetailScreen extends StatefulWidget {
  final SportCategory sport;

  const SportDetailScreen({super.key, required this.sport});

  @override
  _SportDetailScreenState createState() => _SportDetailScreenState();
}

class _SportDetailScreenState extends State<SportDetailScreen> {
  final _progressService = TestProgressService();
  double _progress = 0.0;
  Map<String, bool> _completedTests = {};

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final progress = await _progressService.getSportProgress(widget.sport.name);
    for (final test in widget.sport.tests) {
      final isCompleted = await _progressService.isTestCompleted(
        widget.sport.name, 
        test
      );
      _completedTests[test] = isCompleted;
    }
    setState(() {
      _progress = progress;
    });
  }

  bool _isTestCompleted(String test) {
    return _completedTests[test] ?? false;
  }

  String _getSportDescription(String sportName) {
    switch (sportName) {
      case 'Athletics':
        return 'Official SAI Athletics Assessment Program featuring comprehensive tests:\n\n'
            '• Balance and Stability\n'
            '• Speed and Acceleration\n'
            '• Explosive Power\n'
            '• Agility and Coordination\n'
            '• Throwing Power\n'
            '• Core Strength\n'
            '• Endurance\n\n'
            'Tests are age-categorized (U14/U16) with specific equipment requirements.';
      case 'Archery':
        return 'SAI archery talent identification program. Assessment includes stance stability, draw consistency, and target accuracy. Specialized categories for para-athletes available.';
      case 'Badminton':
        return 'National badminton selection criteria by SAI. Evaluate agility, racquet control, and game awareness. Comprehensive assessment for various age groups and skill levels.';
      case 'Basketball':
        return 'SAI basketball talent search program. Tests include shooting accuracy, dribbling skills, and defensive movements. Inclusive evaluation system for different height categories.';
      case 'Cycling':
        return 'SAI cycling performance assessment. Measure endurance, speed, and technical skills. Adapted testing protocols available for para-cyclists.';
      case 'Football':
        return 'National football talent identification by SAI. Evaluate ball control, game intelligence, and physical fitness. Comprehensive assessment across multiple skill levels.';
      case 'Hockey':
        return 'SAI hockey selection program. Test stick work, tactical understanding, and team coordination. Equal opportunities for players from all backgrounds.';
      case 'Kabaddi':
        return 'Traditional Indian sport selection program by SAI. Assess raiding skills, defensive ability, and match awareness. Promoting talent from grassroots level.';
      default:
        return 'Official SAI assessment program. Complete all tests to be evaluated for national sports programs.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.sport.name,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Sport Info Card
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        widget.sport.icon,
                        size: 32,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.sport.name,
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${widget.sport.tests.length} tests to complete',
                            style: GoogleFonts.montserrat(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _getSportDescription(widget.sport.name),
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: Colors.grey[200],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${(_progress * widget.sport.tests.length).round()}/${widget.sport.tests.length} completed',
                    style: GoogleFonts.montserrat(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tests List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.sport.tests.length,
              itemBuilder: (context, index) {
                final test = widget.sport.tests[index];
                final isCompleted = _isTestCompleted(test);

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: Icon(
                      isCompleted ? Icons.check_circle : widget.sport.icon,
                      color: isCompleted ? Colors.green : null,
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            test,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              decoration:
                                  isCompleted ? TextDecoration.lineThrough : null,
                            ),
                          ),
                        ),
                        Text(
                          '${index + 1}/${widget.sport.tests.length}',
                          style: GoogleFonts.montserrat(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestInstructionsScreen( // Changed from TestExecutionScreen
                            test: TestInfo(
                              title: test,
                              description: 'Detailed analysis of $test performance',
                              difficulty: 'Intermediate',
                              duration: const Duration(minutes: 5),
                              equipment: const ['Camera'],
                              category: widget.sport.name,
                              icon: widget.sport.icon,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
