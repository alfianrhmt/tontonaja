import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/movies.dart';

// Halaman daftar film favorit
class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0A0F),
        automaticallyImplyLeading: false,
        title: Text(
          'Film Favorit',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                favouriteMovies.length.toString() + ' Film',
                style: GoogleFonts.poppins(
                  color: Colors.white38,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
      body: favouriteMovies.isEmpty
          ? buildEmptyView()
          : buildListView(),
    );
  }

  // list film favorit, pakai for loop biasa aja
  Widget buildListView() {
    List<Widget> items = [];

    for (var i = 0; i < favouriteMovies.length; i++) {
      items.add(buildMovieCard(favouriteMovies[i]));
    }

    return ListView(
      padding: EdgeInsets.all(16),
      children: items,
    );
  }

  // kartu 1 film favorit
  Widget buildMovieCard(Map<String, dynamic> movie) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Color(0xFF141420),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // poster
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: SizedBox(
              width: 90,
              height: 120,
              child: Image.network(
                movie['posterUrl'] ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Color(movie['posterColor']),
                    child: Icon(
                      Icons.movie_outlined,
                      color: Colors.white54,
                      size: 32,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 14),
          // info film
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie['title'],
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    movie['year'].toString() + ' • ' + movie['genre'],
                    style: GoogleFonts.poppins(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Color(0xFFFFD700), size: 14),
                      SizedBox(width: 4),
                      Text(
                        movie['rating'].toString(),
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(Icons.access_time_outlined,
                          color: Colors.white38, size: 12),
                      SizedBox(width: 4),
                      Text(
                        movie['duration'],
                        style: GoogleFonts.poppins(
                          color: Colors.white38,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // ikon hati
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.favorite,
              color: Color(0xFFD8F602),
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  // tampilan kalau belum ada film favorit
  Widget buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_outline,
            size: 72,
            color: Colors.white24,
          ),
          SizedBox(height: 16),
          Text(
            'Belum ada film favorit',
            style: GoogleFonts.poppins(
              color: Colors.white54,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tambahkan film ke favorit\ndari halaman detail film',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white38,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}