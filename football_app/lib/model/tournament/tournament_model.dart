// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'tournament_model.freezed.dart';
// part 'tournament_model.g.dart';

// enum TournamentStatus { open, upcoming, ongoing, closed,  }

// class TournamentStatusConverter
//     implements JsonConverter<TournamentStatus, String?> {
//   const TournamentStatusConverter();

//   @override
//   TournamentStatus fromJson(String? json) {
//     switch (json) {
//       case 'draft':
//         return TournamentStatus.open;
//       case 'ongoing':
//         return TournamentStatus.ongoing;
//       case 'completed':
//         return TournamentStatus.closed;
//       default:
//         return TournamentStatus.upcoming;
//     }
//   }

//   @override
//   String toJson(TournamentStatus s) => s.name;
// }

// @freezed
// abstract class TournamentModel with _$TournamentModel {
//   const TournamentModel._();

//   const factory TournamentModel({
//     required String id,
//     required String name,
//     @JsonKey(name: 'venue') String? location,
//     DateTime? startDate,
//     DateTime? endDate,
//     @Default(0) int registeredTeams,
//     int? maxTeams,
//     String? imageUrl,
//     @TournamentStatusConverter()
//     @Default(TournamentStatus.upcoming)
//     TournamentStatus status,
//   }) = _TournamentModel;

//   factory TournamentModel.fromJson(Map<String, dynamic> json) =>
//       _$TournamentModelFromJson(json);

//   String get dateRange {
//     const m = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
//     final s = startDate?.toLocal(), e = endDate?.toLocal();
//     if (s == null) return 'Date TBA';
//     if (e == null) return '${m[s.month - 1]} ${s.day}, ${s.year}';
//     return '${m[s.month - 1]} ${s.day} – ${m[e.month - 1]} ${e.day}, ${e.year}';
//   }

//   String get teamsLabel => maxTeams == null
//       ? '$registeredTeams teams registered'
//       : '$registeredTeams/$maxTeams teams registered';
// }

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_model.freezed.dart';
part 'tournament_model.g.dart';

enum TournamentStatus { open, upcoming, ongoing, closed }

class TournamentStatusConverter
    implements JsonConverter<TournamentStatus, String?> {
  const TournamentStatusConverter();

  @override
  TournamentStatus fromJson(String? json) {
    switch (json) {
      case 'open':
        return TournamentStatus.open;
      case 'ongoing':
        return TournamentStatus.ongoing;
      case 'completed':
        return TournamentStatus.closed;
      default: // draft / upcoming
        return TournamentStatus.upcoming;
    }
  }

  @override
  String toJson(TournamentStatus s) =>
      s == TournamentStatus.closed ? 'completed' : s.name;
}

@freezed
abstract class TournamentModel with _$TournamentModel {
  const TournamentModel._();

  const factory TournamentModel({
    required String id,
    required String name,
    @JsonKey(name: 'venue') String? location,
    DateTime? startDate,
    DateTime? endDate,
    @Default(0) int registeredTeams,
    int? maxTeams,
    String? imageUrl,
    @TournamentStatusConverter()
    @Default(TournamentStatus.upcoming)
    TournamentStatus status,
  }) = _TournamentModel;

  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentModelFromJson(json);

  String get dateRange {
    const m = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final s = startDate?.toLocal(), e = endDate?.toLocal();
    if (s == null) return 'Date TBA';
    if (e == null) return '${m[s.month - 1]} ${s.day}, ${s.year}';
    return '${m[s.month - 1]} ${s.day} – ${m[e.month - 1]} ${e.day}, ${e.year}';
  }

  String get teamsLabel => maxTeams == null
      ? '$registeredTeams teams registered'
      : '$registeredTeams/$maxTeams teams registered';
}