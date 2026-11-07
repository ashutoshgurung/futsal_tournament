import 'package:flutter/material.dart';
import 'package:football_app/model/my_registration/my_registration_model.dart';

class RegistrationDetails extends StatelessWidget {
  final MyRegistrationModel registration;

  const RegistrationDetails({
    required this.registration,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                registration.tournamentName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                registration.teamName,
                style: const TextStyle(
                  color: Color(0xFFB6F36B),
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 22),
              _detailRow('Location', registration.location),
              _detailRow(
                'Tournament date',
                formatDate(registration.tournamentDate),
              ),
              _detailRow(
                'Registered on',
                formatDate(registration.registeredAt),
              ),
              _detailRow('Registration fee', 'Rs. ${registration.registrationFee}'),
              _detailRow('Registration status', registration.registrationStatus),
              _detailRow('Payment status', registration.paymentStatus),
              const SizedBox(height: 20),
              const Text(
                'Captain Information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              _detailRow('Captain name', registration.captainName),
              _detailRow('Phone number', registration.captainPhone),
              const SizedBox(height: 20),
              const Text(
                'Team Players',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              ...registration.players.asMap().entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: const Color(0xFFB6F36B)
                            .withValues(alpha: 0.15),
                        child: Text(
                          '${entry.key + 1}',
                          style: const TextStyle(
                            color: Color(0xFFB6F36B),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        entry.value,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String formatDate(DateTime date) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  return '${date.day} ${months[date.month - 1]} ${date.year}';
}