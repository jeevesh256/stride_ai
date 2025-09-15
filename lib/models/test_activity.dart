class TestActivity {
  final String title;
  final int reps;
  final String achievement;
  final DateTime time;
  final String testType;

  TestActivity({
    required this.title,
    required this.reps,
    required this.achievement,
    required this.time,
    required this.testType,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'reps': reps,
        'achievement': achievement,
        'time': time.toIso8601String(),
        'testType': testType,
      };

  factory TestActivity.fromJson(Map<String, dynamic> json) => TestActivity(
        title: json['title'],
        reps: json['reps'],
        achievement: json['achievement'],
        time: DateTime.parse(json['time']),
        testType: json['testType'],
      );
}
