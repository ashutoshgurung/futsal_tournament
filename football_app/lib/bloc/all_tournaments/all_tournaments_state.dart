import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:football_app/model/tournament/tournament_model.dart';

part 'all_tournaments_state.freezed.dart';

enum AllTournamentsStatus { initial, loading, success, failure }

@freezed
abstract class AllTournamentsState with _$AllTournamentsState {
  const factory AllTournamentsState({
    @Default(AllTournamentsStatus.initial) AllTournamentsStatus status,
    @Default(<TournamentModel>[]) List<TournamentModel> tournaments,
    String? errorMessage,
  }) = _AllTournamentsState;
}
