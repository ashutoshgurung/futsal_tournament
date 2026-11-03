import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/tournament/tournament_bloc.dart';
import 'package:football_app/bloc/tournament/tournament_event.dart';
import 'package:football_app/repository/tournament/tournament_repository.dart';
import 'package:football_app/view/home/widgets/promo_carousel.dart';
import 'package:football_app/view/home/widgets/search_textfield_home_widget.dart';
import 'package:football_app/view/home/widgets/tournament_list.dart';
import 'package:football_app/view/home/widgets/tournament_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  final List banners = [
    'assets/images/futsal1.png',
    'assets/images/futsa2.png',
    'assets/images/futsal3.png',
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TournamentBloc(context.read<TournamentRepository>())
            ..add(const TournamentEvent.loadUpcoming()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/futbookok.png",
                        color: Colors.white,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.person, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 12.0,
                  ),
                  child: SearchTextfieldHomeWidget(),
                ),
                const SizedBox(height: 15),
                PromoCarousel(),
                const SizedBox(height: 15),
                SizedBox(
                  height: 44,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final isSelected = index == 0; // first one active for now
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.green
                              : const Color(0xFF1C1C1E),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: isSelected ? Colors.green : Colors.white12,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              categories[index]['icon'],
                              size: 18,
                              color: isSelected ? Colors.white : Colors.white70,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              categories[index]['text'],
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Upcoming Tournaments",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => TournamentsPage()),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "View All",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.arrow_right_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                TournamentList(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> categories = [
  {'icon': Icons.apps_rounded, 'text': "All"},
  {'icon': Icons.location_on, 'text': "Nearby"},
  {'icon': Icons.calendar_month, 'text': "Upcoming"},
  {'icon': Icons.local_fire_department, 'text': "Popular"},
];
