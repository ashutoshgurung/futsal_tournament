import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchTextfieldHomeWidget extends StatefulWidget {
  const SearchTextfieldHomeWidget({super.key});

  @override
  State<SearchTextfieldHomeWidget> createState() =>
      _SearchTextfieldWidgetState();
}

class _SearchTextfieldWidgetState extends State<SearchTextfieldHomeWidget> {
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
          borderSide: BorderSide(color: Colors.white, width: 1.5),
        ),
      ),
    );
  }
}
