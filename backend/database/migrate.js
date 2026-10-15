// backend/database/migrate.js
// Script untuk membuat tabel dan mengisi data awal (seed) ke SQLite

const Database = require('better-sqlite3');
const path = require('path');

const DB_PATH = path.join(__dirname, '..', 'tontonaja.db');
const db = new Database(DB_PATH);

// Aktifkan foreign key support di SQLite
db.pragma('foreign_keys = ON');

console.log('🚀 Menjalankan migration...');

// ============================================================
// Buat tabel genres
// ============================================================
db.exec(`
  CREATE TABLE IF NOT EXISTS genres (
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT    NOT NULL UNIQUE
  )
`);
console.log('  ✅ Tabel genres dibuat');

// ============================================================
// Buat tabel movies
// ============================================================
db.exec(`
  CREATE TABLE IF NOT EXISTS movies (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    title      TEXT    NOT NULL,
    genre_id   INTEGER NOT NULL,
    year       INTEGER NOT NULL,
    rating     REAL    NOT NULL DEFAULT 0.0,
    duration   TEXT    NOT NULL,
    synopsis   TEXT,
    cast_list  TEXT,
    poster_url TEXT,
    tmdb_id    INTEGER UNIQUE,
    created_at TEXT    NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT    NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (genre_id) REFERENCES genres (id)
  )
`);
console.log('  ✅ Tabel movies dibuat');

// ============================================================
// Buat tabel users
// ============================================================
db.exec(`
  CREATE TABLE IF NOT EXISTS users (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    name       TEXT NOT NULL,
    email      TEXT NOT NULL UNIQUE,
    password   TEXT NOT NULL,
    avatar_url TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
  )
`);
console.log('  ✅ Tabel users dibuat');

// ============================================================
// Buat tabel favourites
// ============================================================
db.exec(`
  CREATE TABLE IF NOT EXISTS favourites (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id    INTEGER NOT NULL,
    movie_id   INTEGER NOT NULL,
    created_at TEXT    NOT NULL DEFAULT (datetime('now')),
    UNIQUE (user_id, movie_id),
    FOREIGN KEY (user_id)  REFERENCES users  (id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies (id) ON DELETE CASCADE
  )
`);
console.log('  ✅ Tabel favourites dibuat');

// ============================================================
// Buat tabel downloads
// ============================================================
db.exec(`
  CREATE TABLE IF NOT EXISTS downloads (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id       INTEGER NOT NULL,
    movie_id      INTEGER NOT NULL,
    file_size     TEXT,
    quality       TEXT    NOT NULL DEFAULT 'HD',
    downloaded_at TEXT    NOT NULL DEFAULT (datetime('now')),
    UNIQUE (user_id, movie_id),
    FOREIGN KEY (user_id)  REFERENCES users  (id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies (id) ON DELETE CASCADE
  )
`);
console.log('  ✅ Tabel downloads dibuat');

// ============================================================
// Seed data genre
// ============================================================
console.log('\n📦 Mengisi data seed...');

const genres = [
  'Action', 'Adventure', 'Animation', 'Comedy', 'Crime',
  'Drama', 'Horror', 'Romance', 'Sci-Fi', 'Thriller', 'Documentary'
];

const insertGenre = db.prepare(
  'INSERT OR IGNORE INTO genres (name) VALUES (?)'
);
genres.forEach(name => insertGenre.run(name));
console.log(`  ✅ ${genres.length} genre dimasukkan`);

// ============================================================
// Seed data film
// ============================================================
const getGenreId = db.prepare('SELECT id FROM genres WHERE name = ?');

const insertMovie = db.prepare(`
  INSERT OR IGNORE INTO movies
    (title, genre_id, year, rating, duration, synopsis, cast_list, poster_url, tmdb_id)
  VALUES
    (@title, @genre_id, @year, @rating, @duration, @synopsis, @cast_list, @poster_url, @tmdb_id)
`);

