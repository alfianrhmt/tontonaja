import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_screen.dart';

// ===============================
// COLOR PALETTE
// ===============================

const green = Color(0xFFD8F602);
const grey = Color(0xFF3B3A3E);
const black = Color(0xFF202226);

// ===============================
// PROFILE SCREEN
// ===============================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,

      // =============================
      // HEADER
      // =============================
      appBar: AppBar(
        backgroundColor: black,
        elevation: 0,
        automaticallyImplyLeading: false,

        title: Text(
          'Profil',
          style: poppins(size: 18, weight: FontWeight.w700),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings_outlined,
              color: Colors.white70,
              size: 20,
            ),
          ),
        ],
      ),

      // =============================
      // CONTENT
      // =============================
      body: SingleChildScrollView(
        child: Column(
          children: [
            // PROFILE
            const ProfileHeader(),

            const SizedBox(height: 19),

            // STATISTICS
            const Row(
              children: [
                Expanded(
                  child: StatCard(number: '12', label: 'Ditonton'),
                ),
                Expanded(
                  child: StatCard(number: '4', label: 'Favorit'),
                ),
                Expanded(
                  child: StatCard(number: '3', label: 'Unduhan'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // MENU
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  sectionTitle('Akun Saya'),

                  menu(Icons.history, 'Riwayat Tonton', '12 film ditonton'),

                  menu(
                    Icons.favorite_outline,
                    'Film Favorit',
                    '4 film disimpan',
                  ),

                  menu(
                    Icons.download_outlined,
                    'Unduhan Saya',
                    '3 film tersedia offline',
                  ),

                  const SizedBox(height: 17),

                  sectionTitle('Pengaturan'),

                  menu(Icons.person_outline, 'Edit Profil'),

                  menu(Icons.notifications_outlined, 'Notifikasi'),

                  menu(Icons.language_outlined, 'Bahasa', 'Indonesia'),

                  menu(Icons.help_outline, 'Bantuan & FAQ'),

                  const SizedBox(height: 15),

                  // LOGOUT
                  SizedBox(
                    width: double.infinity,
                    height: 45,

                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },

                      icon: const Icon(Icons.logout, color: green, size: 17),

                      label: Text(
                        'Keluar',
                        style: poppins(
                          size: 12,
                          weight: FontWeight.w600,
                          color: green,
                        ),
                      ),

                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: green),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===============================
// PROFILE HEADER
// ===============================

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),

        // Avatar
        Container(
          width: 73,
          height: 73,

          decoration: BoxDecoration(
            color: green.withValues(alpha: 0.13),
            shape: BoxShape.circle,
          ),

          alignment: Alignment.center,

          child: Text(
            'BN',
            style: poppins(size: 20, weight: FontWeight.w700, color: green),
          ),
        ),

        const SizedBox(height: 10),

        // Nama
        Text('Budi Nugroho', style: poppins(size: 16, weight: FontWeight.w700)),

        const SizedBox(height: 2),

        // Email
        Text(
          'budi.nugroho@email.com',
          style: poppins(size: 10, color: Colors.white60),
        ),

        const SizedBox(height: 25),
      ],
    );
  }
}

// ===============================
// STAT CARD
// ===============================

class StatCard extends StatelessWidget {
  final String number;
  final String label;

  const StatCard({super.key, required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,

      margin: const EdgeInsets.symmetric(horizontal: 5),

      decoration: BoxDecoration(
        color: black,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: grey, width: 0.5),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Text(number, style: poppins(size: 17, weight: FontWeight.w700)),

          Text(label, style: poppins(size: 9, color: Colors.white60)),
        ],
      ),
    );
  }
}

// ===============================
// MENU CARD
// ===============================

Widget menu(IconData icon, String title, [String? subtitle]) {
  return Container(
    height: subtitle == null ? 48 : 52,

    margin: const EdgeInsets.only(bottom: 6),

    padding: const EdgeInsets.symmetric(horizontal: 10),

    decoration: BoxDecoration(
      color: black,
      borderRadius: BorderRadius.circular(11),
      border: Border.all(color: grey, width: 0.5),
    ),

    child: Row(
      children: [
        // ICON
        Container(
          width: 34,
          height: 34,

          decoration: BoxDecoration(
            color: grey.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(9),
          ),

          child: Icon(icon, color: Colors.white60, size: 16),
        ),

        const SizedBox(width: 10),

        // TEXT
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(title, style: poppins(size: 11, weight: FontWeight.w600)),

              if (subtitle != null)
                Text(subtitle, style: poppins(size: 8, color: Colors.white54)),
            ],
          ),
        ),

        // ARROW
        const Icon(Icons.chevron_right, color: Colors.white38, size: 17),
      ],
    ),
  );
}

// ===============================
// SECTION TITLE
// ===============================

Widget sectionTitle(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 7),

    child: Text(
      text,
      style: poppins(size: 9, weight: FontWeight.w500, color: Colors.white70),
    ),
  );
}

// ===============================
// POPPINS HELPER
// ===============================

TextStyle poppins({
  double size = 14,
  FontWeight weight = FontWeight.w400,
  Color color = Colors.white,
}) {
  return GoogleFonts.poppins(fontSize: size, fontWeight: weight, color: color);
}
