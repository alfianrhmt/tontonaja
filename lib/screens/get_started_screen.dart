import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),

              // Logooo
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

              // App Nameeee
              Text(
                'TontonAja',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Ribuan film, satu aplikasi.\nNikmati kapan saja, di mana saja.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(color: Colors.white60, fontSize: 15),
              ),

              const Spacer(),
            //get started
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => goToLogin(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD8F602),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
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

              // Tombol uhave accpunt
              TextButton(
                onPressed: () => goToLogin(context),
                child: Text(
                  'Sudah punya akun? Masuk',
                  style: GoogleFonts.poppins(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
