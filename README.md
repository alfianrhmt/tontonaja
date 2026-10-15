# Tugas API - TontonAja

Aplikasi streaming dan katalog film sederhana pakai Flutter, backend-nya pakai Express.js dan SQLite.

## Cara Menjalankan

### 1. Jalankan Backend & Database
Masuk ke folder backend, install modul, jalankan migration, lalu start servernya:

```bash
cd backend
npm install
npm run migrate
npm start
```

Server jalan di `http://localhost:3000`.

### 2. Jalankan Aplikasi Flutter
Buka terminal baru di folder utama tontonaja:

```bash
flutter run
```

Pilih Chrome atau device yang mau dipakai.

## Endpoint API Backend

- `GET /api/movies` : ambil semua film (bisa filter ?genre=NamaGenre)
- `GET /api/movies/:id` : detail film berdasarkan id
- `GET /api/movies/search?q=kata_kunci` : cari film berdasarkan judul
- `GET /api/genres` : ambil semua list genre
- `GET /api/favourites` : ambil daftar film favorit
- `POST /api/favourites` : tambah film ke favorit (body: movie_id)
- `DELETE /api/favourites/:movie_id` : hapus film dari favorit
- `GET /api/downloads` : ambil daftar film unduhan
- `POST /api/downloads` : tambah unduhan baru
