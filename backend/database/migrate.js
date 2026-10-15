const Database = require('better-sqlite3');
const path = require('path');

const db = new Database(path.join(__dirname, '..', 'tontonaja.db'));
db.pragma('foreign_keys = ON');

// buat tabel-tabel yang dibutuhkan
db.exec(`
  CREATE TABLE IF NOT EXISTS genres (
    id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
  );

  CREATE TABLE IF NOT EXISTS movies (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    title      TEXT    NOT NULL,
    genre_id   INTEGER NOT NULL REFERENCES genres(id),
    year       INTEGER NOT NULL,
    rating     REAL    NOT NULL DEFAULT 0,
    duration   TEXT    NOT NULL,
    synopsis   TEXT,
    cast_list  TEXT,
    poster_url TEXT,
    tmdb_id    INTEGER UNIQUE,
    created_at TEXT    NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT    NOT NULL DEFAULT (datetime('now'))
  );

  CREATE TABLE IF NOT EXISTS users (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    name       TEXT NOT NULL,
    email      TEXT NOT NULL UNIQUE,
    password   TEXT NOT NULL,
    avatar_url TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
  );

  CREATE TABLE IF NOT EXISTS favourites (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id    INTEGER NOT NULL REFERENCES users(id)  ON DELETE CASCADE,
    movie_id   INTEGER NOT NULL REFERENCES movies(id) ON DELETE CASCADE,
    created_at TEXT    NOT NULL DEFAULT (datetime('now')),
    UNIQUE(user_id, movie_id)
  );

  CREATE TABLE IF NOT EXISTS downloads (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id       INTEGER NOT NULL REFERENCES users(id)  ON DELETE CASCADE,
    movie_id      INTEGER NOT NULL REFERENCES movies(id) ON DELETE CASCADE,
    quality       TEXT    NOT NULL DEFAULT 'HD',
    file_size     TEXT,
    downloaded_at TEXT    NOT NULL DEFAULT (datetime('now')),
    UNIQUE(user_id, movie_id)
  );
`);

// seed genre
const insertGenre = db.prepare('INSERT OR IGNORE INTO genres (name) VALUES (?)');
const genres = ['Action', 'Adventure', 'Animation', 'Comedy', 'Crime', 'Drama', 'Horror', 'Romance', 'Sci-Fi', 'Thriller', 'Documentary'];
genres.forEach(g => insertGenre.run(g));

// seed film
const genreId = name => db.prepare('SELECT id FROM genres WHERE name = ?').get(name).id;

const insertMovie = db.prepare(`
  INSERT OR IGNORE INTO movies (title, genre_id, year, rating, duration, synopsis, cast_list, poster_url, tmdb_id)
  VALUES (@title, @genre_id, @year, @rating, @duration, @synopsis, @cast_list, @poster_url, @tmdb_id)
`);

