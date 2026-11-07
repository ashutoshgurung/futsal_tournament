import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/tournament/tournament_bloc.dart';
import 'package:football_app/bloc/tournament/tournament_state.dart';
import 'package:football_app/view/home/widgets/tournaments_card.dart';
import 'package:google_fonts/google_fonts.dart';

class TournamentList extends StatelessWidget {
  const TournamentList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentBloc, TournamentState>(
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
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) => TournamentCard(
            tournament: state.tournaments[index],
            onTap: () {},
          ),
        );
      },
    );
  }
}
