
# Laporan Fitur Aplikasi Inventaris Barang

### 1. Deskripsi Fitur

Aplikasi ini bertujuan untuk membantu sekolah dalam mengelola inventaris barang dengan fitur utama sebagai berikut:

#### a. Manajemen Data Barang

Fitur ini memungkinkan pencatatan barang yang dimiliki sekolah, termasuk informasi tentang nama, jumlah, serta mengubah dan menghapus data barang.

#### b. Peminjaman dan Pengelolaan Barang

Fitur ini digunakan untuk mencatat peminjaman barang oleh siswa atau guru, memastikan bahwa barang dapat dilacak, dan mengetahui siapa yang terakhir menggunakan barang tersebut.

#### c. Pendataan Ruang Penyimpanan Barang

Fitur ini membantu dalam mencatat lokasi penyimpanan barang di sekolah agar lebih terorganisir dan mudah ditemukan.

---

### 2. Database

#### a. Struktur Database

Database aplikasi terdiri dari beberapa tabel utama yang digunakan untuk menyimpan informasi barang, transaksi, dan lokasi penyimpanan barang.

##### **Diagram Relasi Antar Tabel**

![[relasi.png]]

#### b. Penjelasan Tabel

1. **barang** (Menyimpan informasi barang yang dimiliki sekolah).
2. **siswa** (Menyimpan data siswa yang dapat meminjam barang).
3. **guru** (Menyimpan data guru yang bertanggung jawab atas barang).
4. **transaksi** (Mencatat peminjaman barang oleh siswa/guru).
5. **detail_transaksi** (Menyimpan detail barang yang dipinjam dalam satu transaksi).
6. **ruang** (Menyimpan informasi tentang lokasi penyimpanan barang di sekolah).

---

### 3. Rincian Fitur

#### **Fitur: Manejemen Data Barang**

##### a. Screenshot Fitur

![[fitur.png]]

##### b. Kode Program

##### **Front-End (HTML)**

```html
 <div class="container">
   <h2>Manajemen Data Barang</h2>

    <form id="barangForm">
      <input type="text" id="namaBarang" placeholder="Nama Barang" required>
      <input type="text" id="tipeBarang" placeholder="Tipe Barang" required>
      <input type="number" id="jumlahBarang" placeholder="Jumlah Barang" required>
      <button type="submit">Tambah Barang</button>
    </form>

        <table>
            <thead>
                <tr>
                    <th>Nama Barang</th>
                    <th>Tipe Barang</th>
                    <th>Jumlah</th>
                    <th>Aksi</th>
                </tr>
            </thead>
            <tbody id="barangList">
                <!-- Data akan ditampilkan di sini -->
            </tbody>
        </table>
    </div>
```

##### **Back-End (PHP - Proses Manajemen Data)**
1. tambah_barang.php
```php
<?php
include 'koneksi.php';
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nama_barang = $_POST['nama_barang'];
    $jumlah_barang = $_POST['jumlah_barang'];

    $sql = "INSERT INTO barang (nama_barang, jumlah_barang) VALUES ('$nama_barang', '$jumlah_barang')";

    if ($koneksi->query($sql) === TRUE) {
        echo "Barang berhasil ditambahkan!";
        header("Location: tampil_barang.php");
    } else {
        echo "Error: " . $sql . "<br>" . $koneksi->error;
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Barang</title>
</head>
<body>
    <h2>Tambah Barang</h2>
    <form method="POST">
        <label>Nama Barang:</label>
        <input type="text" name="nama_barang" required><br>
        <label>Jumlah:</label>
        <input type="number" name="jumlah_barang" required><br>
        <label>Lokasi Penyimpanan:</label>
       
        <input type="submit" value="Simpan">
    </form>
</body>
</html>
```

2. tampil_barang.php
```php
<?php
include 'koneksi.php';

$sql = "SELECT barang.id_barang, barang.nama_barang, barang.jumlah_barang
        FROM barang
$result = $koneksi->query($sql);
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data Barang</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>Daftar Barang</h2>
    <table border="1">
        <tr>
            <th>ID Barang</th>
            <th>Nama Barang</th>
            <th>Jumlah</th>
            <th>Lokasi</th>
            <th>Aksi</th>
        </tr>
        <?php while ($row = $result->fetch_assoc()) { ?>
        <tr>
            <td><?php echo $row['id_barang']; ?></td>
            <td><?php echo $row['nama_barang']; ?></td>
            <td><?php echo $row['jumlah_barang']; ?></td>
            <td>
                <a href="edit_barang.php?id=<?php echo $row['id_barang']; ?>">Edit</a> |
                <a href="hapus_barang.php?id=<?php echo $row['id_barang']; ?>" onclick="return confirm('Hapus barang ini?')">Hapus</a>
            </td>
        </tr>
        <?php } ?>
    </table>
</body>
</html>
```

