import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/tie_sheet/tie_sheet_bloc.dart';
import 'package:football_app/model/tie_sheet/tie_sheet_models.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';

class TieSheetDetailScreen extends StatefulWidget {
  const TieSheetDetailScreen({super.key, required this.id});
  final String id;

  @override
  State<TieSheetDetailScreen> createState() => _TieSheetDetailScreenState();
}

class _TieSheetDetailScreenState extends State<TieSheetDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TieSheetBloc>().add(TieSheetEvent.detailRequested(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TieSheetBloc, TieSheetState>(
      listenWhen: (p, c) => p.submitStatus != c.submitStatus,
      listener: (context, state) {
        if (state.submitStatus == TieSheetStatus.failure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage ?? 'Error')));
        }
        if (state.submitStatus == TieSheetStatus.success &&
            state.lastAction == TieSheetAction.deleted) {
          context.pop();
        }
        context.read<TieSheetBloc>().add(const TieSheetEvent.messageConsumed());
      },
      builder: (context, state) {
        final sheet = state.selected;
        return Scaffold(
          appBar: AppBar(
            title: Text(sheet?.name ?? 'Tie sheet'),
            actions: [
              if (sheet != null) ...[
                IconButton(
                  tooltip: sheet.isPublished ? 'Unpublish' : 'Publish',
                  icon: Icon(sheet.isPublished ? Icons.public : Icons.public_off),
                  onPressed: () => context.read<TieSheetBloc>().add(
                      TieSheetEvent.metaUpdated(id: sheet.id, isPublished: !sheet.isPublished)),
                ),
                IconButton(
                  tooltip: sheet.isLocked ? 'Unlock' : 'Lock',
                  icon: Icon(sheet.isLocked ? Icons.lock : Icons.lock_open),
                  onPressed: () => context.read<TieSheetBloc>().add(
                      TieSheetEvent.metaUpdated(id: sheet.id, isLocked: !sheet.isLocked)),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: sheet.isLocked
                      ? null
                      : () => context.read<TieSheetBloc>().add(TieSheetEvent.deleted(sheet.id)),
                ),
              ],
            ],
          ),
          body: () {
            if (state.isDetailLoading && sheet == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (sheet == null) return Center(child: Text(state.errorMessage ?? 'Not found'));
            return _Bracket(rounds: sheet.rounds);
          }(),
        );
      },
    );
  }
}

class _Bracket extends StatelessWidget {
  const _Bracket({required this.rounds});
  final List<BracketRound> rounds;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final r in rounds)
            SizedBox(
              width: 200,
              child: Column(
                children: [
                  Text(r.name, style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 8),
                  for (final m in r.matches)
                    Card(
                      margin: const EdgeInsets.only(right: 12, bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _row(m.team1?.name ?? 'TBD', m.team1Score, m.winnerId == m.team1Id && m.team1Id != null),
                            _row(m.isBye ? 'BYE' : (m.team2?.name ?? 'TBD'), m.team2Score,
                                m.winnerId == m.team2Id && m.team2Id != null),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _row(String name, int? score, bool won) => Row(
        children: [
          Expanded(
            child: Text(name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: won ? FontWeight.bold : FontWeight.normal)),
          ),
          if (score != null) Text('$score'),
        ],
      );
}