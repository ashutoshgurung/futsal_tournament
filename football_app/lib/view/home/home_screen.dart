import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/tournament/tournament_bloc.dart';
import 'package:football_app/bloc/tournament/tournament_event.dart';
import 'package:football_app/bloc/tournament/tournament_state.dart';
import 'package:football_app/repository/tournament/tournament_repository.dart';
import 'package:football_app/view/home/widgets/search_textfield_widget.dart';
import 'package:football_app/view/home/widgets/tournaments_card.dart';
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
                  child: SearchTextfieldWidget(),
                ),

                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/images/futsal1.jpg",
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          height: 180,
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.4),
                        ),

                        Positioned(
                          left: 16,
                          bottom: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ready for the next match?",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                "Discover and register for futsal tournaments.",
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),

                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "Explore Tournaments",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

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
                      Row(
                        children: [
                          Text(
                            "View All",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Icon(Icons.arrow_right_outlined, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                BlocBuilder<TournamentBloc, TournamentState>(
                  builder: (context, state) {
                    // Loading
                    if (state.status == TournamentStatusState.loading ||
                        state.status == TournamentStatusState.initial) {
                      return const Padding(
                        padding: EdgeInsets.all(30),
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.green),
                        ),
                      );
                    }

                    // Error
                    if (state.status == TournamentStatusState.failure) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          state.error ?? 'Something went wrong',
                          style: GoogleFonts.poppins(color: Colors.redAccent),
                        ),
                      );
                    }

                    // Empty
                    if (state.tournaments.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'No tournaments available',
                          style: GoogleFonts.poppins(color: Colors.white70),
                        ),
                      );
                    }

                    // Success
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: state.tournaments.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) => TournamentCard(
                        tournament: state.tournaments[index],
                        onTap: () {},
                      ),
                    );
                  },
                ),
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
