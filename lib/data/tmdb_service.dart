// data/tmdb_service.dart
// Service sederhana untuk mengambil data film dari TMDB API.

import 'dart:convert';
import 'package:http/http.dart' as http;

class TmdbService {
  // ⚠️ GANTI dengan API Key TMDB kamu!
  static const String _apiKey = '12c59e681425d8d7ac03162d38ba78b5';

  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _imageBase = 'https://image.tmdb.org/t/p/w500';

  // Mapping genre ID TMDB → nama genre
  static const Map<int, String> _genreMap = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    18: 'Drama',
    27: 'Horror',
    10749: 'Romance',
    878: 'Sci-Fi',
    53: 'Thriller',
    99: 'Documentary',
  };

  // Ambil genre pertama dari list genre IDs
  static String _getGenre(List<dynamic> genreIds) {
    if (genreIds.isEmpty) return 'Film';
    return _genreMap[genreIds.first] ?? 'Film';
  }

  // Convert data mentah dari TMDB ke format Map yang dipakai aplikasi
  static Map<String, dynamic> _parseMovie(Map<String, dynamic> raw) {
    final rating = (raw['vote_average'] as num?)?.toDouble() ?? 0.0;
    final releaseDate = raw['release_date'] as String? ?? '';
    final year = releaseDate.length >= 4
        ? int.tryParse(releaseDate.substring(0, 4)) ?? 0
        : 0;
    final posterPath = raw['poster_path'] as String?;

    return {
      'id': raw['id'],
      'title': raw['title'] ?? raw['name'] ?? 'Unknown',
      'genre': _getGenre(raw['genre_ids'] as List<dynamic>? ?? []),
      'year': year,
      'rating': double.parse(rating.toStringAsFixed(1)),
      'duration': '-',      // TMDB /discover tidak include runtime, isi '-'
      'synopsis': raw['overview'] ?? '',
      'cast': '',           // Butuh endpoint terpisah, dikosongkan dulu
      'posterUrl': posterPath != null ? '$_imageBase$posterPath' : '',
      'posterColor': 0xFF1E1E2E,
      'accentColor': 0xFFD8F602,
    };
  }

  // Format menit → "Xj Ym"
  static String _formatDuration(int? minutes) {
    if (minutes == null || minutes == 0) return '-';
    final jam = minutes ~/ 60;
    final menit = minutes % 60;
    if (jam == 0) return '${menit}m';
    if (menit == 0) return '${jam}j';
    return '${jam}j ${menit}m';
  }

  // Ambil detail film (runtime + cast) — dipanggil saat buka halaman detail
  static Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
    final url = Uri.parse(
      '$_baseUrl/movie/$movieId?api_key=$_apiKey&language=id-ID&append_to_response=credits',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Gagal ambil detail: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    // Ambil 5 pemeran teratas
    final castList = (data['credits']?['cast'] as List<dynamic>? ?? [])
        .take(5)
        .map((c) => c['name'] as String)
        .join(', ');

    return {
      'duration': _formatDuration(data['runtime'] as int?),
      'cast': castList,
    };
  }

  // Ambil film populer dari TMDB
  static Future<List<Map<String, dynamic>>> getPopularMovies() async {
    final url = Uri.parse(
      '$_baseUrl/movie/popular?api_key=$_apiKey&language=id-ID&page=1',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Gagal ambil data: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final results = data['results'] as List<dynamic>;

    return results.map((e) => _parseMovie(e as Map<String, dynamic>)).toList();
  }

  // Ambil film trending minggu ini dari TMDB
  static Future<List<Map<String, dynamic>>> getTrendingMovies() async {
    final url = Uri.parse(
      '$_baseUrl/trending/movie/week?api_key=$_apiKey&language=id-ID',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Gagal ambil data: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final results = data['results'] as List<dynamic>;

    return results.map((e) => _parseMovie(e as Map<String, dynamic>)).toList();
  }
}
