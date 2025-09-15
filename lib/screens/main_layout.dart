import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'settings_screen.dart';
import 'dashboard_screen.dart';
import 'sports_screen.dart';
import 'progress_history_screen.dart';
import 'badges_screen.dart';
import 'chat_screen.dart';
import 'login_screen.dart'; // Add this import

class MainLayout extends StatefulWidget {
  final int? initialTab;
  const MainLayout({super.key, this.initialTab});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _selectedIndex;
  late StreamSubscription<User?> _userSubscription;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const SportsScreen(),
    const ProgressHistoryScreen(),
    const BadgesScreen(),
  ];

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
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
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
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
              offset: const Offset(0, -30),
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
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    onTap: () {
                      Navigator.pop(context);
                      _handleProfile();
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
                      UserService().logout();
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
            icon: Icon(Icons.sports),
            label: 'Sports',
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
