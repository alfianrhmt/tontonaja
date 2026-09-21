import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Widget kartu film sederhana — hanya untuk tampilan, tidak bisa diklik ke detail.
// Digunakan di section Popular dan Rekomendasi pada halaman Home.
class MovieCard extends StatelessWidget {
  final Map<String, dynamic> movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster film
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFF1E1E2E),
            ),
            child: Stack(
              children: [
                // Gambar poster dari URL
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    movie['posterUrl'] ?? '',
                    height: 180,
                    width: 130,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 180,
                      width: 130,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(movie['posterColor'] as int),
                            Color(movie['accentColor'] as int).withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.movie_outlined,
                          color: Colors.white.withValues(alpha: 0.3),
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                // Rating di pojok kanan atas
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Color(0xFFFFD700), size: 10),
                        const SizedBox(width: 2),
                        Text(
                          movie['rating'].toString(),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Judul film
          Text(
            movie['title'],
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            '${movie['year']} • ${movie['genre']}',
            style: GoogleFonts.poppins(color: Colors.white54, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
