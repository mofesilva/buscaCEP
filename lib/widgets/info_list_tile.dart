import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const InfoListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: GoogleFonts.rajdhani(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.rajdhani(),
      ),
    );
  }
}
