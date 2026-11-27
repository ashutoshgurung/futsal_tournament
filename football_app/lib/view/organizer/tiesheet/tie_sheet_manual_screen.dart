import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:football_app/bloc/tie_sheet/tie_sheet_bloc.dart';
import 'package:football_app/config/routes/route_names.dart';
import 'package:football_app/model/tie_sheet/tie_sheet_models.dart';

class TieSheetManualScreen extends StatefulWidget {
  const TieSheetManualScreen({
    super.key,
    required this.tournamentId,
    required this.teams,
  });

  final String tournamentId;

  /// All teams of the tournament (id + name), passed in from the previous screen.
  final List<Team> teams;

  @override
  State<TieSheetManualScreen> createState() => _TieSheetManualScreenState();
}

class _TieSheetManualScreenState extends State<TieSheetManualScreen> {
  static const _matchCounts = [1, 2, 4, 8, 16, 32];

  final _name = TextEditingController(text: 'Main Draw');
  bool _thirdPlace = false;

  /// pairs[i] = [team1, team2]; null = empty slot (a bye if team2 is empty).
  late List<List<Team?>> _pairs;

  @override
  void initState() {
    super.initState();
    final needed = (widget.teams.length / 2).ceil();
    final count = _matchCounts.firstWhere(
      (c) => c >= needed,
      orElse: () => _matchCounts.last,
    );
    _pairs = _emptyPairs(count);
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  /* ───────────── helpers ───────────── */

  List<List<Team?>> _emptyPairs(int count) =>
      List.generate(count, (_) => <Team?>[null, null]);

  Set<String> get _assignedIds => _pairs
      .expand((p) => p)
      .whereType<Team>()
      .map((t) => t.id)
      .toSet();

  List<Team> get _unassigned =>
      widget.teams.where((t) => !_assignedIds.contains(t.id)).toList();

  int get _assignedCount => _assignedIds.length;

  void _resize(int count) {
    setState(() {
      if (count > _pairs.length) {
        _pairs = [..._pairs, ..._emptyPairs(count - _pairs.length)];
      } else {
        _pairs = _pairs.sublist(0, count); // teams in removed rows become unassigned
      }
    });
  }

  void _autoFill() {
    final shuffled = [...widget.teams]..shuffle(Random());
    setState(() {
      _pairs = _emptyPairs(_pairs.length);
      var i = 0;
      for (final team in shuffled) {
        if (i >= _pairs.length * 2) break;
        _pairs[i ~/ 2][i % 2] = team;
        i++;
      }
    });
  }

  void _clearAll() => setState(() => _pairs = _emptyPairs(_pairs.length));

  Future<void> _pick(int pairIndex, int slot) async {
    final current = _pairs[pairIndex][slot];
    final options = _unassigned;

    final result = await showModalBottomSheet<_PickResult>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        builder: (_, controller) => ListView(
          controller: controller,
          children: [
            if (current != null)
              ListTile(
                leading: const Icon(Icons.close),
                title: Text(slot == 1 ? 'Clear (make BYE)' : 'Clear slot'),
                onTap: () => Navigator.pop(ctx, const _PickResult(null)),
              ),
            if (options.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: Text('All teams are already placed')),
              ),
            for (final t in options)
              ListTile(
                leading: const Icon(Icons.shield_outlined),
                title: Text(t.name),
                subtitle: t.shortName != null ? Text(t.shortName!) : null,
                onTap: () => Navigator.pop(ctx, _PickResult(t)),
              ),
          ],
        ),
      ),
    );

    if (result == null) return; // dismissed
    setState(() => _pairs[pairIndex][slot] = result.team);
  }

  void _submit() {
    final pairings = <Pairing>[];

    for (var i = 0; i < _pairs.length; i++) {
      var a = _pairs[i][0];
      var b = _pairs[i][1];
      if (a == null && b == null) {
        _snack('Match ${i + 1} has no teams. Fill it or reduce the number of matches.');
        return;
      }
      if (a == null) {
        a = b; // a lone team always goes in slot 1 (bye)
        b = null;
      }
      pairings.add(Pairing(team1Id: a!.id, team2Id: b?.id));
    }

    if (_assignedCount < 2) {
      _snack('Place at least 2 teams');
      return;
    }
    if (_assignedCount < widget.teams.length) {
      _snack('${widget.teams.length - _assignedCount} team(s) are not placed yet');
      return;
    }

    context.read<TieSheetBloc>().add(TieSheetEvent.manualSubmitted(
          tournamentId: widget.tournamentId,
          name: _name.text.trim().isEmpty ? null : _name.text.trim(),
          pairings: pairings,
          thirdPlaceMatch: _thirdPlace,
        ));
  }

  void _snack(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  /* ───────────── UI ───────────── */

  @override
  Widget build(BuildContext context) {
    return BlocListener<TieSheetBloc, TieSheetState>(
      listenWhen: (p, c) => p.submitStatus != c.submitStatus,
      listener: (context, state) {
        if (state.submitStatus == TieSheetStatus.failure) {
          _snack(state.errorMessage ?? 'Error');
          context.read<TieSheetBloc>().add(const TieSheetEvent.messageConsumed());
        }
        if (state.submitStatus == TieSheetStatus.success &&
            state.lastAction == TieSheetAction.created) {
          final id = state.selected!.id;
          context.read<TieSheetBloc>().add(const TieSheetEvent.messageConsumed());
          context.pushReplacement(RouteNames.tieSheetDetailOf(id));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manual draw'),
          actions: [
            IconButton(
              tooltip: 'Auto fill (random)',
              icon: const Icon(Icons.shuffle),
              onPressed: _autoFill,
            ),
            IconButton(
              tooltip: 'Clear all',
              icon: const Icon(Icons.clear_all),
              onPressed: _clearAll,
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                children: [
                  TextField(
                    controller: _name,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text('First-round matches'),
                      const Spacer(),
                      DropdownButton<int>(
                        value: _pairs.length,
                        items: [
                          for (final c in _matchCounts)
                            DropdownMenuItem(value: c, child: Text('$c')),
                        ],
                        onChanged: (v) => v == null ? null : _resize(v),
                      ),
                    ],
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: _thirdPlace,
                    onChanged: (v) => setState(() => _thirdPlace = v),
                    title: const Text('Third place match'),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Placed $_assignedCount / ${widget.teams.length} teams',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: _pairs.length,
                itemBuilder: (_, i) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Match ${i + 1}',
                            style: Theme.of(context).textTheme.labelLarge),
                        const SizedBox(height: 8),
                        _SlotTile(
                          team: _pairs[i][0],
                          placeholder: 'Select team 1',
                          onTap: () => _pick(i, 0),
                        ),
                        const SizedBox(height: 6),
                        _SlotTile(
                          team: _pairs[i][1],
                          placeholder:
                              _pairs[i][0] != null ? 'BYE (tap to select team 2)' : 'Select team 2',
                          isBye: _pairs[i][0] != null && _pairs[i][1] == null,
                          onTap: () => _pick(i, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<TieSheetBloc, TieSheetState>(
              buildWhen: (p, c) => p.submitStatus != c.submitStatus,
              builder: (context, state) => FilledButton(
                onPressed: state.isSubmitting ? null : _submit,
                child: state.isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Create draw'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PickResult {
  const _PickResult(this.team);
  final Team? team; // null = clear
}

class _SlotTile extends StatelessWidget {
  const _SlotTile({
    required this.team,
    required this.placeholder,
    required this.onTap,
    this.isBye = false,
  });

  final Team? team;
  final String placeholder;
  final bool isBye;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: team != null ? scheme.primary : scheme.outlineVariant),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              team != null ? Icons.shield : (isBye ? Icons.skip_next : Icons.add),
              size: 18,
              color: team != null ? scheme.primary : scheme.outline,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                team?.name ?? placeholder,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: team != null ? null : scheme.outline,
                  fontWeight: team != null ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}