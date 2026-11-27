import 'package:football_app/model/tie_sheet/tie_sheet_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'tie_sheet_event.freezed.dart';

@freezed
class TieSheetEvent with _$TieSheetEvent {
  /// Load all tie sheets of a tournament (list screen).
  const factory TieSheetEvent.listRequested(String tournamentId) = TieSheetListRequested;

  /// Load one tie sheet with its rounds/matches (bracket screen).
  const factory TieSheetEvent.detailRequested(String id) = TieSheetDetailRequested;

  /// Automatic draw.
  const factory TieSheetEvent.generateSubmitted({
    required String tournamentId,
    String? name,
    @Default('random') String seedingMethod,
    @Default([]) List<String> seeds,
    @Default(false) bool thirdPlaceMatch,
  }) = TieSheetGenerateSubmitted;

  /// Manual draw: organizer picks every first-round pairing.
  const factory TieSheetEvent.manualSubmitted({
    required String tournamentId,
    String? name,
    required List<Pairing> pairings,
    @Default(false) bool thirdPlaceMatch,
  }) = TieSheetManualSubmitted;

  /// Re-arrange an existing draw before play starts.
  const factory TieSheetEvent.pairingsReplaced({
    required String id,
    required List<Pairing> pairings,
    bool? thirdPlaceMatch,
  }) = TieSheetPairingsReplaced;

  /// Rename / publish / lock.
  const factory TieSheetEvent.metaUpdated({
    required String id,
    String? name,
    bool? isPublished,
    bool? isLocked,
  }) = TieSheetMetaUpdated;

  const factory TieSheetEvent.deleted(String id) = TieSheetDeleted;

  /// Clears one-shot messages (error / success) after the UI has shown them.
  const factory TieSheetEvent.messageConsumed() = TieSheetMessageConsumed;
}