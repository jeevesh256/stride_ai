import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/user_service.dart';
import '../models/user.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late User _user;
  final UserService _userService = UserService();
  final List<String> _availableSports = [
    'Running',
    'Weightlifting',
    'Swimming',
    'Cycling',
    'Basketball',
    'Soccer',
    'Tennis',
    'Yoga'
  ];
  final List<String> _genderOptions = ['Male', 'Female', 'Other', 'Prefer not to say'];

  @override
  void initState() {
    super.initState();
    _user = UserService.currentUser!;
  }

  void _saveSettings() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await _userService.updateUser(_user);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Settings saved successfully')),
        );
        Navigator.pop(context);
      }
    }
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                _user.name[0].toUpperCase(),
                style: GoogleFonts.montserrat(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: IconButton(
                  icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                  onPressed: () {
                    // TODO: Implement image picker
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Coming soon!')),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          _user.email,
          style: GoogleFonts.montserrat(
            color: Colors.grey[600],
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildAchievements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Achievements'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildAchievementChip('🏃 Running Enthusiast', true),
              _buildAchievementChip('💪 10 Tests Completed', true),
              _buildAchievementChip('🎯 Perfect Form', true),
              _buildAchievementChip('🔥 3 Day Streak', false),
              _buildAchievementChip('🏆 All Sports Master', false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementChip(String label, bool earned) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label),
        backgroundColor: earned 
            ? Theme.of(context).colorScheme.primaryContainer
            : Colors.grey[200],
        labelStyle: GoogleFonts.montserrat(
          color: earned 
              ? Theme.of(context).colorScheme.primary
              : Colors.grey,
          fontWeight: earned ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildAchievements(),
            const SizedBox(height: 24),
            _buildSectionHeader('Personal Information'),
            TextFormField(
              initialValue: _user.name,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _user.name = value ?? '',
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Name is required' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _user.gender.isEmpty ? null : _user.gender,
              decoration: const InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
              items: _genderOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _user.gender = value ?? '');
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _user.phoneNumber,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              onSaved: (value) => _user.phoneNumber = value ?? '',
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _user.location,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _user.location = value ?? '',
            ),

            _buildSectionHeader('Physical Details'),
            TextFormField(
              initialValue: _user.age.toString(),
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onSaved: (value) => _user.age = int.tryParse(value ?? '') ?? 0,
              validator: (value) =>
                  int.tryParse(value ?? '') == null ? 'Invalid age' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _user.weight.toString(),
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onSaved: (value) =>
                  _user.weight = double.tryParse(value ?? '') ?? 0.0,
              validator: (value) =>
                  double.tryParse(value ?? '') == null ? 'Invalid weight' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _user.height.toString(),
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onSaved: (value) =>
                  _user.height = double.tryParse(value ?? '') ?? 0.0,
              validator: (value) =>
                  double.tryParse(value ?? '') == null ? 'Invalid height' : null,
            ),

            _buildSectionHeader('Sports Preferences'),
            Wrap(
              spacing: 8,
              children: _availableSports.map((sport) {
                return FilterChip(
                  label: Text(sport),
                  selected: _user.preferredSports.contains(sport),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _user.preferredSports.add(sport);
                      } else {
                        _user.preferredSports.remove(sport);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveSettings,
        label: const Text('Save'),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
