INSERT INTO kategori (nama_kategori) VALUES
  ('Mebeler'),
  ('Elektronik'),
  ('Alat Tulis & Kantor'),
  ('Olahraga'),
  ('Alat Kebersihan'),
  ('Buku & Media Pembelajaran'),
  ('Perlengkapan Kelas'),
  ('Sarana Kesehatan')
ON CONFLICT (nama_kategori) DO NOTHING;
