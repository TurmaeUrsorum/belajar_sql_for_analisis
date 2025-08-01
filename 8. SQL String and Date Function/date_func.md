Keren, sekarang kita bahas fungsi **manipulasi tanggal di MySQL** — ini **sangat penting** buat data scientist, data analyst, maupun backend dev.

---

## 📅 Fungsi Manipulasi Tanggal di MySQL (Lengkap + Contoh)

### 🔹 1. **Ambil Komponen dari Tanggal**

| Fungsi                           | Keterangan                | Contoh                          | Output |
| -------------------------------- | ------------------------- | ------------------------------- | ------ |
| `YEAR(date)`                     | Ambil tahun               | `YEAR('2025-07-31')`            | `2025` |
| `MONTH(date)`                    | Ambil bulan (angka)       | `MONTH('2025-07-31')`           | `7`    |
| `DAY(date)` / `DAYOFMONTH(date)` | Ambil tanggal (hari)      | `DAY('2025-07-31')`             | `31`   |
| `DAYOFWEEK(date)`                | Hari ke-berapa (1=Sunday) | `DAYOFWEEK('2025-07-31')`       | `5`    |
| `WEEK(date)`                     | Ambil nomor minggu        | `WEEK('2025-07-31')`            | `31`   |
| `QUARTER(date)`                  | Kuartal                   | `QUARTER('2025-07-31')`         | `3`    |
| `HOUR(datetime)`                 | Jam                       | `HOUR('2025-07-31 14:30:00')`   | `14`   |
| `MINUTE(datetime)`               | Menit                     | `MINUTE('2025-07-31 14:30:00')` | `30`   |
| `SECOND(datetime)`               | Detik                     | `SECOND('2025-07-31 14:30:45')` | `45`   |

---

### 🔹 2. **Format Tanggal**

| Fungsi                      | Keterangan               | Contoh                                | Output         |
| --------------------------- | ------------------------ | ------------------------------------- | -------------- |
| `DATE_FORMAT(date, format)` | Format tanggal ke string | `DATE_FORMAT(NOW(), '%Y-%m-%d')`      | `'2025-07-31'` |
| `TIME_FORMAT(time, format)` | Format waktu             | `TIME_FORMAT('14:30:00', '%h:%i %p')` | `'02:30 PM'`   |

> 📌 Format code: `%Y` (tahun), `%m` (bulan), `%d` (hari), `%H` (jam 24), `%h` (jam 12), `%i` (menit), `%s` (detik), `%W` (nama hari), dll.

---

### 🔹 3. **Tanggal Hari Ini / Sekarang**

| Fungsi      | Keterangan                     | Contoh      | Output                  |
| ----------- | ------------------------------ | ----------- | ----------------------- |
| `NOW()`     | Tanggal & waktu sekarang       | `NOW()`     | `'2025-07-31 20:11:00'` |
| `CURDATE()` | Tanggal sekarang (tanpa waktu) | `CURDATE()` | `'2025-07-31'`          |
| `CURTIME()` | Waktu sekarang                 | `CURTIME()` | `'20:11:00'`            |

---

### 🔹 4. **Operasi Penjumlahan dan Pengurangan**

| Fungsi                            | Keterangan                | Contoh                                     | Output         |
| --------------------------------- | ------------------------- | ------------------------------------------ | -------------- |
| `DATE_ADD(date, INTERVAL n unit)` | Tambah tanggal            | `DATE_ADD('2025-07-31', INTERVAL 7 DAY)`   | `'2025-08-07'` |
| `DATE_SUB(date, INTERVAL n unit)` | Kurangi tanggal           | `DATE_SUB('2025-07-31', INTERVAL 1 MONTH)` | `'2025-06-31'` |
| `ADDDATE()` / `SUBDATE()`         | Alias dari `DATE_ADD/SUB` | —                                          | —              |

> 📌 Unit: `DAY`, `MONTH`, `YEAR`, `HOUR`, `MINUTE`, `SECOND`, `WEEK`, `QUARTER`

---

### 🔹 5. **Perbedaan antara Dua Tanggal**

| Fungsi                              | Keterangan                  | Contoh                                             | Output |
| ----------------------------------- | --------------------------- | -------------------------------------------------- | ------ |
| `DATEDIFF(date1, date2)`            | Selisih dalam **hari**      | `DATEDIFF('2025-08-01', '2025-07-31')`             | `1`    |
| `TIMESTAMPDIFF(unit, date1, date2)` | Selisih dalam unit tertentu | `TIMESTAMPDIFF(MONTH, '2025-01-01', '2025-07-31')` | `7`    |

---

### 🔹 6. **Lain-lain**

| Fungsi                      | Keterangan                          | Contoh                                  |
| --------------------------- | ----------------------------------- | --------------------------------------- |
| `STR_TO_DATE(str, format)`  | Ubah string ke tanggal              | `STR_TO_DATE('31-07-2025', '%d-%m-%Y')` |
| `LAST_DAY(date)`            | Hari terakhir di bulan itu          | `LAST_DAY('2025-02-15') → '2025-02-28'` |
| `MAKEDATE(year, dayofyear)` | Buat tanggal dari tahun + hari ke-n | `MAKEDATE(2025, 213) → '2025-07-31'`    |
| `MAKETIME(hour, min, sec)`  | Buat waktu dari jam\:menit\:detik   | `MAKETIME(14, 30, 0)` → `'14:30:00'`    |

---

## 💡 Contoh Kasus Nyata:

### 1. Cari customer yang daftar dalam 30 hari terakhir:

```sql
SELECT *
FROM customers
WHERE signup_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);
```

### 2. Tampilkan total order per bulan di tahun 2025:

```sql
SELECT 
  MONTH(order_date) AS bulan,
  COUNT(*) AS total_order
FROM orders
WHERE YEAR(order_date) = 2025
GROUP BY bulan;
```

### 3. Format tanggal lahir jadi “31 Juli 2025”:

```sql
SELECT 
  DATE_FORMAT(birth_date, '%d %M %Y') AS formatted_dob
FROM customers;
```

---

Kalau kamu pengin latihan SQL manipulasi tanggal dari dataset fiktif atau data beneran, tinggal bilang aja — bisa aku bantu buatin 👌
