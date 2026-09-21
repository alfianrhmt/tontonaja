import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/movies.dart';
import '../widgets/movie_card.dart';
import '../widgets/section_header.dart';
import 'search_screen.dart';
import 'movie_detail_screen.dart';
import 'movie_list_screen.dart';

// Halaman utama aplikasi
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Pindah ke halaman detail film
  void bukaDetail(BuildContext context, Map<String, dynamic> movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie)),
    );
  }

  // Pindah ke halaman daftar film
  void bukaDaftar(BuildContext context, String kategori) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieListScreen(category: kategori),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ambil data film dari movies.dart
    final featuredMovie = movies[0];
    final popularMovies = movies.sublist(1, 7);
    final recommendedMovies = movies.sublist(7, 14);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0F),
        elevation: 0,
        title: Text(
          'TontonAja',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FILM UNGGULAN
            GestureDetector(
              onTap: () => bukaDetail(context, featuredMovie),
              child: Container(
                height: 440,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      // Poster film
                      Positioned.fill(
                        child: Image.network(
                          featuredMovie['posterUrl'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Color(featuredMovie['posterColor']),
                            );
                          },
                        ),
                      ),

                      // Lapisan gelap biar teks kebaca
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black87],
                            ),
                          ),
                        ),
                      ),

                      // Teks dan tombol di bawah
                      Positioned(
                        left: 20,
                        right: 20,
                        bottom: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              featuredMovie['genre'],
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFD8F602),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              featuredMovie['title'],
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Color(0xFFFFD700),
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${featuredMovie['rating']}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '${featuredMovie['year']}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  featuredMovie['duration'],
                                  style: GoogleFonts.poppins(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () =>
                                    bukaDetail(context, featuredMovie),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD8F602),
                                  foregroundColor: Colors.black,
                                ),
                                child: Text(
                                  'Tonton Sekarang',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // GENRE
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: genres.map((genre) {
                  return GestureDetector(
                    onTap: () => bukaDaftar(context, genre),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E2E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        genre,
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 28),

            // FILM POPULAR
            SectionHeader(
              title: 'Film Popular',
              onSeeAll: () => bukaDaftar(context, 'Semua'),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: popularMovies.map((movie) {
                  return MovieCard(movie: movie);
                }).toList(),
              ),
            ),

            const SizedBox(height: 28),

            // REKOMENDASI
            SectionHeader(
              title: 'Rekomendasi',
              onSeeAll: () => bukaDaftar(context, 'Semua'),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: recommendedMovies.map((movie) {
                  return MovieCard(movie: movie);
                }).toList(),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
