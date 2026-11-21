import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum TournamentStatus { ongoing, upcoming, completed }

const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String _fmt(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')} ${_months[d.month - 1]}';

class Tournament {
  final String name;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final int teams;

  const Tournament({
    required this.name,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.teams,
  });

  String get dates => '${_fmt(startDate)} - ${_fmt(endDate)}';

  TournamentStatus get status {
    final n = DateTime.now();
    final today = DateTime(n.year, n.month, n.day);
    if (today.isBefore(startDate)) return TournamentStatus.upcoming;
    if (today.isAfter(endDate)) return TournamentStatus.completed;
    return TournamentStatus.ongoing;
  }
}

class OrganizerTournamentsScreen extends StatefulWidget {
  const OrganizerTournamentsScreen({super.key});

  @override
  State<OrganizerTournamentsScreen> createState() =>
      _OrganizerTournamentsScreenState();
}

class _OrganizerTournamentsScreenState extends State<OrganizerTournamentsScreen> {
  final List<Tournament> _tournaments = [];
  TournamentStatus? _filter; // null = All

  Future<void> _openCreateSheet() async {
    final created = await showModalBottomSheet<Tournament>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1C1C1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _TournamentForm(),
    );
    if (created != null) {
      setState(() => _tournaments.insert(0, created));
    }
  }

  void _delete(Tournament t) {
    final index = _tournaments.indexOf(t);
    setState(() => _tournaments.remove(t));
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text('"${t.name}" deleted', style: GoogleFonts.poppins()),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => setState(() => _tournaments.insert(index, t)),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final items = _filter == null
        ? _tournaments
        : _tournaments.where((t) => t.status == _filter).toList();

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
                    'Tournaments',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton.filled(
                  style: IconButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: _openCreateSheet,
                  icon: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 38,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _filterChip('All', null),
                  _filterChip('Ongoing', TournamentStatus.ongoing),
                  _filterChip('Upcoming', TournamentStatus.upcoming),
                  _filterChip('Completed', TournamentStatus.completed),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: items.isEmpty
                  ? _emptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, i) {
                        final t = items[i];
                        return Dismissible(
                          key: ObjectKey(t),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) => _delete(t),
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 24),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: _TournamentCard(t),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState() {
    final noneAtAll = _tournaments.isEmpty;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.emoji_events_outlined,
            size: 56,
            color: Colors.white24,
          ),
          const SizedBox(height: 12),
          Text(
            noneAtAll ? 'No tournaments yet' : 'No tournaments in this filter',
            style: GoogleFonts.poppins(color: Colors.white54),
          ),
          if (noneAtAll) ...[
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _openCreateSheet,
              icon: const Icon(Icons.add, color: Colors.white),
              label: Text(
                'Create tournament',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _filterChip(String label, TournamentStatus? value) {
    final selected = _filter == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: selected ? Colors.white : Colors.white70,
          ),
        ),
        selected: selected,
        showCheckmark: false,
        backgroundColor: const Color(0xFF1C1C1E),
        selectedColor: Colors.green,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onSelected: (_) => setState(() => _filter = value),
      ),
    );
  }
}

// ───────────────────────── Create form ─────────────────────────

class _TournamentForm extends StatefulWidget {
  const _TournamentForm();

  @override
  State<_TournamentForm> createState() => _TournamentFormState();
}

class _TournamentFormState extends State<_TournamentForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _teamsCtrl = TextEditingController();
  DateTime? _start;
  DateTime? _end;
  String? _dateError;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _locationCtrl.dispose();
    _teamsCtrl.dispose();
    super.dispose();
  }

  InputDecoration _dec(String label, IconData icon) => InputDecoration(
    labelText: label,
    labelStyle: GoogleFonts.poppins(color: Colors.white54, fontSize: 13),
    prefixIcon: Icon(icon, color: Colors.white54),
    filled: true,
    fillColor: Colors.black,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Colors.green),
    ),
  );

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final first = isStart
        ? DateTime(now.year - 1)
        : (_start ?? DateTime(now.year - 1));
    final picked = await showDatePicker(
      context: context,
      initialDate: (isStart ? _start : _end) ?? _start ?? now,
      firstDate: first,
      lastDate: DateTime(now.year + 5),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Colors.green,
            surface: Color(0xFF1C1C1E),
          ),
        ),
        child: child!,
      ),
    );
    if (picked == null) return;
    setState(() {
      _dateError = null;
      if (isStart) {
        _start = picked;
        if (_end != null && _end!.isBefore(picked)) _end = null;
      } else {
        _end = picked;
      }
    });
  }

  void _submit() {
    final valid = _formKey.currentState!.validate();
    if (_start == null || _end == null) {
      setState(() => _dateError = 'Please pick start and end dates');
      return;
    }
    if (!valid) return;

    Navigator.pop(
      context,
      Tournament(
        name: _nameCtrl.text.trim(),
        location: _locationCtrl.text.trim(),
        startDate: _start!,
        endDate: _end!,
        teams: int.parse(_teamsCtrl.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'New tournament',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameCtrl,
                style: GoogleFonts.poppins(color: Colors.white),
                cursorColor: Colors.green,
                textCapitalization: TextCapitalization.words,
                decoration: _dec(
                  'Tournament name',
                  Icons.emoji_events_outlined,
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter a name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _locationCtrl,
                style: GoogleFonts.poppins(color: Colors.white),
                cursorColor: Colors.green,
                textCapitalization: TextCapitalization.words,
                decoration: _dec('Location', Icons.location_on_outlined),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter a location' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _teamsCtrl,
                style: GoogleFonts.poppins(color: Colors.white),
                cursorColor: Colors.green,
                keyboardType: TextInputType.number,
                decoration: _dec('Number of teams', Icons.groups_outlined),
                validator: (v) {
                  final n = int.tryParse((v ?? '').trim());
                  if (n == null || n < 2) return 'Enter at least 2 teams';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _dateButton(
                      label: 'Start date',
                      value: _start,
                      onTap: () => _pickDate(isStart: true),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _dateButton(
                      label: 'End date',
                      value: _end,
                      onTap: () => _pickDate(isStart: false),
                    ),
                  ),
                ],
              ),
              if (_dateError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 4),
                  child: Text(
                    _dateError!,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Create tournament',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateButton({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: Colors.white54,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value == null ? label : _fmt(value),
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: value == null ? Colors.white54 : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── Card ─────────────────────────

class _TournamentCard extends StatelessWidget {
  final Tournament t;
  const _TournamentCard(this.t);

  Color get _statusColor => switch (t.status) {
    TournamentStatus.ongoing => Colors.green,
    TournamentStatus.upcoming => Colors.orangeAccent,
    TournamentStatus.completed => Colors.grey,
  };

  String get _statusLabel => switch (t.status) {
    TournamentStatus.ongoing => 'Ongoing',
    TournamentStatus.upcoming => 'Upcoming',
    TournamentStatus.completed => 'Completed',
  };

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1C1C1E),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // TODO: navigate to tournament details
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.emoji_events, color: Colors.amber),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      t.name,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _statusLabel,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _infoRow(Icons.location_on_outlined, t.location),
              const SizedBox(height: 6),
              _infoRow(Icons.calendar_today_outlined, t.dates),
              const SizedBox(height: 6),
              _infoRow(Icons.groups_outlined, '${t.teams} teams'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) => Row(
    children: [
      Icon(icon, size: 16, color: Colors.white54),
      const SizedBox(width: 8),
      Text(
        text,
        style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70),
      ),
    ],
  );
}
