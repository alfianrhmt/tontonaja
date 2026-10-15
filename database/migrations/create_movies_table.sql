-- ============================================================
-- TontonAja — Database Migration Script
-- Deskripsi : Membuat struktur tabel untuk aplikasi movie streaming TontonAja
-- Dibuat     : 2026
-- Database   : MySQL / MariaDB
-- ============================================================

-- Buat database (opsional, jalankan jika belum ada)
CREATE DATABASE IF NOT EXISTS tontonaja_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE tontonaja_db;

-- ============================================================
-- Tabel: genres
-- Menyimpan daftar genre film
-- ============================================================
CREATE TABLE IF NOT EXISTS genres (
  id   INT          NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_genre_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- Tabel: movies
-- Menyimpan data film utama
-- ============================================================
CREATE TABLE IF NOT EXISTS movies (
  id          INT            NOT NULL AUTO_INCREMENT,
  title       VARCHAR(255)   NOT NULL,
  genre_id    INT            NOT NULL,
  year        YEAR           NOT NULL,
  rating      DECIMAL(3, 1)  NOT NULL DEFAULT 0.0,
  duration    VARCHAR(20)    NOT NULL COMMENT 'Format: Xj Ym (contoh: 2j 49m)',
  synopsis    TEXT,
  cast_list   TEXT           COMMENT 'Nama pemeran dipisah koma',
  poster_url  VARCHAR(500),
  tmdb_id     INT            UNIQUE    COMMENT 'ID film dari TMDB API (opsional)',
  created_at  TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (genre_id) REFERENCES genres (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  INDEX idx_movies_year   (year),
  INDEX idx_movies_rating (rating)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- Tabel: users
-- Menyimpan data pengguna aplikasi
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
  id         INT          NOT NULL AUTO_INCREMENT,
  name       VARCHAR(150) NOT NULL,
  email      VARCHAR(255) NOT NULL,
  password   VARCHAR(255) NOT NULL COMMENT 'Hashed password (bcrypt)',
  avatar_url VARCHAR(500),
  created_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_user_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- Tabel: favourites
-- Menyimpan film favorit masing-masing user
-- ============================================================
CREATE TABLE IF NOT EXISTS favourites (
  id         INT       NOT NULL AUTO_INCREMENT,
  user_id    INT       NOT NULL,
  movie_id   INT       NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_favourite (user_id, movie_id),
  FOREIGN KEY (user_id)  REFERENCES users  (id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (movie_id) REFERENCES movies (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- Tabel: downloads
-- Menyimpan film yang diunduh oleh user
-- ============================================================
CREATE TABLE IF NOT EXISTS downloads (
  id            INT         NOT NULL AUTO_INCREMENT,
  user_id       INT         NOT NULL,
  movie_id      INT         NOT NULL,
  file_size     VARCHAR(20) COMMENT 'Ukuran file, contoh: 1.2 GB',
  quality       VARCHAR(10) DEFAULT 'HD' COMMENT 'Kualitas: SD, HD, FHD',
  downloaded_at TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_download (user_id, movie_id),
  FOREIGN KEY (user_id)  REFERENCES users  (id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (movie_id) REFERENCES movies (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- DATA SEED: Insert genre-genre yang tersedia
-- ============================================================
INSERT INTO genres (name) VALUES
  ('Action'),
  ('Adventure'),
  ('Animation'),
  ('Comedy'),
  ('Crime'),
  ('Drama'),
  ('Horror'),
  ('Romance'),
  ('Sci-Fi'),
  ('Thriller'),
  ('Documentary');

-- ============================================================
-- DATA SEED: Insert data film awal (dari data statis aplikasi)
-- ============================================================
INSERT INTO movies (title, genre_id, year, rating, duration, synopsis, cast_list, poster_url, tmdb_id) VALUES
(
  'Interstellar',
  (SELECT id FROM genres WHERE name = 'Sci-Fi'),
  2014, 8.7, '2j 49m',
  'Seorang mantan pilot NASA melakukan perjalanan melalui lubang cacing di luar angkasa untuk memastikan kelangsungan hidup umat manusia.',
  'Matthew McConaughey, Anne Hathaway, Jessica Chastain',
  'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
  157336
),
(
  'The Dark Knight',
  (SELECT id FROM genres WHERE name = 'Action'),
  2008, 9.0, '2j 32m',
  'Batman menghadapi musuh terbesarnya, The Joker, yang berusaha menjerumuskan kota Gotham ke dalam kekacauan.',
  'Christian Bale, Heath Ledger, Aaron Eckhart',
  'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
  155
),
(
  'Inception',
  (SELECT id FROM genres WHERE name = 'Sci-Fi'),
  2010, 8.8, '2j 28m',
  'Seorang pencuri yang memasuki mimpi orang lain untuk mencuri rahasia mendapat tugas berbeda: menanamkan sebuah ide ke dalam pikiran seseorang.',
  'Leonardo DiCaprio, Joseph Gordon-Levitt, Elliot Page',
  'https://image.tmdb.org/t/p/w500/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg',
  27205
),
(
  'Parasite',
  (SELECT id FROM genres WHERE name = 'Drama'),
  2019, 8.5, '2j 12m',
  'Keluarga miskin yang perlahan menyusup ke dalam kehidupan keluarga kaya. Pemenang Oscar ini adalah satir gelap tentang kesenjangan kelas sosial.',
  'Song Kang-ho, Lee Sun-kyun, Cho Yeo-jeong',
  'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
  496243
),
(
  'The Conjuring',
  (SELECT id FROM genres WHERE name = 'Horror'),
  2013, 7.5, '1j 52m',
  'Pasangan paranormal investigator membantu sebuah keluarga yang diteror oleh kehadiran jahat di rumah baru mereka.',
  'Vera Farmiga, Patrick Wilson, Lili Taylor',
  'https://image.tmdb.org/t/p/w500/wVYREutTvI2tmxr6ujrHT704wGF.jpg',
  138843
),
(
  'Avengers: Endgame',
  (SELECT id FROM genres WHERE name = 'Action'),
  2019, 8.4, '3j 1m',
  'Para Avengers yang tersisa bersatu untuk membalikkan aksi Thanos dan memulihkan keseimbangan alam semesta.',
  'Robert Downey Jr., Chris Evans, Mark Ruffalo',
  'https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
  299534
),
(
  'The Grand Budapest Hotel',
  (SELECT id FROM genres WHERE name = 'Comedy'),
  2014, 8.1, '1j 39m',
  'Petualangan seorang concierge legendaris di sebuah hotel mewah Eropa bersama lobby boy-nya yang setia.',
  'Ralph Fiennes, Tony Revolori, Saoirse Ronan',
  'https://image.tmdb.org/t/p/w500/eWdyYQreja6JGCzqHWXpWHDrrPo.jpg',
  120467
),
(
  'Dune',
  (SELECT id FROM genres WHERE name = 'Sci-Fi'),
  2021, 8.0, '2j 35m',
  'Seorang pemuda berbakat dari keluarga bangsawan memimpin gerakan pembebasan di planet gurun yang menyimpan sumber daya paling berharga di alam semesta.',
  'Timothee Chalamet, Rebecca Ferguson, Oscar Isaac',
  'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
  438631
),
(
  'A Quiet Place',
  (SELECT id FROM genres WHERE name = 'Horror'),
  2018, 7.5, '1j 30m',
  'Sebuah keluarga berjuang untuk bertahan hidup dalam dunia yang dihuni makhluk pemburu buta yang bereaksi terhadap suara.',
  'Emily Blunt, John Krasinski, Millicent Simmonds',
  'https://image.tmdb.org/t/p/w500/nAU74GmpUk7t5iklEp3bufwDq4n.jpg',
  447332
),
(
  'Crazy Rich Asians',
  (SELECT id FROM genres WHERE name = 'Comedy'),
  2018, 6.9, '2j 1m',
  'Seorang wanita Amerika-Cina terkejut saat mengetahui bahwa pacarnya berasal dari salah satu keluarga terkaya di Singapura.',
  'Constance Wu, Henry Golding, Michelle Yeoh',
  'https://image.tmdb.org/t/p/w500/gnTqi6bWzWk0qA4z0kO2LgC7j5K.jpg',
  476669
),
(
  'Joker',
  (SELECT id FROM genres WHERE name = 'Drama'),
  2019, 8.4, '2j 2m',
  'Kisah asal-usul sang villain ikonik Batman. Seorang pria yang gagal sebagai komedian stand-up perlahan kehilangan kewarasannya.',
  'Joaquin Phoenix, Robert De Niro, Zazie Beetz',
  'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg',
  475557
),
(
  'John Wick',
  (SELECT id FROM genres WHERE name = 'Action'),
  2014, 7.4, '1j 41m',
  'Seorang pembunuh bayaran legendaris yang sudah pensiun kembali ke dunia bawah tanah setelah anjingnya dibunuh oleh anak mafia.',
  'Keanu Reeves, Michael Nyqvist, Alfie Allen',
  'https://image.tmdb.org/t/p/w500/fZPSd91yGE9fCcCe6OoQr6E3Bev.jpg',
  245891
),
(
  'Midsommar',
  (SELECT id FROM genres WHERE name = 'Horror'),
  2019, 7.1, '2j 28m',
  'Sepasang kekasih dan teman-teman mereka mengunjungi festival musim panas di Swedia yang ternyata menyimpan ritual pagan yang gelap.',
  'Florence Pugh, Jack Reynor, Vilhelm Blomgren',
  'https://image.tmdb.org/t/p/w500/7LEI8ulhhTeB2YDX0iY20VIhuK8.jpg',
  530385
),
(
  'The Martian',
  (SELECT id FROM genres WHERE name = 'Sci-Fi'),
  2015, 8.0, '2j 24m',
  'Seorang astronaut ditinggal sendirian di Mars setelah dianggap tewas dan harus bertahan hidup menggunakan kecerdasannya.',
  'Matt Damon, Jessica Chastain, Kristen Wiig',
  'https://image.tmdb.org/t/p/w500/5BHuvQ6p9kL09NMd8yFkL2Y1gRk.jpg',
  286217
),
(
  'Knives Out',
  (SELECT id FROM genres WHERE name = 'Drama'),
  2019, 7.9, '2j 10m',
  'Kematian misterius seorang penulis novel detektif memicu penyelidikan yang melibatkan seluruh anggota keluarganya yang eksentrik.',
  'Daniel Craig, Ana de Armas, Chris Evans',
  'https://image.tmdb.org/t/p/w500/pThyQovXQrw2m0s9x82twj48Jq4.jpg',
  546554
);