3. edit_barang.php
```php
<?php
include 'koneksi.php';

if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    die("ID barang tidak valid.");
}

$id = intval($_GET['id']); // Pastikan ID adalah angka untuk mencegah SQL Injection

// Gunakan prepared statement untuk mengambil data barang
$stmt = $koneksi->prepare("SELECT * FROM barang WHERE id_barang = ?");
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();
$row = $result->fetch_assoc();

if (!$row) {
    die("Data barang tidak ditemukan.");
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nama_barang = trim($_POST['nama_barang']);
    $jumlah_barang = intval($_POST['jumlah_barang']);

    if (empty($nama_barang) || $jumlah_barang <= 0) {
        echo "Harap isi semua data dengan benar.";
    } else {
        // Gunakan prepared statement untuk update
        $stmt = $koneksi->prepare("UPDATE barang SET nama_barang=?, jumlah_barang=? WHERE id_barang=?");
        $stmt->bind_param("siii", $nama_barang, $jumlah_barang, $id);

        if ($stmt->execute()) {
            echo "<script>alert('Data berhasil diperbarui!'); window.location.href='tampil_barang.php';</script>";
        } else {
            echo "Error updating record: " . $stmt->error;
        }
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <title>Edit Barang</title>
</head>
<body>
    <h2>Edit Barang</h2>
    <form method="POST">
        <label>Nama Barang:</label>
        <input type="text" name="nama_barang" value="<?php echo htmlspecialchars($row['nama_barang']); ?>" required><br>

        <label>Jumlah:</label>
        <input type="number" name="jumlah_barang" value="<?php echo $row['jumlah_barang']; ?>" required><br>

        <input type="submit" value="Update">
    </form>
</body>
</html>
```

4. hapus_barang.php
```php
<?php
include 'koneksi.php';

$id = $_GET['id'];
$sql = "DELETE FROM barang WHERE id_barang = $id";

if ($koneksi->query($sql) === TRUE) {
    header("Location: tampil_barang.php");
} else {
    echo "Error deleting record: " . $koneksi->error;
}
?>
```
##### c. Analisis Kode

Kode ini merupakan implementasi dari sistem **manajemen data barang**, yang memungkinkan pengguna untuk menambah, melihat, mengedit, dan menghapus data barang. Berikut penjelasan dari masing-masing bagian:

1. **Tambah Barang (tambah_barang.php)**
    - Menggunakan form untuk input data barang (nama, tipe,  jumlah barang).
    - Data dikirim dengan metode **POST** dan disimpan ke dalam database melalui query **INSERT**
    - Setelah data berhasil ditambahkan, halaman diarahkan ke **tampil_barang.php**.
2. **Tampilkan Data Barang (tampil_barang.php)**
    - Mengambil data dari tabel **barang** dan menampilkan dalam bentuk tabel.
    - Setiap barang memiliki opsi **edit** dan **hapus**.
3. **Edit Barang (edit_barang.php)**
    - Mengambil data barang berdasarkan **ID** yang dikirim melalui URL.
    - Menggunakan **Prepared Statement** untuk mencegah **SQL Injection**.
    - Setelah perubahan disimpan, pengguna diarahkan kembali ke daftar barang.
4. **Hapus Barang (hapus_barang.php)**
    - Menghapus data barang berdasarkan **ID** yang dikirim melalui URL.
    - Setelah berhasil dihapus, pengguna diarahkan kembali ke daftar barang.


##### d. Peran Fitur dalam Database

Fitur ini berperan dalam **mengelola data barang di database**, dengan operasi CRUD (**Create, Read, Update, Delete**) pada tabel **barang**. Berikut fungsinya:

- **Menambah Data** → Barang baru bisa didaftarkan ke dalam sistem.
- **Menampilkan Data** → Data barang dapat ditampilkan dalam tabel yang rapi.
- **Mengedit Data** → Jika ada perubahan, pengguna bisa memperbarui nama, tipe, dan jumlah barang.
- **Menghapus Data** → Jika barang sudah tidak diperlukan, datanya bisa dihapus untuk menjaga keakuratan inventaris.

