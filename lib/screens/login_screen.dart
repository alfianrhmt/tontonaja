import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_screen.dart';

// WARNA
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

      // HEADER
      appBar: AppBar(
        backgroundColor: black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Profil',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings_outlined,
              color: Colors.white70,
            ),
          ),
        ],
      ),

      // ISI HALAMAN
      body: SingleChildScrollView(
        child: Column(
          children: [

            // PROFIL
            const ProfileHeader(),

            const SizedBox(height: 20),

            // STATISTIK
            const Row(
              children: [
                Expanded(
                  child: StatCard(
                    number: '12',
                    title: 'Ditonton',
                  ),
                ),
                Expanded(
                  child: StatCard(
                    number: '4',
                    title: 'Favorit',
                  ),
                ),
                Expanded(
                  child: StatCard(
                    number: '3',
                    title: 'Unduhan',
                  ),
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

                  const Text(
                    'Akun Saya',
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 7),

                  const MenuCard(
                    icon: Icons.history,
                    title: 'Riwayat Tonton',
                    subtitle: '12 film ditonton',
                  ),

                  const MenuCard(
                    icon: Icons.favorite_outline,
                    title: 'Film Favorit',
                    subtitle: '4 film disimpan',
                  ),

                  const MenuCard(
                    icon: Icons.download_outlined,
                    title: 'Unduhan Saya',
                    subtitle: '3 film tersedia offline',
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Pengaturan',
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 7),

                  const MenuCard(
                    icon: Icons.person_outline,
                    title: 'Edit Profil',
                  ),

                  const MenuCard(
                    icon: Icons.notifications_outlined,
                    title: 'Notifikasi',
                  ),

                  const MenuCard(
                    icon: Icons.language_outlined,
                    title: 'Bahasa',
                    subtitle: 'Indonesia',
                  ),

                  const MenuCard(
                    icon: Icons.help_outline,
                    title: 'Bantuan & FAQ',
                  ),

                  const SizedBox(height: 15),

                  // TOMBOL KELUAR
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
                      icon: const Icon(
                        Icons.logout,
                        color: green,
                      ),
                      label: const Text(
                        'Keluar',
                        style: TextStyle(
                          color: green,
                          fontWeight: FontWeight.bold,
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

        // AVATAR
        Container(
          width: 73,
          height: 73,
          decoration: BoxDecoration(
            color: green.withValues(alpha: 0.13),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            'BN',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: green,
            ),
          ),
        ),

        const SizedBox(height: 10),

        // NAMA
        Text(
          'Budi Nugroho',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 2),

        // EMAIL
        Text(
          'budi.nugroho@email.com',
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: Colors.white60,
          ),
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
  final String title;

  const StatCard({
    super.key,
    required this.number,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: black,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: grey,
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 9,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}

// ===============================
// MENU CARD
// ===============================

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const MenuCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: subtitle == null ? 48 : 52,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: black,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: grey,
          width: 0.5,
        ),
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
            child: Icon(
              icon,
              color: Colors.white60,
              size: 16,
            ),
          ),

          const SizedBox(width: 10),

          // TEXT
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),

                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: GoogleFonts.poppins(
                      fontSize: 8,
                      color: Colors.white54,
                    ),
                  ),
              ],
            ),
          ),

          // PANAH
          const Icon(
            Icons.chevron_right,
            color: Colors.white38,
            size: 17,
          ),
        ],
      ),
    );
  }
}
