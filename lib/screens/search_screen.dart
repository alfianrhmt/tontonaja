import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/movies.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil FIlm dengan acakk
    final randomMovies = [...movies];
    randomMovies.shuffle();
    final topMovies = randomMovies.take(3).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0F),
        title: const SearchBox(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Film Terpopuler (${topMovies.length})',
            style: GoogleFonts.poppins(color: Colors.white70),
          ),
          const SizedBox(height: 12),
          for (final movie in topMovies) MovieItem(movie: movie),
        ],
      ),
    );
  }
}

// Kotak Search
class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFFD8F602)),
          const SizedBox(width: 10),
          Text(
            'Cari film...',
            style: GoogleFonts.poppins(color: Colors.white38, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class MovieItem extends StatelessWidget {
  final Map<String, dynamic> movie;

  const MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF141420),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 90,
              color: const Color(0xFF1E1E2E),
            ), //kotak buat diisii posterr
            const SizedBox(width: 14),
            Text(
              '${movie['title']}\n${movie['genre']}\nRating: ${movie['rating']}',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
