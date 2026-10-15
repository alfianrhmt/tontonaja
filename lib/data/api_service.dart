import 'dart:convert';
import 'package:http/http.dart' as http;

const baseUrl = 'http://localhost:3000/api';

Future<List<Map<String, dynamic>>> fetchMovies({String? genre}) async {
  try {
    var url = '$baseUrl/movies';
    if (genre != null && genre != 'Semua') {
      url += '?genre=$genre';
    }

    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      return List<Map<String, dynamic>>.from(body['data']);
    }
  } catch (e) {
    // error diabaikan
  }
  return [];
}

Future<List<Map<String, dynamic>>> searchMovies(String query) async {
  try {
    final res = await http.get(Uri.parse('$baseUrl/movies/search?q=$query'));
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      return List<Map<String, dynamic>>.from(body['data']);
    }
  } catch (e) {
    // error diabaikan
  }
  return [];
}

Future<List<Map<String, dynamic>>> fetchFavourites() async {
  try {
    final res = await http.get(Uri.parse('$baseUrl/favourites'));
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      return List<Map<String, dynamic>>.from(body['data']);
    }
  } catch (e) {
    // error diabaikan
  }
  return [];
}

Future<List<Map<String, dynamic>>> fetchDownloads() async {
  try {
    final res = await http.get(Uri.parse('$baseUrl/downloads'));
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      return List<Map<String, dynamic>>.from(body['data']);
    }
  } catch (e) {
    // error diabaikan
  }
  return [];
}

Future<List<String>> fetchGenres() async {
  try {
    final res = await http.get(Uri.parse('$baseUrl/genres'));
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      final list = List<Map<String, dynamic>>.from(body['data']);
      return ['Semua', ...list.map((g) => g['name'].toString())];
    }
  } catch (e) {
    // error diabaikan
  }
  return ['Semua'];
}

// samakan nama field database ke widget
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
