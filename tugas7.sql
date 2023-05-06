//pelanggan memesan didalam table pesanan
CREATE TABLE pesanan (
  id_pesanan INT PRIMARY KEY,
  nama_pelanggan VARCHAR(50),
  jumlah_pesanan INT,
  total_harga DECIMAL(10,2),
  status_pembayaran VARCHAR(10) DEFAULT 'belum lunas'
);
//table pembayaran
CREATE TABLE pembayaran (
  id_pembayaran INT PRIMARY KEY,
  id_pesanan INT,
  jumlah_pembayaran DECIMAL(10,2),
  tanggal_pembayaran DATE,
  status_pembayaran VARCHAR(10) DEFAULT 'belum lunas',
  FOREIGN KEY (id_pesanan) REFERENCES pesanan(id_pesanan)
);
CREATE TRIGGER update_status_pembayaran
AFTER UPDATE ON pembayaran
FOR EACH ROW
BEGIN
  IF NEW.status_pembayaran = 'lunas' THEN
    UPDATE pesanan
    SET status_pembayaran = 'lunas'
    WHERE id_pesanan = NEW.id_pesanan;
  END IF;
END;