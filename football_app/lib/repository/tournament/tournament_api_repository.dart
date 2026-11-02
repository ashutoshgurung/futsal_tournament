// import 'package:football_app/data/network/base_api_services.dart';
// import 'package:football_app/model/tournament/tournament_model.dart';

// import 'package:football_app/repository/tournament/tournament_repository.dart';

// class TournamentApiRepository implements TournamentRepository {
//   final BaseApiServices _api;
//   TournamentApiRepository(this._api);

//   // Android emulator: 10.0.2.2 | iOS simulator: localhost | real phone: your PC's LAN IP
//   static const String _baseUrl = 'http://10.0.2.2:5000';

//   @override
//   Future<List<TournamentModel>> getUpcomingTournaments() async {
//     final res = await _api.getApi('$_baseUrl/api/tournaments?status=upcoming');

//     // Works whether the API returns [ ... ] or { "data": [ ... ] }
//     final List list = res is List ? res : (res['data'] as List);

//     return list
//         .map((e) => TournamentModel.fromJson(e as Map<String, dynamic>))
//         .toList();
//   }
// }
import 'package:football_app/data/network/base_api_services.dart';
import 'package:football_app/model/tournament/tournament_model.dart';
import 'package:football_app/repository/tournament/tournament_repository.dart';

class TournamentApiRepository implements TournamentRepository {
  final BaseApiServices _api;
  TournamentApiRepository(this._api);

  // Android emulator: 10.0.2.2 | iOS simulator: localhost | real phone: your PC's LAN IP
  static const String _baseUrl = 'http://192.168.0.4:5001';

  @override
  Future<List<TournamentModel>> getUpcomingTournaments() async {
    // Public route: no token needed. Backend returns { success, data: [...], meta }
    final res = await _api.getApi('$_baseUrl/api/tournaments/public');

    final List list = res is List ? res : (res['data'] as List? ?? []);

    return list
        .map((e) => TournamentModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
