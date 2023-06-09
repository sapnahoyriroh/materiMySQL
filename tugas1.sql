create table produk(
    -> id int not null auto_increment primary key,
    -> kode varchar(10),
    -> nama varchar(45),
    -> harga_beli double,
    -> harga_jual double,
    -> stok int(11),
    -> min_stok int(11),
    -> jenis_produk_id int(11) not null references jenis_produk(id));


 create table pesanan_items(
     id int not null auto_increment primary key,
     produk_id int(11) not null references produk(id),
     pesanan_id int(11) not null references pesanan(id),
     qty int(11),
     harga double);

create table vendor(
     id int not null auto_increment primary key,
     nomor varchar(4),
     nama varchar(40),
     kota varchar(30),
     kontak varchar(11));

 create table pembelian(
    id int not null auto_increment primary key,
    tanggal varchar(45),
    nomor varchar(10),     
    produk_id int(11) not null references produk(id),
    jumlah int(11),
    harga double,
    vendor_id int(11) not null references vendor(id));

 ALTER TABLE pelanggan
    ADD COLUMN IF NOT EXISTS
    alamat varchar(40);

 ALTER TABLE pelanggan
    CHANGE nama nama_pelanggan varchar(45);

 ALTER TABLE pelanggan 
    MODIFY nama_pelanggan varchar(50);
