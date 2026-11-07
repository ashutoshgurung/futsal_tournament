import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FPasswordInputWidget extends StatefulWidget {
  const FPasswordInputWidget({super.key});

  @override
  State<FPasswordInputWidget> createState() => _FPasswordInputWidgetState();
}

class _FPasswordInputWidgetState extends State<FPasswordInputWidget> {
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
