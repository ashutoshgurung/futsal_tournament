import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _Team {
  final String name;
  final String city;
  final int players;

  const _Team({required this.name, required this.city, required this.players});
}

// TODO: replace with data from your Bloc / repository.
const _mockTeams = <_Team>[
  _Team(name: 'Lakeside FC', city: 'Pokhara', players: 18),
  _Team(name: 'Annapurna United', city: 'Pokhara', players: 20),
  _Team(name: 'Fewa Warriors', city: 'Lekhnath', players: 16),
  _Team(name: 'Machhapuchhre SC', city: 'Kaski', players: 22),
  _Team(name: 'Gandaki Strikers', city: 'Syangja', players: 19),
];

class OrganizerTeamsScreen extends StatefulWidget {
  const OrganizerTeamsScreen({super.key});

  @override
  State<OrganizerTeamsScreen> createState() => _OrganizerTeamsScreenState();
}

class _OrganizerTeamsScreenState extends State<OrganizerTeamsScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final teams = _mockTeams
        .where((t) =>
            t.name.toLowerCase().contains(_query.toLowerCase()) ||
            t.city.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return SafeArea(
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
                    // TODO: navigate to add team screen
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (v) => setState(() => _query = v),
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
            Expanded(
              child: teams.isEmpty
                  ? Center(
                      child: Text(
                        'No teams found',
                        style: GoogleFonts.poppins(color: Colors.white54),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: teams.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, i) => _TeamTile(teams[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamTile extends StatelessWidget {
  final _Team team;
  const _TeamTile(this.team);

  @override
  Widget build(BuildContext context) {
    return Material(
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
    );
  }
}