# Konsultasi 1
## 1. Tentukan 3 fitur dengan berdiskusi dengan teman masing-masing
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

## 2. Dari 3 fitur tersebut, buatlah skema rencana relasi antar tabel

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


## 3. Buat 1 fitur terlebih dahulu (minimal front-end)
![[fitur2.png]]


# Konsultasi 2
## Laporan Fitur Aplikasi Inventaris Barang

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

##### c. Analisis Kode

- Formulir peminjaman memungkinkan pemilihan siswa dan barang.
- Data yang dikirim akan disimpan dalam tabel `transaksi` dan `detail_transaksi`.
- `id_transaksi` dihasilkan dari tabel `transaksi` dan digunakan di `detail_transaksi`.

##### d. Peran Fitur dalam Database

- `transaksi.id_siswa → siswa.nis` (Mencatat peminjaman siswa).
- `detail_transaksi.id_transaksi → transaksi.id_transaksi` (Setiap transaksi memiliki detail barang yang dipinjam).
- `detail_transaksi.id_barang → barang.id_barang` (Barang yang dipinjam terhubung dengan detail transaksi).

---

#### **Fitur: Pendataan Ruang Penyimpanan Barang**
##### a. Screenshot Fitur
![[fitur4.png]]

##### b. Kode Program

##### **Front-End (HTML & JavaScript)**

```html
<form id="formPeminjaman">
    <label for="siswa">Siswa:</label>
    <select id="siswa"></select>
    
    <label for="barang">Barang:</label>
    <select id="barang"></select>
    
    <button type="submit">Pinjam</button>
</form>
```

##### **Back-End (PHP - Proses Peminjaman)**

```php
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id_siswa = $_POST['id_siswa'];
    $id_barang = $_POST['id_barang'];
    
    $query = "INSERT INTO transaksi (id_siswa, tanggal_pinjam) VALUES ('$id_siswa', NOW())";
    mysqli_query($conn, $query);
    
    $id_transaksi = mysqli_insert_id($conn);
    $query_detail = "INSERT INTO detail_transaksi (id_transaksi, id_barang) VALUES ('$id_transaksi', '$id_barang')";
    mysqli_query($conn, $query_detail);
}
```

##### c. Analisis Kode

- Formulir peminjaman memungkinkan pemilihan siswa dan barang.
- Data yang dikirim akan disimpan dalam tabel `transaksi` dan `detail_transaksi`.
- `id_transaksi` dihasilkan dari tabel `transaksi` dan digunakan di `detail_transaksi`.

##### d. Peran Fitur dalam Database

- `transaksi.id_siswa → siswa.nis` (Mencatat peminjaman siswa).
- `detail_transaksi.id_transaksi → transaksi.id_transaksi` (Setiap transaksi memiliki detail barang yang dipinjam).
- `detail_transaksi.id_barang → barang.id_barang` (Barang yang dipinjam terhubung dengan detail transaksi).

---


### 4. Relasi

Relasi dalam fitur peminjaman dan pengelolaan barang:

- **transaksi.id_siswa → siswa.nis** → 1 siswa dapat memiliki banyak transaksi.
- **detail_transaksi.id_transaksi → transaksi.id_transaksi** → 1 transaksi mencakup banyak barang.
- **detail_transaksi.id_barang → barang.id_barang** → 1 barang bisa dipinjam beberapa kali.

**Analisis Query Relasi:**

```sql
SELECT siswa.nama, barang.nama_barang, transaksi.tanggal_pinjam
FROM transaksi
JOIN siswa ON transaksi.id_siswa = siswa.nis
JOIN detail_transaksi ON transaksi.id_transaksi = detail_transaksi.id_transaksi
JOIN barang ON detail_transaksi.id_barang = barang.id_barang;
```

_Menampilkan nama siswa, barang yang dipinjam, dan tanggal peminjaman._

---


