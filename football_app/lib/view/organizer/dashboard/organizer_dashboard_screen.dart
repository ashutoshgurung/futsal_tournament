import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:football_app/bloc/auth/auth_bloc.dart';
import 'package:football_app/data/exceptions/app_exceptions.dart';
import 'package:football_app/repository/organization/organization_repository.dart';
import 'package:football_app/view/organizer/widgets/verify_email_banner.dart';

class OrganizerDashboardScreen extends StatefulWidget {
  const OrganizerDashboardScreen({super.key});

  @override
  State<OrganizerDashboardScreen> createState() =>
      _OrganizerDashboardScreenState();
}

class _OrganizerDashboardScreenState extends State<OrganizerDashboardScreen> {
  Map<String, dynamic>? _usage;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final repo = context.read<OrganizationRepository>();
    setState(() {
      _loading = _usage == null; // keep old numbers during pull-to-refresh
      _error = null;
    });
    try {
      final res = await repo.fetchOverview();
      if (!mounted) return;
      setState(() {
        _usage = Map<String, dynamic>.from((res['usage'] as Map?) ?? {});
        _loading = false;
      });
    } on AppExceptions catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.userMessage;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Could not load your stats.';
        _loading = false;
      });
    }
  }

  String _count(String key) => _loading ? '–' : '${_usage?[key] ?? 0}';

  @override
  Widget build(BuildContext context) {
    final session = context.watch<AuthBloc>().state.session;
    final orgName =
        session?.organization?['name'] as String? ?? 'your organization';
    final userName = session?.user?['name'] as String? ?? '';

    return SafeArea(
      child: RefreshIndicator(
        color: Colors.green,
        onRefresh: _load,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              userName.isEmpty ? 'Welcome 👋' : 'Welcome, $userName 👋',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Managing $orgName',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white54),
            ),
            const SizedBox(height: 16),

            const VerifyEmailBanner(),

            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _error!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _load,
                      child: Text(
                        'Retry',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: [
                _StatCard('Tournaments', _count('tournaments'),
                    Icons.emoji_events_outlined),
                _StatCard('Teams', _count('teams'), Icons.groups_outlined),
                _StatCard('Players', _count('players'), Icons.person_outline),
                _StatCard('Matches', _count('matches'), Icons.sports_soccer),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard(this.label, this.value, this.icon);
  final String label, value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: Colors.green),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.white54),
          ),
        ],
      ),
    );
  }
}