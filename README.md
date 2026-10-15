# TontonAja

Aplikasi katalog dan streaming film sederhana berbasis Flutter dengan backend REST API (Express.js) dan database SQLite.

Proyek ini dibuat untuk memenuhi tugas mata kuliah Pemrograman API / Web Service.

---

## Fitur Utama

- **Home**: Menampilkan film trending dan populer (menggunakan TMDB API).
- **Semua Film & Filter Genre**: Menampilkan katalog film dari database lokal berdasarkan genre.
- **Pencarian Film**: Mencari film berdasarkan judul lewat API backend.
- **Favorit**: Menyimpan dan melihat daftar film favorit pengguna.
- **Unduhan**: Menampilkan daftar film yang diunduh secara offline.

---

## 1. Menjalankan Backend & Database Migration

Backend dibuat menggunakan Node.js (Express) dan SQLite (better-sqlite3).

### Langkah Menjalankan:

1. Masuk ke folder backend:
   ```bash
   cd backend
   ```

2. Install dependency:
   ```bash
   npm install
   ```

3. Jalankan script migration untuk membuat tabel dan data awal:
   ```bash
   npm run migrate
   ```
   *File database `tontonaja.db` akan otomatis dibuat beserta tabel `genres`, `movies`, `users`, `favourites`, dan `downloads`.*

4. Jalankan server:
   ```bash
   npm start
   ```
   Server berjalan di `http://localhost:3000`.

---

## 2. Daftar Endpoint API

| Method | Endpoint | Deskripsi |
|---|---|---|
| `GET` | `/api/movies` | Ambil semua film (bisa filter `?genre=Action`) |
| `GET` | `/api/movies/:id` | Detail satu film |
| `GET` | `/api/movies/search?q=keyword` | Cari film berdasarkan judul |
| `GET` | `/api/genres` | Ambil daftar genre |
| `GET` | `/api/favourites` | Ambil daftar film favorit |
| `POST` | `/api/favourites` | Tambah film ke favorit |
| `DELETE` | `/api/favourites/:movie_id` | Hapus film dari favorit |
| `GET` | `/api/downloads` | Ambil daftar film yang diunduh |
| `POST` | `/api/downloads` | Tambah film ke unduhan |

---

## 3. Menjalankan Aplikasi Flutter

1. Kembali ke root folder proyek:
   ```bash
   cd ..
   ```

2. Ambil paket dependency Flutter:
   ```bash
   flutter pub get
   ```

3. Jalankan aplikasi:
   ```bash
   flutter run
   ```

> **Catatan Konfigurasi IP (`lib/data/api_service.dart`):**
> - Default menggunakan `http://10.0.2.2:3000/api` (khusus Android Emulator).
> - Jika menggunakan Web / Desktop / HP fisik, ubah base URL di `lib/data/api_service.dart` ke IP lokal laptop kamu atau `localhost`.

---

## Struktur Folder

```
tontonaja/
├── backend/
│   ├── database/
│   │   └── migrate.js    # Script migration & seeder database SQLite
│   ├── index.js          # REST API server (Express)
│   ├── package.json
│   └── tontonaja.db      # File database SQLite
├── lib/
│   ├── data/
│   │   ├── api_service.dart   # Service untuk memanggil API backend lokal
│   │   └── tmdb_service.dart  # Service untuk memanggil TMDB API (film trending)
│   ├── screens/               # Halaman antarmuka (Home, List, Detail, Search, dll)
│   ├── widgets/               # Komponen widget reusable
│   └── main.dart              # Entry point Flutter
└── README.md
```
