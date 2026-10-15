import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/api_service.dart';
import '../data/tmdb_service.dart';
import '../widgets/movie_card.dart';
import '../widgets/section_header.dart';
import 'search_screen.dart';
import 'movie_detail_screen.dart';
import 'movie_list_screen.dart';

// Halaman utama aplikasi — load data dari TMDB API dengan fallback ke backend lokal
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _popularMovies = [];
  List<Map<String, dynamic>> _trendingMovies = [];
  List<String> _genres = ['Semua', 'Action', 'Sci-Fi', 'Drama', 'Comedy', 'Horror'];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMovies();
    fetchGenres().then((g) {
      if (mounted) setState(() => _genres = g);
    }).catchError((_) {});
  }

  // Ambil data dari TMDB, kalau gagal fallback ke backend lokal
  Future<void> _loadMovies() async {
    try {
      final results = await Future.wait([
        TmdbService.getPopularMovies(),
        TmdbService.getTrendingMovies(),
      ]);

      if (!mounted) return;
      setState(() {
        _popularMovies = results[0];
        _trendingMovies = results[1];
        _isLoading = false;
      });
    } catch (e) {
      // Fallback ke database backend lokal
      try {
        final local = await fetchMovies();
        final normalized = local.map(normalizeMovie).toList();
        if (!mounted) return;
        setState(() {
          _popularMovies = normalized.take(7).toList();
          _trendingMovies = normalized.skip(7).take(7).toList();
          _isLoading = false;
          _error = 'TMDB offline, menggunakan data dari backend lokal.';
        });
      } catch (_) {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _error = 'Gagal memuat film dari TMDB maupun backend lokal.\n($e)';
        });
      }
    }
  }

  void _bukaDetail(BuildContext context, Map<String, dynamic> movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie)),
    );
  }

  void _bukaDaftar(BuildContext context, String kategori) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieListScreen(category: kategori),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Film unggulan: ambil dari trending (TMDB) atau list popular
    final featuredMovie = _trendingMovies.isNotEmpty
        ? _trendingMovies.first
        : (_popularMovies.isNotEmpty ? _popularMovies.first : null);

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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFD8F602)),
            )
          : RefreshIndicator(
              color: const Color(0xFFD8F602),
              backgroundColor: const Color(0xFF1E1E2E),
              onRefresh: _loadMovies,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Pesan error/fallback kalau ada
                    if (_error != null)
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A1A1A),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade900),
                        ),
                        child: Text(
                          _error!,
                          style: GoogleFonts.poppins(
                            color: Colors.red.shade300,
                            fontSize: 11,
                          ),
                        ),
                      ),

                    // FILM UNGGULAN (dari trending TMDB)
                    if (featuredMovie != null)
                      GestureDetector(
                        onTap: () => _bukaDetail(context, featuredMovie),
                        child: Container(
                          height: 440,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              // Poster film
                              Positioned.fill(
                                child: featuredMovie['posterUrl'] != ''
                                    ? Image.network(
                                        featuredMovie['posterUrl'],
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: Color(
                                                featuredMovie['posterColor']),
                                          );
                                        },
                                      )
                                    : Container(
                                        color:
                                            Color(featuredMovie['posterColor']),
                                      ),
                              ),

                              // Lapisan gelap
                              Positioned.fill(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black87
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // Teks dan tombol
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
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 48,
                                      child: ElevatedButton(
                                        onPressed: () =>
                                            _bukaDetail(context, featuredMovie),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFFD8F602),
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
                        children: _genres.map((genre) {
                          return GestureDetector(
                            onTap: () => _bukaDaftar(context, genre),
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
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

                    // FILM POPULAR (dari TMDB)
                    SectionHeader(
                      title: 'Film Popular',
                      onSeeAll: () => _bukaDaftar(context, 'Semua'),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 250,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: _popularMovies.take(10).map((movie) {
                          return GestureDetector(
                            onTap: () => _bukaDetail(context, movie),
                            child: MovieCard(movie: movie),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // TRENDING (dari TMDB)
                    SectionHeader(
                      title: 'Trending Minggu Ini',
                      onSeeAll: () => _bukaDaftar(context, 'Semua'),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 250,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: _trendingMovies.skip(1).take(10).map((movie) {
                          return GestureDetector(
                            onTap: () => _bukaDetail(context, movie),
                            child: MovieCard(movie: movie),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
    );
  }
}
