import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_screen.dart';

const green = Color(0xFFD8F602);
const grey = Color(0xFF3B3A3E);
const black = Color(0xFF202226);

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 17),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 31),

              // LOGO
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.circular(22),
                      ),

                      child: Image.asset(
                        'image/logo_tontonaja.png',
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'TontonAja',
                      style: GoogleFonts.poppins(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 34),

              // JUDUL
              Text(
                'Selamat Datang',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              Text(
                'Masuk untuk melanjutkan',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 26),

              // EMAIL
              Text(
                'Email',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 6),

              TextField(
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white,
                ),

                decoration: InputDecoration(
                  hintText: 'contoh@email.com',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white54,
                  ),

                  prefixIcon: const Icon(
                    Icons.mail_outline_rounded,
                    color: grey,
                    size: 17,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: const BorderSide(color: grey),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: const BorderSide(color: grey),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: const BorderSide(
                      color: green,
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 13),

              // PASSWORD
              Text(
                'Password',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 6),

              TextField(
                obscureText: true,

                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white,
                ),

                decoration: InputDecoration(
                  hintText: 'Masukkan password',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white54,
                  ),

                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: grey,
                    size: 17,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: const BorderSide(color: grey),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: const BorderSide(color: grey),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide: const BorderSide(
                      color: green,
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 13),

              // LUPA PASSWORD
              Align(
                alignment: Alignment.centerRight,

                child: Text(
                  'Lupa Password?',
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: green,
                  ),
                ),
              ),

              const SizedBox(height: 31),

              // MASUK
              SizedBox(
                width: double.infinity,
                height: 45,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MainScreen(),
                      ),
                      (route) => false,
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    foregroundColor: black,
                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),

                  child: Text(
                    'Masuk',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 13),

              // TAMU
              SizedBox(
                width: double.infinity,
                height: 45,

                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MainScreen(),
                      ),
                      (route) => false,
                    );
                  },

                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: grey),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),

                  child: Text(
                    'Lanjut sebagai Tamu',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 26),

              // DAFTAR
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Belum punya akun? ',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: Colors.white70,
                    ),

                    children: [
                      TextSpan(
                        text: 'Daftar',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
