import 'package:flutter/material.dart';
import 'package:football_app/view/organizer/dashboard/organizer_dashboard_screen.dart';
import 'package:football_app/view/organizer/profile/organizer_profile_screen.dart';
import 'package:football_app/view/organizer/teams/organizer_team_screen.dart';
import 'package:football_app/view/organizer/tournaments/organizer_tournaments_screen.dart';
import 'package:google_fonts/google_fonts.dart';


class OrganizerShellScreen extends StatefulWidget {
  const OrganizerShellScreen({super.key});

  @override
  State<OrganizerShellScreen> createState() => _OrganizerShellScreenState();
}

class _OrganizerShellScreenState extends State<OrganizerShellScreen> {
  int _index = 0;

  static const _pages = <Widget>[
    OrganizerDashboardScreen(),
    OrganizerTournamentsScreen(),
    OrganizerTeamsScreen(),
    OrganizerProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: const Color(0xFF1C1C1E),
          indicatorColor: Colors.green.withValues(alpha: 0.25),
          labelTextStyle: WidgetStatePropertyAll(
            GoogleFonts.poppins(fontSize: 11, color: Colors.white70),
          ),
          iconTheme: const WidgetStatePropertyAll(
            IconThemeData(color: Colors.white70),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.emoji_events_outlined),
              label: 'Tournaments',
            ),
            NavigationDestination(
              icon: Icon(Icons.groups_outlined),
              label: 'Teams',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}