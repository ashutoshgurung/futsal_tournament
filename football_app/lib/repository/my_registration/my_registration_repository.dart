import 'package:football_app/model/my_registration/my_registration_model.dart';

abstract class RegistrationRepository {
  Future<List<MyRegistrationModel>> getMyRegistrations();
}

class MyRegistrationRepository implements RegistrationRepository {
  @override
  Future<List<MyRegistrationModel>> getMyRegistrations() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      MyRegistrationModel(
        id: 'REG-001',
        tournamentName: 'Pokhara Futsal Cup',
        teamName: 'Thunder FC',
        location: 'Lakeside, Pokhara',
        tournamentDate: DateTime(2026, 11, 15),
        registeredAt: DateTime(2026, 11, 1),
        registrationStatus: 'approved',
        paymentStatus: 'paid',
        captainName: 'Ashutosh Gurung',
        captainPhone: '9800000000',
        registrationFee: 'Rs. 2,000',
        players: [
          'Ashutosh Gurung',
          'Ram Thapa',
          'Suman Gurung',
          'Bibek Sharma',
          'Anish Rai',
        ],
      ),
      MyRegistrationModel(
        id: 'REG-002',
        tournamentName: 'Weekend Futsal League',
        teamName: 'Thunder FC',
        location: 'Pokhara',
        tournamentDate: DateTime(2026, 10, 20),
        registeredAt: DateTime(2026, 10, 5),
        registrationStatus: 'approved',
        paymentStatus: 'paid',
        captainName: 'Ashutosh Gurung',
        captainPhone: '9800000000',
        registrationFee: 'Rs. 1,500',
        players: [
          'Ashutosh Gurung',
          'Ram Thapa',
          'Suman Gurung',
          'Bibek Sharma',
          'Anish Rai',
        ],
      ),
      MyRegistrationModel(
        id: 'REG-003',
        tournamentName: 'Pokhara Champions League',
        teamName: 'Thunder FC',
        location: 'Bagar, Pokhara',
        tournamentDate: DateTime(2026, 11, 25),
        registeredAt: DateTime(2026, 11, 5),
        registrationStatus: 'pending',
        paymentStatus: 'unpaid',
        captainName: 'Ashutosh Gurung',
        captainPhone: '9800000000',
        registrationFee: 'Rs. 2,500',
        players: [
          'Ashutosh Gurung',
          'Ram Thapa',
          'Suman Gurung',
          'Bibek Sharma',
          'Anish Rai',
        ],
      ),
    ];
  }
}
