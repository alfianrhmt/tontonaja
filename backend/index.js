// backend/index.js
// Server API TontonAja menggunakan Express + SQLite

const express = require('express');
const cors    = require('cors');
const path    = require('path');
const Database = require('better-sqlite3');

const app  = express();
const PORT = 3000;

// ── Middleware ────────────────────────────────────────────────
app.use(cors());
app.use(express.json());

// ── Koneksi Database ──────────────────────────────────────────
const DB_PATH = path.join(__dirname, 'tontonaja.db');
const db = new Database(DB_PATH);
db.pragma('foreign_keys = ON');

// ─────────────────────────────────────────────────────────────
// MOVIES — endpoint untuk data film
// ─────────────────────────────────────────────────────────────

// GET /api/movies — ambil semua film, bisa filter by genre
app.get('/api/movies', (req, res) => {
  const { genre } = req.query;

  let query = `
    SELECT m.*, g.name AS genre_name
    FROM movies m
    JOIN genres g ON m.genre_id = g.id
  `;
  const params = [];

  if (genre && genre !== 'Semua') {
    query += ' WHERE g.name = ?';
    params.push(genre);
  }

  query += ' ORDER BY m.rating DESC';

  const movies = db.prepare(query).all(...params);
  res.json({ success: true, data: movies });
});

// GET /api/movies/search?q=keyword — cari film berdasarkan judul
// ⚠️ Harus SEBELUM /:id agar tidak tertangkap sebagai ID
app.get('/api/movies/search', (req, res) => {
  const { q } = req.query;
  if (!q) return res.json({ success: true, data: [] });

  const movies = db.prepare(`
    SELECT m.*, g.name AS genre_name
    FROM movies m
    JOIN genres g ON m.genre_id = g.id
    WHERE m.title LIKE ?
    ORDER BY m.rating DESC
  `).all(`%${q}%`);

  res.json({ success: true, data: movies });
});

// GET /api/movies/:id — detail satu film
app.get('/api/movies/:id', (req, res) => {
  const movie = db.prepare(`
    SELECT m.*, g.name AS genre_name
    FROM movies m
    JOIN genres g ON m.genre_id = g.id
    WHERE m.id = ?
  `).get(req.params.id);

  if (!movie) {
    return res.status(404).json({ success: false, message: 'Film tidak ditemukan' });
  }

  res.json({ success: true, data: movie });
});

// ─────────────────────────────────────────────────────────────
// GENRES — endpoint untuk data genre
// ─────────────────────────────────────────────────────────────

// GET /api/genres — ambil semua genre
app.get('/api/genres', (req, res) => {
  const genres = db.prepare('SELECT * FROM genres ORDER BY name').all();
  res.json({ success: true, data: genres });
});

// ─────────────────────────────────────────────────────────────
// FAVOURITES — endpoint untuk film favorit
// ─────────────────────────────────────────────────────────────

// GET /api/favourites — semua film favorit
app.get('/api/favourites', (req, res) => {
  const favourites = db.prepare(`
    SELECT m.*, g.name AS genre_name
    FROM favourites f
    JOIN movies m ON f.movie_id = m.id
    JOIN genres g ON m.genre_id = g.id
    ORDER BY f.created_at DESC
  `).all();

  res.json({ success: true, data: favourites });
});

// POST /api/favourites — tambah film ke favorit
app.post('/api/favourites', (req, res) => {
  const { user_id = 1, movie_id } = req.body;

  if (!movie_id) {
    return res.status(400).json({ success: false, message: 'movie_id wajib diisi' });
  }

  try {
    db.prepare(
      'INSERT INTO favourites (user_id, movie_id) VALUES (?, ?)'
    ).run(user_id, movie_id);

    res.status(201).json({ success: true, message: 'Ditambahkan ke favorit' });
  } catch (err) {
    res.status(409).json({ success: false, message: 'Film sudah ada di favorit' });
  }
});

// DELETE /api/favourites/:movie_id — hapus dari favorit
app.delete('/api/favourites/:movie_id', (req, res) => {
  db.prepare(
    'DELETE FROM favourites WHERE movie_id = ?'
  ).run(req.params.movie_id);

  res.json({ success: true, message: 'Dihapus dari favorit' });
});

// ─────────────────────────────────────────────────────────────
// DOWNLOADS — endpoint untuk film yang didownload
// ─────────────────────────────────────────────────────────────

// GET /api/downloads — semua film yang didownload
app.get('/api/downloads', (req, res) => {
  const downloads = db.prepare(`
    SELECT m.*, g.name AS genre_name, d.quality, d.file_size, d.downloaded_at
    FROM downloads d
    JOIN movies m ON d.movie_id = m.id
    JOIN genres g ON m.genre_id = g.id
    ORDER BY d.downloaded_at DESC
  `).all();

  res.json({ success: true, data: downloads });
});

// POST /api/downloads — tambah film ke downloads
app.post('/api/downloads', (req, res) => {
  const { user_id = 1, movie_id, quality = 'HD', file_size = '1.2 GB' } = req.body;

  if (!movie_id) {
    return res.status(400).json({ success: false, message: 'movie_id wajib diisi' });
  }

  try {
    db.prepare(
      'INSERT INTO downloads (user_id, movie_id, quality, file_size) VALUES (?, ?, ?, ?)'
    ).run(user_id, movie_id, quality, file_size);

    res.status(201).json({ success: true, message: 'Film berhasil didownload' });
  } catch (err) {
    res.status(409).json({ success: false, message: 'Film sudah didownload sebelumnya' });
  }
});

// ─────────────────────────────────────────────────────────────
// Health check
// ─────────────────────────────────────────────────────────────
app.get('/', (req, res) => {
  res.json({
    message: 'TontonAja API',
    version: '1.0.0',
    endpoints: [
      'GET  /api/movies',
      'GET  /api/movies/:id',
      'GET  /api/movies/search?q=',
      'GET  /api/genres',
      'GET  /api/favourites',
      'POST /api/favourites',
      'DELETE /api/favourites/:movie_id',
      'GET  /api/downloads',
      'POST /api/downloads',
    ],
  });
});

// ── Start server ──────────────────────────────────────────────
app.listen(PORT, () => {
  console.log(`🎬 TontonAja API berjalan di http://localhost:${PORT}`);
  console.log(`📄 Lihat semua endpoint di http://localhost:${PORT}`);
});
