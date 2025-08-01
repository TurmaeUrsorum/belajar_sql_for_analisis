Mantap, karena kamu pakai **MySQL**, berikut ini adalah **fungsi manipulasi string yang umum di MySQL**, lengkap dengan **contoh nyata** dan **catatan khas MySQL**.

---

## 🧩 1. **Penggabungan String**

| Fungsi                              | Keterangan                   | Contoh                                              |
| ----------------------------------- | ---------------------------- | --------------------------------------------------- |
| `CONCAT(str1, str2, ...)`           | Gabungkan string             | `CONCAT('Data', ' ', 'Science') → 'Data Science'`   |
| `CONCAT_WS(delim, str1, str2, ...)` | Gabung string dengan pemisah | `CONCAT_WS('-', '2025', '07', '31') → '2025-07-31'` |

---

## 🔡 2. **Ubah Huruf Besar/Kecil**

| Fungsi                      | Keterangan             | Contoh                     |
| --------------------------- | ---------------------- | -------------------------- |
| `UPPER(str)` / `UCASE(str)` | Jadi huruf besar semua | `UPPER('chat') → 'CHAT'`   |
| `LOWER(str)` / `LCASE(str)` | Jadi huruf kecil semua | `LOWER('HELLO') → 'hello'` |

---

## ✂️ 3. **Ambil Bagian dari String**

| Fungsi                          | Keterangan                  | Contoh                             |
| ------------------------------- | --------------------------- | ---------------------------------- |
| `SUBSTRING(str, start, length)` | Ambil sebagian string       | `SUBSTRING('MySQL', 2, 3) → 'ySQ'` |
| `LEFT(str, n)`                  | Ambil n karakter dari kiri  | `LEFT('OpenAI', 4) → 'Open'`       |
| `RIGHT(str, n)`                 | Ambil n karakter dari kanan | `RIGHT('OpenAI', 2) → 'AI'`        |
| `MID(str, start, length)`       | Alias dari `SUBSTRING`      | `MID('Hello', 2, 2) → 'el'`        |

---

## 🔍 4. **Pencarian dan Posisi**

| Fungsi                | Keterangan                    | Contoh                             |
| --------------------- | ----------------------------- | ---------------------------------- |
| `LOCATE(substr, str)` | Posisi substr di str          | `LOCATE('a', 'banana') → 2`        |
| `INSTR(str, substr)`  | Sama dengan `LOCATE`          | `INSTR('banana', 'a') → 2`         |
| `LIKE`                | Cari pola dengan `%` atau `_` | `'email@gmail.com' LIKE '%gmail%'` |
| `REGEXP` / `RLIKE`    | Regex pattern matching        | `'abc123' REGEXP '[0-9]' → TRUE`   |

---

## 🔁 5. **Mengganti Isi String**

| Fungsi                   | Keterangan              | Contoh                                               |
| ------------------------ | ----------------------- | ---------------------------------------------------- |
| `REPLACE(str, from, to)` | Ganti teks dalam string | `REPLACE('data-science', '-', ' ') → 'data science'` |

---

## 🔢 6. **Panjang String**

| Fungsi                                       | Keterangan                                 | Contoh                  |
| -------------------------------------------- | ------------------------------------------ | ----------------------- |
| `LENGTH(str)`                                | Panjang dalam byte (UTF-8 bisa > karakter) | `LENGTH('😊') → 4`      |
| `CHAR_LENGTH(str)` / `CHARACTER_LENGTH(str)` | Panjang dalam karakter                     | `CHAR_LENGTH('😊') → 1` |

---

## 🧹 7. **Trim Spasi**

| Fungsi       | Keterangan                 | Contoh                        |
| ------------ | -------------------------- | ----------------------------- |
| `TRIM(str)`  | Hilangkan spasi kiri-kanan | `TRIM('  hello  ') → 'hello'` |
| `LTRIM(str)` | Hilangkan spasi kiri       | `LTRIM('  hello') → 'hello'`  |
| `RTRIM(str)` | Hilangkan spasi kanan      | `RTRIM('hello  ') → 'hello'`  |

---

## 🧪 8. **Lain-lain**

| Fungsi                           | Keterangan                  | Contoh                             |
| -------------------------------- | --------------------------- | ---------------------------------- |
| `REVERSE(str)`                   | Balik string                | `REVERSE('abc') → 'cba'`           |
| `ELT(N, str1, str2, ...)`        | Ambil elemen ke-N           | `ELT(2, 'A', 'B', 'C') → 'B'`      |
| `FIELD(str, val1, val2, ...)`    | Posisi str di list          | `FIELD('B', 'A', 'B', 'C') → 2`    |
| `FORMAT(number, decimal_places)` | Format angka sebagai string | `FORMAT(1234.567, 2) → '1,234.57'` |

---

## 💡 Contoh Praktis Query di MySQL:

### 🎯 1. Ambil username dari email:

```sql
SELECT 
  email,
  SUBSTRING(email, 1, LOCATE('@', email) - 1) AS username
FROM users;
```

### 🎯 2. Ganti “-” jadi spasi di nama produk:

```sql
SELECT 
  REPLACE(product_name, '-', ' ') AS cleaned_name
FROM products;
```

### 🎯 3. Ambil nama produk dengan awalan “ABC” (case-insensitive):

```sql
SELECT * FROM products
WHERE UPPER(LEFT(product_code, 3)) = 'ABC';
```

---

Kalau kamu pakai **versi MySQL tertentu** atau **mau query dari kasus nyata**, tinggal kirim datanya — aku bantu buatkan spesifik 👌
