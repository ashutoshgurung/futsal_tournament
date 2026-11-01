import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchTextfieldWidget extends StatefulWidget {
  const SearchTextfieldWidget({super.key});

  @override
  State<SearchTextfieldWidget> createState() => _SearchTextfieldWidgetState();
}

class _SearchTextfieldWidgetState extends State<SearchTextfieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: "Search Tournaments...",
        hintStyle: GoogleFonts.poppins(color: Colors.black, fontSize: 13),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(Icons.search, color: Colors.black),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          // borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green, width: 1.5),
        ),
      ),
    );
  }
}
