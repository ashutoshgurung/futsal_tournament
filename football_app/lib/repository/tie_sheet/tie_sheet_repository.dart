import 'package:dio/dio.dart';
import 'package:football_app/model/tie_sheet/tie_sheet_models.dart';

class TieSheetRepository {
  TieSheetRepository(this._dio);
  final Dio _dio; // baseUrl + auth interceptor already configured

  static const _base = '/tie-sheets';

  Future<List<TieSheet>> list(String tournamentId) async {
    final res = await _dio.get(_base, queryParameters: {'tournamentId': tournamentId});
    return (res.data['data'] as List)
        .map((e) => TieSheet.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<TieSheet> get(String id) async {
    final res = await _dio.get('$_base/$id');
    return TieSheet.fromJson(res.data['data']);
  }

  Future<TieSheet> generate({
    required String tournamentId,
    String? name,
    String seedingMethod = 'random', // 'random' | 'seeded'
    List<String> seeds = const [],
    bool thirdPlaceMatch = false,
  }) async {
    final res = await _dio.post('$_base/generate', data: {
      'tournamentId': tournamentId,
      if (name != null) 'name': name,
      'seedingMethod': seedingMethod,
      'seeds': seeds,
      'thirdPlaceMatch': thirdPlaceMatch,
    });
    return TieSheet.fromJson(res.data['data']);
  }

  Future<TieSheet> createManual({
    required String tournamentId,
    String? name,
    required List<Pairing> pairings,
    bool thirdPlaceMatch = false,
  }) async {
    final res = await _dio.post('$_base/manual', data: {
      'tournamentId': tournamentId,
      if (name != null) 'name': name,
      'pairings': pairings.map(_pairingJson).toList(),
      'thirdPlaceMatch': thirdPlaceMatch,
    });
    return TieSheet.fromJson(res.data['data']);
  }

  Future<TieSheet> replacePairings(
    String id, {
    required List<Pairing> pairings,
    bool? thirdPlaceMatch,
  }) async {
    final res = await _dio.put('$_base/$id/pairings', data: {
      'pairings': pairings.map(_pairingJson).toList(),
      if (thirdPlaceMatch != null) 'thirdPlaceMatch': thirdPlaceMatch,
    });
    return TieSheet.fromJson(res.data['data']);
  }

  Future<TieSheet> update(String id, {String? name, bool? isPublished, bool? isLocked}) async {
    final res = await _dio.patch('$_base/$id', data: {
      if (name != null) 'name': name,
      if (isPublished != null) 'isPublished': isPublished,
      if (isLocked != null) 'isLocked': isLocked,
    });
    return TieSheet.fromJson(res.data['data']);
  }

  Future<void> delete(String id) => _dio.delete('$_base/$id');

  // drop null team2Id so backend treats it as a bye
  Map<String, dynamic> _pairingJson(Pairing p) => {
        if (p.team1Id != null) 'team1Id': p.team1Id,
        if (p.team2Id != null) 'team2Id': p.team2Id,
      };
}