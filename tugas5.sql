//input pelanggan
DELIMITER $$
CREATE PROCEDURE inputPelanggan(
	kode varchar(10),
	nama VARCHAR(45),
	jk char(1), 
	tmp_lahir varchar(30), 
	tgl_lahir date, 
	email varchar(45),
	kartu_id int(11)
)
BEGIN
	INSERT INTO pelanggan   
	VALUES (kode, nama, jk, tmp_lahir, tgl_lahir,email,kartu_id);
END$$
DELIMITER ;
CALL inputPelanggan('11','C011', 'Bhatito','L','Surabaya','1990-11-20','bhatito@gmail.com','1');

//input produk
DELIMITER $$
CREATE PROCEDURE inputProduk(
	kode VARCHAR(10),
	nama VARCHAR(45),
	harga_beli double, 
	harga_jual double,
	stok int(11), 
	min_stok int(11), 
	jenis_produk_id int(11)
)
BEGIN
	INSERT INTO produk VALUES (kode, nama, harga_beli, harga_jual, stok,min_stok,jenis_produk_id);
END$$
DELIMITER ;
CALL inputProduk('TV03','Televisi 60 inch', '5500000','7440000','4','2','1');

//melihat pelanggan
DELIMITER $$ 
CREATE PROCEDURE showPelanggan()
BEGIN    
	SELECT * FROM pelanggan;
END
$$

DELIMITER ;

CALL showPelanggan();
//melihat produk
DELIMITER $$ 
CREATE PROCEDURE showProduk()
BEGIN    
	SELECT * FROM produk;
END
$$

DELIMITER ;

CALL showProduk();


//totalpesanan
DELIMITER $$ 
CREATE PROCEDURE totalPesanan()
 BEGIN 
SELECT pelanggan.kode AS kode_pelanggan, pelanggan.nama, SUM(pesanan_items.qty) AS semua_produk, SUM(pesanan_items.qty * pesanan_items.harga) AS harga 
FROM pesanan_items 
JOIN pesanan ON pesanan_items.pesanan_id = pesanan.id 
JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id
GROUP BY pelanggan.kode, pelanggan.nama;
END
$$
DELIMITER ;

//produk seluruh pelanggan
DELIMITER $$
CREATE PROCEDURE PesananSemuaPelanggan()
BEGIN
  SELECT pesanan.id, pesanan.tanggal, pesanan.total, pelanggan.nama
  FROM pesanan
  JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id;
END $$
DELIMITER ;
//view baru: pesanan_produk_vw
create view pesanan_produk_vw as
SELECT pesanan.id AS pesanan_id, pesanan.tanggal, pelanggan.kode AS kode_pelanggan, pelanggan.nama, produk.kode AS Kode_Produk, produk.nama AS produk, pesanan_items.qty AS jumlah_produk, produk.harga_jual as harga_jual_perproduk
    FROM pesanan
    JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id
    JOIN pesanan_items ON pesanan.id = pesanan_items.pesanan_id
    JOIN produk ON pesanan_items.produk_id = produk.id
    GROUP BY pesanan.id, produk.id, pesanan_items.id, pelanggan.id;




