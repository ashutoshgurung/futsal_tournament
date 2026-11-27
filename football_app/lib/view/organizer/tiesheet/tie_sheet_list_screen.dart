import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/tie_sheet/tie_sheet_bloc.dart';
import 'package:football_app/config/routes/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';

class TieSheetListScreen extends StatefulWidget {
  const TieSheetListScreen({super.key, required this.tournamentId});
  final String tournamentId;

  @override
  State<TieSheetListScreen> createState() => _TieSheetListScreenState();
}

class _TieSheetListScreenState extends State<TieSheetListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TieSheetBloc>().add(TieSheetEvent.listRequested(widget.tournamentId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tie Sheets')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(RouteNames.tieSheetCreateOf(widget.tournamentId)),
        icon: const Icon(Icons.add),
        label: const Text('New draw'),
      ),
      body: BlocBuilder<TieSheetBloc, TieSheetState>(
        buildWhen: (p, c) => p.listStatus != c.listStatus || p.sheets != c.sheets,
        builder: (context, state) {
          if (state.isListLoading) return const Center(child: CircularProgressIndicator());
          if (state.listStatus == TieSheetStatus.failure) {
            return Center(child: Text(state.errorMessage ?? 'Something went wrong'));
          }
          if (state.sheets.isEmpty) return const Center(child: Text('No tie sheets yet'));
          return ListView.separated(
            itemCount: state.sheets.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final s = state.sheets[i];
              return ListTile(
                title: Text(s.name),
                subtitle: Text('${s.bracketSize} slots · ${s.seedingMethod}'),
                trailing: Icon(s.isPublished ? Icons.public : Icons.lock_outline),
                onTap: () => context.push(RouteNames.tieSheetDetailOf(s.id)),
              );
            },
          );
        },
      ),
    );
  }
}