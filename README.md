📄 BLUEPRINT APLIKASI
“Deadline” – Aplikasi Manajemen Tugas & Produktivitas
________________________________________
🧩 1. Tema / Konsep Aplikasi
Aplikasi “Deadline” merupakan aplikasi berbasis mobile yang bertujuan membantu pengguna dalam mengelola tugas, aktivitas, kebiasaan, dan target secara terstruktur.
Aplikasi ini dirancang untuk:
•	Mahasiswa
•	Pelajar
•	Pengguna umum
dengan fokus utama pada:
•	Manajemen waktu
•	Pengingat deadline
•	Peningkatan produktivitas
________________________________________
🎯 2. Tujuan Aplikasi
•	Membantu pengguna mencatat dan mengelola tugas
•	Menghindari keterlambatan deadline
•	Meningkatkan konsistensi kebiasaan (habit)
•	Memvisualisasikan progress melalui statistik
________________________________________





🏗️ 3. Arsitektur Folder
lib/
├── main.dart
├── models/
│   └── task_model.dart
├── screens/
│   ├── home_screen.dart
│   ├── homework_screen.dart
│   ├── activity_screen.dart
│   ├── habit_screen.dart
│   ├── goal_screen.dart
│   ├── calendar_screen.dart
│   ├── analytics_screen.dart
│   └── settings_screen.dart
└── widgets/
    └── custom_card.dart
________________________________________
🔄 4. Alur Navigasi (User Flow)
🔹 Level 1 (Navigasi Utama)
Navigasi menggunakan Bottom Navigation Bar:
•	Home
•	Calendar
•	Analytics
•	Settings
________________________________________
🔹 Level 2 (Dashboard)
Pada halaman Home terdapat 4 menu utama:
•	Homework
•	Activity
•	Habit
•	Goal
Saat salah satu menu dipilih → pindah ke halaman detail.
________________________________________
🔹 Level 3 (Manajemen Data)
Di setiap halaman kategori:
•	User melihat daftar data
•	User menekan tombol ➕
•	Muncul form input (Bottom Sheet)
•	Data disimpan ke database lokal
________________________________________
🗃️ 5. Struktur Data (Database Isar)
Setiap data disimpan dalam satu koleksi bernama Task.
Field	Tipe Data	Keterangan
id	Integer	ID otomatis
title	String	Judul tugas
category	String	Homework / Activity / Habit / Goal
date	DateTime	Deadline
isCompleted	Boolean	Status selesai
progress	Double	Progress (khusus Goal)
________________________________________
🖥️ 6. Desain Tampilan (UI Overview)
🏠 Home Screen
•	Header dengan informasi aplikasi
•	Card sambutan
•	Menu 4 kategori (grid)
________________________________________
📚 Halaman Kategori
•	List tugas
•	Tombol tambah data
•	Status checklist
________________________________________
📅 Calendar Screen
•	Menampilkan jadwal berdasarkan tanggal
•	Menggunakan library table_calendar
________________________________________
📊 Analytics Screen
•	Grafik batang (aktivitas mingguan)
•	Grafik lingkaran (progress habit)
________________________________________
⚙️ Settings Screen
•	Nama pengguna
•	Mode gelap/terang
•	Hapus data lokal
________________________________________
🚀 7. Teknologi yang Digunakan
•	Flutter (Framework)
•	Isar Database (Local Storage)
•	Table Calendar (Kalender)
•	FL Chart (Grafik)
•	Google Fonts (Typography)
________________________________________
⏳ 8. Rencana Pengembangan (Timeline 2 Minggu)
Hari	Kegiatan
1–3	Setup project & UI dasar
4–6	Navigasi & halaman utama
7–9	CRUD data (Homework)
10–11	Kalender & grafik
12–13	UI polishing
14	Testing & finalisasi
________________________________________
🎯 KESIMPULAN
Aplikasi Deadline dirancang sebagai solusi sederhana namun efektif untuk membantu pengguna mengatur waktu, menyelesaikan tugas, dan meningkatkan produktivitas secara terstruktur.
________________________________________
Keunggulan aplikasi:
•	Tanpa login (lebih cepat digunakan)
•	UI sederhana & user friendly
•	Mendukung berbagai jenis aktivitas dalam satu aplikasi
________________________________________


