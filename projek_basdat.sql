-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 09 Apr 2025 pada 19.11
-- Versi Server: 10.1.19-MariaDB
-- PHP Version: 7.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `projek_basdat`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE `barang` (
  `id_barang` int(50) NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `tipe_barang` varchar(255) NOT NULL,
  `jumlah_barang` int(255) NOT NULL,
  `id_ruang` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`id_barang`, `nama_barang`, `tipe_barang`, `jumlah_barang`, `id_ruang`) VALUES
(17, 'Kipas Angin', 'Elektronik', 38, 7),
(20, 'AC', 'Elektronik', 10, 7),
(21, 'Meja', 'Peralatan Sekolah', 3, 8),
(22, 'kursi', 'Peralatan Sekolah', 23, 9),
(25, 'Pensil', 'Peralatan Sekolah', 30, 11),
(26, 'Sapu', 'Alat Membersihkan', 2, 7);

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_transaksi`
--

CREATE TABLE `detail_transaksi` (
  `id_detail` int(11) NOT NULL,
  `id_transaksi` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `detail_transaksi`
--

INSERT INTO `detail_transaksi` (`id_detail`, `id_transaksi`, `id_barang`, `jumlah`) VALUES
(11, 2, 0, 5),
(14, 5, 0, 3),
(15, 6, 0, 2),
(17, 8, 13, 3),
(19, 10, 1, 7),
(21, 12, 17, 3),
(22, 13, 17, 2),
(23, 14, 21, 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `guru`
--

CREATE TABLE `guru` (
  `id_guru` int(50) NOT NULL,
  `nama_guru` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `ruang`
--

CREATE TABLE `ruang` (
  `id_ruang` int(50) NOT NULL,
  `nama_ruang` varchar(255) NOT NULL,
  `lokasi` varchar(255) NOT NULL,
  `kapasitas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `ruang`
--

INSERT INTO `ruang` (`id_ruang`, `nama_ruang`, `lokasi`, `kapasitas`) VALUES
(7, 'Lab Komputer RPL', 'Gedung B Lantai 1', 255),
(8, 'Lab Komputer PS', 'Gedung A Lantai 2', 29),
(9, 'Lab Komputer AK', 'Gedung D Lantai 3', 40),
(11, 'Lab Komputer AP', 'Gedung D Lantai 3', 20);

-- --------------------------------------------------------

--
-- Struktur dari tabel `siswa`
--

CREATE TABLE `siswa` (
  `id_siswa` int(20) NOT NULL,
  `nis` int(50) NOT NULL,
  `nama_siswa` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `siswa`
--

INSERT INTO `siswa` (`id_siswa`, `nis`, `nama_siswa`) VALUES
(22, 1234567890, 'Adrian'),
(23, 1234567891, 'Aisyah Chumairah'),
(24, 1234567892, 'Clement Hermawan'),
(25, 1234567893, 'Condrado Alain Sharon'),
(26, 1234567894, 'Faroek Al-Qayyum'),
(27, 1234567895, 'Githania Agatha'),
(28, 1234567896, 'Indrawan'),
(29, 1234567897, 'Jillyan Bintang Kausar'),
(30, 1234567898, 'Kristian'),
(31, 1234567899, 'Mirsya Emiyanti Martubi');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int(11) NOT NULL,
  `id_siswa` int(11) NOT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `tanggal_pinjam` date NOT NULL,
  `status_kembali` enum('dipinjam','dikembalikan') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_siswa`, `tanggal_kembali`, `tanggal_pinjam`, `status_kembali`) VALUES
(2, 24, '2025-03-19', '2025-03-10', 'dikembalikan'),
(5, 27, '2025-03-15', '2025-03-13', 'dikembalikan'),
(6, 22, '2025-03-19', '2025-03-13', 'dikembalikan'),
(8, 27, '2025-03-16', '2025-03-14', 'dikembalikan'),
(10, 27, '2025-03-22', '2025-03-20', 'dipinjam'),
(12, 27, '2025-03-08', '2025-03-04', 'dipinjam'),
(13, 22, '2025-03-04', '2025-03-01', 'dipinjam'),
(14, 30, '2025-03-15', '2025-03-14', 'dipinjam');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `UserID` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `NamaLengkap` varchar(255) NOT NULL,
  `role` enum('administrator','user') NOT NULL,
  `Alamat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`UserID`, `username`, `password`, `Email`, `NamaLengkap`, `role`, `Alamat`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'agathagithania@gmail.com', 'Githania Agatha', 'administrator', 'Tes'),
(2, 'user', 'ee11cbb19052e40b07aac0ca060c23ee', 'user@gmail.com', 'User', 'user', 'p');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `id_ruang` (`id_ruang`),
  ADD KEY `id_ruang_2` (`id_ruang`);

--
-- Indexes for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `id_transaksi` (`id_transaksi`),
  ADD KEY `id_barang` (`id_barang`),
  ADD KEY `id_barang_2` (`id_barang`),
  ADD KEY `id_barang_3` (`id_barang`),
  ADD KEY `id_transaksi_2` (`id_transaksi`);

--
-- Indexes for table `guru`
--
ALTER TABLE `guru`
  ADD PRIMARY KEY (`id_guru`);

--
-- Indexes for table `ruang`
--
ALTER TABLE `ruang`
  ADD PRIMARY KEY (`id_ruang`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id_siswa`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_siswa` (`id_siswa`),
  ADD KEY `id_siswa_2` (`id_siswa`),
  ADD KEY `id_siswa_3` (`id_siswa`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barang`
--
ALTER TABLE `barang`
  MODIFY `id_barang` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  MODIFY `id_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `guru`
--
ALTER TABLE `guru`
  MODIFY `id_guru` int(50) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ruang`
--
ALTER TABLE `ruang`
  MODIFY `id_ruang` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id_siswa` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD CONSTRAINT `fk_transaksi` FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi` (`id_transaksi`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `ruang`
--
ALTER TABLE `ruang`
  ADD CONSTRAINT `ruang_ibfk_1` FOREIGN KEY (`id_ruang`) REFERENCES `barang` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_siswa`) REFERENCES `siswa` (`id_siswa`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
