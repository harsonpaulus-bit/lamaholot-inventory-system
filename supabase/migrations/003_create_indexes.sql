CREATE INDEX IF NOT EXISTS idx_barang_nama ON barang (nama_barang);
CREATE INDEX IF NOT EXISTS idx_barang_kategori ON barang (kategori_id);
CREATE INDEX IF NOT EXISTS idx_barang_kondisi ON barang (kondisi);
CREATE INDEX IF NOT EXISTS idx_barang_kategori_kondisi ON barang (kategori_id, kondisi);
CREATE INDEX IF NOT EXISTS idx_barang_created_at ON barang (created_at DESC);
