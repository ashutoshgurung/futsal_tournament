import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:football_app/model/tournament/tournament_model.dart';

part 'tournament_state.freezed.dart';

enum TournamentStatusState { initial, loading, success, failure }

@freezed
abstract class TournamentState with _$TournamentState {
  const factory TournamentState({
    @Default(TournamentStatusState.initial) TournamentStatusState status,
    @Default([]) List<TournamentModel> tournaments,
    String? error,
  }) = _TournamentState;
}
