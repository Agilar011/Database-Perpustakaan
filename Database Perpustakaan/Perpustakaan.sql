drop database if exists Perpustakaan;
create database Perpustakaan;
use  Perpustakaan;
create table SHIFT(
   KODE_SHIFT           varchar(50) not null,
   JAM_KERJA            time  DEFAULT null,
   JAM_PULANG           time  DEFAULT null,
   primary key (KODE_SHIFT));

create table AUTHENTICATION_SISTEM(
   LOGIN_ID             varchar(10) not null,
   KODE_PETUGAS         varchar(10)  DEFAULT null,
   PASS                 varchar(1024)  DEFAULT null,
   primary key (LOGIN_ID));

create table PETUGAS(
   KODE_PETUGAS         varchar(10) not null,
   LOGIN_ID             varchar(10)  DEFAULT null,
   KODE_SHIFT           varchar(50) not null,
   JABATAN_PETUGAS      varchar(50)  DEFAULT null,
   NAMA_PETUGAS         varchar(100)  DEFAULT null,
   ALAMAT_PETUGAS       varchar(100)  DEFAULT null,
   JENISKELAMIN_PETUGAS varchar(100)  DEFAULT null,
   TELEPON_PETUGAS      varchar(14)  DEFAULT null,
   primary key (KODE_PETUGAS));

create table ANGGOTA(
   KODE_ANGGOTA         varchar(50) NOT null,
   NAMA_ANGGOTA         varchar(100)  DEFAULT null,
   ANGKATAN_ANGGOTA     varchar(100)  DEFAULT null,
   JENISKELAMIN_ANGGOTA varchar(20)  DEFAULT null,
   JURUSAN_ANGGOTA      varchar(20)  DEFAULT null,
   ALAMAT_ANGGOTA       varchar(100)  DEFAULT null,
   primary key (KODE_ANGGOTA));

create table BUKU(
   KODE_BUKU            varchar(50) not null,
   ID_PENULIS           varchar(10) not null,
   PUBLISHER_ID         varchar(10) not null,
   KODE_RAK             varchar(20) not null,
   JUDUL_BUKU           varchar(50)  DEFAULT null,
   TAHUN_TERBIT         year  DEFAULT null,
   PENERBIT_BUKU        varchar(40)  DEFAULT null,
   GENRE_BUKU           varchar(20)  DEFAULT null,
   HARGA_BUKU           int  DEFAULT null,
   primary key (KODE_BUKU));

create table PENULIS(
   ID_PENULIS           varchar(10) not null,
   NAMA_PENULIS         varchar(50)  DEFAULT null,
   NEGARA_PENULIS       varchar(50)  DEFAULT null,
   primary key (ID_PENULIS));

create table PUBLISHER(
   PUBLISHER_ID         varchar(10) not null,
   NAMA_PUBLISHER       varchar(50)  DEFAULT null,
   NEGARA_PUBLISHER     varchar(50)  DEFAULT null,
   primary key (PUBLISHER_ID));

create table RAK(
   KODE_RAK             varchar(20) not null,
   NAMA_RAK             varchar(10)  DEFAULT null,
   primary key (KODE_RAK));

create table PEMINJAM(
   KODE_PETUGAS         varchar(10) not null,
   KODE_ANGGOTA         varchar(50) not null,
   KODE_PINJAM          varchar(10) not null,
   TANGGAL_KEMBALI      date  DEFAULT null,
   TANGGAL_PINJAM       date  DEFAULT null,
   primary key (KODE_PINJAM));

create table SEDANG_DIPINJAM(
   KODE_PETUGAS         varchar(10) not null,
   KODE_ANGGOTA         varchar(50) not null,
   KODE_PINJAM          varchar(10) not null,
   KODE_BUKU            varchar(50) not null,
   primary key (KODE_PETUGAS, KODE_ANGGOTA, KODE_PINJAM, KODE_BUKU));


create table PENGEMBALIAN(
   KODE_PETUGAS         varchar(10) not null,
   KODE_ANGGOTA         varchar(50) not null,
   KODE_KEMBALI         varchar(10) not null,
   TANGGAL_KEMBALI      date  DEFAULT null,
   JATUH_TEMPO          datetime  DEFAULT null,
   DENDA                int  DEFAULT null,
   JUMLAH_DENDA         int  DEFAULT null,
   primary key (KODE_KEMBALI));

create table SEDANG_DIKEMBALIKAN(
   KODE_PETUGAS         varchar(10) not null,
   KODE_ANGGOTA         varchar(50) not null,
   KODE_KEMBALI         varchar(10) not null,
   KODE_BUKU            varchar(50) not null,
   primary key (KODE_PETUGAS, KODE_ANGGOTA, KODE_KEMBALI, KODE_BUKU));