const moviesData = [
  {
    title: 'Interstellar', genre: 'Sci-Fi', year: 2014, rating: 8.7,
    duration: '2j 49m', tmdb_id: 157336,
    synopsis: 'Seorang mantan pilot NASA melakukan perjalanan melalui lubang cacing di luar angkasa untuk memastikan kelangsungan hidup umat manusia.',
    cast_list: 'Matthew McConaughey, Anne Hathaway, Jessica Chastain',
    poster_url: 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
  },
  {
    title: 'The Dark Knight', genre: 'Action', year: 2008, rating: 9.0,
    duration: '2j 32m', tmdb_id: 155,
    synopsis: 'Batman menghadapi musuh terbesarnya, The Joker, yang berusaha menjerumuskan kota Gotham ke dalam kekacauan.',
    cast_list: 'Christian Bale, Heath Ledger, Aaron Eckhart',
    poster_url: 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
  },
  {
    title: 'Inception', genre: 'Sci-Fi', year: 2010, rating: 8.8,
    duration: '2j 28m', tmdb_id: 27205,
    synopsis: 'Seorang pencuri yang memasuki mimpi orang lain untuk mencuri rahasia mendapat tugas berbeda: menanamkan sebuah ide ke dalam pikiran seseorang.',
    cast_list: 'Leonardo DiCaprio, Joseph Gordon-Levitt, Elliot Page',
    poster_url: 'https://image.tmdb.org/t/p/w500/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg',
  },
  {
    title: 'Parasite', genre: 'Drama', year: 2019, rating: 8.5,
    duration: '2j 12m', tmdb_id: 496243,
    synopsis: 'Keluarga miskin yang perlahan menyusup ke dalam kehidupan keluarga kaya. Pemenang Oscar ini adalah satir gelap tentang kesenjangan kelas sosial.',
    cast_list: 'Song Kang-ho, Lee Sun-kyun, Cho Yeo-jeong',
    poster_url: 'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
  },
  {
    title: 'The Conjuring', genre: 'Horror', year: 2013, rating: 7.5,
    duration: '1j 52m', tmdb_id: 138843,
    synopsis: 'Pasangan paranormal investigator membantu sebuah keluarga yang diteror oleh kehadiran jahat di rumah baru mereka.',
    cast_list: 'Vera Farmiga, Patrick Wilson, Lili Taylor',
    poster_url: 'https://image.tmdb.org/t/p/w500/wVYREutTvI2tmxr6ujrHT704wGF.jpg',
  },
  {
    title: 'Avengers: Endgame', genre: 'Action', year: 2019, rating: 8.4,
    duration: '3j 1m', tmdb_id: 299534,
    synopsis: 'Para Avengers yang tersisa bersatu untuk membalikkan aksi Thanos dan memulihkan keseimbangan alam semesta.',
    cast_list: 'Robert Downey Jr., Chris Evans, Mark Ruffalo',
    poster_url: 'https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
  },
  {
    title: 'The Grand Budapest Hotel', genre: 'Comedy', year: 2014, rating: 8.1,
    duration: '1j 39m', tmdb_id: 120467,
    synopsis: 'Petualangan seorang concierge legendaris di sebuah hotel mewah Eropa bersama lobby boy-nya yang setia.',
    cast_list: 'Ralph Fiennes, Tony Revolori, Saoirse Ronan',
    poster_url: 'https://image.tmdb.org/t/p/w500/eWdyYQreja6JGCzqHWXpWHDrrPo.jpg',
  },
  {
    title: 'Dune', genre: 'Sci-Fi', year: 2021, rating: 8.0,
    duration: '2j 35m', tmdb_id: 438631,
    synopsis: 'Seorang pemuda berbakat dari keluarga bangsawan memimpin gerakan pembebasan di planet gurun yang menyimpan sumber daya paling berharga di alam semesta.',
    cast_list: 'Timothee Chalamet, Rebecca Ferguson, Oscar Isaac',
    poster_url: 'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
  },
  {
    title: 'A Quiet Place', genre: 'Horror', year: 2018, rating: 7.5,
    duration: '1j 30m', tmdb_id: 447332,
    synopsis: 'Sebuah keluarga berjuang untuk bertahan hidup dalam dunia yang dihuni makhluk pemburu buta yang bereaksi terhadap suara.',
    cast_list: 'Emily Blunt, John Krasinski, Millicent Simmonds',
    poster_url: 'https://image.tmdb.org/t/p/w500/nAU74GmpUk7t5iklEp3bufwDq4n.jpg',
  },
  {
    title: 'Crazy Rich Asians', genre: 'Comedy', year: 2018, rating: 6.9,
    duration: '2j 1m', tmdb_id: 476669,
    synopsis: 'Seorang wanita Amerika-Cina terkejut saat mengetahui bahwa pacarnya berasal dari salah satu keluarga terkaya di Singapura.',
    cast_list: 'Constance Wu, Henry Golding, Michelle Yeoh',
    poster_url: 'https://image.tmdb.org/t/p/w500/gnTqi6bWzWk0qA4z0kO2LgC7j5K.jpg',
  },
  {
    title: 'Joker', genre: 'Drama', year: 2019, rating: 8.4,
    duration: '2j 2m', tmdb_id: 475557,
    synopsis: 'Kisah asal-usul sang villain ikonik Batman. Seorang pria yang gagal sebagai komedian stand-up perlahan kehilangan kewarasannya.',
    cast_list: 'Joaquin Phoenix, Robert De Niro, Zazie Beetz',
    poster_url: 'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg',
  },
  {
    title: 'John Wick', genre: 'Action', year: 2014, rating: 7.4,
    duration: '1j 41m', tmdb_id: 245891,
    synopsis: 'Seorang pembunuh bayaran legendaris yang sudah pensiun kembali ke dunia bawah tanah setelah anjingnya dibunuh oleh anak mafia.',
    cast_list: 'Keanu Reeves, Michael Nyqvist, Alfie Allen',
    poster_url: 'https://image.tmdb.org/t/p/w500/fZPSd91yGE9fCcCe6OoQr6E3Bev.jpg',
  },
  {
    title: 'Midsommar', genre: 'Horror', year: 2019, rating: 7.1,
    duration: '2j 28m', tmdb_id: 530385,
    synopsis: 'Sepasang kekasih dan teman-teman mereka mengunjungi festival musim panas di Swedia yang menyimpan ritual pagan yang gelap.',
    cast_list: 'Florence Pugh, Jack Reynor, Vilhelm Blomgren',
    poster_url: 'https://image.tmdb.org/t/p/w500/7LEI8ulhhTeB2YDX0iY20VIhuK8.jpg',
  },
  {
    title: 'The Martian', genre: 'Sci-Fi', year: 2015, rating: 8.0,
    duration: '2j 24m', tmdb_id: 286217,
    synopsis: 'Seorang astronaut ditinggal sendirian di Mars setelah dianggap tewas dan harus bertahan hidup menggunakan kecerdasannya.',
    cast_list: 'Matt Damon, Jessica Chastain, Kristen Wiig',
    poster_url: 'https://image.tmdb.org/t/p/w500/5BHuvQ6p9kL09NMd8yFkL2Y1gRk.jpg',
  },
  {
    title: 'Knives Out', genre: 'Drama', year: 2019, rating: 7.9,
    duration: '2j 10m', tmdb_id: 546554,
    synopsis: 'Kematian misterius seorang penulis novel detektif memicu penyelidikan yang melibatkan seluruh anggota keluarganya yang eksentrik.',
    cast_list: 'Daniel Craig, Ana de Armas, Chris Evans',
    poster_url: 'https://image.tmdb.org/t/p/w500/pThyQovXQrw2m0s9x82twj48Jq4.jpg',
  },
];

const seedMovies = db.transaction(() => {
  moviesData.forEach(movie => {
    const genre = getGenreId.get(movie.genre);
    insertMovie.run({
      title: movie.title,
      genre_id: genre.id,
      year: movie.year,
      rating: movie.rating,
      duration: movie.duration,
      synopsis: movie.synopsis,
      cast_list: movie.cast_list,
      poster_url: movie.poster_url,
      tmdb_id: movie.tmdb_id,
    });
  });
});

seedMovies();
console.log(`  ✅ ${moviesData.length} film dimasukkan`);

db.close();
console.log('\n🎉 Migration selesai! Database: tontonaja.db');
