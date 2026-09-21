import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'downloads_screen.dart';
import 'favourites_screen.dart';

// Halaman detail film.
// Menerima data film dari halaman sebelumnya lewat constructor.
class MovieDetailScreen extends StatelessWidget {
  final Map<String, dynamic> movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster film dengan tombol play di tengah
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  color: Color(movie['posterColor'] as int),
                  child: Image.network(
                    movie['posterUrl'] ?? '',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.movie_creation_outlined,
                        size: 100,
                        color: Colors.white24,
                      );
                    },
                  ),
                ),
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD8F602),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.play_arrow, color: Colors.black, size: 38),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul film
                  Text(
                    movie['title'],
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Info: rating, tahun, durasi, genre
                  Wrap(
                    spacing: 16,
                    children: [
                      _InfoBadge(
                        icon: Icons.star,
                        text: '${movie['rating']}',
                        color: const Color(0xFFFFD700),
                      ),
                      _InfoBadge(
                        icon: Icons.calendar_today_outlined,
                        text: '${movie['year']}',
                        color: Colors.white54,
                      ),
                      _InfoBadge(
                        icon: Icons.access_time_outlined,
                        text: movie['duration'],
                        color: Colors.white54,
                      ),
                      _InfoBadge(
                        icon: Icons.local_movies_outlined,
                        text: movie['genre'],
                        color: Color(movie['accentColor'] as int),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Tombol Tonton
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Memutar ${movie['title']}...'),
                            backgroundColor: const Color(0xFF1E1E2E),
                          ),
                        );
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: Text(
                        'Tonton',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD8F602),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Tombol Favorit dan Unduh
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FavouritesScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.favorite_outline, size: 18),
                          label: Text('Favorit', style: GoogleFonts.poppins(fontSize: 13)),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white70,
                            side: const BorderSide(color: Colors.white24),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DownloadsScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.download_outlined, size: 18),
                          label: Text('Unduh', style: GoogleFonts.poppins(fontSize: 13)),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white70,
                            side: const BorderSide(color: Colors.white24),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Sinopsis
                  Text(
                    'Sinopsis',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie['synopsis'],
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Pemeran
                  Text(
                    'Pemeran',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _CastRow(castString: movie['cast']),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Badge kecil untuk menampilkan info (rating, tahun, durasi, genre)
class _InfoBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _InfoBadge({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.poppins(
            color: color,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Widget untuk menampilkan avatar pemeran dari string yang dipisah koma
class _CastRow extends StatelessWidget {
  final String castString;

  const _CastRow({required this.castString});

  @override
  Widget build(BuildContext context) {
    final castList = castString.split(', ');

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: castList.map((name) {
          final words = name.split(' ');
          final initials = words.length > 1 ? words[0][0] + words[1][0] : words[0][0];

          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: const Color(0xFF1E1E2E),
                  child: Text(
                    initials,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 70,
                  child: Text(
                    words.first,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white60,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}