ALTER TABLE petugas
ADD FOREIGN KEY(login_id) REFERENCES authentication_sistem(login_id),
ADD FOREIGN KEY(kode_shift) REFERENCES shift(kode_shift);

ALTER TABLE authentication_sistem
ADD FOREIGN KEY(kode_petugas) REFERENCES petugas(kode_petugas);

ALTER TABLE peminjam
ADD FOREIGN KEY(kode_petugas) REFERENCES petugas(kode_petugas),
ADD FOREIGN KEY(kode_anggota) REFERENCES anggota(kode_anggota);

ALTER TABLE pengembalian
ADD FOREIGN KEY(kode_petugas) REFERENCES petugas(kode_petugas),
ADD FOREIGN KEY(kode_anggota) REFERENCES anggota(kode_anggota);

ALTER TABLE buku
ADD FOREIGN KEY(id_penulis) REFERENCES penulis(id_penulis),
ADD FOREIGN KEY(publisher_id) REFERENCES publisher (publisher_id),
ADD FOREIGN KEY(kode_rak) REFERENCES rak(kode_rak);


insert into shift values 
('KD1','07:00:00','14:00:00'),
('KD2','14:00:00','21:00:00');

insert into anggota values
('A001', 'ADITYA', '2021', 'PRIA', 'MESIN', 'MALANG'),
('A002', 'SANIA', '2020', 'PEREMPUAN', 'MP', 'MALANG'),
('A003', 'CALVIN', '2020', 'PRIA', 'TI', 'KEDIRI'),
('A004', 'DIMAS', '2021', 'PRIA', 'MI', 'SURABAYA'),
('A005', 'ZIDANE', '2022', 'PRIA', 'SIPIL', 'SIDOARJO'),
('A006', 'PUTRI', '2022', 'PEREMPUAN', 'TI', 'PONOROGO'),
('A007', 'RANIA', '2019', 'PEREMPUAN', 'AM', 'MALANG'),
('A008', 'TANTRI', '2019', 'PEREMPUAN', 'AM', 'TUBAN'),
('A009', 'RIO', '2021', 'PRIA', 'SIPIL', 'BLITAR'),
('A010', 'ADINDA', '2021', 'PEREMPUAN', 'TK', 'MALANG');

insert into rak(kode_rak, nama_rak) values
('KR01', 'Agama'),
('KR02', 'Geografi'),
('KR03', 'Sejarah'),
('KR04', 'Novel'),
('KR05', 'Fiksi'),
('KR06', 'Horor'),
('KR07', 'Misteri'),
('KR08', 'Petualangan'),
('KR09', 'Sastra'),
('KR10', 'Fantasi');

insert into penulis values
('NP001','Indra Hadi','Indonesia'),
('NP002','Slamet Purnomo','Indonesia'),
('NP003','Didik Nurhayadi','Indonesia'),
('NP004','Titiek Sumiarti','Indonesia'),
('NP005','Nathanael Richard','Indonesia'),
('NP006','Ahmad Ghozali','Indonesia'),
('NP007','Andi Subagyo','Indonesia'),
('NP008','Tri Jagat','Indonesia'),
('NP009','Fayzah Rahma','Indonesia'),
('NP010','Nining Suharti','Indonesia');


insert into publisher values
('PI001','Andi Publisher','Indonesia'),
('PI002','Elexmedia Komputindo','Indonesia'),
('PI003','Gagas Media','Indonesia'),
('PI004','Grasindo','Indonesia'),
('PI005','GPU','Indonesia'),
('PI006','Agro Media','Indonesia'),
('PI007','Penerbit Erlangga','Indonesia'),
('PI008','Mizan','Indonesia'),
('PI009','Tiga Serangkai','Indonesia'),
('PI010','Benteng Pusaka','Indonesia');

insert into AUTHENTICATION_SISTEM values
('098870', 'KP010', 'adq890'),
('098871', 'KP007', 'adj659'),
('098872', 'KP003', 'adf789'),
('098873', 'KP008', 'adu544'),
('098874', 'KP004', 'adg524'),
('098875', 'KP006', 'adh253'),
('098876', 'KP005', 'adc634'),
('098877', 'KP009', 'adi345'),
('098878', 'KP001', 'ads234'),
('098879', 'KP002', 'ada252');