Fitur ini memastikan bahwa data barang selalu **terorganisir dan up-to-date**, sehingga memudahkan dalam **pemantauan stok dan lokasi penyimpanan**.

---


#### **Fitur: Peminjaman dan Pengelolaan Barang**

##### a. Screenshot Fitur
![[fitur3.png]]

##### b. Kode Program

##### **Front-End (HTML & PHP)**

```html
<h2>Form Peminjaman Barang</h2>
    <form method="POST">
        <label>Nama Siswa:</label>
        <select name="id_siswa" required>
            <option value="">-- Pilih Siswa --</option>
            <?php
            $result = $koneksi->query("SELECT * FROM siswa");
            while ($row = $result->fetch_assoc()) {
                echo "<option value='{$row['id_siswa']}'>{$row['nama_siswa']}</option>";
            }
            ?>
        </select><br>

        <label>Tanggal Pinjam:</label>
        <input type="date" name="tanggal_pinjam" required><br>
        <label>Tanggal Kembali:</label>
        <input type="date" name="tanggal_kembali" required><br>

        <h3>Pilih Barang</h3>
        <label>Barang:</label>
        <select id="barangSelect" name="barang_id" onchange="tampilkanInputJumlah()" required>
            <option value="">-- Pilih Barang --</option>
            <?php
            $result = $koneksi->query("SELECT * FROM barang WHERE jumlah_barang > 0");
            $barang_tersedia = false;
            while ($row = $result->fetch_assoc()) {
                $barang_tersedia = true;
                echo "<option value='{$row['id_barang']}'>{$row['nama_barang']} (Stok: {$row['jumlah_barang']})</option>";
            }

            if (!$barang_tersedia) {
                echo "<option value='' disabled>Tidak ada barang tersedia</option>";
            }
            ?>
        </select><br>

        <div id="jumlahBarang" style="display: none;">
            <label>Jumlah:</label>
            <input type="number" name="jumlah" min="1" max="100" value="1"><br>
        </div>

        <input type="submit" value="Pinjam" <?php echo !$barang_tersedia ? 'disabled' : ''; ?>>
    </form>
```

##### **Back-End (PHP - Proses Peminjaman)**
```php
<?php
// Include file koneksi
include 'koneksi3.php';

// Proses saat form disubmit
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_siswa = $_POST['id_siswa'];
    $tanggal_pinjam = $_POST['tanggal_pinjam'];
    $tanggal_kembali = $_POST['tanggal_kembali'];
    $barang_id = $_POST['barang_id'];
    $jumlah = $_POST['jumlah'];

    // Validasi data
    if (empty($id_siswa) || empty($tanggal_pinjam) || empty($tanggal_kembali) || empty($barang_id) || empty($jumlah)) {
        echo "Semua field harus diisi!";
        exit;
    }

    // Cek stok barang
    $cek_barang = $koneksi->query("SELECT jumlah_barang FROM barang WHERE id_barang = '$barang_id'");
    $data_barang = $cek_barang->fetch_assoc();

    if ($data_barang['jumlah_barang'] < $jumlah) {
        echo "Stok barang tidak mencukupi!";
        exit;
    }

    // Simpan data peminjaman
    $insert = $koneksi->query("INSERT INTO peminjaman (id_siswa, id_barang, tanggal_pinjam, tanggal_kembali, jumlah)
                               VALUES ('$id_siswa', '$barang_id', '$tanggal_pinjam', '$tanggal_kembali', '$jumlah')");

    if ($insert) {
        // Kurangi stok barang
        $koneksi->query("UPDATE barang SET jumlah_barang = jumlah_barang - $jumlah WHERE id_barang = '$barang_id'");

        // Redirect ke halaman utama
        header("Location: index.php");
        exit;
    } else {
        echo "Gagal meminjam barang: " . $koneksi->error;
    }
}
?>

```

##### c. Analisis Kode

- Pengguna mengisi form untuk memilih:
    - Siswa (yang meminjam)
    - Tanggal pinjam & kembali
    - Barang dan jumlah yang dipinjam

- Saat form disubmit:
    1. Data siswa dan tanggal disimpan ke **tabel `transaksi`** sebagai satu peminjaman.
    2. ID transaksi yang baru dibuat digunakan untuk menyimpan data barang ke **`detail_transaksi`**.
    3. Jumlah stok di **tabel `barang`** dikurangi sesuai jumlah yang dipinjam.

