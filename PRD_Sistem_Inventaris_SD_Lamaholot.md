# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Sistem Informasi Inventaris Berbasis Web**
**SD Lamaholot — Jakarta Barat**

---

| Atribut           | Detail                                          |
|-------------------|--------------------------------------------------|
| Versi Dokumen     | 2.0.0                                            |
| Status            | ✅ Final — Siap Eksekusi                          |
| Dibuat oleh       | Tim Pengembang — Ardian S.                       |
| Tanggal Dibuat    | April 2025                                       |
| Terakhir Direvisi | 13 April 2026                                    |
| Stack Teknologi   | Astro 4.x · Supabase · Tailwind CSS v4 · Vercel |
| Lisensi           | Internal — SD Lamaholot                          |

---

## Daftar Isi

1. [Ringkasan Eksekutif](#1-ringkasan-eksekutif)
2. [Latar Belakang & Analisis Masalah](#2-latar-belakang--analisis-masalah)
3. [Visi & Misi Produk](#3-visi--misi-produk)
4. [Tujuan & Indikator Keberhasilan](#4-tujuan--indikator-keberhasilan)
5. [Ruang Lingkup & Roadmap](#5-ruang-lingkup--roadmap)
6. [Analisis Stakeholder & Target Pengguna](#6-analisis-stakeholder--target-pengguna)
7. [Persona Pengguna](#7-persona-pengguna)
8. [Fitur & Persyaratan Fungsional](#8-fitur--persyaratan-fungsional)
9. [Persyaratan Non-Fungsional](#9-persyaratan-non-fungsional)
10. [Alur Pengguna (User Flow)](#10-alur-pengguna-user-flow)
11. [Arsitektur & Kebutuhan Teknis](#11-arsitektur--kebutuhan-teknis)
12. [Desain Database](#12-desain-database)
13. [API & Integrasi](#13-api--integrasi)
14. [Keamanan](#14-keamanan)
15. [UI/UX Guidelines & Wireframe](#15-uiux-guidelines--wireframe)
16. [Strategi Testing](#16-strategi-testing)
17. [Deployment & Release Plan](#17-deployment--release-plan)
18. [Monitoring & Observability](#18-monitoring--observability)
19. [Batasan Sistem](#19-batasan-sistem)
20. [Risiko & Mitigasi](#20-risiko--mitigasi)
21. [Kriteria Penerimaan (Acceptance Criteria)](#21-kriteria-penerimaan-acceptance-criteria)
22. [Timeline & Milestones](#22-timeline--milestones)
23. [Maintenance & Support Plan](#23-maintenance--support-plan)
24. [Glosarium](#24-glosarium)
25. [Lampiran](#25-lampiran)

---

## 1. Ringkasan Eksekutif

**SD Lamaholot** (NPSN: 20105717), sekolah dasar swasta di bawah naungan Yayasan Keluarga Lamaholot yang berlokasi di Jl. Jagung Raya-Bojong Indah, Rawa Buaya, Cengkareng, Jakarta Barat, telah beroperasi sejak **1910** dan meraih **Akreditasi A**. Dengan sejarah panjang dan komitmen terhadap kualitas pendidikan, pengelolaan aset sekolah yang efisien menjadi kebutuhan kritis.

Saat ini, pencatatan inventaris masih dilakukan secara manual menggunakan buku fisik dan spreadsheet tidak terstruktur. Hal ini menyebabkan **inefisiensi operasional**, **risiko kehilangan data**, dan **ketiadaan akuntabilitas** dalam pengelolaan aset sekolah.

Dokumen PRD ini mendefinisikan secara lengkap kebutuhan dan spesifikasi teknis untuk membangun **Sistem Informasi Inventaris Berbasis Web** yang modern, aman, dan mudah digunakan — dirancang khusus untuk kebutuhan SD Lamaholot.

**Estimasi pengembangan:** 6–8 minggu (1 developer full-stack)
**Estimasi biaya operasional:** Rp 0/bulan (Supabase Free Tier + Vercel Free Tier)

---

## 2. Latar Belakang & Analisis Masalah

### 2.1 Kondisi Saat Ini (As-Is)

SD Lamaholot mengandalkan pencatatan manual untuk mengelola inventaris sekolah. Proses yang berjalan saat ini:

```
┌─────────────────────────────────────────────────────────────┐
│                    PROSES MANUAL (As-Is)                     │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  [Barang Masuk] → Catat di Buku Inventaris (Manual)        │
│       ↓                                                     │
│  [Perlu Data]  → Cari di Buku / Spreadsheet (Lambat)       │
│       ↓                                                     │
│  [Buat Laporan]→ Ketik Ulang ke Excel (Rentan Error)       │
│       ↓                                                     │
│  [Audit]       → Hitung Manual Satu Per Satu (Lama)        │
│                                                             │
│  ⚠ Pain Points:                                            │
│  • Data tersebar di buku & file berbeda                     │
│  • Tidak ada backup otomatis                                │
│  • Pencarian memakan waktu 10-30 menit                     │
│  • Laporan akhir tahun bisa memakan waktu 2-3 hari         │
│  • Tidak ada jejak siapa yang mengubah data                 │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 2.2 Identifikasi Masalah

| # | Masalah | Dampak | Frekuensi |
|---|---------|--------|-----------|
| 1 | Data inventaris tersebar di buku dan file berbeda | Inkonsistensi data, duplikasi | Selalu |
| 2 | Pencarian barang sangat lambat (manual) | Waktu terbuang 10–30 menit per pencarian | Harian |
| 3 | Tidak ada backup data otomatis | Risiko kehilangan data permanen | Kritis |
| 4 | Pembuatan laporan memakan waktu lama | 2–3 hari kerja untuk laporan tahunan | Semester/Tahunan |
| 5 | Tidak ada jejak audit perubahan data | Tidak dapat melacak modifikasi data | Selalu |
| 6 | Tidak ada visibilitas real-time kondisi barang | Keputusan pengadaan tidak akurat | Bulanan |
| 7 | Sulit mengetahui barang yang perlu diperbaiki/diganti | Aset rusak tidak tertangani tepat waktu | Mingguan |

### 2.3 Solusi yang Diusulkan (To-Be)

```
┌─────────────────────────────────────────────────────────────┐
│              PROSES DIGITAL (To-Be)                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  [Barang Masuk] → Input via Form Web (Tervalidasi)         │
│       ↓                                                     │
│  [Perlu Data]  → Pencarian Real-time (< 5 detik)           │
│       ↓                                                     │
│  [Buat Laporan]→ Generate Otomatis (< 1 menit)             │
│       ↓                                                     │
│  [Audit]       → Data Akurat, Tersinkron Real-time         │
│                                                             │
│  ✅ Keunggulan:                                             │
│  • Single source of truth (satu sumber data)               │
│  • Backup otomatis via Supabase                             │
│  • Pencarian instan dengan filter                           │
│  • Laporan auto-generate, siap cetak                        │
│  • Akses dari mana saja via browser                         │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 3. Visi & Misi Produk

### 3.1 Visi

> Menjadi sistem pengelolaan inventaris **terbaik di kelasnya** untuk sekolah dasar — yang efisien, akurat, dan dapat diandalkan — sehingga SD Lamaholot dapat fokus pada misi utamanya: **memberikan pendidikan berkualitas bagi siswa**.

### 3.2 Misi

1. **Digitalisasi Total** — Mengubah seluruh proses pencatatan inventaris dari manual ke digital
2. **Akurasi Data** — Memastikan data inventaris selalu akurat melalui validasi terstruktur dan single source of truth
3. **Efisiensi Operasional** — Menghemat waktu staf administrasi secara signifikan dalam pengelolaan barang
4. **Aksesibilitas** — Memungkinkan akses data inventaris dari mana saja, kapan saja, melalui browser web
5. **Keamanan** — Melindungi data inventaris dari akses tidak sah dan kehilangan data
6. **Keberlanjutan** — Membangun fondasi sistem yang skalabel untuk mendukung kebutuhan masa depan

### 3.3 Value Proposition

| Untuk | Yang Membutuhkan | Produk Ini Adalah | Yang Memberikan |
|-------|-------------------|-------------------|-----------------|
| Admin / Staf TU SD Lamaholot | Cara efisien mengelola inventaris sekolah | Sistem informasi inventaris berbasis web | Pengelolaan data terpusat, pencarian cepat, laporan otomatis, dan keamanan data |

---

## 4. Tujuan & Indikator Keberhasilan

### 4.1 Tujuan Utama

| # | Tujuan | Prioritas |
|---|--------|-----------|
| T1 | Mendigitalisasi seluruh pencatatan inventaris sekolah | 🔴 Kritis |
| T2 | Meningkatkan akurasi data melalui validasi input terstruktur | 🔴 Kritis |
| T3 | Mempercepat pencarian dan pemfilteran data barang | 🟡 Tinggi |
| T4 | Menyediakan laporan inventaris otomatis dan real-time | 🟡 Tinggi |
| T5 | Memastikan keamanan data melalui autentikasi dan kontrol akses | 🔴 Kritis |
| T6 | Menyediakan dashboard ringkasan untuk pengambilan keputusan | 🟢 Sedang |

### 4.2 Key Performance Indicators (KPIs)

| Metrik | Baseline (Manual) | Target (v1.0) | Target (v2.0) |
|--------|--------------------|----------------|----------------|
| Waktu pencarian barang | 10–30 menit | < 5 detik | < 3 detik |
| Akurasi data vs catatan fisik | ~70% | ≥ 95% | ≥ 99% |
| Waktu pembuatan laporan | 2–3 hari | < 1 menit | < 30 detik |
| Uptime sistem | N/A | ≥ 99% | ≥ 99.5% |
| First Contentful Paint (FCP) | N/A | < 3 detik | < 2 detik |
| Waktu training user baru | N/A | < 30 menit | < 15 menit |
| Tingkat adopsi pengguna | 0% | ≥ 80% | 100% |

### 4.3 Metode Pengukuran

| KPI | Cara Pengukuran |
|-----|-----------------|
| Waktu pencarian | Timestamp query Supabase (response time API) |
| Akurasi data | Cross-check data digital vs data fisik setelah migrasi |
| Waktu laporan | Pengukuran dari klik "Generate" hingga laporan terlihat |
| Uptime | Monitoring via Supabase Status + Vercel Analytics |
| FCP | Lighthouse audit score |
| Training | Observasi langsung saat onboarding user |
| Adopsi | Tracking login frequency setelah 1 bulan deployment |

---

## 5. Ruang Lingkup & Roadmap

### 5.1 Versi 1.0 — MVP (Minimum Viable Product) ✅ Target Release

**Fokus:** Fondasi sistem yang fungsional dan stabil

| Modul | Fitur |
|-------|-------|
| Autentikasi | Login/logout dengan email & password via Supabase Auth |
| Dashboard | Ringkasan statistik inventaris (total barang, per kondisi, per kategori) |
| Manajemen Barang | CRUD lengkap: tambah, lihat, edit, hapus barang |
| Manajemen Kategori | CRUD kategori dengan proteksi referensi relasional |
| Pencarian & Filter | Real-time search, filter kategori, filter kondisi (kombinasi) |
| Laporan | Halaman laporan dengan fungsi cetak browser (Ctrl+P) |
| Keamanan | RLS (Row Level Security) pada semua tabel |

### 5.2 Versi 1.1 — Quick Wins (Post-MVP)

**Fokus:** Polish dan fitur yang sering diminta

| Modul | Fitur |
|-------|-------|
| Laporan | Export laporan ke PDF |
| Dashboard | Chart/grafik visualisasi (pie chart kondisi, bar chart per kategori) |
| UX | Pagination pada tabel barang (10/25/50 per halaman) |
| UX | Sorting kolom tabel (ascending/descending) |
| Data | Soft delete (kolom `deleted_at`) untuk pencegahan kehilangan data |
| Data | Bulk import barang dari file CSV |

### 5.3 Versi 2.0 — Feature Complete

**Fokus:** Multi-user, akuntabilitas, dan otomasi

| Modul | Fitur |
|-------|-------|
| Multi-Role | Role Kepala Sekolah (read-only), Operator TU (full access) |
| Audit Log | Riwayat perubahan data (siapa, kapan, apa yang diubah) |
| Notifikasi | Alert untuk barang rusak berat yang perlu tindakan |
| Foto Barang | Upload dan tampilkan foto barang (Supabase Storage) |
| Lokasi Detail | Pemetaan lokasi ruangan (Ruang Kelas 1, Gudang, dll.) |

### 5.4 Versi 3.0 — Advanced (Long-term)

**Fokus:** Integrasi dan automatisasi lanjutan

| Modul | Fitur |
|-------|-------|
| Peminjaman | Fitur peminjaman dan pengembalian barang |
| QR Code | Generate QR Code per barang untuk scanning cepat |
| Mobile | Progressive Web App (PWA) untuk akses offline |
| Integrasi | Koneksi dengan sistem keuangan sekolah |
| Analytics | Prediksi kebutuhan pengadaan barang berdasarkan tren |

### 5.5 Prioritization Matrix (MoSCoW — v1.0)

| Prioritas | Fitur |
|-----------|-------|
| **Must Have** | Login/logout, CRUD barang, CRUD kategori, pencarian, filter, dashboard statistik, laporan cetak, RLS |
| **Should Have** | Sortable table, pagination, toast notification, loading states, error boundaries |
| **Could Have** | Dark mode toggle, animasi mikro, export CSV |
| **Won't Have (v1.0)** | Multi-role, audit log, foto barang, peminjaman, QR code, mobile app, PDF export |

---

## 6. Analisis Stakeholder & Target Pengguna

### 6.1 Peta Stakeholder

| Stakeholder | Peran dalam Proyek | Ekspektasi Utama | Power | Interest |
|-------------|---------------------|-------------------|-------|----------|
| Kepala Sekolah | Sponsor / Decision Maker | Laporan akurat, sistem mudah digunakan, ROI positif | Tinggi | Tinggi |
| Staff TU / Admin | Pengguna Utama (End User) | Kemudahan input data, pencarian cepat, laporan otomatis | Sedang | Tinggi |
| Yayasan Keluarga Lamaholot | Stakeholder Strategis | Transparansi aset, akuntabilitas | Tinggi | Sedang |
| Tim Pengembang | Pembangun Sistem | Spesifikasi jelas, requirement stabil | Rendah | Tinggi |
| Guru | Pengguna Tidak Langsung | Dapat melaporkan kerusakan barang | Rendah | Rendah |

### 6.2 RACI Matrix

| Aktivitas | Kepala Sekolah | Staff TU | Tim Dev | Yayasan |
|-----------|----------------|----------|---------|---------|
| Penentuan requirement | A | C | R | I |
| Desain UI/UX | I | C | R | — |
| Pengembangan | I | — | R/A | — |
| Testing (UAT) | A | R | C | I |
| Deployment | A | I | R | I |
| Migrasi data | C | R | C | I |
| Training | I | R | R | — |
| Go-live decision | A | C | I | I |

> **R** = Responsible, **A** = Accountable, **C** = Consulted, **I** = Informed

---

## 7. Persona Pengguna

### 7.1 Persona Utama: Ibu Ratna — Staff Administrasi

| Atribut | Detail |
|---------|--------|
| **Nama** | Ibu Ratna (representasi persona) |
| **Usia** | 40 tahun |
| **Jabatan** | Staff Tata Usaha (TU) |
| **Kemampuan Teknis** | Dasar — terbiasa menggunakan komputer, browser, dan Microsoft Excel |
| **Perangkat** | Laptop Windows dengan Chrome/Edge, sesekali HP Android |
| **Tugas Harian** | Mengelola surat, mencatat inventaris, membuat laporan |
| **Frustasi** | Menghabiskan banyak waktu mencari data di buku inventaris, harus menghitung ulang setiap kali membuat laporan |
| **Kebutuhan** | Sistem sederhana yang bisa dia operasikan sendiri tanpa bantuan teknis |
| **Goal** | "Saya ingin bisa langsung tahu ada berapa kursi yang masih bagus tanpa harus bolak-balik buka buku catatan" |

### 7.2 User Needs Summary

| Need | Priority | Addressed by Feature |
|------|----------|----------------------|
| Input data barang dengan cepat | 🔴 Kritis | Form input tervalidasi dengan dropdown |
| Cari barang berdasarkan nama | 🔴 Kritis | Real-time search bar |
| Lihat ringkasan kondisi semua barang | 🟡 Tinggi | Dashboard statistik |
| Cetak laporan untuk rapat | 🟡 Tinggi | Halaman laporan + fungsi cetak |
| Kelola kategori barang | 🟢 Sedang | Halaman manajemen kategori |
| Akses dari HP ketika tidak di kantor | 🟢 Sedang | Desain responsif |

---

## 8. Fitur & Persyaratan Fungsional

### 8.1 Autentikasi (AUTH)

| ID | Persyaratan | Prioritas | Catatan |
|----|-------------|-----------|---------|
| AUTH-01 | Sistem menyediakan halaman login dengan form email dan password | Must | Landing page default |
| AUTH-02 | Sistem memvalidasi kredensial melalui Supabase Auth | Must | Gunakan `signInWithPassword()` |
| AUTH-03 | Sistem menampilkan pesan error deskriptif jika login gagal (email salah, password salah, akun tidak ditemukan) | Must | Pesan error berbahasa Indonesia |
| AUTH-04 | Sistem menyimpan sesi pengguna secara aman menggunakan cookie httpOnly | Must | Jangan gunakan localStorage |
| AUTH-05 | Pengguna yang belum login diarahkan ke halaman login secara otomatis (route protection) | Must | Middleware Astro |
| AUTH-06 | Sistem menyediakan fungsi logout yang mengakhiri sesi sepenuhnya dan redirect ke login | Must | Clear semua cookies & token |
| AUTH-07 | Sesi otomatis kedaluwarsa setelah 7 hari tidak aktif | Should | Konfigurasi via Supabase |
| AUTH-08 | Tampilkan nama/email pengguna yang sedang login di navbar | Should | Indikator sesi aktif |

**Edge Cases:**
- Double submit pada form login → Disable tombol setelah klik pertama
- Token expired saat sedang input data → Redirect ke login + tampilkan pesan informatif
- Multiple tab terbuka → Konsistensi sesi antar tab

---

### 8.2 Dashboard (DASH)

| ID | Persyaratan | Prioritas | Catatan |
|----|-------------|-----------|---------|
| DASH-01 | Menampilkan **summary cards**: Total Barang, Barang Kondisi Baik, Rusak Ringan, Rusak Berat | Must | Card dengan ikon dan angka besar |
| DASH-02 | Menampilkan jumlah kategori barang yang aktif | Must | Card tambahan |
| DASH-03 | Card summary menampilkan **persentase** dari total (misal: "Baik — 75%") | Should | Visual context |
| DASH-04 | Menyediakan navigasi cepat (**quick action buttons**) ke fitur utama: Tambah Barang, Lihat Laporan | Should | Akselerasi workflow |
| DASH-05 | Menampilkan **5 barang terbaru** yang ditambahkan/diperbarui | Should | Recent activity |
| DASH-06 | Menampilkan **alert/peringatan** jika ada barang berstatus "Rusak Berat" yang belum ditangani | Could | Badge merah pada card |
| DASH-07 | Data dashboard diperbarui secara **real-time** tanpa refresh manual | Should | Supabase Realtime subscription |

**Spesifikasi Visual Dashboard:**

```
┌────────────────────────────────────────────────────────┐
│  Selamat Datang, [Nama Admin]           [🔔] [Logout] │
├────────────────────────────────────────────────────────┤
│                                                        │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌────────┐│
│  │📦 Total   │  │✅ Baik    │  │⚠️ Rusak   │  │❌ Rusak ││
│  │  Barang   │  │          │  │  Ringan  │  │  Berat ││
│  │   234     │  │  180     │  │   42     │  │   12   ││
│  │           │  │  (77%)   │  │  (18%)   │  │  (5%)  ││
│  └──────────┘  └──────────┘  └──────────┘  └────────┘│
│                                                        │
│  ┌─────── Quick Actions ─────────────────────────────┐│
│  │ [+ Tambah Barang]  [📊 Lihat Laporan]  [📂 Kategori]│
│  └───────────────────────────────────────────────────┘│
│                                                        │
│  ┌─────── Barang Terbaru ────────────────────────────┐│
│  │ # │ Nama         │ Kategori │ Kondisi │ Tanggal   ││
│  │ 1 │ Meja Guru    │ Mebeler  │ Baik    │ 13 Apr    ││
│  │ 2 │ Laptop ASUS  │ Elektr.  │ R.Ringan│ 12 Apr    ││
│  │ 3 │ Papan Tulis  │ Kelas    │ Baik    │ 10 Apr    ││
│  │ ...                                               ││
│  └───────────────────────────────────────────────────┘│
└────────────────────────────────────────────────────────┘
```

---

### 8.3 Manajemen Barang (BRG)

#### 8.3.1 Tambah Barang

| ID | Persyaratan | Prioritas | Catatan |
|----|-------------|-----------|---------|
| BRG-01 | Sistem menyediakan form tambah barang lewat **modal dialog** | Must | Tidak perlu pindah halaman |
| BRG-02 | Field wajib (required): **Nama Barang**, **Kategori**, **Jumlah**, **Kondisi**, **Lokasi** | Must | Semua wajib diisi |
| BRG-03 | Field opsional: **Keterangan** (textarea) | Must | Catatan tambahan |
| BRG-04 | Field **Nama Barang**: minimal 3 karakter, maksimal 255 karakter | Must | Validasi real-time |
| BRG-05 | Field **Jumlah**: hanya menerima angka positif (≥ 1), tipe `number` | Must | Input `type="number"` min=1 |
| BRG-06 | Field **Kondisi**: dropdown dengan opsi `Baik` / `Rusak Ringan` / `Rusak Berat` | Must | Tidak bisa diketik manual |
| BRG-07 | Field **Kategori**: dropdown yang terisi otomatis dari tabel `kategori` | Must | Fetch dari Supabase |
| BRG-08 | Field **Lokasi**: text input, minimal 2 karakter | Must | Contoh: "Gudang", "Ruang Kelas 1A" |
| BRG-09 | Sistem menampilkan pesan validasi inline jika ada field yang tidak valid | Must | Pesan di bawah field terkait |
| BRG-10 | Data tersimpan ke Supabase setelah submit berhasil, modal tertutup, tabel di-refresh | Must | Optimistic atau wait response |
| BRG-11 | Tampilkan **toast notification** sukses setelah barang berhasil ditambahkan | Must | "Barang berhasil ditambahkan" |
| BRG-12 | Tombol submit **disabled** selama proses penyimpanan (prevent double submit) | Should | Loading state dengan spinner |

**Edge Cases:**
- Kategori kosong (belum ada kategori) → Tampilkan pesan: "Silakan tambah kategori terlebih dahulu"
- Koneksi putus saat submit → Tampilkan error + data form tidak hilang (persist form state)
- Nama barang duplikat → Diizinkan (karena bisa ada barang sama di lokasi berbeda)

#### 8.3.2 Lihat & Cari Barang

| ID | Persyaratan | Prioritas | Catatan |
|----|-------------|-----------|---------|
| BRG-13 | Sistem menampilkan daftar semua barang dalam format **tabel responsif** | Must | DataTable component |
| BRG-14 | Kolom tabel: **No**, **Nama Barang**, **Kategori**, **Jumlah**, **Kondisi**, **Lokasi**, **Aksi** | Must | Urutan tetap |
| BRG-15 | Kolom **Kondisi** ditampilkan sebagai **badge berwarna**: Hijau (Baik), Kuning (Rusak Ringan), Merah (Rusak Berat) | Must | Visual differentiation |
| BRG-16 | Fitur **pencarian real-time** berdasarkan nama barang (debounce 300ms) | Must | Search bar di atas tabel |
| BRG-17 | Filter **dropdown kategori** (pilih satu atau "Semua Kategori") | Must | Reset saat pilih "Semua" |
| BRG-18 | Filter **dropdown kondisi** (pilih satu atau "Semua Kondisi") | Must | Reset saat pilih "Semua" |
| BRG-19 | Filter kategori dan kondisi dapat **dikombinasikan** dengan pencarian | Must | AND logic |
| BRG-20 | Tampilkan **jumlah hasil** yang ditemukan: "Menampilkan X dari Y barang" | Should | Counter di bawah filter |
| BRG-21 | Tampilkan **empty state** yang informatif jika tidak ada data / tidak ada hasil filter | Should | Ikon + pesan + CTA |
| BRG-22 | **Pagination**: tampilkan 10 barang per halaman dengan navigasi halaman | Should | Prev/Next + nomor halaman |

**Spesifikasi Empty State:**

```
┌─────────────────────────────────────────┐
│                                         │
│            📦                           │
│                                         │
│    Belum ada barang yang terdaftar       │
│    Mulai tambahkan barang pertama Anda   │
│                                         │
│         [+ Tambah Barang]               │
│                                         │
└─────────────────────────────────────────┘
```

#### 8.3.3 Edit Barang

| ID | Persyaratan | Prioritas | Catatan |
|----|-------------|-----------|---------|
| BRG-23 | Setiap baris data memiliki tombol **Edit** (ikon pensil) | Must | Di kolom Aksi |
| BRG-24 | Klik Edit membuka **modal dialog** yang sudah terisi data barang saat ini | Must | Pre-fill semua field |
| BRG-25 | Validasi sama dengan form Tambah Barang | Must | Reuse validation logic |
| BRG-26 | Perubahan tersimpan setelah klik **Simpan**, tabel di-refresh otomatis | Must | Feedback visual |
| BRG-27 | Tampilkan toast notification sukses/gagal setelah operasi | Must | — |

#### 8.3.4 Hapus Barang

| ID | Persyaratan | Prioritas | Catatan |
|----|-------------|-----------|---------|
| BRG-28 | Setiap baris data memiliki tombol **Hapus** (ikon tempat sampah, warna merah) | Must | Di kolom Aksi |
| BRG-29 | Klik Hapus menampilkan **dialog konfirmasi**: "Apakah Anda yakin ingin menghapus [Nama Barang]?" | Must | Tampilkan nama barang |
| BRG-30 | Dialog konfirmasi memiliki tombol **Batal** (secondary) dan **Hapus** (danger/merah) | Must | Mencegah klik tidak sengaja |
| BRG-31 | Setelah konfirmasi, data dihapus dari Supabase, tabel di-refresh, tampilkan toast | Must | Hard delete (v1.0), Soft delete (v1.1) |

---

### 8.4 Manajemen Kategori (KAT)

| ID | Persyaratan | Prioritas | Catatan |
|----|-------------|-----------|---------|
| KAT-01 | Sistem menampilkan **daftar semua kategori** dalam format tabel/list | Must | Kolom: No, Nama Kategori, Jumlah Barang, Aksi |
| KAT-02 | Kolom **Jumlah Barang** menampilkan hitungan barang per kategori | Should | Aggregate count |
| KAT-03 | Admin dapat **menambah kategori** baru dengan nama yang unik (case-insensitive) | Must | Validasi unik sebelum submit |
| KAT-04 | Admin dapat **mengedit** nama kategori | Must | Modal edit |
| KAT-05 | Admin dapat **menghapus** kategori yang **tidak memiliki barang terkait** | Must | Cek referensi sebelum hapus |
| KAT-06 | Jika kategori memiliki barang terkait, hapus **ditolak** dengan pesan: "Kategori tidak dapat dihapus karena masih memiliki X barang terkait" | Must | Informasi jumlah barang |
| KAT-07 | Nama kategori minimal 2 karakter, maksimal 100 karakter | Must | Validasi |
| KAT-08 | Tampilkan **empty state** jika belum ada kategori | Should | Ikon + pesan + CTA |

**Seed Data Kategori (Pre-filled saat setup):**

| Nama Kategori | Contoh Barang |
|---------------|---------------|
| Mebeler | Meja, Kursi, Lemari, Rak |
| Elektronik | Komputer, Printer, Proyektor, Speaker |
| Alat Tulis & Kantor | Papan tulis, Penghapus, Spidol, Stapler |
| Olahraga | Bola, Net, Matras, Raket |
| Alat Kebersihan | Sapu, Pel, Ember, Tempat Sampah |
| Buku & Media | Buku paket, Buku perpustakaan, Globe, Peta |
| Perlengkapan Kelas | Jam dinding, Bendera, Taplak meja |
| Sarana Kesehatan | Kotak P3K, Timbangan, Obat-obatan |

---

### 8.5 Laporan Inventaris (LAP)

| ID | Persyaratan | Prioritas | Catatan |
|----|-------------|-----------|---------|
| LAP-01 | Sistem menyediakan halaman **laporan** yang menampilkan rekap data inventaris terkini | Must | Halaman khusus |
| LAP-02 | Bagian atas laporan menampilkan **ringkasan statistik**: Total barang, per kondisi, per kategori | Must | Summary section |
| LAP-03 | Laporan menampilkan **tabel lengkap** semua barang, terurut berdasarkan kategori | Must | Grouped by category |
| LAP-04 | Laporan dapat **difilter** berdasarkan kategori dan/atau kondisi | Must | Same filter component |
| LAP-05 | Pengguna dapat **mencetak laporan** melalui tombol "Cetak" yang memicu `window.print()` | Must | Print-friendly CSS |
| LAP-06 | Layout cetak menampilkan **kop surat** SD Lamaholot (nama sekolah, alamat, logo) | Should | `@media print` styling |
| LAP-07 | Layout cetak menampilkan **tanggal cetak** dan **total halaman** | Should | Footer print |
| LAP-08 | *(v1.1)* Export laporan ke format **PDF** | Could | Gunakan library `html2pdf.js` |
| LAP-09 | *(v1.1)* Export data ke format **CSV** | Could | Untuk pengolahan di Excel |

**Spesifikasi Layout Cetak:**

```
┌─────────────────────────────────────────────────────────┐
│                    SD LAMAHOLOT                          │
│     Jl. Jagung Raya, Rawa Buaya, Jakarta Barat          │
│           Telp: 021-58356813                             │
│ ─────────────────────────────────────────────────────── │
│                                                         │
│              LAPORAN INVENTARIS BARANG                   │
│              Periode: April 2026                        │
│                                                         │
│  Ringkasan:                                             │
│  • Total Barang  : 234                                  │
│  • Kondisi Baik  : 180 (77%)                            │
│  • Rusak Ringan  : 42 (18%)                             │
│  • Rusak Berat   : 12 (5%)                              │
│                                                         │
│  ┌─────────────────────────────────────────────────┐    │
│  │ No │ Nama Barang │ Kategori │ Jml │ Kondisi   │    │
│  │  1 │ Meja Guru   │ Mebeler  │  10 │ Baik      │    │
│  │  2 │ Kursi Siswa │ Mebeler  │  60 │ Baik      │    │
│  │ ...│             │          │     │           │    │
│  └─────────────────────────────────────────────────┘    │
│                                                         │
│  Dicetak pada: 13 April 2026 | Halaman 1 dari 3        │
│                                                         │
│  Mengetahui,                                            │
│  Kepala Sekolah                Admin                    │
│                                                         │
│  _______________            _______________             │
│  (Nama Kepsek)              (Nama Admin)                │
└─────────────────────────────────────────────────────────┘
```

---

## 9. Persyaratan Non-Fungsional

### 9.1 Performa

| ID | Persyaratan | Target | Cara Verifikasi |
|----|-------------|--------|-----------------|
| PERF-01 | First Contentful Paint (FCP) | < 3 detik (3G) | Lighthouse audit |
| PERF-02 | Largest Contentful Paint (LCP) | < 2.5 detik | Lighthouse audit |
| PERF-03 | Time to Interactive (TTI) | < 5 detik | Lighthouse audit |
| PERF-04 | Operasi CRUD → response API | < 2 detik | Network tab monitoring |
| PERF-05 | Pencarian real-time (debounce) | < 500ms setelah stop typing | Timestamp logging |
| PERF-06 | Bundle size halaman | < 200KB (gzipped) | Build output analysis |

### 9.2 Keandalan (Reliability)

| ID | Persyaratan | Target |
|----|-------------|--------|
| REL-01 | Uptime sistem per bulan | ≥ 99% (SLA Supabase + Vercel) |
| REL-02 | Pesan error ramah pengguna jika koneksi gagal | Selalu |
| REL-03 | Operasi database dilindungi dari data race | Via Supabase transactions |
| REL-04 | Graceful degradation saat Supabase Realtime tidak tersedia | Fallback ke polling / manual refresh |

### 9.3 Skalabilitas

| ID | Persyaratan | Target |
|----|-------------|--------|
| SCAL-01 | Kapasitas record barang tanpa degradasi performa | Hingga 10.000 record |
| SCAL-02 | Arsitektur modular & extensible | Mendukung penambahan modul baru |
| SCAL-03 | Database indexing pada kolom yang sering di-query | `nama_barang`, `kategori_id`, `kondisi` |

### 9.4 Kompatibilitas Browser

| ID | Persyaratan |
|----|-------------|
| COMP-01 | Chrome ≥ 90, Firefox ≥ 90, Safari ≥ 15, Edge ≥ 90 |
| COMP-02 | Responsif pada viewport: Desktop (≥ 1024px), Tablet (768–1023px), Mobile (< 768px) |
| COMP-03 | Print stylesheet kompatibel pada Chrome dan Edge (target utama cetak) |

### 9.5 Accessibility (Aksesibilitas)

| ID | Persyaratan |
|----|-------------|
| ACC-01 | Kontras warna memenuhi standar WCAG 2.1 Level AA (≥ 4.5:1 untuk teks normal) |
| ACC-02 | Semua form element memiliki `label` yang terhubung |
| ACC-03 | Navigasi keyboard fungsional (Tab, Enter, Escape) |
| ACC-04 | Semantic HTML (header, main, nav, footer, section, article) |
| ACC-05 | ARIA attributes pada komponen interaktif (modal, dropdown, toast) |

### 9.6 Lighthouse Score Target

| Kategori | Target Score |
|----------|-------------|
| Performance | ≥ 90 |
| Accessibility | ≥ 90 |
| Best Practices | ≥ 90 |
| SEO | ≥ 90 |

---

## 10. Alur Pengguna (User Flow)

### 10.1 Flow Login

```
┌───────────┐     ┌──────────────┐     ┌────────────────┐
│ Buka App  │────▶│ Cek Sesi     │────▶│ Sesi Valid?    │
└───────────┘     └──────────────┘     └───────┬────────┘
                                          │          │
                                         Ya        Tidak
                                          │          │
                                          ▼          ▼
                                   ┌──────────┐ ┌──────────────┐
                                   │Dashboard │ │ Halaman Login│
                                   └──────────┘ └──────┬───────┘
                                                       │
                                                       ▼
                                                ┌──────────────┐
                                                │ Input Email  │
                                                │ & Password   │
                                                └──────┬───────┘
                                                       │
                                                       ▼
                                                ┌──────────────┐
                                                │ Validasi via │
                                                │ Supabase Auth│
                                                └──────┬───────┘
                                                   │        │
                                                Berhasil   Gagal
                                                   │        │
                                                   ▼        ▼
                                            ┌──────────┐ ┌──────────┐
                                            │Dashboard │ │ Error    │
                                            │          │ │ Message  │
                                            └──────────┘ │ + Retry  │
                                                         └──────────┘
```

### 10.2 Flow CRUD Barang (Lengkap)

```
┌──────────────────────────────────────────────────────────────────┐
│                     HALAMAN DAFTAR BARANG                        │
│                                                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌───────────────────────┐  │
│  │ Search Bar   │  │ Filter Kat.  │  │ Filter Kondisi       │  │
│  │ [🔍_______]  │  │ [▼ Semua  ]  │  │ [▼ Semua Kondisi  ]  │  │
│  └──────┬───────┘  └──────┬───────┘  └───────────┬───────────┘  │
│         │                 │                      │               │
│         └─────────────────┼──────────────────────┘               │
│                           │                                      │
│                           ▼                                      │
│  ┌───────────────────────────────────────────────────────────┐   │
│  │                    TABEL BARANG                           │   │
│  │  Menampilkan X dari Y barang                             │   │
│  │ ┌───┬──────────┬────────┬─────┬──────────┬──────┬──────┐ │   │
│  │ │ # │ Nama     │ Kat.   │ Jml │ Kondisi  │ Lok. │ Aksi │ │   │
│  │ ├───┼──────────┼────────┼─────┼──────────┼──────┼──────┤ │   │
│  │ │ 1 │ Meja     │ Mebel  │ 10  │ 🟢 Baik  │ R.1  │ ✏️🗑│ │   │
│  │ │ 2 │ Laptop   │ Elek.  │  2  │ 🟡 R.R.  │ TU   │ ✏️🗑│ │   │
│  │ └───┴──────────┴────────┴─────┴──────────┴──────┴──────┘ │   │
│  │                 [◀ 1 2 3 ... ▶]                          │   │
│  └───────────────────────────────────────────────────────────┘   │
│                                                                  │
│  [+ Tambah Barang]  ← Floating Action Button (FAB)             │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘

                      │ Klik "Tambah"
                      ▼
              ┌───────────────────┐
              │  MODAL: TAMBAH    │
              │                   │
              │  Nama: [_______]  │
              │  Kat.: [▼ Pilih]  │
              │  Jumlah: [___]    │
              │  Kondisi: [▼___]  │
              │  Lokasi: [_____]  │
              │  Ket.: [________] │
              │                   │
              │ [Batal] [Simpan]  │
              └───────────────────┘
                      │
                  ┌───┴────┐
               Valid    Invalid
                  │       │
                  ▼       ▼
            ┌─────────┐ ┌─────────────┐
            │ Simpan  │ │ Tampilkan   │
            │ ke DB   │ │ Error pada  │
            │         │ │ Field       │
            └────┬────┘ └─────────────┘
                 │
                 ▼
            ┌─────────┐
            │ Toast:  │
            │ Sukses! │
            │ Refresh │
            │ Tabel   │
            └─────────┘
```

### 10.3 Flow Cetak Laporan

```
Dashboard → Menu Laporan
     ↓
Halaman Laporan (Tampil ringkasan + tabel lengkap)
     ↓
(Opsional) Pilih filter: kategori / kondisi
     ↓
Klik tombol "🖨️ Cetak Laporan"
     ↓
Browser print dialog terbuka (tampilan sudah diformat print-friendly)
     ↓
Pilih printer / Save as PDF → Selesai
```

---

## 11. Arsitektur & Kebutuhan Teknis

### 11.1 Diagram Arsitektur Sistem

```
┌─────────────────────────────────────────────────────────────────┐
│                        USER (Browser)                            │
│              Chrome / Firefox / Safari / Edge                    │
└───────────────────────────┬─────────────────────────────────────┘
                            │ HTTPS
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│                    VERCEL (Frontend Hosting)                      │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │                   ASTRO 4.x (SSR/SSG)                     │  │
│  │  ┌─────────────┐  ┌──────────────┐  ┌─────────────────┐  │  │
│  │  │   Pages     │  │  Layouts     │  │  Components     │  │  │
│  │  │  (Routing)  │  │  (Templates) │  │  (UI Elements)  │  │  │
│  │  └─────────────┘  └──────────────┘  └─────────────────┘  │  │
│  │  ┌─────────────┐  ┌──────────────┐  ┌─────────────────┐  │  │
│  │  │  Middleware  │  │  Lib/        │  │  Types/         │  │  │
│  │  │  (Auth Guard)│  │  (Supabase)  │  │  (TypeScript)   │  │  │
│  │  └─────────────┘  └──────────────┘  └─────────────────┘  │  │
│  │                                                           │  │
│  │  Styling: Tailwind CSS v4                                 │  │
│  └───────────────────────────────────────────────────────────┘  │
└───────────────────────────┬─────────────────────────────────────┘
                            │ HTTPS / REST API + Realtime (WebSocket)
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│                     SUPABASE CLOUD (BaaS)                        │
│  ┌───────────────┐  ┌───────────────┐  ┌────────────────────┐  │
│  │  Supabase     │  │  PostgREST    │  │  Supabase          │  │
│  │  Auth (GoTrue)│  │  (REST API)   │  │  Realtime (WS)     │  │
│  │  • JWT Token  │  │  • Auto CRUD  │  │  • Live Subscr.    │  │
│  │  • Session Mgmt│  │  • Filtering │  │  • Change Events   │  │
│  └───────────────┘  └───────────────┘  └────────────────────┘  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │              PostgreSQL Database                         │   │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌─────────┐ │   │
│  │  │ kategori │  │  barang  │  │ RLS      │  │ Triggers│ │   │
│  │  │          │◄─┤          │  │ Policies │  │         │ │   │
│  │  └──────────┘  └──────────┘  └──────────┘  └─────────┘ │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

### 11.2 Technology Stack Detail

#### Frontend

| Teknologi | Versi | Fungsi | Justifikasi |
|-----------|-------|--------|-------------|
| **Astro** | ≥ 4.x | Framework utama (SSR/SSG) | Zero JS by default, performa tinggi, cocok untuk aplikasi interaktif ringan |
| **Tailwind CSS** | v4 | Utility-first CSS framework | Rapid UI development, konsistensi desain, ukuran bundle kecil |
| **TypeScript** | ≥ 5.x | Type safety | Mengurangi runtime error, IDE support, maintainability |
| **Supabase JS** | ≥ 2.x | Client SDK Supabase | Official SDK, real-time support, type-safe queries |

#### Backend (BaaS)

| Layanan | Fungsi | Free Tier Limit |
|---------|--------|-----------------|
| **Supabase Auth** | Autentikasi JWT | 50.000 MAU |
| **Supabase Database** | PostgreSQL terkelola | 500MB storage |
| **Supabase REST API** | Auto-generated CRUD | Unlimited requests |
| **Supabase Realtime** | WebSocket subscriptions | 200 concurrent connections |

#### Infrastructure & DevOps

| Alat | Fungsi | Tier |
|------|--------|------|
| **Vercel** | Frontend hosting, CI/CD, preview deployments | Free (Hobby) |
| **Supabase Cloud** | Database & backend hosting | Free |
| **GitHub** | Version control, source of truth | Free |
| **GitHub Actions** *(opsional)* | CI pipeline: lint, type-check | Free (2000 min/month) |

### 11.3 Struktur Direktori Proyek

```
lamaholot-inventory-system/
├── src/
│   ├── components/              # Komponen UI reusable
│   │   ├── auth/
│   │   │   └── LoginForm.astro  # Form login
│   │   ├── barang/
│   │   │   ├── BarangTable.astro     # Tabel daftar barang
│   │   │   ├── BarangForm.astro      # Form tambah/edit (reusable)
│   │   │   ├── BarangFilter.astro    # Search + filter controls
│   │   │   └── BarangDeleteDialog.astro  # Konfirmasi hapus
│   │   ├── kategori/
│   │   │   ├── KategoriList.astro    # Daftar kategori
│   │   │   └── KategoriForm.astro    # Form tambah/edit kategori
│   │   ├── laporan/
│   │   │   ├── LaporanSummary.astro  # Ringkasan statistik
│   │   │   └── LaporanTable.astro    # Tabel laporan print-ready
│   │   └── shared/
│   │       ├── Navbar.astro          # Navigasi utama
│   │       ├── Sidebar.astro         # *(opsional) Sidebar navigasi*
│   │       ├── Button.astro          # Tombol reusable
│   │       ├── Modal.astro           # Modal dialog
│   │       ├── Toast.astro           # Toast notification
│   │       ├── Badge.astro           # Badge kondisi
│   │       ├── Card.astro            # Card component
│   │       ├── EmptyState.astro      # Empty state component
│   │       ├── LoadingSpinner.astro  # Loading indicator
│   │       └── Pagination.astro      # Navigasi halaman
│   ├── layouts/
│   │   ├── MainLayout.astro     # Layout utama dengan navbar
│   │   ├── AuthLayout.astro     # Layout halaman login (tanpa navbar)
│   │   └── PrintLayout.astro    # Layout khusus cetak
│   ├── pages/
│   │   ├── index.astro          # Redirect → /dashboard atau /login
│   │   ├── login.astro          # Halaman login
│   │   ├── dashboard.astro      # Halaman dashboard
│   │   ├── barang/
│   │   │   └── index.astro      # Halaman daftar + CRUD barang
│   │   ├── kategori.astro       # Halaman manajemen kategori
│   │   └── laporan.astro        # Halaman laporan + cetak
│   ├── middleware/
│   │   └── index.ts             # Auth guard middleware
│   ├── lib/
│   │   ├── supabase.ts          # Inisialisasi & konfigurasi Supabase client
│   │   ├── auth.ts              # Helper functions autentikasi
│   │   ├── queries.ts           # Database query functions (reusable)
│   │   └── helpers.ts           # Utilitas umum (format tanggal, dll.)
│   ├── types/
│   │   └── index.ts             # TypeScript type & interface definitions
│   └── styles/
│       └── print.css            # Print-specific styles
├── public/
│   ├── favicon.svg              # Favicon
│   └── logo-lamaholot.png       # Logo sekolah (untuk kop surat cetak)
├── supabase/
│   ├── migrations/
│   │   ├── 001_create_tables.sql     # DDL: tabel & tipe
│   │   ├── 002_create_rls.sql        # RLS policies
│   │   ├── 003_create_indexes.sql    # Database indexes
│   │   ├── 004_create_triggers.sql   # Triggers (updated_at)
│   │   └── 005_seed_data.sql         # Data awal (kategori)
│   └── config.toml              # Supabase project config
├── .env.example                 # Template environment variables
├── .gitignore                   # Git ignore rules
├── astro.config.mjs             # Konfigurasi Astro
├── tailwind.config.mjs          # Konfigurasi Tailwind CSS
├── tsconfig.json                # TypeScript config
├── package.json                 # Dependencies & scripts
└── README.md                    # Dokumentasi proyek
```

### 11.4 Environment Variables

```env
# .env.example
# ──────────────────────────────────────────────────
# Supabase Configuration
# ──────────────────────────────────────────────────
PUBLIC_SUPABASE_URL=https://<project-ref>.supabase.co
PUBLIC_SUPABASE_ANON_KEY=<your-anon-key>

# ──────────────────────────────────────────────────
# App Configuration
# ──────────────────────────────────────────────────
PUBLIC_APP_NAME="Inventaris SD Lamaholot"
PUBLIC_APP_VERSION="1.0.0"
```

> **⚠️ Catatan Keamanan:**
> - Gunakan prefix `PUBLIC_` untuk variabel yang diakses di sisi client pada Astro
> - **Jangan pernah** commit `.env` ke repository
> - **Jangan pernah** gunakan `SUPABASE_SERVICE_ROLE_KEY` di frontend

---

## 12. Desain Database

### 12.1 Entity Relationship Diagram (ERD)

```
┌──────────────────────────┐            ┌────────────────────────────────────┐
│        kategori           │            │              barang                │
├──────────────────────────┤            ├────────────────────────────────────┤
│ id          UUID    [PK] │◄───────────│ id             UUID         [PK]  │
│ nama_kategori VARCHAR(100)│    1    N  │ nama_barang    VARCHAR(255)       │
│ created_at  TIMESTAMPTZ  │            │ kategori_id    UUID         [FK]  │
└──────────────────────────┘            │ jumlah         INTEGER            │
                                        │ kondisi        kondisi_barang     │
                                        │ lokasi         VARCHAR(150)       │
                                        │ keterangan     TEXT               │
                                        │ created_at     TIMESTAMPTZ        │
                                        │ updated_at     TIMESTAMPTZ        │
                                        └────────────────────────────────────┘

Relasi: kategori (1) ──── (N) barang
Constraint: ON DELETE RESTRICT (kategori tidak bisa dihapus jika masih punya barang)
```

### 12.2 Definisi Tabel

#### Tabel: `kategori`

| Kolom | Tipe Data | Constraint | Default | Keterangan |
|-------|-----------|------------|---------|------------|
| `id` | `UUID` | PRIMARY KEY | `gen_random_uuid()` | ID unik kategori |
| `nama_kategori` | `VARCHAR(100)` | NOT NULL, UNIQUE | — | Nama kategori, harus unik |
| `created_at` | `TIMESTAMPTZ` | NOT NULL | `now()` | Timestamp pembuatan |

#### Tabel: `barang`

| Kolom | Tipe Data | Constraint | Default | Keterangan |
|-------|-----------|------------|---------|------------|
| `id` | `UUID` | PRIMARY KEY | `gen_random_uuid()` | ID unik barang |
| `nama_barang` | `VARCHAR(255)` | NOT NULL | — | Nama barang |
| `kategori_id` | `UUID` | NOT NULL, FK → `kategori.id` | — | Referensi ke kategori |
| `jumlah` | `INTEGER` | NOT NULL, CHECK ≥ 0 | — | Jumlah unit barang |
| `kondisi` | `kondisi_barang` (ENUM) | NOT NULL | — | Kondisi: Baik / Rusak Ringan / Rusak Berat |
| `lokasi` | `VARCHAR(150)` | NOT NULL | — | Lokasi penyimpanan |
| `keterangan` | `TEXT` | NULLABLE | — | Catatan tambahan (opsional) |
| `created_at` | `TIMESTAMPTZ` | NOT NULL | `now()` | Timestamp pembuatan |
| `updated_at` | `TIMESTAMPTZ` | NOT NULL | `now()` | Timestamp terakhir diperbarui |

### 12.3 SQL Migration Scripts

#### 001_create_tables.sql

```sql
-- =============================================
-- Migration 001: Create Tables
-- SD Lamaholot Inventory System
-- =============================================

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

-- Comment on tables
COMMENT ON TABLE kategori IS 'Tabel kategori barang inventaris';
COMMENT ON TABLE barang IS 'Tabel utama data barang inventaris';
```

#### 002_create_rls.sql

```sql
-- =============================================
-- Migration 002: Row Level Security Policies
-- =============================================

-- Aktifkan RLS pada semua tabel
ALTER TABLE kategori ENABLE ROW LEVEL SECURITY;
ALTER TABLE barang ENABLE ROW LEVEL SECURITY;

-- Policy: authenticated users can SELECT
CREATE POLICY "Authenticated users can view kategori"
  ON kategori FOR SELECT
  TO authenticated
  USING (true);

-- Policy: authenticated users can INSERT
CREATE POLICY "Authenticated users can insert kategori"
  ON kategori FOR INSERT
  TO authenticated
  WITH CHECK (true);

-- Policy: authenticated users can UPDATE
CREATE POLICY "Authenticated users can update kategori"
  ON kategori FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Policy: authenticated users can DELETE
CREATE POLICY "Authenticated users can delete kategori"
  ON kategori FOR DELETE
  TO authenticated
  USING (true);

-- Repeat for barang table
CREATE POLICY "Authenticated users can view barang"
  ON barang FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Authenticated users can insert barang"
  ON barang FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can update barang"
  ON barang FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Authenticated users can delete barang"
  ON barang FOR DELETE
  TO authenticated
  USING (true);
```

#### 003_create_indexes.sql

```sql
-- =============================================
-- Migration 003: Database Indexes
-- Optimasi query yang sering digunakan
-- =============================================

-- Index pada nama_barang untuk pencarian
CREATE INDEX IF NOT EXISTS idx_barang_nama
  ON barang (nama_barang);

-- Index pada kategori_id untuk JOIN dan filter
CREATE INDEX IF NOT EXISTS idx_barang_kategori
  ON barang (kategori_id);

-- Index pada kondisi untuk filter
CREATE INDEX IF NOT EXISTS idx_barang_kondisi
  ON barang (kondisi);

-- Composite index untuk filter kombinasi (kategori + kondisi)
CREATE INDEX IF NOT EXISTS idx_barang_kategori_kondisi
  ON barang (kategori_id, kondisi);

-- Index pada created_at untuk sorting (barang terbaru)
CREATE INDEX IF NOT EXISTS idx_barang_created_at
  ON barang (created_at DESC);

-- Index trigram untuk pencarian ILIKE (opsional, butuh extension)
-- CREATE EXTENSION IF NOT EXISTS pg_trgm;
-- CREATE INDEX IF NOT EXISTS idx_barang_nama_trgm
--   ON barang USING GIN (nama_barang gin_trgm_ops);
```

#### 004_create_triggers.sql

```sql
-- =============================================
-- Migration 004: Triggers
-- =============================================

-- Function: auto-update updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger: set updated_at on barang update
CREATE TRIGGER set_barang_updated_at
  BEFORE UPDATE ON barang
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at();
```

#### 005_seed_data.sql

```sql
-- =============================================
-- Migration 005: Seed Data
-- Data awal kategori untuk SD Lamaholot
-- =============================================

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
```

### 12.4 TypeScript Type Definitions

```typescript
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
```

---

## 13. API & Integrasi

### 13.1 Supabase API Endpoints (Auto-generated)

Semua endpoint di bawah ini otomatis tersedia melalui PostgREST Supabase:

| Metode | Endpoint | Deskripsi | Digunakan di |
|--------|----------|-----------|-------------|
| `GET` | `/rest/v1/barang` | Ambil semua barang | Halaman Barang, Laporan |
| `GET` | `/rest/v1/barang?id=eq.{id}` | Ambil barang by ID | Form Edit |
| `POST` | `/rest/v1/barang` | Tambah barang baru | Form Tambah |
| `PATCH` | `/rest/v1/barang?id=eq.{id}` | Update barang | Form Edit |
| `DELETE` | `/rest/v1/barang?id=eq.{id}` | Hapus barang | Tombol Hapus |
| `GET` | `/rest/v1/kategori` | Ambil semua kategori | Dropdown, Halaman Kategori |
| `POST` | `/rest/v1/kategori` | Tambah kategori | Form Tambah Kategori |
| `PATCH` | `/rest/v1/kategori?id=eq.{id}` | Update kategori | Form Edit Kategori |
| `DELETE` | `/rest/v1/kategori?id=eq.{id}` | Hapus kategori | Tombol Hapus Kategori |

### 13.2 Query Patterns (Supabase JS Client)

```typescript
// Contoh query yang akan digunakan di aplikasi

// 1. Ambil barang dengan join kategori + filter + pagination
const { data, count } = await supabase
  .from('barang')
  .select('*, kategori(nama_kategori)', { count: 'exact' })
  .ilike('nama_barang', `%${search}%`)
  .eq('kategori_id', kategoriId)       // conditional
  .eq('kondisi', kondisi)              // conditional
  .order('created_at', { ascending: false })
  .range(offset, offset + pageSize - 1);

// 2. Dashboard stats
const { count: totalBarang } = await supabase
  .from('barang')
  .select('*', { count: 'exact', head: true });

const { count: kondisiBaik } = await supabase
  .from('barang')
  .select('*', { count: 'exact', head: true })
  .eq('kondisi', 'Baik');

// 3. Kategori dengan count barang
const { data: kategoris } = await supabase
  .from('kategori')
  .select('*, barang(count)');

// 4. Realtime subscription
const channel = supabase
  .channel('barang-changes')
  .on('postgres_changes', { event: '*', schema: 'public', table: 'barang' },
    (payload) => { /* refresh data */ }
  )
  .subscribe();
```

---

## 14. Keamanan

### 14.1 Authentication & Session Management

| Aspek | Implementasi |
|-------|-------------|
| Metode autentikasi | Supabase Auth — email/password (GoTrue) |
| Token storage | Cookie `httpOnly` (lebih aman daripada localStorage) |
| Session expiry | 7 hari (konfigurasi di Supabase Auth settings) |
| Route protection | Astro middleware — cek token pada setiap request ke halaman terproteksi |
| Logout | Clear cookies + `supabase.auth.signOut()` + redirect ke /login |

### 14.2 Row Level Security (RLS) — Defense in Depth

RLS wajib aktif pada semua tabel. Ini adalah **lapisan keamanan terakhir** — bahkan jika frontend dimanipulasi, data tidak dapat diakses tanpa autentikasi valid.

| Tabel | Policy | Akses |
|-------|--------|-------|
| `kategori` | `authenticated_select`, `authenticated_insert`, `authenticated_update`, `authenticated_delete` | Semua operasi hanya untuk user terautentikasi |
| `barang` | `authenticated_select`, `authenticated_insert`, `authenticated_update`, `authenticated_delete` | Semua operasi hanya untuk user terautentikasi |

> **⚠️ PENTING:** Selalu pisahkan policy per operasi (SELECT, INSERT, UPDATE, DELETE) — hindari menggunakan `FOR ALL` agar lebih mudah di-debug dan di-audit.

### 14.3 Input Validation — Defense Layers

| Layer | Validasi | Implementasi |
|-------|----------|-------------|
| **Client-side** | Form validation | HTML5 `required`, `min`, `maxlength` + JavaScript validation |
| **API-level** | Type checking | Supabase auto-validates berdasarkan tipe kolom |
| **Database-level** | Constraints | NOT NULL, CHECK, UNIQUE, FOREIGN KEY, ENUM |

**Validasi spesifik:**
- `nama_barang`: min 3, max 255 karakter, sanitize HTML entities
- `jumlah`: integer ≥ 0, no decimal
- `kondisi`: hanya menerima value dari ENUM `kondisi_barang`
- `lokasi`: min 2, max 150 karakter
- `nama_kategori`: min 2, max 100 karakter, unique (case-insensitive)

### 14.4 XSS Prevention

- Semua user input di-render menggunakan text interpolation (bukan `innerHTML`)
- Astro secara default melakukan HTML escaping pada template expressions
- Content Security Policy (CSP) headers di-set via Vercel config

### 14.5 Environment Security

- API keys di environment variables, **tidak pernah di-hardcode**
- `.env` di `.gitignore` — tidak pernah di-commit
- Hanya gunakan `anon key` di frontend — **bukan `service_role key`**
- `service_role key` hanya digunakan di server-side jika dibutuhkan

---

## 15. UI/UX Guidelines & Wireframe

### 15.1 Design Principles

| Prinsip | Penjelasan | Implementasi |
|---------|------------|-------------|
| **Clarity** | Tampilan bersih, minimalis, fokus pada data | White space yang cukup, hierarki visual jelas |
| **Consistency** | Komponen seragam di semua halaman | Design token: warna, font, spacing, radius |
| **Feedback** | Setiap aksi mendapat respons visual | Loading state, toast notification, error message, disabled state |
| **Forgiveness** | Kesalahan mudah dibatalkan | Konfirmasi dialog sebelum hapus, form state preserved |
| **Accessibility** | Dapat digunakan oleh semua orang | WCAG AA compliance, keyboard navigation, semantic HTML |

### 15.2 Design Tokens

#### Colors

| Token | Hex | Penggunaan |
|-------|-----|------------|
| `--color-primary` | `#2563EB` | Tombol utama, link, aksen |
| `--color-primary-hover` | `#1D4ED8` | Hover state tombol utama |
| `--color-success` | `#16A34A` | Badge "Baik", toast sukses |
| `--color-warning` | `#D97706` | Badge "Rusak Ringan", alert |
| `--color-danger` | `#DC2626` | Badge "Rusak Berat", tombol hapus, error |
| `--color-bg-primary` | `#F8FAFC` | Background halaman |
| `--color-bg-card` | `#FFFFFF` | Background card & modal |
| `--color-bg-sidebar` | `#1E293B` | Background sidebar/navbar (dark) |
| `--color-text-primary` | `#1E293B` | Teks utama |
| `--color-text-secondary` | `#64748B` | Teks sekunder, placeholder |
| `--color-border` | `#E2E8F0` | Border tabel, card, input |

#### Typography

| Token | Value | Penggunaan |
|-------|-------|------------|
| `--font-family` | `'Inter', system-ui, sans-serif` | Font utama |
| `--font-size-xs` | `0.75rem` (12px) | Badge text, label kecil |
| `--font-size-sm` | `0.875rem` (14px) | Body text tabel |
| `--font-size-base` | `1rem` (16px) | Body text umum |
| `--font-size-lg` | `1.125rem` (18px) | Sub-heading |
| `--font-size-xl` | `1.25rem` (20px) | Card title |
| `--font-size-2xl` | `1.5rem` (24px) | Page title |
| `--font-size-3xl` | `1.875rem` (30px) | Dashboard numbers |

#### Spacing & Sizing

| Token | Value |
|-------|-------|
| `--radius-sm` | `4px` |
| `--radius-md` | `8px` |
| `--radius-lg` | `12px` |
| `--radius-full` | `9999px` |
| `--shadow-sm` | `0 1px 2px rgba(0,0,0,0.05)` |
| `--shadow-md` | `0 4px 6px rgba(0,0,0,0.07)` |
| `--shadow-lg` | `0 10px 15px rgba(0,0,0,0.1)` |

### 15.3 Komponen UI

| Komponen | Deskripsi | Interaksi |
|----------|-----------|-----------|
| **Navbar** | Navigasi utama horizontal, nama sekolah, menu, user info, logout | Sticky top, responsive (hamburger di mobile) |
| **Sidebar** *(opsional)* | Navigasi vertikal di desktop | Collapsible, icon + label |
| **DataTable** | Tabel data dengan header sortable | Hover highlight, zebra striping |
| **Modal** | Dialog overlay untuk form tambah/edit | Focus trap, close on Escape, close on backdrop click |
| **Toast** | Notifikasi floating di pojok kanan atas | Auto-dismiss 3 detik, dismissable manual |
| **Badge** | Label status dengan warna | Tidak interaktif |
| **SearchBar** | Input pencarian dengan ikon 🔍 | Debounce 300ms, clear button (×) |
| **Button** | Tombol aksi (variants: primary, secondary, danger, ghost) | Loading state (spinner + disabled) |
| **Card** | Container dengan shadow | Hover effect subtle (desktop) |
| **EmptyState** | Placeholder saat tidak ada data | Ikon + pesan + CTA button |
| **LoadingSpinner** | Indikator loading | Skeleton loading untuk tabel |
| **Pagination** | Navigasi halaman tabel | Prev/Next + nomor halaman |

### 15.4 Responsivitas

| Breakpoint | Layout | Navigasi | Tabel |
|------------|--------|----------|-------|
| **Desktop** (≥ 1024px) | Full layout, sidebar visible | Sidebar + navbar | Tabel penuh |
| **Tablet** (768–1023px) | Fluid layout | Navbar + hamburger menu | Tabel scroll horizontal |
| **Mobile** (< 768px) | Single column | Navbar + hamburger menu | Card view (stacked) |

### 15.5 Page Wireframes

#### Halaman Login

```
┌─────────────────────────────────────────────┐
│                                             │
│              ┌───────────────┐              │
│              │   🏫 Logo     │              │
│              │ SD LAMAHOLOT  │              │
│              │               │              │
│              │ Sistem        │              │
│              │ Inventaris    │              │
│              │               │              │
│              │ Email:        │              │
│              │ [___________] │              │
│              │               │              │
│              │ Password:     │              │
│              │ [___________] │              │
│              │               │              │
│              │ [   Login   ] │              │
│              │               │              │
│              │ ⚠ Error msg   │              │
│              │               │              │
│              └───────────────┘              │
│                                             │
│      © 2026 SD Lamaholot                    │
└─────────────────────────────────────────────┘
```

#### Halaman Barang (Desktop)

```
┌─────────────────────────────────────────────────────────────────┐
│  🏫 SD Lamaholot Inventaris    Dashboard | Barang | Kategori |  │
│                                     Laporan  |  [Logout]       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  📦 Daftar Barang                         [+ Tambah Barang]    │
│                                                                 │
│  ┌──────────────┐ ┌─────────────────┐ ┌──────────────────┐     │
│  │🔍 Cari barang│ │▼ Semua Kategori │ │▼ Semua Kondisi   │     │
│  └──────────────┘ └─────────────────┘ └──────────────────┘     │
│                                                                 │
│  Menampilkan 1-10 dari 234 barang                              │
│  ┌────┬──────────────┬──────────┬─────┬──────────┬──────┬────┐ │
│  │ No │ Nama Barang  │ Kategori │ Jml │ Kondisi  │ Lok  │Aksi│ │
│  ├────┼──────────────┼──────────┼─────┼──────────┼──────┼────┤ │
│  │  1 │ Meja Guru    │ Mebeler  │  10 │🟢 Baik   │ R.1  │✏🗑│ │
│  │  2 │ Kursi Siswa  │ Mebeler  │  60 │🟢 Baik   │ R.2  │✏🗑│ │
│  │  3 │ Laptop ASUS  │ Elektro. │   2 │🟡 R.Rin. │ TU   │✏🗑│ │
│  │  4 │ Proyektor    │ Elektro. │   1 │🔴 R.Bert │ Gudg │✏🗑│ │
│  │ ...│              │          │     │          │      │    │ │
│  └────┴──────────────┴──────────┴─────┴──────────┴──────┴────┘ │
│                                                                 │
│                        [◀ 1 2 3 ... 24 ▶]                      │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 16. Strategi Testing

### 16.1 Test Levels

| Level | Tipe | Tools | Coverage Target |
|-------|------|-------|-----------------|
| Unit | Fungsi utilitas, helpers, formatters | Vitest | ≥ 80% |
| Integration | API calls, Supabase queries | Vitest + Supabase local | Semua endpoint |
| E2E | Flow utama user | Playwright *(opsional v1.1)* | Critical paths |
| Manual | Visual, responsif, print | Browser inspection | Semua halaman |

### 16.2 Test Scenarios (Manual Testing Checklist)

#### Autentikasi

| # | Skenario | Expected Result | Status |
|---|----------|-----------------|--------|
| 1 | Login dengan email & password valid | Redirect ke dashboard | ☐ |
| 2 | Login dengan email salah | Error: "Email atau password salah" | ☐ |
| 3 | Login dengan password salah | Error: "Email atau password salah" | ☐ |
| 4 | Login dengan field kosong | Validasi HTML5 mencegah submit | ☐ |
| 5 | Akses /dashboard tanpa login | Redirect ke /login | ☐ |
| 6 | Akses /barang tanpa login | Redirect ke /login | ☐ |
| 7 | Logout | Redirect ke /login, sesi berakhir | ☐ |
| 8 | Kembali ke dashboard setelah logout (back button) | Tetap di /login | ☐ |

#### CRUD Barang

| # | Skenario | Expected Result | Status |
|---|----------|-----------------|--------|
| 9 | Tambah barang dengan semua field valid | Data muncul di tabel, toast sukses | ☐ |
| 10 | Tambah barang dengan nama < 3 karakter | Error validasi pada field nama | ☐ |
| 11 | Tambah barang dengan jumlah negatif | Error validasi pada field jumlah | ☐ |
| 12 | Tambah barang tanpa pilih kategori | Error validasi pada field kategori | ☐ |
| 13 | Edit barang — ubah nama | Nama terupdate di tabel | ☐ |
| 14 | Edit barang — ubah kondisi | Kondisi & badge terupdate | ☐ |
| 15 | Hapus barang — klik Batal di dialog | Data tidak terhapus | ☐ |
| 16 | Hapus barang — klik Konfirmasi | Data terhapus, toast sukses | ☐ |

#### Pencarian & Filter

| # | Skenario | Expected Result | Status |
|---|----------|-----------------|--------|
| 17 | Ketik "meja" di search bar | Hanya barang dengan nama mengandung "meja" | ☐ |
| 18 | Pilih kategori "Elektronik" | Hanya barang kategori Elektronik | ☐ |
| 19 | Pilih kondisi "Rusak Berat" | Hanya barang kondisi Rusak Berat | ☐ |
| 20 | Kombinasi: search "laptop" + kondisi "Baik" | Barang nama "laptop" dengan kondisi Baik | ☐ |
| 21 | Search tanpa hasil | Empty state ditampilkan | ☐ |
| 22 | Reset filter (pilih "Semua") | Semua barang ditampilkan | ☐ |

#### Dashboard

| # | Skenario | Expected Result | Status |
|---|----------|-----------------|--------|
| 23 | Buka dashboard | Statistik akurat (total, per kondisi) | ☐ |
| 24 | Tambah barang baru | Dashboard stats terupdate | ☐ |
| 25 | Edit kondisi barang | Angka per kondisi terupdate | ☐ |

#### Laporan & Cetak

| # | Skenario | Expected Result | Status |
|---|----------|-----------------|--------|
| 26 | Buka halaman laporan | Data lengkap ditampilkan | ☐ |
| 27 | Klik "Cetak" | Print dialog terbuka, layout rapi | ☐ |
| 28 | Filter laporan by kategori | Laporan hanya menampilkan kategori terpilih | ☐ |

#### Responsivitas

| # | Skenario | Expected Result | Status |
|---|----------|-----------------|--------|
| 29 | Akses di viewport mobile (375px) | Layout mobile, tabel jadi card | ☐ |
| 30 | Akses di viewport tablet (768px) | Layout tablet, tabel scroll horizontal | ☐ |
| 31 | Akses di viewport desktop (1280px) | Layout penuh | ☐ |

### 16.3 Performance Testing

| Test | Tool | Target |
|------|------|--------|
| Lighthouse Performance | Chrome DevTools | Score ≥ 90 |
| Lighthouse Accessibility | Chrome DevTools | Score ≥ 90 |
| Page load time (3G) | Chrome DevTools Network Throttling | < 5 detik |
| API response time | Supabase Dashboard → Logs | < 2 detik |

---

## 17. Deployment & Release Plan

### 17.1 Environment Strategy

| Environment | URL | Purpose | Auto Deploy |
|-------------|-----|---------|-------------|
| **Development** | `localhost:4321` | Pengembangan lokal | — |
| **Preview** | `pr-xxx.vercel.app` | Review per Pull Request | ✅ (tiap PR) |
| **Production** | `inventaris-lamaholot.vercel.app` | Produksi (live) | ✅ (merge ke `main`) |

### 17.2 Deployment Pipeline

```
┌──────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│ git push │────▶│ Vercel Build │────▶│ Preview URL  │────▶│ Merge to     │
│ (branch) │     │ (auto)       │     │ (auto)       │     │ main         │
└──────────┘     └──────────────┘     └──────────────┘     └──────┬───────┘
                                                                  │
                                                                  ▼
                                                           ┌──────────────┐
                                                           │ Production   │
                                                           │ Deploy (auto)│
                                                           └──────────────┘
```

### 17.3 Pre-Production Checklist

| # | Item | Status |
|---|------|--------|
| 1 | Semua test pass | ☐ |
| 2 | RLS policies sudah benar (test via Supabase Policy Tester) | ☐ |
| 3 | Environment variables set di Vercel | ☐ |
| 4 | Admin account sudah dibuat di Supabase Auth | ☐ |
| 5 | Seed data kategori sudah dijalankan | ☐ |
| 6 | Lighthouse score ≥ 90 (4 kategori) | ☐ |
| 7 | Responsif diuji di 3 viewport (mobile, tablet, desktop) | ☐ |
| 8 | Print layout diuji | ☐ |
| 9 | `.env` tidak ter-commit (cek .gitignore) | ☐ |
| 10 | Custom domain di-set *(opsional)* | ☐ |

### 17.4 Go-Live Steps

1. **Setup Supabase project** (production) → Catat `URL` dan `ANON_KEY`
2. **Jalankan migration SQL** secara berurutan (001–005)
3. **Buat admin account** di Supabase Auth → Dashboard → Authentication → Users
4. **Set environment variables** di Vercel → Project Settings → Environment Variables
5. **Deploy ke production** → Merge branch ke `main`
6. **Verifikasi** → Login, coba semua fitur, cek data
7. **Training user** → Demo ke Staff TU
8. **Handover** → Berikan akses login + dokumentasi

### 17.5 Data Migration Plan (Manual → Digital)

| Step | Aksi | PIC | Estimasi Waktu |
|------|------|-----|---------------|
| 1 | Inventarisasi buku catatan dan spreadsheet lama | Staff TU | 1 hari |
| 2 | Standardisasi format data (nama, kategori, kondisi) | Staff TU + Tim Dev | 1 hari |
| 3 | Input data ke sistem (manual entry atau bulk CSV import di v1.1) | Staff TU | 2–3 hari |
| 4 | Cross-check: data digital vs data fisik | Staff TU | 1 hari |
| 5 | Sign-off: data migrasi dinyatakan valid | Kepala Sekolah | — |

---

## 18. Monitoring & Observability

### 18.1 Monitoring Stack

| Aspek | Tool | Metrik |
|-------|------|--------|
| **Frontend Performance** | Vercel Analytics (built-in) | Core Web Vitals, page views, traffic |
| **Backend Health** | Supabase Dashboard | Database size, API requests, auth events |
| **Error Tracking** | Browser Console + Supabase Logs | Runtime errors, failed queries |
| **Uptime** | Supabase Status Page + Vercel Status | Service availability |

### 18.2 Alerts

| Event | Severity | Response |
|-------|----------|----------|
| Supabase database approaching 500MB limit | Warning | Evaluate data, consider plan upgrade |
| Build fail di Vercel | High | Fix error, re-deploy |
| Login failure spike | Medium | Cek apakah ada serangan brute-force |
| API error rate > 5% | High | Investigate query errors di Supabase Logs |

---

## 19. Batasan Sistem

| # | Batasan | Dampak | Mitigasi |
|---|---------|--------|----------|
| 1 | Memerlukan koneksi internet aktif | Tidak bisa diakses offline | Tampilkan pesan informatif saat offline |
| 2 | V1.0: Single admin (satu akun) | Tidak ada pembagian hak akses | Multi-role di v2.0 |
| 3 | Tidak ada upload foto barang (v1.0) | Identifikasi barang terbatas | Foto barang di v2.0 (Supabase Storage) |
| 4 | Tidak ada fitur undo/pemulihan data setelah hapus | Risiko kehilangan data | Konfirmasi dialog + soft delete di v1.1 |
| 5 | Free tier Supabase: 500MB database storage | Batas kapasitas | Cukup untuk ~100.000 record teks; upgrade jika perlu |
| 6 | Free tier Vercel: 100GB bandwidth/bulan | Batas traffic | Sangat cukup untuk skala SD (< 10 user aktif) |
| 7 | Tidak ada integrasi ke sistem lain | Standalone system | API-ready architecture, integrasi di v3.0 |

---

## 20. Risiko & Mitigasi

| ID | Risiko | Probabilitas | Dampak | Level | Mitigasi | PIC |
|----|--------|-------------|--------|-------|----------|-----|
| R-01 | RLS salah konfigurasi → data bocor | Rendah | Kritis | 🔴 Tinggi | Test RLS via Supabase Policy Tester; review sebelum deploy | Developer |
| R-02 | User lupa password → terkunci dari sistem | Sedang | Tinggi | 🟡 Sedang | Dokumentasi reset via Supabase Auth dashboard; pertimbangkan fitur forgot password v1.1 | Developer + Admin |
| R-03 | Data hilang akibat hapus tidak sengaja | Sedang | Tinggi | 🟡 Sedang | Konfirmasi dialog; soft delete di v1.1; Supabase auto-backup (Point-in-Time Recovery di paid plan) | Developer |
| R-04 | Koneksi internet tidak stabil di sekolah | Tinggi | Sedang | 🟡 Sedang | Optimasi query, error handling graceful, pertimbangkan PWA offline mode di v3.0 | Developer |
| R-05 | User resistance (tidak mau pakai sistem baru) | Sedang | Tinggi | 🟡 Sedang | Training hands-on, UI sederhana & familiar, pendampingan bulan pertama | Tim Dev + Kepsek |
| R-06 | Supabase free tier down / rate limited | Rendah | Sedang | 🟢 Rendah | Monitor Supabase status; architektur siap migrasi ke paid plan | Developer |
| R-07 | Data migrasi dari buku ke sistem mengandung error | Sedang | Sedang | 🟡 Sedang | Proses input bertahap + cross-check; validasi input ketat | Staff TU |
| R-08 | Performa lambat saat data > 5000 record | Rendah | Rendah | 🟢 Rendah | Database indexing sudah disiapkan; pagination; query optimization | Developer |

---

## 21. Kriteria Penerimaan (Acceptance Criteria)

Sistem dinyatakan **siap digunakan (production-ready)** jika memenuhi **SEMUA** kriteria berikut:

### ✅ Autentikasi

- [ ] Login dengan email & password valid → berhasil masuk ke dashboard
- [ ] Login dengan kredensial salah → pesan error berbahasa Indonesia
- [ ] Akses halaman terproteksi tanpa login → redirect ke /login
- [ ] Logout → sesi berakhir, redirect ke /login
- [ ] Back button setelah logout → tidak bisa kembali ke dashboard

### ✅ Dashboard

- [ ] Total barang menampilkan angka yang akurat
- [ ] Statistik per kondisi (Baik, Rusak Ringan, Rusak Berat) akurat
- [ ] Jumlah kategori akurat
- [ ] Quick action buttons navigasi dengan benar
- [ ] Data ter-update setelah operasi CRUD

### ✅ Manajemen Barang

- [ ] Tambah barang valid → data muncul di tabel, toast sukses
- [ ] Tambah barang dengan field kosong → error validasi inline
- [ ] Tambah barang dengan jumlah 0 atau negatif → error validasi
- [ ] Edit barang → modal pre-filled, perubahan tersimpan
- [ ] Hapus barang → dialog konfirmasi muncul, data terhapus setelah konfirmasi
- [ ] Hapus barang → klik Batal → data tidak terhapus

### ✅ Pencarian & Filter

- [ ] Ketik nama → tabel difilter sesuai input (debounce)
- [ ] Pilih filter kategori → hanya barang dalam kategori tersebut
- [ ] Pilih filter kondisi → hanya barang dengan kondisi tersebut
- [ ] Kombinasi filter + search → AND logic berfungsi benar
- [ ] Reset filter → semua data ditampilkan
- [ ] Tidak ada hasil → empty state informatif

### ✅ Manajemen Kategori

- [ ] Tambah kategori → muncul di daftar
- [ ] Tambah kategori duplikat → error "nama sudah digunakan"
- [ ] Hapus kategori tanpa barang → berhasil dihapus
- [ ] Hapus kategori yang punya barang → ditolak dengan pesan informatif
- [ ] Edit kategori → nama terupdate

### ✅ Laporan

- [ ] Halaman laporan memuat data terkini dengan ringkasan statistik
- [ ] Filter laporan berfungsi
- [ ] Fungsi cetak menghasilkan layout print-friendly (kop surat, format rapi)

### ✅ Non-Fungsional

- [ ] Responsif di 3 viewport: mobile, tablet, desktop
- [ ] Lighthouse Performance score ≥ 90
- [ ] Lighthouse Accessibility score ≥ 90
- [ ] Semua operasi CRUD response < 2 detik
- [ ] RLS active & tested — user tanpa login tidak bisa akses data via API langsung

---

## 22. Timeline & Milestones

### 22.1 Project Timeline (6–8 Minggu)

| Minggu | Phase | Deliverables |
|--------|-------|-------------|
| **1** | 🏗️ Setup & Foundation | Project scaffolding, Supabase setup, database migration, design system (token, komponen dasar) |
| **2** | 🔐 Authentication | Halaman login, Supabase Auth integrasi, middleware auth guard, route protection |
| **3** | 📦 Manajemen Barang | CRUD barang (list, tambah, edit, hapus), tabel responsif, modal dialog, validasi, toast |
| **4** | 📂 Kategori & Filter | CRUD kategori, search bar, dropdown filter, kombinasi filter, pagination |
| **5** | 📊 Dashboard & Laporan | Dashboard statistik, halaman laporan, print stylesheet, kop surat |
| **6** | 🎨 Polish | Responsivitas, empty states, loading states, error handling, accessibility, animasi |
| **7** | 🧪 Testing & Fix | Manual testing (semua skenario), bug fixes, Lighthouse audit, review RLS |
| **8** | 🚀 Deploy & Handover | Production deployment, data migrasi, training user, dokumentasi |

### 22.2 Key Milestones

| Milestone | Target | Deliverable |
|-----------|--------|-------------|
| **M1: Foundation Ready** | Akhir Minggu 1 | Project berjalan di localhost, database ready, design system terdefinisi |
| **M2: Auth Complete** | Akhir Minggu 2 | Login/logout berfungsi, route terproteksi |
| **M3: Core CRUD** | Akhir Minggu 4 | CRUD barang + kategori + filter berfungsi penuh |
| **M4: Feature Complete** | Akhir Minggu 5 | Dashboard + laporan + cetak berfungsi |
| **M5: Polish Complete** | Akhir Minggu 6 | UI polished, responsif, accessible |
| **M6: Test Complete** | Akhir Minggu 7 | Semua test pass, Lighthouse ≥ 90 |
| **M7: Go Live** | Akhir Minggu 8 | Production deploy, data migrasi, training selesai |

---

## 23. Maintenance & Support Plan

### 23.1 Post-Launch Support (Bulan 1–3)

| Periode | Aktivitas |
|---------|-----------|
| Minggu 1–2 setelah launch | **Pendampingan aktif** — standby untuk fix critical bugs, bantu user jika ada kendala |
| Minggu 3–4 | **Monitor & stabilize** — pantau error logs, optimasi jika ada bottleneck |
| Bulan 2–3 | **Evaluasi** — kumpulkan feedback user, plan v1.1 improvements |

### 23.2 Regular Maintenance

| Aktivitas | Frekuensi | PIC |
|-----------|-----------|-----|
| Update dependencies (Astro, Tailwind, Supabase JS) | Bulanan | Developer |
| Review Supabase usage & storage | Bulanan | Developer |
| Backup data verification | Bulanan | Developer |
| Security patch review | Saat ada advisory | Developer |
| Feature request review | Per kuartal | Kepsek + Developer |

### 23.3 SLA (Service Level Agreement)

| Severity | Definisi | Response Time | Resolution Time |
|----------|----------|---------------|-----------------|
| **Critical** | Sistem down, data tidak bisa diakses | < 4 jam | < 24 jam |
| **High** | Fitur utama (CRUD) tidak berfungsi | < 8 jam | < 48 jam |
| **Medium** | Fitur pendukung (laporan, filter) bermasalah | < 24 jam | < 1 minggu |
| **Low** | Visual bug, minor UX issue | < 48 jam | < 2 minggu |

---

## 24. Glosarium

| Istilah | Definisi |
|---------|----------|
| **BaaS** | Backend-as-a-Service — layanan backend siap pakai tanpa perlu mengelola server sendiri |
| **RLS** | Row Level Security — mekanisme kontrol akses di level baris pada PostgreSQL |
| **JWT** | JSON Web Token — standar terbuka untuk autentikasi berbasis token |
| **CRUD** | Create, Read, Update, Delete — empat operasi dasar pada data |
| **SSG** | Static Site Generation — halaman di-render saat build time untuk performa tinggi |
| **SSR** | Server-Side Rendering — halaman di-render saat request untuk data dinamis |
| **UUID** | Universally Unique Identifier — format ID unik 128-bit sebagai primary key |
| **Soft Delete** | Penghapusan logis — menandai data sebagai "dihapus" tanpa menghapusnya dari database |
| **Debounce** | Teknik menunda eksekusi fungsi hingga pengguna berhenti mengetik, mengurangi query berlebihan |
| **FCP** | First Contentful Paint — waktu browser pertama kali me-render konten |
| **LCP** | Largest Contentful Paint — waktu elemen terbesar di viewport selesai di-render |
| **WCAG** | Web Content Accessibility Guidelines — standar aksesibilitas web |
| **MoSCoW** | Must/Should/Could/Won't — framework prioritisasi fitur |
| **RACI** | Responsible/Accountable/Consulted/Informed — framework pembagian peran |
| **UAT** | User Acceptance Testing — pengujian oleh pengguna akhir sebelum go-live |
| **CI/CD** | Continuous Integration/Continuous Deployment — otomasi build dan deploy |
| **ERD** | Entity Relationship Diagram — visualisasi struktur dan relasi tabel database |
| **PWA** | Progressive Web App — aplikasi web yang bisa berfungsi seperti app native |
| **CSP** | Content Security Policy — header keamanan untuk mencegah XSS |

---

## 25. Lampiran

### Lampiran A: Referensi Teknis

| Resource | URL |
|----------|-----|
| Astro Documentation | https://docs.astro.build |
| Supabase Documentation | https://supabase.com/docs |
| Tailwind CSS v4 | https://tailwindcss.com/docs |
| Supabase Auth Guide | https://supabase.com/docs/guides/auth |
| Supabase RLS Guide | https://supabase.com/docs/guides/auth/row-level-security |
| Vercel Deployment | https://vercel.com/docs |
| WCAG 2.1 Guidelines | https://www.w3.org/WAI/WCAG21/quickref/ |

### Lampiran B: Informasi Kontak SD Lamaholot

| | Detail |
|---|--------|
| Nama Sekolah | SD Lamaholot |
| NPSN | 20105717 |
| Alamat | Jl. Jagung Raya-Bojong Indah, Rawa Buaya, Cengkareng, Jakarta Barat, DKI Jakarta 11740 |
| Telepon | 021-58356813 |
| Email | sdslamaholot11@gmail.com |
| Yayasan | Yayasan Keluarga Lamaholot |
| Akreditasi | A (SK No. 906/BAN-SM/SK/2019) |

### Lampiran C: Changelog Dokumen

| Versi | Tanggal | Perubahan |
|-------|---------|-----------|
| 1.0.0 | 2025 | Dokumen awal (draft) |
| 2.0.0 | 13 April 2026 | Revisi major: Tambah ringkasan eksekutif, visi-misi, analisis stakeholder, persona, roadmap (v1.0–v3.0), wireframe detail, TypeScript types, migration scripts terpisah, strategi testing lengkap, deployment plan, monitoring, maintenance plan, timeline & milestones, SLA, glosarium diperluas, lampiran |

---

> **📌 Dokumen ini adalah living document.**
> Revisi akan dilakukan seiring perkembangan proyek. Setiap perubahan signifikan harus dicatat di Changelog (Lampiran C).

*Versi: 2.0.0 — SD Lamaholot Inventory System*
*Status: ✅ Final — Siap Eksekusi*
