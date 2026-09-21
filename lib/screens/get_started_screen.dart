import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

// Halaman pertama yang tampil saat aplikasi dibuka.
class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF141708), // gelap dengan sedikit aksen chartreuse di puncak
              Color(0xFF0A0A0F),
              Color(0xFF0A0A0F),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Spacer(flex: 2),

                // Logo dan nama aplikasi
                Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B3A3E),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        'image/logo_tontonaja.png',
                        fit: BoxFit.contain,
                      ),
                    ), 
                    const SizedBox(height: 20),
                    Text(
                      'TontonAja',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ribuan film, satu aplikasi.\nNikmati kapan saja, di mana saja.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.white60,
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),

                const Spacer(flex: 2),

                // Visual dekoratif — poster film warna-warni
                SizedBox(
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _PosterPlaceholder(color: const Color(0xFF1A237E), offset: -8),
                      _PosterPlaceholder(color: const Color(0xFF1B5E20), offset: 0),
                      _PosterPlaceholder(color: const Color(0xFF880E4F), offset: -4),
                      _PosterPlaceholder(color: const Color(0xFF4A148C), offset: 8),
                      _PosterPlaceholder(color: const Color(0xFF004D40), offset: -2),
                    ],
                  ),
                ),

                const Spacer(flex: 3),

                // Tombol Mulai Sekarang
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD8F602),
                      foregroundColor: Colors.black, // teks hitam agar terbaca di atas hijau
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Mulai Sekarang',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: Text(
                    'Sudah punya akun? Masuk',
                    style: GoogleFonts.poppins(color: Colors.white54, fontSize: 14),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget poster dekoratif di halaman Get Started
class _PosterPlaceholder extends StatelessWidget {
  final Color color;
  final double offset;

  const _PosterPlaceholder({required this.color, required this.offset});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, offset),
      child: Container(
        width: 60,
        height: 90,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(Icons.movie, color: Colors.white.withValues(alpha: 0.2), size: 24),
      ),
    );
  }
}