const movies = [
  {
    title: 'Interstellar', genre_id: genreId('Sci-Fi'), year: 2014, rating: 8.7, duration: '2j 49m', tmdb_id: 157336,
    synopsis: 'Seorang mantan pilot NASA melakukan perjalanan melalui lubang cacing di luar angkasa untuk memastikan kelangsungan hidup umat manusia.',
    cast_list: 'Matthew McConaughey, Anne Hathaway, Jessica Chastain',
    poster_url: 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
  },
  {
    title: 'The Dark Knight', genre_id: genreId('Action'), year: 2008, rating: 9.0, duration: '2j 32m', tmdb_id: 155,
    synopsis: 'Batman menghadapi musuh terbesarnya, The Joker, yang berusaha menjerumuskan kota Gotham ke dalam kekacauan.',
    cast_list: 'Christian Bale, Heath Ledger, Aaron Eckhart',
    poster_url: 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
  },
  {
    title: 'Inception', genre_id: genreId('Sci-Fi'), year: 2010, rating: 8.8, duration: '2j 28m', tmdb_id: 27205,
    synopsis: 'Seorang pencuri yang memasuki mimpi orang lain mendapat tugas untuk menanamkan sebuah ide ke dalam pikiran targetnya.',
    cast_list: 'Leonardo DiCaprio, Joseph Gordon-Levitt, Elliot Page',
    poster_url: 'https://image.tmdb.org/t/p/w500/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg',
  },
  {
    title: 'Parasite', genre_id: genreId('Drama'), year: 2019, rating: 8.5, duration: '2j 12m', tmdb_id: 496243,
    synopsis: 'Keluarga miskin yang perlahan menyusup ke kehidupan keluarga kaya. Satir gelap tentang kesenjangan kelas sosial.',
    cast_list: 'Song Kang-ho, Lee Sun-kyun, Cho Yeo-jeong',
    poster_url: 'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
  },
  {
    title: 'The Conjuring', genre_id: genreId('Horror'), year: 2013, rating: 7.5, duration: '1j 52m', tmdb_id: 138843,
    synopsis: 'Sepasang paranormal investigator membantu keluarga yang diteror oleh kehadiran jahat di rumah baru mereka.',
    cast_list: 'Vera Farmiga, Patrick Wilson, Lili Taylor',
    poster_url: 'https://image.tmdb.org/t/p/w500/wVYREutTvI2tmxr6ujrHT704wGF.jpg',
  },
  {
    title: 'Avengers: Endgame', genre_id: genreId('Action'), year: 2019, rating: 8.4, duration: '3j 1m', tmdb_id: 299534,
    synopsis: 'Para Avengers yang tersisa bersatu untuk membalikkan aksi Thanos dan memulihkan keseimbangan alam semesta.',
    cast_list: 'Robert Downey Jr., Chris Evans, Mark Ruffalo',
    poster_url: 'https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
  },
  {
    title: 'The Grand Budapest Hotel', genre_id: genreId('Comedy'), year: 2014, rating: 8.1, duration: '1j 39m', tmdb_id: 120467,
    synopsis: 'Petualangan concierge legendaris sebuah hotel mewah Eropa bersama lobby boy setianya.',
    cast_list: 'Ralph Fiennes, Tony Revolori, Saoirse Ronan',
    poster_url: 'https://image.tmdb.org/t/p/w500/eWdyYQreja6JGCzqHWXpWHDrrPo.jpg',
  },
  {
    title: 'Dune', genre_id: genreId('Sci-Fi'), year: 2021, rating: 8.0, duration: '2j 35m', tmdb_id: 438631,
    synopsis: 'Pemuda dari keluarga bangsawan memimpin perlawanan di planet gurun yang menyimpan sumber daya paling berharga di alam semesta.',
    cast_list: 'Timothee Chalamet, Rebecca Ferguson, Oscar Isaac',
    poster_url: 'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
  },
  {
    title: 'A Quiet Place', genre_id: genreId('Horror'), year: 2018, rating: 7.5, duration: '1j 30m', tmdb_id: 447332,
    synopsis: 'Keluarga yang berjuang bertahan hidup di dunia yang dihuni makhluk pemburu buta sensitif suara.',
    cast_list: 'Emily Blunt, John Krasinski, Millicent Simmonds',
    poster_url: 'https://image.tmdb.org/t/p/w500/nAU74GmpUk7t5iklEp3bufwDq4n.jpg',
  },
  {
    title: 'Crazy Rich Asians', genre_id: genreId('Comedy'), year: 2018, rating: 6.9, duration: '2j 1m', tmdb_id: 476669,
    synopsis: 'Wanita Amerika-Cina kaget saat tahu pacarnya berasal dari salah satu keluarga terkaya di Singapura.',
    cast_list: 'Constance Wu, Henry Golding, Michelle Yeoh',
    poster_url: 'https://image.tmdb.org/t/p/w500/gnTqi6bWzWk0qA4z0kO2LgC7j5K.jpg',
  },
  {
    title: 'Joker', genre_id: genreId('Drama'), year: 2019, rating: 8.4, duration: '2j 2m', tmdb_id: 475557,
    synopsis: 'Asal-usul villain ikonik Batman — pria gagal yang perlahan kehilangan kewarasan dan jadi simbol perlawanan.',
    cast_list: 'Joaquin Phoenix, Robert De Niro, Zazie Beetz',
    poster_url: 'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg',
  },
  {
    title: 'John Wick', genre_id: genreId('Action'), year: 2014, rating: 7.4, duration: '1j 41m', tmdb_id: 245891,
    synopsis: 'Pembunuh bayaran pensiun kembali beraksi setelah anjingnya dibunuh anak mafia. Koreografi pertarungan yang luar biasa.',
    cast_list: 'Keanu Reeves, Michael Nyqvist, Alfie Allen',
    poster_url: 'https://image.tmdb.org/t/p/w500/fZPSd91yGE9fCcCe6OoQr6E3Bev.jpg',
  },
  {
    title: 'Midsommar', genre_id: genreId('Horror'), year: 2019, rating: 7.1, duration: '2j 28m', tmdb_id: 530385,
    synopsis: 'Sepasang kekasih mengunjungi festival musim panas di Swedia yang ternyata menyimpan ritual pagan yang mengerikan.',
    cast_list: 'Florence Pugh, Jack Reynor, Vilhelm Blomgren',
    poster_url: 'https://image.tmdb.org/t/p/w500/7LEI8ulhhTeB2YDX0iY20VIhuK8.jpg',
  },
  {
    title: 'The Martian', genre_id: genreId('Sci-Fi'), year: 2015, rating: 8.0, duration: '2j 24m', tmdb_id: 286217,
    synopsis: 'Astronaut yang tertinggal sendirian di Mars harus bertahan hidup menggunakan ilmu pengetahuan sambil menunggu pertolongan.',
    cast_list: 'Matt Damon, Jessica Chastain, Kristen Wiig',
    poster_url: 'https://image.tmdb.org/t/p/w500/5BHuvQ6p9kL09NMd8yFkL2Y1gRk.jpg',
  },
  {
    title: 'Knives Out', genre_id: genreId('Drama'), year: 2019, rating: 7.9, duration: '2j 10m', tmdb_id: 546554,
    synopsis: 'Kematian misterius penulis novel detektif memicu penyelidikan yang melibatkan seluruh keluarganya yang eksentrik.',
    cast_list: 'Daniel Craig, Ana de Armas, Chris Evans',
    poster_url: 'https://image.tmdb.org/t/p/w500/pThyQovXQrw2m0s9x82twj48Jq4.jpg',
  },
];

const seed = db.transaction(() => {
  movies.forEach(m => insertMovie.run(m));

  // seed user demo
  db.prepare(`
    INSERT OR IGNORE INTO users (id, name, email, password)
    VALUES (1, 'User Demo', 'user@tontonaja.com', 'password123')
  `).run();

  // seed data awal favorit & unduhan
  const insertFav = db.prepare('INSERT OR IGNORE INTO favourites (user_id, movie_id) VALUES (?, ?)');
  [1, 3, 6, 11].forEach(id => insertFav.run(1, id));

  const insertDl = db.prepare('INSERT OR IGNORE INTO downloads (user_id, movie_id, quality, file_size) VALUES (?, ?, ?, ?)');
  insertDl.run(1, 2, 'HD', '1.4 GB');
  insertDl.run(1, 8, 'Full HD', '2.1 GB');
  insertDl.run(1, 12, 'HD', '1.1 GB');
});

seed();

db.close();
console.log('migration selesai.');
