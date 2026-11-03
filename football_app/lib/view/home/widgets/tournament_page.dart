import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/tournament/tournament_bloc.dart';
import 'package:football_app/bloc/tournament/tournament_event.dart';
import 'package:football_app/bloc/tournament/tournament_state.dart';
import 'package:football_app/data/network/network_api_services.dart';
import 'package:football_app/repository/tournament/tournament_api_repository.dart';
import 'package:football_app/view/home/widgets/tournaments_card.dart';
import 'package:google_fonts/google_fonts.dart';

class TournamentsPage extends StatelessWidget {
  const TournamentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TournamentBloc(TournamentApiRepository(NetworkApiServices()))
            ..add(const TournamentEvent.loadUpcoming()),
      child: const _TournamentsView(),
    );
  }
}

class _TournamentsView extends StatelessWidget {
  const _TournamentsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Tournaments',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<TournamentBloc, TournamentState>(
        builder: (context, state) {
          switch (state.status) {
            case TournamentStatusState.initial:
            case TournamentStatusState.loading:
              return const Center(
                child: CircularProgressIndicator(color: Colors.green),
              );

            case TournamentStatusState.failure:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.wifi_off,
                        color: Colors.white54,
                        size: 40,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        state.error ?? 'Something went wrong',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(color: Colors.white70),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context.read<TournamentBloc>().add(
                          const TournamentEvent.loadUpcoming(),
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );

            case TournamentStatusState.success:
              if (state.tournaments.isEmpty) {
                return Center(
                  child: Text(
                    'No tournaments yet',
                    style: GoogleFonts.poppins(color: Colors.white54),
                  ),
                );
              }
              return RefreshIndicator(
                color: Colors.green,
                onRefresh: () async {
                  final bloc = context.read<TournamentBloc>();
                  bloc.add(const TournamentEvent.loadUpcoming());
                  await bloc.stream.firstWhere(
                    (s) => s.status != TournamentStatusState.loading,
                  );
                },
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: state.tournaments.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => TournamentCard(
                    tournament: state.tournaments[i],
                    onTap: () {
                      // TODO: navigate to tournament details
                    },
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
