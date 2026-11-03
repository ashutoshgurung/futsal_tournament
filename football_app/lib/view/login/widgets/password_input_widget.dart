import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordInputWidget extends StatefulWidget {
  const PasswordInputWidget({super.key});

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  final passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        focusNode: passwordFocusNode,
        obscureText: true,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: GoogleFonts.poppins(color: Colors.white54, fontSize: 14),
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
          filled: true,
          fillColor: const Color(0xFF191919),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Color(0xFF303030)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Color(0xFF303030)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Color(0xFFB7F34A)),
          ),
        ),
      ),
    );
  }
}
