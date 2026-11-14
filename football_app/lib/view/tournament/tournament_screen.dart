import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/all_tournaments/all_tournaments_bloc.dart';
import 'package:football_app/bloc/all_tournaments/all_tournaments_event.dart';
import 'package:football_app/bloc/all_tournaments/all_tournaments_state.dart';
import 'package:football_app/repository/tournament/tournament_repository.dart';
import 'package:football_app/view/tournament/widgets/search_textfield_tournament_widget.dart';
import 'package:football_app/view/tournament/widgets/tournament_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class TournamentScreen extends StatelessWidget {
  const TournamentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AllTournamentsBloc(context.read<TournamentRepository>())
            ..add(const AllTournamentsEvent.loadAll()),
      child: const _TournamentView(),
    );
  }
}

class _TournamentView extends StatelessWidget {
  const _TournamentView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 75),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Expanded(child: SearchTextfieldTournamentWidget()),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.tune, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "All Tournaments",
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ---- Tournament list below "All Tournaments" ----
          Expanded(
            child: BlocBuilder<AllTournamentsBloc, AllTournamentsState>(
              builder: (context, state) {
                switch (state.status) {
                  case AllTournamentsStatus.initial:
                  case AllTournamentsStatus.loading:
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );

                  case AllTournamentsStatus.failure:
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.errorMessage ?? 'Something went wrong',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () => context
                                .read<AllTournamentsBloc>()
                                .add(const AllTournamentsEvent.loadAll()),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );

                  case AllTournamentsStatus.success:
                    if (state.tournaments.isEmpty) {
                      return const Center(
                        child: Text(
                          'No tournaments found',
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () async => context
                          .read<AllTournamentsBloc>()
                          .add(const AllTournamentsEvent.loadAll()),
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                        itemCount: state.tournaments.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, i) => TournamentCardWidget(
                          tournament: state.tournaments[i],
                          onTap: () {},
                        ),
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
