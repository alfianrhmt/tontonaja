import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  // transisi ke login
  void goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: SafeArea(
        minimum: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),

            // Logo
            Container(
              width: 90,
              height: 90,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF3B3A3E),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Image.asset('image/logo_tontonaja.png'),
            ),
            const SizedBox(height: 20),

            // App Name
            Text(
              'TontonAja',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Deskripsi singkat
            Text(
              'Ribuan film, satu aplikasi.\nNikmati kapan saja, di mana saja.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: Colors.white60, fontSize: 15),
            ),

            const Spacer(),

            // Tombol Mulai Sekarang
            ElevatedButton(
              onPressed: () => goToLogin(context),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                backgroundColor: const Color(0xFFD8F602),
                foregroundColor: Colors.black,
              ),
              child: Text(
                'Mulai Sekarang',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),

            // Tombol untuk yang sudah punya akun
            TextButton(
              onPressed: () => goToLogin(context),
              child: Text(
                'Sudah punya akun? Masuk',
                style: GoogleFonts.poppins(color: Colors.white54, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
