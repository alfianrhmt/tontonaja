import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/get_started_screen.dart';

void main() {
  runApp(const TontonAjaApp());
}

// Root widget aplikasi
class TontonAjaApp extends StatelessWidget {
  const TontonAjaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TontonAja',
      debugShowCheckedModeBanner: false,
      // Tema Aplikasi
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0F),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD8F602),
          surface: Color(0xFF141420),
        ),
      ),
      // Halaman pertama
      home: const GetStartedScreen(),
    );
  }
}
