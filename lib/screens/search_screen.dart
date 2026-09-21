import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/movies.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengurutkan FIlm berdasarkan rating
    final popularMovies = [...movies]
      ..sort((a, b) => (b['rating'] as num).compareTo(a['rating'] as num));//..cascade operator (digunakan untuk menjalankan method yang sama)//membandingkan rate 2 film // compereTo descending
    //Sistem mengambil seluruh data film, membuat salinannya, kemudian mengurutkan film berdasarkan rating tertinggi ke terendah.

    // Batas Flim yang ditampilkan
    final topMovies = popularMovies.take(3).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            autofocus: true,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Cari film...',
              hintStyle: GoogleFonts.poppins(color: Colors.white38),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFFD8F602),
                size: 20,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Film Terpopuler (${topMovies.length})',
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Daftar film terpopuler
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: topMovies.length,
              itemBuilder: (context, index) {
                return _SearchResultItem(movie: topMovies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
// Item untuk menampilkan detail film
class _SearchResultItem extends StatelessWidget {
  final Map<String, dynamic> movie;

  const _SearchResultItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF141420),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Mini poster
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 64,
              height: 90,
              child: Image.network(
                movie['posterUrl'] ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
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
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Info film
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie['title'] ?? 'Tanpa Judul',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  movie['genre'] ?? 'Genre tidak tersedia',
                  style: GoogleFonts.poppins(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '${movie['rating'] ?? 0.0}',
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.chevron_right,
            color: Colors.white30,
          ),
        ],
      ),
    );
  }
}