import 'dart:convert';
import 'package:http/http.dart' as http;

// ganti ini kalau port-nya beda
const _base = 'http://10.0.2.2:3000/api'; // emulator Android
// const _base = 'http://localhost:3000/api'; // web / iOS simulator

Future<List<Map<String, dynamic>>> fetchMovies({String? genre}) async {
  final url = genre != null && genre != 'Semua'
      ? Uri.parse('$_base/movies?genre=$genre')
      : Uri.parse('$_base/movies');

  final res = await http.get(url);
  if (res.statusCode != 200) throw Exception('gagal ambil film');

  final body = jsonDecode(res.body) as Map<String, dynamic>;
  return List<Map<String, dynamic>>.from(body['data']);
}

Future<List<Map<String, dynamic>>> searchMovies(String query) async {
  final url = Uri.parse('$_base/movies/search?q=${Uri.encodeComponent(query)}');
  final res = await http.get(url);
  if (res.statusCode != 200) throw Exception('gagal cari film');

  final body = jsonDecode(res.body) as Map<String, dynamic>;
  return List<Map<String, dynamic>>.from(body['data']);
}

Future<List<Map<String, dynamic>>> fetchFavourites() async {
  final res = await http.get(Uri.parse('$_base/favourites'));
  if (res.statusCode != 200) throw Exception('gagal ambil favorit');

  final body = jsonDecode(res.body) as Map<String, dynamic>;
  return List<Map<String, dynamic>>.from(body['data']);
}

Future<List<Map<String, dynamic>>> fetchDownloads() async {
  final res = await http.get(Uri.parse('$_base/downloads'));
  if (res.statusCode != 200) throw Exception('gagal ambil unduhan');

  final body = jsonDecode(res.body) as Map<String, dynamic>;
  return List<Map<String, dynamic>>.from(body['data']);
}

Future<List<String>> fetchGenres() async {
  final res = await http.get(Uri.parse('$_base/genres'));
  if (res.statusCode != 200) throw Exception('gagal ambil genre');

  final body = jsonDecode(res.body) as Map<String, dynamic>;
  final list = List<Map<String, dynamic>>.from(body['data']);
  return ['Semua', ...list.map((g) => g['name'] as String)];
}

// normalisasi key supaya kompatibel dengan screen yang sudah ada
Map<String, dynamic> normalizeMovie(Map<String, dynamic> m) {
  return {
    ...m,
    'genre': m['genre_name'] ?? m['genre'] ?? '',
    'posterUrl': m['poster_url'] ?? m['posterUrl'] ?? '',
    'posterColor': m['posterColor'] ?? 0xFF1E1E2E,
    'accentColor': m['accentColor'] ?? 0xFFD8F602,
    'cast': m['cast_list'] ?? m['cast'] ?? '',
  };
}
