// src/types/index.ts

// ──────────────────────────────────────
// Enum
// ──────────────────────────────────────
export type KondisiBarang = 'Baik' | 'Rusak Ringan' | 'Rusak Berat';

export const KONDISI_OPTIONS: KondisiBarang[] = [
  'Baik',
  'Rusak Ringan',
  'Rusak Berat',
];

// ──────────────────────────────────────
// Database Row Types (matches Supabase)
// ──────────────────────────────────────
export interface Kategori {
  id: string;
  nama_kategori: string;
  created_at: string;
}

export interface Barang {
  id: string;
  nama_barang: string;
  kategori_id: string;
  jumlah: number;
  kondisi: KondisiBarang;
  lokasi: string;
  keterangan: string | null;
  created_at: string;
  updated_at: string;
}

// ──────────────────────────────────────
// View Types (with joined data)
// ──────────────────────────────────────
export interface BarangWithKategori extends Barang {
  kategori: Pick<Kategori, 'nama_kategori'>;
}

export interface KategoriWithCount extends Kategori {
  barang_count: number;
}

// ──────────────────────────────────────
// Form Types (for input)
// ──────────────────────────────────────
export interface BarangFormData {
  nama_barang: string;
  kategori_id: string;
  jumlah: number;
  kondisi: KondisiBarang;
  lokasi: string;
  keterangan?: string;
}

export interface KategoriFormData {
  nama_kategori: string;
}

// ──────────────────────────────────────
// Dashboard Types
// ──────────────────────────────────────
export interface DashboardStats {
  total_barang: number;
  total_kategori: number;
  kondisi_baik: number;
  kondisi_rusak_ringan: number;
  kondisi_rusak_berat: number;
}

// ──────────────────────────────────────
// Filter Types
// ──────────────────────────────────────
export interface BarangFilter {
  search: string;
  kategori_id: string | null;  // null = semua
  kondisi: KondisiBarang | null; // null = semua
  page: number;
  per_page: number;
}
