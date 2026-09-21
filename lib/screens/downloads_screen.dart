import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/movies.dart';

// Halaman untuk nampilin film yang udah didownload
// Catatan: ini masih dummy ya, belum ada proses download beneran
class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ambil jumlah film yang udah didownload
    int jumlahFilm = downloadedMovies.length;

    return Scaffold(
      backgroundColor: Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0A0F),
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
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                jumlahFilm.toString() + ' Film',
                style: GoogleFonts.poppins(
                  color: Colors.white38,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
      body: jumlahFilm == 0 ? tampilanKosong() : tampilanListFilm(),
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
  Widget tampilanListFilm() {
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
