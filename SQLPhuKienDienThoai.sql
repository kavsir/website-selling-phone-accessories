CREATE DATABASE SQLDienThoai
GO 
USE SQLDienThoai
GO

INSERT INTO TaiKhoan (MaTaiKhoan, TenDangNhap, MatKhau, VaiTro) VALUES
 (1, 'admin', 'admin123', 'Admin'),
 (2, 'user', 'user123', 'User');

 INSERT INTO QuanLy (MaQuanLy, HoTen, Email, SDT) VALUES
(1, N'Nguyễn Quản Lý', 'quanly@gmail.com', '0912345678');
INSERT INTO KhachHang (MaKhachHang, HoTen, Email, SDT, DiaChi, NgayDangKy) VALUES
(2, N'Nguyễn Văn A', 'user@gmail.com', '0901234567', N'123 Lê Lợi, Q1', '2024-01-01');


-- Hãng điện thoại
INSERT INTO HangDienThoai (MaHang, TenHang) VALUES
(1, N'Apple');

-- Dòng điện thoại
INSERT INTO DienThoai (MaDienThoai, TenDienThoai, MaHang) VALUES
(1, N'iPhone 14', 1);

-- Loại phụ kiện
INSERT INTO LoaiPhuKien (MaLoaiPhuKien, TenLoai) VALUES
(1, N'Ốp lưng');

-- Sản phẩm
INSERT INTO SanPham (MaSP, TenSP, MoTa, GiaBan, SoLuong, NgayNhap, TrangThai, HinhAnh, MaQuanLy, MaLoaiPhuKien, MaDienThoai) VALUES
(1, N'Ốp lưng iPhone 14', N'Ốp silicon cao cấp', 150000, 20, '2025-06-23', N'Còn hàng', 'oplung.jpg', 1, 1, 1);


-- Giỏ hàng của khách hàng 2
INSERT INTO GioHang (MaGioHang, MaKhachHang, NgayTao, TongTien) VALUES
(1, 2, '2024-03-12', 150000);

-- Chi tiết giỏ hàng
INSERT INTO ChiTietGioHang (MaChiTiet, MaGioHang, MaSanPham, SoLuong, Gia) VALUES
(1, 1, 1, 1, 150000);

-- Đơn hàng
INSERT INTO DonHang (MaDonHang, MaKhachHang, NgayDat, TrangThai, GhiChu) VALUES
(1, 2, '2024-03-13', N'Đang xử lý', N'Giao trong ngày');

-- Chi tiết đơn hàng
INSERT INTO ChiTietDonHang (MaChiTiet, MaDonHang, MaSanPham, SoLuong, DonGia) VALUES
(1, 1, 1, 1, 150000);

-- Hóa đơn
INSERT INTO HoaDon (MaHoaDon, MaDonHang, NgayLap, TongTien, TrangThaiTT) VALUES
(1, 1, '2024-03-13', 150000, N'Chưa thanh toán');

-- Thanh toán
INSERT INTO ThanhToan (MaThanhToan, MaKhachHang, MaHoaDon, NgayThanhToan, PhuongThuc, SoTien) VALUES
(1, 2, 1, '2024-03-14', N'COD', 150000);

CREATE TABLE TaiKhoan (
    MaTaiKhoan INT PRIMARY KEY,
    TenDangNhap NVARCHAR(50),
    MatKhau NVARCHAR(255),
    VaiTro NVARCHAR(20) 
);


CREATE TABLE KhachHang (
    MaKhachHang INT PRIMARY KEY,
    HoTen NVARCHAR(100),
    Email NVARCHAR(100),
    SDT NVARCHAR(20),
    DiaChi NVARCHAR(255),
    NgayDangKy DATE,
    FOREIGN KEY (MaKhachHang) REFERENCES TaiKhoan(MaTaiKhoan)
);


CREATE TABLE QuanLy (
    MaQuanLy INT PRIMARY KEY,
    HoTen NVARCHAR(100),
    Email NVARCHAR(100),
    SDT NVARCHAR(20),
    FOREIGN KEY (MaQuanLy) REFERENCES TaiKhoan(MaTaiKhoan)
);

CREATE TABLE HangDienThoai(
	MaHang INT PRIMARY KEY,
	TenHang NVARCHAR(20),
);



CREATE TABLE DienThoai(
    MaDienThoai INT PRIMARY KEY,
    TenDienThoai NVARCHAR(50),
    MaHang INT,
    FOREIGN KEY (MaHang) REFERENCES HangDienThoai(MaHang)
);


CREATE TABLE LoaiPhuKien (
	MaLoaiPhuKien INT PRIMARY KEY,
	TenLoai NVARCHAR(20),
);

CREATE TABLE SanPham (
    MaSP INT PRIMARY KEY,
    TenSP NVARCHAR(100),
    MoTa NVARCHAR(MAX),
    GiaBan DECIMAL(18, 2),
    SoLuong INT,
    NgayNhap DATE,
    TrangThai NVARCHAR(50),
    HinhAnh NVARCHAR(255),
    MaQuanLy INT,
    FOREIGN KEY (MaQuanLy) REFERENCES QuanLy(MaQuanLy),
	MaLoaiPhuKien INT FOREIGN KEY REFERENCES LoaiPhuKien(MaLoaiPhuKien),
    MaDienThoai INT FOREIGN KEY REFERENCES DienThoai(MaDienThoai)
);


CREATE TABLE GioHang (
    MaGioHang INT PRIMARY KEY,
    MaKhachHang INT,
    NgayTao DATE,
    TongTien DECIMAL(18, 2),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);

CREATE TABLE ChiTietGioHang (
    MaChiTiet INT PRIMARY KEY,
    MaGioHang INT,
    MaSanPham INT,
    SoLuong INT,
    Gia DECIMAL(18, 2),
    FOREIGN KEY (MaGioHang) REFERENCES GioHang(MaGioHang),
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSP)
);

CREATE TABLE DonHang (
    MaDonHang INT PRIMARY KEY,
    MaKhachHang INT,
    NgayDat DATE,
    TrangThai NVARCHAR(50),
    GhiChu NVARCHAR(255),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);

CREATE TABLE ChiTietDonHang (
    MaChiTiet INT PRIMARY KEY,
    MaDonHang INT,
    MaSanPham INT,
    SoLuong INT,
    DonGia DECIMAL(18, 2),
    ThanhTien AS (SoLuong * DonGia) PERSISTED,
    FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang),
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSP)
);

CREATE TABLE HoaDon (
    MaHoaDon INT PRIMARY KEY,
    MaDonHang INT,
    NgayLap DATE,
    TongTien DECIMAL(18, 2),
    TrangThaiTT NVARCHAR(50),
    FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang)
);

CREATE TABLE ThanhToan (
    MaThanhToan INT PRIMARY KEY,
    MaKhachHang INT,
    MaHoaDon INT UNIQUE,
    NgayThanhToan DATE,
    PhuongThuc NVARCHAR(50),
    SoTien DECIMAL(18, 2),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),
    FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon)
);


