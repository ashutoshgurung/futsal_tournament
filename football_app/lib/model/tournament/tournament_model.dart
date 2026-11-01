import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_model.freezed.dart';
part 'tournament_model.g.dart';

enum TournamentStatus { open, upcoming, registrationSoon }

@freezed
abstract class TournamentModel with _$TournamentModel {
  const TournamentModel._(); // needed so we can add getters below

  const factory TournamentModel({
    @JsonKey(name: '_id') required String id, // Mongo's id key
    required String name,
    required String location,
    required DateTime startDate,
    required DateTime endDate,
    @Default(0) int registeredTeams,
    @Default(0) int maxTeams,
    @JsonKey(name: 'image') @Default('') String imageUrl,
    @JsonKey(unknownEnumValue: TournamentStatus.upcoming)
    @Default(TournamentStatus.upcoming)
    TournamentStatus status,
  }) = _TournamentModel;

  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentModelFromJson(json);

  String get dateRange {
    const m = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final s = startDate, e = endDate;
    return '${m[s.month - 1]} ${s.day} – ${m[e.month - 1]} ${e.day}, ${e.year}';
  }
}