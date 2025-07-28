-- Active: 1728529519693@@127.0.0.1@3306@perpustakaan

show tables;

create table buku (
    id_buku int not null PRIMARY KEY,
    judul_buku VARCHAR(100) not null,
    nama_penulis VARCHAR(100) not null,
    jumlah INT(5) not null
)

DESCRIBE buku;

alter Table buku ADD lokasi VARCHAR(50) after id_buku;

CREATE Table peminjam_buku (
    no_peminjam int not null PRIMARY KEY,
    nama_peminjam VARCHAR(100) not null,
    id_buku int not null,
    jumlah_buku INT(5) not null,
    tgl_pinjam DATETIME,
    tgl_ekspetasi_kembali DATETIME,
    tgl_actual_kembali DATETIME,

    Foreign Key (id_buku) REFERENCES buku(id_buku)
)

DESCRIBE peminjam_buku

INSERT INTO
    perpustakaan.buku (
        id_buku,
        lokasi,
        judul_buku,
        nama_penulis,
        jumlah
    )
VALUES
    (
        1234133,
        '2U91',
        'Membuat Strategi Bisnis',
        'Dewey Deckers',
        2
    ),
    (
        1390022,
        '1A12',
        'Anatomi Tubuh for Kids',
        'Syafina',
        3
    ),
    (
        1773364,
        '1A29',
        'Sentiment Analysis for Dummies 2nd Edition',
        'Regina Alwi, Humaira',
        2
    );

SELECT * FROM buku

INSERT INTO
    perpustakaan.peminjam_buku (
        no_peminjam,
        nama_peminjam,
        id_buku,
        jumlah_buku,
        tgl_pinjam,
        tgl_ekspetasi_kembali,
        tgl_actual_kembali
    )
VALUES
    (
        0000000001,
        'Adi',
        1234133,
        1,
        '2022-10-10',
        '2022-10-17',
        NULL
    ),
    (
        0000000002,
        'Firman',
        1234133,
        1,
        '2022-10-12',
        '2022-10-19',
        NULL
    ),
    (
        0000000003,
        'Tina',
        1773364,
        1,
        '2022-10-09',
        '2022-10-16',
        '2022-10-12'
    );


SELECT * FROM peminjam_buku

-- mantap