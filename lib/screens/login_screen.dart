import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_screen.dart';

const green = Color(0xFFD8F602);
const grey = Color(0xFF3B3A3E);
const black = Color(0xFF202226);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordHidden = true;

  void goToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
      (route) => false,
    );
  }

  void forgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: grey,
        content: Text(
          'Link reset password telah dikirim ke email Anda.',
          style: poppins(12),
        ),
      ),
    );
  }

  void register() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: black,
        title: Text('Daftar Akun', style: poppins(18, weight: FontWeight.w700)),
        content: Text(
          'Fitur pendaftaran tersedia di versi lengkap aplikasi.',
          style: poppins(12),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: poppins(12, weight: FontWeight.w600, color: green),
            ),
          ),
        ],
      ),
    );
  }

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

              // Logo
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
                      style: poppins(23, weight: FontWeight.w700),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 34),

              Text(
                'Selamat Datang',
                style: poppins(20, weight: FontWeight.w700),
              ),

              Text(
                'Masuk untuk melanjutkan',
                style: poppins(11, color: Colors.white70),
              ),

              const SizedBox(height: 26),

              inputField(
                label: 'Email',
                hint: 'contoh@email.com',
                icon: Icons.mail_outline_rounded,
              ),

              const SizedBox(height: 13),

              inputField(
                label: 'Password',
                hint: 'Masukkan password',
                icon: Icons.lock_outline_rounded,
                obscureText: passwordHidden,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordHidden = !passwordHidden;
                    });
                  },
                  icon: Icon(
                    passwordHidden
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: grey,
                    size: 18,
                  ),
                ),
              ),

              const SizedBox(height: 13),

              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: forgotPassword,
                  child: Text(
                    'Lupa Password?',
                    style: poppins(9, weight: FontWeight.w500, color: green),
                  ),
                ),
              ),

              const SizedBox(height: 31),

              // Tombol Masuk
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: goToHome,
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
                    style: poppins(12, weight: FontWeight.w700, color: black),
                  ),
                ),
              ),

              const SizedBox(height: 13),

              // Tombol Tamu
              SizedBox(
                width: double.infinity,
                height: 45,
                child: OutlinedButton(
                  onPressed: goToHome,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: Text('Lanjut sebagai Tamu', style: poppins(12)),
                ),
              ),

              const SizedBox(height: 26),

              // Daftar
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun? ',
                      style: poppins(10, color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: register,
                      child: Text(
                        'Daftar',
                        style: poppins(
                          10,
                          weight: FontWeight.w700,
                          color: green,
                        ),
                      ),
                    ),
                  ],
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

// Input Email dan Password
Widget inputField({
  required String label,
  required String hint,
  required IconData icon,
  bool obscureText = false,
  Widget? suffix,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: poppins(10)),

      const SizedBox(height: 6),

      TextField(
        obscureText: obscureText,
        style: poppins(12),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: poppins(12, color: Colors.white54),
          prefixIcon: Icon(icon, color: grey, size: 17),
          suffixIcon: suffix,
          filled: true,
          fillColor: black,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          border: inputBorder(),
          enabledBorder: inputBorder(),
          focusedBorder: inputBorder(green, 1.5),
        ),
      ),
    ],
  );
}

// Border input
OutlineInputBorder inputBorder([Color color = grey, double width = 1]) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(9),
    borderSide: BorderSide(color: color, width: width),
  );
}

// Font Poppins
TextStyle poppins(
  double size, {
  FontWeight weight = FontWeight.w400,
  Color color = Colors.white,
}) {
  return GoogleFonts.poppins(fontSize: size, fontWeight: weight, color: color);
}
