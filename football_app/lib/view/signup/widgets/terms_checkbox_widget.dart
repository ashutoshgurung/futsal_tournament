import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? errorText;

  const TermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Checkbox(
            value: value,
            activeColor: const Color(0xFFB7F34A),
            checkColor: Colors.black,
            side: const BorderSide(color: Colors.white54, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            onChanged: (v) => onChanged(v ?? false),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(!value),
              child: Text(
                "I agree to terms and conditions",
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
              ),
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                errorText!,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.redAccent,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