- Validasi dilakukan agar semua input lengkap dan stok barang cukup.
##### d. Peran Fitur dalam Database

- `transaksi.id_siswa → siswa.nis`  
    Mencatat siapa siswa yang meminjam barang berdasarkan NIS.
- `detail_transaksi.id_transaksi → transaksi.id_transaksi`  
    Menghubungkan setiap detail barang dengan transaksi utama (sebagai satu peminjaman).
- `detail_transaksi.id_barang → barang.id_barang`  
    Menunjukkan barang apa yang dipinjam dan berapa jumlahnya dalam transaksi tersebut.

---
 
#### **Fitur: Pendataan Ruang Penyimpanan Barang**
##### a. Screenshot Fitur
![[fitur4.png]]

##### b. Kode Program

##### **Front-End (PHP)**

```PHP
<?php
include 'koneksi3.php';

// Ambil data ruang
$ruang = $koneksi->query("SELECT * FROM ruang");

// Cek mode edit
$edit_mode = false;
$data_edit = null;
if (isset($_GET['edit'])) {
    $edit_mode = true;
    $id_edit = $_GET['edit'];
    $data_edit = $koneksi->query("SELECT * FROM ruang WHERE id_ruang = '$id_edit'")->fetch_assoc();
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Manajemen Ruang</title>
    <style>
        input { width: 100%; padding: 8px; margin: 6px 0; }
        table, th, td { border: 1px solid #000; border-collapse: collapse; }
        th, td { padding: 8px; text-align: center; }
        table { width: 100%; margin-top: 20px; }
        .btn { padding: 8px 16px; cursor: pointer; }
        .btn-green { background-color: green; color: white; border: none; }
    </style>
</head>
<body>
    <h2><?php echo $edit_mode ? "Edit Ruang" : "Tambah Ruang Baru"; ?></h2>

    <form method="POST" action="ruang_proses.php">
        <?php if ($edit_mode): ?>
            <input type="hidden" name="id_ruang" value="<?php echo $data_edit['id_ruang']; ?>">
        <?php endif; ?>

        <label>Nama Ruang:</label>
        <input type="text" name="nama_ruang" required value="<?php echo $edit_mode ? $data_edit['nama_ruang'] : ''; ?>">

        <label>Lokasi:</label>
        <input type="text" name="lokasi" required value="<?php echo $edit_mode ? $data_edit['lokasi'] : ''; ?>">

        <label>Kapasitas:</label>
        <input type="number" name="kapasitas" required value="<?php echo $edit_mode ? $data_edit['kapasitas'] : ''; ?>">

        <button type="submit" class="btn btn-green" name="<?php echo $edit_mode ? 'edit_ruang' : 'tambah_ruang'; ?>">
            <?php echo $edit_mode ? 'Simpan Perubahan' : 'Tambah Ruang'; ?>
        </button>
    </form>

    <hr>
    <h2>Daftar Ruang</h2>
    <table>
        <thead style="background-color: #007bff; color: white;">
            <tr>
                <th>ID Ruang</th>
                <th>Nama Ruang</th>
                <th>Lokasi</th>
                <th>Kapasitas</th>
                <th>Aksi</th>
            </tr>
        </thead>
        <tbody>
            <?php while($row = $ruang->fetch_assoc()): ?>
                <tr>
                    <td><?php echo $row['id_ruang']; ?></td>
                    <td><?php echo $row['nama_ruang']; ?></td>
                    <td><?php echo $row['lokasi']; ?></td>
                    <td><?php echo $row['kapasitas']; ?></td>
                    <td>
                        <a href="ruang.php?edit=<?php echo $row['id_ruang']; ?>">Edit</a> |
                        <a href="ruang_proses.php?hapus=<?php echo $row['id_ruang']; ?>" onclick="return confirm('Yakin ingin hapus?')">Hapus</a>
                    </td>
                </tr>
            <?php endwhile; ?>
        </tbody>
    </table>
</body>
</html>

```

##### **Back-End (PHP - Proses Peminjaman)**

