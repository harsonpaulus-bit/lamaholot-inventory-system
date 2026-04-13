CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  return NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER set_barang_updated_at
  BEFORE UPDATE ON barang
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at();
