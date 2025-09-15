import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultSection extends StatelessWidget {
  final String title;
  final String content;

  const ResultSection({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.playfairDisplay(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent[100],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
