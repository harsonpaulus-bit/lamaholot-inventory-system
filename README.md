<div align="center">

# 🏫 Sistem Informasi Inventaris SD Lamaholot
**Solusi Digital Manajemen Aset Sekolah yang Terintegrasi, Modern, dan Accountable**

[![Build Status](https://img.shields.io/badge/Status-Live-success.svg)](https://lamaholot-inventory.netlify.app)
[![Tech Stack](https://img.shields.io/badge/Stack-Astro%20|%20Supabase%20|%20Tailwind-blue.svg)](https://astro.build)
[![Deployment](https://img.shields.io/badge/Deploy-Netlify-00AD9F.svg?logo=netlify&logoColor=white)](https://netlify.com)
[![Maintainer](https://img.shields.io/badge/Maintainer-Tim%20IT%20Lamaholot-orange.svg)](https://github.com/harsonpaulus-bit)

---

**Sistem Informasi Inventaris SD Lamaholot** adalah platform berbasis web yang dirancang khusus untuk mendigitalisasi seluruh pencatatan aset (barang) di lingkungan SD Lamaholot, Jakarta Barat. Sistem ini menggantikan proses manual yang lambat dengan database yang tersentralisasi untuk meningkatkan efisiensi operasional dan akuntabilitas pengelolaan aset sekolah.

[🚀 Telusuri Aplikasi Live](https://lamaholot-inventory.netlify.app) • [📖 Dokumentasi Teknis](#-stack-teknologi) • [🏗️ Arsitektur](#-struktur-proyek)

</div>

---

## ✨ Fitur Utama (Core Modules)

Sistem ini dibangun dengan pendekatan **Premium ERP Style** untuk memberikan visibilitas maksimal bagi pengambil keputusan:

- **📊 Smart Dashboard Analitik**: 
  - Visualisasi real-time kondisi aset (Baik/Rusak/Rusak Berat).
  - Grafik tren pertumbuhan aset bulanan.
  - Distribusi barang per kategori secara dinamis.
  - Panel aktivitas terbaru dan aksi cepat (*Quick Actions*).
- **📦 Manajemen Invenraris (Inventory CRUD)**: 
  - Pencatatan barang lengkap dengan nama, jumlah, lokasi, dan deskripsi.
  - Tracking kondisi fisik barang (Baik, Rusak Ringan, Rusak Berat).
- **📂 Manajemen Kategori (Classification)**:
  - Klasifikasi aset yang fleksibel untuk mempermudah pencarian dan audit.
- **🔐 Keamanan & Akses Terpusat**:
  - Autentikasi terintegrasi dengan **Supabase Auth**.
  - Proteksi rute SSR melalui middleware.
- **📄 Pelaporan Terstruktur**:
  - Modul khusus untuk monitoring dan ekspor data aset.

## 🛠️ Stack Teknologi

Sistem dikembangkan menggunakan teknologi mutakhir untuk memastikan performa dan kemudahan pemeliharaan:

| Layer | Teknologi | Peran |
| :--- | :--- | :--- |
| **Frontend Framework** | [Astro 5.x](https://astro.build) | Server-Side Rendering (SSR) & Islands Architecture |
| **Database** | [Supabase (PostgreSQL)](https://supabase.com) | Penyimpanan data relasional & Row Level Security (RLS) |
| **Authentication** | [Supabase Auth](https://supabase.com/auth) | Manajemen sesi pengguna & proteksi rute |
| **Styling** | [Tailwind CSS v3.4](https://tailwindcss.com) | Desain antarmuka responsif & premium |
| **Visualizations** | [Chart.js 4.x](https://www.chartjs.org/) | Grafik analitik interaktif di dashboard |
| **Hosting** | [Netlify](https://www.netlify.com) | Infrastruktur cloud dengan Edge Functions |

## 🏗️ Struktur Proyek (Directory Mapping)

Untuk developer yang akan melanjutkan pengembangan, berikut adalah peta direktori utama:

```text
/
├── src/
│   ├── components/       # Komponen UI Shared (Card, Badge, Button, etc)
│   │   └── shared/       # Komponen atomic yang digunakan global
│   ├── layouts/          # Template utama (Sidebar, Header, Profile)
│   ├── lib/              # Konfigurasi Supabase (createSSRClient & utils)
│   ├── middleware.ts     # Proteksi rute SSR & verifikasi cookie sesi
│   ├── types/            # Definisi TypeScript untuk Barang & Kategori
│   └── pages/            # View/Rute Utama Aplikasi
│       ├── dashboard.astro # Halaman analitik utama
│       ├── barang/         # Modul manajemen barang
│       ├── kategori.astro  # Modul manajemen kategori
│       ├── laporan.astro   # Modul pelaporan
│       └── login.astro     # Gerbang masuk sistem (Auth)
├── supabase/             
│   └── migrations/       # Skema database & SQL Migration files
├── astro.config.mjs      # Konfigurasi adapter Netlify (@astrojs/netlify)
└── tailwind.config.mjs   # Desain system (Colors, Container, Mixins)
```

## 🚀 Memulai (Local Development)

### 1. Prasyarat (Prerequisites)
- **Node.js**: v18.x atau v20.x (direkomendasikan)
- **npm**: v9.x+ atau yarn/pnpm

### 2. Instalasi & Setup
```bash
# 1. Clone repository
git clone https://github.com/harsonpaulus-bit/lamaholot-inventory-system.git

# 2. Masuk ke direktori
cd lamaholot-inventory-system

# 3. Instal dependensi
npm install

# 4. Inisialisasi Environment
cp .env.example .env
```

### 3. Konfigurasi Database
1. Buat project baru di [Supabase Dashboard](https://supabase.com).
2. Jalankan SQL migrations yang ada di folder `supabase/migrations/` di SQL Editor Supabase secara berurutan (001 -> 005).
3. Masukkan `PUBLIC_SUPABASE_URL` dan `PUBLIC_SUPABASE_ANON_KEY` ke file `.env` lokal Anda.

### 4. Menjalankan Server
```bash
npm run dev
```

## ☁️ Deployment (CI/CD)

Proyek ini menggunakan **Netlify** dengan adapter SSR yang dioptimalkan:
- **Build Command**: `npm run build`
- **Publish Directory**: `dist`
- **Adapter**: `@astrojs/netlify` (Otomatis mendeteksi Edge Functions)

Pastikan variabel lingkungan (Environment Variables) sudah disetel di dashboard Netlify agar koneksi Supabase di sisi server berjalan lancar.

---

## 👨‍💻 Panduan Delegasi Developer (Best Practices)

1. **Authentication**: Gunakan `createSSRClient` dari `@/lib/supabase` untuk melakukan query di sisi server (Astro) agar sesi user tetap sinkron.
2. **Database Schema**: Perhatikan integritas data. Hapus barang lewat cascade atau batasi penghapusan kategori jika masih memiliki barang aktif (`RESTRICT`).
3. **Styling**: Gunakan variabel warna dari `Tailwind Config` (misal: `bg-primary-600`) untuk menjaga konsistensi visual ERP.
4. **Middleware**: Semua halaman baru secara default terproteksi. Jika ingin rute publik, update logic di `src/middleware.ts`.

---

<div align="center">
Dikelola oleh Tim Techese - SD Lamaholot © 2026
</div>