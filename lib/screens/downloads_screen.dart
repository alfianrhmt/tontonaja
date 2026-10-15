import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/api_service.dart';

// Halaman untuk nampilin film yang udah didownload
class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({super.key});

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  List<Map<String, dynamic>> _downloadedMovies = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    try {
      final list = await fetchDownloads();
      if (!mounted) return;
      setState(() {
        _downloadedMovies = list.map(normalizeMovie).toList();
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    int jumlahFilm = _downloadedMovies.length;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0F),
        automaticallyImplyLeading: false,
        title: Text(
          'Unduhan',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '$jumlahFilm Film',
                style: GoogleFonts.poppins(
                  color: Colors.white38,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFD8F602)),
            )
          : (jumlahFilm == 0 ? tampilanKosong() : tampilanListFilm(_downloadedMovies)),
    );
  }

  // kalau belum ada film yang didownload, tampilin ini
  Widget tampilanKosong() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.download_outlined,
            size: 72,
            color: Colors.white24,
          ),
          SizedBox(height: 16),
          Text(
            'Belum ada unduhan',
            style: GoogleFonts.poppins(
              color: Colors.white54,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Unduh film dari halaman detail\nuntuk ditonton secara offline',
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

  // kalau udah ada film yang didownload, tampilin list-nya
  Widget tampilanListFilm(List<Map<String, dynamic>> downloadedMovies) {
    return Column(
      children: [
        infoPenyimpanan(),
        SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: downloadedMovies.length,
            itemBuilder: (context, index) {
              var film = downloadedMovies[index];
              return itemFilm(film);
            },
          ),
        ),
      ],
    );
  }

  // kotak info penyimpanan di atas, isinya masih statis
  Widget infoPenyimpanan() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF141420),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFD8F602).withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.storage_outlined,
              color: Color(0xFFD8F602),
              size: 24,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Penyimpanan Unduhan',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.45,
                    backgroundColor: Colors.white12,
                    color: Color(0xFFD8F602),
                    minHeight: 5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '4.5 GB dari 10 GB digunakan',
                  style: GoogleFonts.poppins(
                    color: Colors.white38,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // satu baris item film yang udah didownload
  Widget itemFilm(Map<String, dynamic> film) {
    // anggap semua film statusnya udah selesai download
    double progress = 1.0;
    String status = 'Selesai';

    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF141420),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // gambar poster film
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 70,
              height: 95,
              child: Image.network(
                film['posterUrl'] ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(film['posterColor']),
                          Color(film['accentColor']).withOpacity(0.5),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.movie_outlined,
                        color: Colors.white.withOpacity(0.3),
                        size: 26,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 14),

          // judul, tahun, durasi, sama progress bar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  film['title'],
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  film['year'].toString() + ' • ' + film['duration'],
                  style: GoogleFonts.poppins(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white12,
                    color: progress == 1.0 ? Colors.greenAccent : Color(0xFFD8F602),
                    minHeight: 4,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      progress == 1.0 ? Icons.check_circle_outline : Icons.download_outlined,
                      size: 12,
                      color: progress == 1.0 ? Colors.greenAccent : Color(0xFFD8F602),
                    ),
                    SizedBox(width: 4),
                    Text(
                      status,
                      style: GoogleFonts.poppins(
                        color: progress == 1.0 ? Colors.greenAccent : Color(0xFFD8F602),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // tombol play
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFD8F602).withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.play_arrow,
              color: Color(0xFFD8F602),
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
