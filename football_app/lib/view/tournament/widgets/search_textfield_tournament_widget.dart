import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchTextfieldTournamentWidget extends StatefulWidget {
  const SearchTextfieldTournamentWidget({super.key});

  @override
  State<SearchTextfieldTournamentWidget> createState() =>
      _SearchTextfieldWidgetState();
}

class _SearchTextfieldWidgetState
    extends State<SearchTextfieldTournamentWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "Search Tournaments...",
          hintStyle: GoogleFonts.poppins(color: Colors.black, fontSize: 12),
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
      ),
    );
  }
}
