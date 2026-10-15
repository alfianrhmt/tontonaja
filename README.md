# TontonAja 🎬

Aplikasi mobile streaming film yang dibuat dengan **Flutter**, mengonsumsi data dari **TMDB API** (The Movie Database).

> Tugas Mata Kuliah: Pemrograman API  
> Nama Repo: `tontonaja`

---

## 📱 Fitur Aplikasi

- **Home** — Menampilkan film populer & trending dari TMDB API secara real-time
- **Movie Detail** — Detail film lengkap (runtime, cast, sinopsis) dari TMDB API
- **Search** — Pencarian film
- **Favourites** — Daftar film favorit pengguna
- **Downloads** — Daftar film yang diunduh
- **Profile** — Halaman profil pengguna

---

## 🌐 API yang Digunakan

**The Movie Database (TMDB) API** — `https://api.themoviedb.org/3`

| Endpoint | Fungsi |
|---|---|
| `GET /movie/popular` | Mengambil daftar film populer |
| `GET /trending/movie/week` | Mengambil film trending minggu ini |
| `GET /movie/{id}?append_to_response=credits` | Detail film + daftar pemeran |

- **Base URL**: `https://api.themoviedb.org/3`
- **Image Base URL**: `https://image.tmdb.org/t/p/w500`
- **Autentikasi**: API Key (query parameter `api_key`)
- **Bahasa**: `id-ID` (Bahasa Indonesia)

---

## 🗄️ Database Migration

Script SQL untuk membuat struktur database tersedia di:

```
database/migrations/create_movies_table.sql
```

Script ini membuat **5 tabel**:

| Tabel | Keterangan |
|---|---|
| `genres` | Daftar genre film |
| `movies` | Data film utama |
| `users` | Data pengguna aplikasi |
| `favourites` | Film favorit per user |
| `downloads` | Film yang diunduh per user |

### Cara menjalankan migration:

```bash
# Login ke MySQL
mysql -u root -p

# Jalankan script
source database/migrations/create_movies_table.sql
```

Atau via command line langsung:

```bash
mysql -u root -p tontonaja_db < database/migrations/create_movies_table.sql
```

---

## 🚀 Cara Menjalankan Aplikasi

### Prasyarat
- Flutter SDK ≥ 3.13.2
- Dart SDK
- Android Studio / VS Code

### Langkah-langkah

```bash
# 1. Clone repository
git clone https://github.com/alfianrhmt/tontonaja.git
cd tontonaja

# 2. Install dependencies
flutter pub get

# 3. Jalankan aplikasi
flutter run
```

---

## 📦 Dependencies

| Package | Versi | Fungsi |
|---|---|---|
| `http` | ^1.2.0 | HTTP request ke TMDB API |
| `google_fonts` | ^6.1.0 | Tipografi Google Fonts |
| `cupertino_icons` | ^1.0.8 | Icon iOS-style |

---

## 📁 Struktur Proyek

```
lib/
├── data/
│   ├── movies.dart         # Data film statis (fallback)
│   └── tmdb_service.dart   # Service TMDB API
├── screens/
│   ├── home_screen.dart
│   ├── movie_detail_screen.dart
│   ├── movie_list_screen.dart
│   ├── search_screen.dart
│   ├── favourites_screen.dart
│   ├── downloads_screen.dart
│   ├── profile_screen.dart
│   ├── login_screen.dart
│   ├── get_started_screen.dart
│   └── main_screen.dart
└── widgets/
database/
└── migrations/
    └── create_movies_table.sql
```
