# 1. Tentukan 3 fitur dengan berdiskusi dengan teman masing-masing
### 1. Manajemen Data Barang
*Tabel terkait* : barang

- Menyimpan informasi barang seperti id_barang, jumlah_barang, nama_barang, tipe_barang serta mengubah dan menghapus data barang.

### 2. Peminjaman dan Pengelolaan Barang
*Tabel terkait* : barang, siswa, guru

- Mencatat peminjaman barang oleh siswa atau guru dengan hubungan ke tabel siswa dan
guru.
- Memastikan barang dapat dilacak dan diketahui siapa yang terakhir menggunakan barang
tersebut.

### 3. Pendataan Ruang Penyimpanan Barang
*Tabel terkait* : ruang

- Menyimpan informasi tentang lokasi barang di sekolah, termasuk id_ruang, nama_ruang,
kapasitas_ruang.
- Membantu dalam mengatur dan mengelola tempat penyimpanan barang agar lebih
terorganisir.

# 2. Dari 3 fitur tersebut, buatlah skema rencana relasi antar tabel

### 1. Manajemen Data Barang 
- *Tabel utama* : barang (Menyimpan informasi barang di sekolah).
- *Relasi :*
    - barang.id_guru → guru_pembimbing.id_guru (*1 guru bisa bertanggung jawab atas banyak barang*).
    - barang.id_siswa → siswa.nis (*1 siswa bisa bertanggung jawab atas beberapa barang*).

### 2. Peminjaman dan Pengelolaan Barang
- *Tabel utama* : barang (Menyimpan informasi barang).
- *Tabel pendukung* : siswa, guru, transaksi, detail_transaksi
- *Relasi* :
    - transaksi.id_siswa → siswa.nis (*1 siswa bisa melakukan banyak transaksi peminjaman*).
    - detail_transaksi.id_transaksi → transaksi.id_transaksi (*1 transaksi bisa memiliki banyak barang yang dipinjam*).
    - detail_transaksi.id_barang → barang.id_barang (*1 barang bisa dipinjam dalam beberapa transaksi berbeda*).

### 3. Pendataan Ruang Penyimpanan Barang 
- *Tabel utama* : barang, ruang
- *Relasi* :
    - barang.id_ruang → ruang.id_ruang (*1 ruang bisa menyimpan banyak barang*).

### Skema Relasi Antar Tabel dalam Bentuk Diagram
![[relasi.png]]

Penjelasan Gambar Relasi :
Diagram ini menunjukkan skema relasi antar tabel dalam sistem inventaris yang digunakan untuk mencatat peminjaman barang. Berikut adalah penjelasan hubungan antara tabel-tabel tersebut:
**1. Relasi antara `siswa` dan `transaksi`**  
Tabel `siswa` memiliki hubungan **satu ke banyak** (one-to-many) dengan tabel `transaksi`. Setiap siswa (`id_siswa`) dapat melakukan beberapa transaksi peminjaman barang, tetapi satu transaksi hanya bisa dilakukan oleh satu siswa.

**2. Relasi antara `transaksi` dan `detail_transaksi`**  
Tabel `transaksi` berelasi dengan **detail_transaksi** dalam hubungan **satu ke banyak**. Setiap transaksi (`id_transaksi`) dapat mencakup lebih dari satu barang yang dipinjam, sehingga detail peminjaman dicatat dalam `detail_transaksi`.

**3. Relasi antara `detail_transaksi` dan `barang`**  
Tabel `detail_transaksi` memiliki hubungan **banyak ke satu** (many-to-one) dengan tabel `barang`. Setiap entri dalam `detail_transaksi` mencatat barang yang dipinjam dengan mengacu pada `id_barang`, tetapi satu barang dapat muncul dalam banyak transaksi peminjaman.

#### **Kesimpulan**
Relasi ini membentuk sistem inventaris yang memungkinkan pencatatan peminjaman barang dengan baik. Siswa dapat meminjam barang, transaksi dicatat dalam `transaksi`, dan detail barang yang dipinjam dicatat dalam `detail_transaksi`. Barang juga dikaitkan dengan ruangan untuk melacak lokasi penyimpanannya. Dengan skema ini, sistem inventaris dapat mengelola data barang, mencatat peminjaman, dan melacak lokasi barang dengan lebih terstruktur.


# 3. Buat 1 fitur terlebih dahulu (minimal front-end)
![[fitur2.png]]

