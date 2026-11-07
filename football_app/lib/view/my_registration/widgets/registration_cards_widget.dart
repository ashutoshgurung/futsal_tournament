import 'package:flutter/material.dart';
import 'package:football_app/model/my_registration/my_registration_model.dart';
import 'package:football_app/view/my_registration/widgets/registration_details_bottom_sheet_widget.dart';
import 'package:football_app/view/my_registration/widgets/status+chip_widget.dart';

class RegistrationCard extends StatelessWidget {
  final MyRegistrationModel registration;
  final VoidCallback onTap;

  const RegistrationCard({
    required this.registration,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    registration.tournamentName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white54,
                  size: 15,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.groups_outlined,
                  color: Color(0xFFB6F36B),
                  size: 19,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    registration.teamName,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            _infoRow(
              Icons.location_on_outlined,
              registration.location,
            ),
            const SizedBox(height: 9),
            _infoRow(
              Icons.calendar_month_outlined,
              formatDate(registration.tournamentDate),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 13),
              child: Divider(color: Colors.white12, height: 1),
            ),
            Row(
              children: [
                StatusChip(
                  label: registration.registrationStatus,
                  isPayment: false,
                ),
                const SizedBox(width: 8),
                StatusChip(
                  label: registration.paymentStatus,
                  isPayment: true,
                ),
                const Spacer(),
                Text(
                  'Rs. ${registration.registrationFee}',
                  style: const TextStyle(
                    color: Color(0xFFB6F36B),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white54, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}