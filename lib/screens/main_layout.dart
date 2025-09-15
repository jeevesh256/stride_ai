import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'dashboard_screen.dart';
import 'sports_screen.dart'; // Import SportsScreen
import 'progress_history_screen.dart';
import 'badges_screen.dart';
import 'chat_screen.dart';
import 'login_screen.dart';
import 'settings_screen.dart';

class MainLayout extends StatefulWidget {
  final int? initialTab;
  const MainLayout({super.key, this.initialTab});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _selectedIndex;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const SportsScreen(), // Replace TestLibraryScreen with SportsScreen
    const ProgressHistoryScreen(),
    const BadgesScreen(),
  ];

  late StreamSubscription<User?> _userSubscription;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleLogout() {
    UserService().logout();
    setState(() {});
  }

  void _handleProfile() {  // renamed from _handleSettings
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab ?? 0;
    _userSubscription = UserService().userStream.listen((user) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (UserService.currentUser == null) {
      return const LoginScreen();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.fitness_center,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Stride AI',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: PopupMenuButton(
              offset: const Offset(0, 40),
              position: PopupMenuPosition.under,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: Text(
                      UserService.currentUser!.name[0].toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    UserService.currentUser!.name,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.person), // changed from settings icon
                    title: const Text('Profile'), // changed from Settings
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    onTap: () {
                      Navigator.pop(context);
                      _handleProfile(); // renamed from _handleSettings
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    onTap: () {
                      Navigator.pop(context);
                      _handleLogout();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            );
          },
          child: const Icon(Icons.chat),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports), // Updated icon for Sports
            label: 'Sports', // Updated label for Sports
          ),
          NavigationDestination(
            icon: Icon(Icons.trending_up),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events),
            label: 'Badges',
          ),
        ],
      ),
    );
  }
}
