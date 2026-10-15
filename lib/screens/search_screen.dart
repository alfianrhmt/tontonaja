import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _movies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialMovies();
  }

  // ambil film awal dari database backend
  Future<void> _loadInitialMovies() async {
    try {
      final list = await fetchMovies();
      setState(() {
        _movies = list.map(normalizeMovie).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  // cari film lewat endpoint /api/movies/search?q=
  Future<void> _onSearch(String query) async {
    if (query.trim().isEmpty) {
      _loadInitialMovies();
      return;
    }
    setState(() => _isLoading = true);
    try {
      final list = await searchMovies(query);
      setState(() {
        _movies = list.map(normalizeMovie).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0F),
        title: Container(
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
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearch,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Cari film...',
                    hintStyle: GoogleFonts.poppins(color: Colors.white38, fontSize: 14),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFD8F602)),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  _searchController.text.isEmpty
                      ? 'Film Terpopuler (${_movies.length})'
                      : 'Hasil Pencarian (${_movies.length})',
                  style: GoogleFonts.poppins(color: Colors.white70),
                ),
                const SizedBox(height: 12),
                if (_movies.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        'Film tidak ditemukan',
                        style: GoogleFonts.poppins(color: Colors.white38),
                      ),
                    ),
                  )
                else
                  for (final movie in _movies) MovieItem(movie: movie),
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
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 64,
                height: 90,
                child: Image.network(
                  movie['posterUrl'] ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Color(movie['posterColor'] ?? 0xFF1E1E2E),
                      child: const Icon(Icons.movie_outlined, color: Colors.white38),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                '${movie['title']}\n${movie['genre']}\nRating: ${movie['rating']}',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
