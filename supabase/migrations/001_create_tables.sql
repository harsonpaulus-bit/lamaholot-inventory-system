-- Custom ENUM type untuk kondisi barang
CREATE TYPE kondisi_barang AS ENUM ('Baik', 'Rusak Ringan', 'Rusak Berat');

-- Tabel: kategori
CREATE TABLE IF NOT EXISTS kategori (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nama_kategori VARCHAR(100) NOT NULL UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Tabel: barang
CREATE TABLE IF NOT EXISTS barang (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nama_barang VARCHAR(255) NOT NULL,
  kategori_id UUID NOT NULL REFERENCES kategori(id) ON DELETE RESTRICT,
  jumlah INTEGER NOT NULL CHECK (jumlah >= 0),
  kondisi kondisi_barang NOT NULL,
  lokasi VARCHAR(150) NOT NULL,
  keterangan TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMENT ON TABLE kategori IS 'Tabel kategori barang inventaris';
COMMENT ON TABLE barang IS 'Tabel utama data barang inventaris';
