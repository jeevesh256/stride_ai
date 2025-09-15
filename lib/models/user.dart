class User {
  final String email;
  final String password;
  String name;
  String location;
  String gender;
  String phoneNumber;
  int age;
  double weight;
  double height;
  List<String> preferredSports;

  User({
    required this.email,
    required this.password,
    required this.name,
    this.location = '',
    this.gender = '',
    this.phoneNumber = '',
    this.age = 0,
    this.weight = 0.0,
    this.height = 0.0,
    this.preferredSports = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      location: json['location'] ?? '',
      gender: json['gender'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      age: json['age'] ?? 0,
      weight: (json['weight'] ?? 0.0).toDouble(),
      height: (json['height'] ?? 0.0).toDouble(),
      preferredSports: List<String>.from(json['preferredSports'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'location': location,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'age': age,
      'weight': weight,
      'height': height,
      'preferredSports': preferredSports,
    };
  }
}
