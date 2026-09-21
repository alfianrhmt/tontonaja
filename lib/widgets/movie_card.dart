import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Kartu film kecil, dipakai di section Popular dan Rekomendasi
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
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              movie['posterUrl'] ?? '',
              height: 180,
              width: 130,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  width: 130,
                  color: Color(movie['posterColor']),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // Rating film
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFFFD700), size: 12),
              const SizedBox(width: 4),
              Text(
                movie['rating'].toString(),
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 4),

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

          // Tahun dan genre
          Text(
            '${movie['year']} • ${movie['genre']}',
            style: GoogleFonts.poppins(color: Colors.white54, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