insert into petugas values
('KP001','098878','ADMINISTRASI','KD2','KEVIN','MALANG','PRIA','081222333444'),
('KP002','098879','ADMINISTRASI','KD2','YADI','MALANG','PRIA','085456789234'),
('KP003','098872','MANAGER','KD1','YANTI','SURABAYA','PEREMPUAN','081234890567'),
('KP004','098874','INVENTARIS','KD1','WATI','SURABAYA','PEREMPUAN','082321654987'),
('KP005','098876','KEAMANAN','KD1','YATNO','SIDOARJO','PRIA','087254867965'),
('KP006','098875','KEBERSIHAN','KD2','ANDIK','SIDOARJO','PRIA','087254862234'),
('KP007','098871','KEAMANAN','KD2','YANTO','KEDIRI','PRIA','087254867285'),
('KP008','098873','KEBERSIHAN','KD1','WIDODO','BLITAR','PRIA','087254868864'),
('KP009','098877','INVENTARIS','KD1','RUDI','PONOROGO','PRIA','087254866768'),
('KP010','098870','INVENTARIS','KD1','SITI','MALANG','PEREMPUAN','087254864825');


insert into sedang_dipinjam values
('KP001','A002','KPM002','KB567'),
('KP003','A008','KPM001','KB478'),
('KP007','A007','KPM003','KB890'),
('KP004','A001','KPM009','KB001'),
('KP002','A004','KPM006','KB022'),
('KP005','A003','KPM004','KB123'),
('KP009','A009','KPM005','KB444'),
('KP006','A006','KPM007','KB902'),
('KP008','A005','KPM008','KB266'),
('KP010','A010','KPM010','KB455');

insert into sedang_dikembalikan values
('KP001','A002','KK002','KB567'),
('KP003','A008','KK001','KB478'),
('KP007','A007','KK003','KB890'),
('KP004','A001','KK009','KB001'),
('KP002','A004','KK006','KB022'),
('KP005','A003','KK004','KB123'),
('KP009','A009','KK005','KB444'),
('KP006','A006','KK007','KB902'),
('KP008','A005','KK008','KB266'),
('KP010','A010','KK010','KB455');


insert into peminjam(kode_petugas, kode_anggota, kode_pinjam,tanggal_pinjam, tanggal_kembali)
values
('KP002','A003','KPM001','2022-06-08','2022-06-10'),
('KP005','A002','KPM010','2022-07-10','2022-07-12'),
('KP006','A007','KPM006','2022-07-24','2022-07-26'),
('KP007','A008','KPM009','2022-07-01','2022-07-03'),
('KP009','A009','KPM004','2022-06-07','2022-06-09'),
('KP001','A001','KPM005','2022-06-09','2022-06-11'),
('KP003','A004','KPM008','2022-06-10','2022-06-12'),
('KP004','A006','KPM007','2022-06-16','2022-06-18'),
('KP008','A005','KPM003','2022-07-03','2022-07-05'),
('KP010','A010','KPM002','2022-06-18','2022-06-20');

insert into pengembalian values
('KP007','A006','KK006','2022-06-18','2022-06-18,'1000','null),
('KP003','A001','KK005','2022-06-11','2022-06-11','1000','null),
('KP004','A010','KK007','2022-06-20','2022-06-20','1000','null),
('KP005','A005','KK004','2022-07-05','2022-07-05','1000','null),
('KP008','A004','KK008','2022-06-12','2022-06-14','1000','2000),
('KP001','A007','KK003','2022-07-26','2022-07-26','1000','null),
('KP006','A003','KK009','2022-06-12','2022-06-13','1000','1000),
('KP010','A009','KK002','2022-06-09','2022-06-13','1000','4000),
('KP009','A008','KK010','2022-07-03','2022-07-03','1000','1000),
('KP002','A002','KK001','2022-07-12','2022-07-12','1000','null);

insert into buku values
('KB567','NP001','PI001','KR01','Kisah Sunda Empire','1999','Andi Publisher','Geografi'),
('KB478','NP002','PI002','KR02','Bobo','2002','Elexmedia Komputindo','Fantasi'),
('KB890','NP003','PI003','KR03','Piknik Seru','2000','Gagas Media','Novel'),
('KB001','NP004','PI004','KR04','Distilasi Alkena ','2001','Grasindo','Sastra'),
('KB022','NP005','PI005','KR05','Dilan','1988','GPU','Novel'),
('KB123','NP006','PI006','KR06','Suster Keramas','2014','Agro Media','Horor'),
('KB444','NP007','PI007','KR07','Siksa Kubur','2008','Penerbit Erlangga','Misteri'),
('KB902','NP008','PI008','KR08','Suara Hati dan Al-Qur'an','2020','Mizan','Agama'),
('KB266','NP009','PI009','KR09','SiBolang','2015','Tiga Serangkai','Petualangan'),
('KB455','NP010','PI010','KR10','Ir Soekarno','2019','Benteng Pusaka','Sejarah');
