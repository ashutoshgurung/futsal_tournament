import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/tie_sheet/tie_sheet_bloc.dart';
import 'package:football_app/config/routes/route_names.dart';
import 'package:go_router/go_router.dart';

class TieSheetCreateScreen extends StatefulWidget {
  const TieSheetCreateScreen({super.key, required this.tournamentId});
  final String tournamentId;

  @override
  State<TieSheetCreateScreen> createState() => _TieSheetCreateScreenState();
}

class _TieSheetCreateScreenState extends State<TieSheetCreateScreen> {
  final _name = TextEditingController(text: 'Main Draw');
  bool _thirdPlace = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TieSheetBloc, TieSheetState>(
      listenWhen: (p, c) => p.submitStatus != c.submitStatus,
      listener: (context, state) {
        if (state.submitStatus == TieSheetStatus.failure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage ?? 'Error')));
          context.read<TieSheetBloc>().add(const TieSheetEvent.messageConsumed());
        }
        if (state.submitStatus == TieSheetStatus.success &&
            (state.lastAction == TieSheetAction.generated ||
                state.lastAction == TieSheetAction.created)) {
          final id = state.selected!.id;
          context.read<TieSheetBloc>().add(const TieSheetEvent.messageConsumed());
          context.pushReplacement(RouteNames.tieSheetDetailOf(id));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Generate draw')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(controller: _name, decoration: const InputDecoration(labelText: 'Name')),
              SwitchListTile(
                value: _thirdPlace,
                onChanged: (v) => setState(() => _thirdPlace = v),
                title: const Text('Third place match'),
              ),
              const Spacer(),
              BlocBuilder<TieSheetBloc, TieSheetState>(
                buildWhen: (p, c) => p.submitStatus != c.submitStatus,
                builder: (context, state) => SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: state.isSubmitting
                        ? null
                        : () => context.read<TieSheetBloc>().add(
                              TieSheetEvent.generateSubmitted(
                                tournamentId: widget.tournamentId,
                                name: _name.text.trim(),
                                thirdPlaceMatch: _thirdPlace,
                              ),
                            ),
                    child: state.isSubmitting
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Generate'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}