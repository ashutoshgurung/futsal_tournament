
import 'package:flutter/material.dart';
import 'package:football_app/view/home/home_screen.dart';
import 'package:football_app/view/profile/profile_screen.dart';
import 'package:football_app/view/registration/registration_screen.dart';
import 'package:football_app/view/tournament/tournament_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BottomNavigationScreen extends StatelessWidget {
  BottomNavigationScreen({super.key});

  final PersistentTabController controller =
      PersistentTabController(initialIndex: 0);

  final List<PersistentTabConfig> tabs = [
    PersistentTabConfig(
      screen: HomeScreen(),
      item: ItemConfig(
        icon: const Icon(Icons.home_outlined),
        title: "Home",
        activeForegroundColor: Colors.greenAccent,
        inactiveForegroundColor: Colors.white,
      ),
    ),
    PersistentTabConfig(
      screen: TournamentScreen(),
      item: ItemConfig(
        icon: const Icon(Icons.emoji_events_outlined),
        title: "Tournament",
        activeForegroundColor: Colors.greenAccent,
        inactiveForegroundColor: Colors.white,
      ),
    ),
    PersistentTabConfig(
      screen: RegistrationScreen(),
      item: ItemConfig(
        icon: const Icon(Icons.assignment_outlined),
        title: "Registration",
        activeForegroundColor: Colors.greenAccent,
        inactiveForegroundColor: Colors.white,
      ),
    ),
    PersistentTabConfig(
      screen: ProfileScreen(),
      item: ItemConfig(
        icon: const Icon(Icons.person_outline),
        title: "Profile",
        activeForegroundColor: Colors.greenAccent,
        inactiveForegroundColor: Colors.white,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: controller,
      tabs: tabs,
      backgroundColor: Colors.black,
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: const NavBarDecoration(
          color: Colors.black,
        ),
      ),
      hideNavigationBar: false,
    );
  }
}
