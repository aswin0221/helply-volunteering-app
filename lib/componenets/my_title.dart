import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helply_app/constants/colors.dart';

class MyTitle extends StatelessWidget {
  final String title;

  const MyTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.teal.shade900,
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontSize: 28),
    );
  }
}
