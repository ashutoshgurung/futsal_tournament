import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailInputWidget extends StatefulWidget {
  const EmailInputWidget({super.key});

  @override
  State<EmailInputWidget> createState() => _EmailInputWidgetState();
}

class _EmailInputWidgetState extends State<EmailInputWidget> {
  final emailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        focusNode: emailFocusNode,
        keyboardType: TextInputType.emailAddress,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Email address',
          hintStyle: GoogleFonts.poppins(color: Colors.white54, fontSize: 14),
          prefixIcon: const Icon(Icons.email_outlined, color: Colors.white70),
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
