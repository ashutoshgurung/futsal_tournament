import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback? onTournamentsTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onMyRegistrationTap;
  final VoidCallback? onBecomeOrganizerTap;

  const AppDrawer({
    super.key,
    this.onTournamentsTap,
    this.onProfileTap,
    this.onMyRegistrationTap,
    this.onBecomeOrganizerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF121212),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  "assets/images/futhub_white.png",
                  color: Colors.white,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Divider(color: Colors.white12, height: 1),
            const SizedBox(height: 8),
            _DrawerItem(
              icon: Icons.home_rounded,
              title: "Home",
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.emoji_events_rounded,
              title: "Tournaments",
              onTap: () {
                Navigator.pop(context);
                onTournamentsTap?.call();
              },
            ),
            _DrawerItem(
              icon: Icons.person,
              title: "Profile",
              onTap: () {
                Navigator.pop(context);
                onProfileTap?.call();
              },
            ),
            _DrawerItem(
              icon: Icons.assignment_outlined,
              title: "My Registration",
              onTap: () {
                Navigator.pop(context);
                onMyRegistrationTap?.call();
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(color: Colors.white12, height: 1),
            ),
            _DrawerItem(
              icon: Icons.sports_soccer,
              title: "Become an Organizer",
              highlight: true,
              onTap: () {
                Navigator.pop(context);
                onBecomeOrganizerTap?.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool highlight;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: highlight ? Colors.green : Colors.white70),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: highlight ? FontWeight.w600 : FontWeight.w500,
          color: highlight ? Colors.green : Colors.white,
        ),
      ),
      onTap: onTap,
    );
  }
}
