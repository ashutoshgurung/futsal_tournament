import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/teams/teams_bloc.dart';
import 'package:football_app/bloc/teams/teams_event.dart';
import 'package:football_app/bloc/teams/teams_state.dart';
import 'package:football_app/model/team/team.dart';
import 'package:football_app/repository/teams/teams_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class OrganizerTeamsScreen extends StatelessWidget {
  const OrganizerTeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Later: provide the repository higher up (RepositoryProvider / get_it)
    return BlocProvider(
      create: (_) =>
          TeamsBloc(MockTeamsRepository())..add(const TeamsEvent.started()),
      child: const _TeamsView(),
    );
  }
}

class _TeamsView extends StatelessWidget {
  const _TeamsView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeamsBloc, TeamsState>(
      listenWhen: (p, c) =>
          p.errorMessage != c.errorMessage && c.errorMessage != null,
      listener: (context, state) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Teams',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton.filled(
                    style: IconButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      // TODO: push AddTeamScreen, then:
                      // context.read<TeamsBloc>().add(TeamsEvent.teamAdded(team));
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (v) =>
                    context.read<TeamsBloc>().add(TeamsEvent.searchChanged(v)),
                style: GoogleFonts.poppins(color: Colors.white),
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  hintText: 'Search teams',
                  hintStyle: GoogleFonts.poppins(color: Colors.white38),
                  prefixIcon: const Icon(Icons.search, color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF1C1C1E),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Expanded(child: _TeamsBody()),
            ],
          ),
        ),
      ),
    );
  }
}

class _TeamsBody extends StatelessWidget {
  const _TeamsBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamsBloc, TeamsState>(
      builder: (context, state) {
        switch (state.status) {
          case TeamsStatus.initial:
          case TeamsStatus.loading:
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );

          case TeamsStatus.failure:
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Something went wrong',
                    style: GoogleFonts.poppins(color: Colors.white54),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => context.read<TeamsBloc>().add(
                      const TeamsEvent.started(),
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );

          case TeamsStatus.success:
            final teams = state.visibleTeams;
            return RefreshIndicator(
              color: Colors.green,
              onRefresh: () async {
                final bloc = context.read<TeamsBloc>();
                bloc.add(const TeamsEvent.refreshed());
                await bloc.stream.firstWhere((s) => s != state);
              },
              child: teams.isEmpty
                  ? ListView(
                      // ListView so pull-to-refresh works on the empty state
                      children: [
                        const SizedBox(height: 120),
                        Center(
                          child: Text(
                            'No teams found',
                            style: GoogleFonts.poppins(color: Colors.white54),
                          ),
                        ),
                      ],
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: teams.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, i) => _TeamTile(teams[i]),
                    ),
            );
        }
      },
    );
  }
}

class _TeamTile extends StatelessWidget {
  final Team team;
  const _TeamTile(this.team);

  @override
  Widget build(BuildContext context) {
    // Your existing tile code, unchanged. Add swipe-to-delete if you want:
    return Dismissible(
      key: ValueKey(team.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade700,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) =>
          context.read<TeamsBloc>().add(TeamsEvent.teamDeleted(team.id)),
      child: Material(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // TODO: navigate to team details
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.green.withValues(alpha: 0.25),
                  child: Text(
                    team.name[0].toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        team.name,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${team.city} • ${team.players} players',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white38),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
