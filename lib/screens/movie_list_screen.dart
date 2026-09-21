import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/movies.dart';


class MovieListScreen extends StatelessWidget {
  final String category;

  const MovieListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {

    final filteredMovies = category == 'Semua'
        ? movies
        : movies.where((m) => m['genre'] == category).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          category == 'Semua' ? 'Semua Film' : 'Genre: $category',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${filteredMovies.length} Film',
                style: GoogleFonts.poppins(color: Colors.white54, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [

          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              children: genres.map((genre) {
                final isSelected = genre == category;
                return GestureDetector(
                  onTap: () {
                    if (!isSelected) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieListScreen(category: genre),
                        ),
                      );
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFD8F602) : const Color(0xFF1E1E2E),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      genre,
                      style: GoogleFonts.poppins(
                        color: isSelected ? Colors.black : Colors.white54,
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 8),


          Expanded(
            child: filteredMovies.isEmpty
                ? _EmptyState(category: category)
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.62,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: filteredMovies.length,
                    itemBuilder: (context, index) {
                      return _MovieGridCard(movie: filteredMovies[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}


class _MovieGridCard extends StatelessWidget {
  final Map<String, dynamic> movie;

  const _MovieGridCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Color(movie['posterColor'] as int),
                  child: Image.network(
                    movie['posterUrl'] ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.movie_outlined, size: 50, color: Colors.white24);
                    },
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Color(0xFFFFD700), size: 12),
                      const SizedBox(width: 3),
                      Text(
                        movie['rating'].toString(),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 11,
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

        Text(
          movie['title'],
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        Text(
          '${movie['year']} • ${movie['genre']}',
          style: GoogleFonts.poppins(color: Colors.white54, fontSize: 11),
        ),
      ],
    );
  }
}


class _EmptyState extends StatelessWidget {
  final String category;

  const _EmptyState({required this.category});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.movie_filter_outlined, size: 64, color: Colors.white24),
          const SizedBox(height: 16),
          Text(
            'Tidak ada film',
            style: GoogleFonts.poppins(
              color: Colors.white54,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'untuk kategori "$category"',
            style: GoogleFonts.poppins(color: Colors.white38, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
