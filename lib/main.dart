import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/get_started_screen.dart';

void main() {
  // Set orientasi hanya portrait agar tampilan konsisten
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // Set status bar transparan agar menyatu dengan background gelap
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
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
      // Theme gelap dengan font Poppins
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0F),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF141420),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return GoogleFonts.poppins(
                color: const Color(0xFFD8F602),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              );
            }
            return GoogleFonts.poppins(
              color: Colors.white38,
              fontSize: 11,
            );
          }),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD8F602),
          surface: Color(0xFF141420),
        ),
      ),
      // Halaman pertama adalah Get Started
      home: const GetStartedScreen(),
    );
  }
}