```php
<?php
include 'koneksi3.php';

// Tambah ruang
if (isset($_POST['tambah_ruang'])) {
    $nama = $_POST['nama_ruang'];
    $lokasi = $_POST['lokasi'];
    $kapasitas = $_POST['kapasitas'];

    $koneksi->query("INSERT INTO ruang (nama_ruang, lokasi, kapasitas) 
                     VALUES ('$nama', '$lokasi', '$kapasitas')");
    header("Location: ruang.php");
    exit;
}

// Edit ruang
if (isset($_POST['edit_ruang'])) {
    $id = $_POST['id_ruang'];
    $nama = $_POST['nama_ruang'];
    $lokasi = $_POST['lokasi'];
    $kapasitas = $_POST['kapasitas'];

    $koneksi->query("UPDATE ruang SET nama_ruang='$nama', lokasi='$lokasi', kapasitas='$kapasitas' 
                     WHERE id_ruang = '$id'");
    header("Location: ruang.php");
    exit;
}

// Hapus ruang
if (isset($_GET['hapus'])) {
    $id = $_GET['hapus'];
    $koneksi->query("DELETE FROM ruang WHERE id_ruang = '$id'");
    header("Location: ruang.php");
    exit;
}
?>

```

##### c. Analisis Kode

1. **Menampilkan Form Tambah/Edit Ruang**
    - Jika ada `?edit=id`, maka form akan otomatis terisi data lama untuk diedit.
    - Jika tidak, form digunakan untuk menambah data baru.
2. **Menampilkan Daftar Ruang**
    - Mengambil semua data dari tabel `ruang` dan menampilkannya dalam bentuk tabel.
3. **Aksi Tambah**
    - Ketika tombol "Tambah Ruang" ditekan, data disimpan ke tabel `ruang`.
4. **Aksi Edit**    
    - Ketika tombol "Simpan Perubahan" ditekan, data ruang akan diperbarui di tabel.
5. **Aksi Hapus**
    - Jika pengguna klik "Hapus", data ruang berdasarkan `id_ruang` akan dihapus.

##### d. Peran Fitur dalam Database

- `ruang.id_ruang → (digunakan di daftar & pengelolaan ruang)`  
    (Sebagai identitas unik setiap ruang yang dapat ditambahkan, diedit, atau dihapus.)
- `ruang.nama_ruang → (ditampilkan di form & tabel)`  
    (Menunjukkan nama dari ruang, seperti Lab Komputer atau Aula.)
- `ruang.lokasi → (ditampilkan di form & tabel)`  
    (Menjelaskan lokasi fisik dari ruang, misalnya Gedung A Lantai 2.)
- `ruang.kapasitas → (ditampilkan di form & tabel)`  
    (Menentukan kapasitas maksimum orang dalam satu ruang.)

---


### 4. Relasi

#### **1. Manajemen Data Barang**

**Relasi:**
- **Tidak ada relasi dengan tabel lain.**
- Data berdiri sendiri di dalam tabel `barang`.

**Analisis Query:**
```sql
SELECT nama_barang, tipe_barang, jumlah FROM barang;
```

_Menampilkan nama barang, tipe barang, dan jumlah barang yang tersedia._

---

#### **2. Fitur Peminjaman Barang**

**Relasi:**
- **transaksi.id_siswa → siswa.id_siswa** → 1 siswa dapat memiliki banyak transaksi.
- **detail_transaksi.id_transaksi → transaksi.id_transaksi** → 1 transaksi mencakup banyak barang.
- **detail_transaksi.id_barang → barang.id_barang** → 1 barang bisa dipinjam beberapa kali.

**Analisis Query Relasi :**

```sql
SELECT siswa.nama, barang.nama_barang, transaksi.tanggal_pinjam  FROM transaksi  JOIN siswa ON transaksi.id_siswa = siswa.id_siswa  JOIN detail_transaksi ON transaksi.id_transaksi = detail_transaksi.id_transaksi  JOIN barang ON detail_transaksi.id_barang = barang.id_barang;
```

_Menampilkan nama siswa, barang yang dipinjam, dan tanggal peminjaman._

---

#### **3. Pendataan Ruang Penyimpanan**

**Relasi:**
- **ruang.id_ruang → barang.id_ruang** → 1 ruang bisa memiliki banyak barang.

**Analisis Query Relasi:**
```SQL
SELECT ruang.nama_ruang, ruang.keterangan, COUNT(barang.id_barang) AS jumlah_barang FROM ruang LEFT JOIN barang ON ruang.id_ruang = barang.id_ruang GROUP BY ruang.id_ruang;
```

_Menampilkan nama ruang, keterangannya, dan jumlah barang yang disimpan._

---


