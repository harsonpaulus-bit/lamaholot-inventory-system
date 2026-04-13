ALTER TABLE kategori ENABLE ROW LEVEL SECURITY;
ALTER TABLE barang ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can view kategori" ON kategori FOR SELECT TO authenticated USING (true);
CREATE POLICY "Authenticated users can insert kategori" ON kategori FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Authenticated users can update kategori" ON kategori FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Authenticated users can delete kategori" ON kategori FOR DELETE TO authenticated USING (true);

CREATE POLICY "Authenticated users can view barang" ON barang FOR SELECT TO authenticated USING (true);
CREATE POLICY "Authenticated users can insert barang" ON barang FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Authenticated users can update barang" ON barang FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Authenticated users can delete barang" ON barang FOR DELETE TO authenticated USING (true);
