# Productivity Timer Irfan Sabrian

Productivity Timer Irfan Sabrian adalah aplikasi timer produktivitas berbasis Flutter. Aplikasi ini membantu pengguna mengatur sesi kerja, istirahat pendek, dan istirahat panjang dengan tampilan timer berbentuk progress lingkaran.

Aplikasi mendukung pengaturan durasi timer, pause/resume, reset, serta pergantian tema light dan dark.

## Fitur Utama

- Timer kerja default 25 menit.
- Timer short break default 5 menit.
- Timer long break default 20 menit.
- Progress timer berbentuk circular indicator.
- Tombol `Work`, `Short Break`, dan `Long Break`.
- Tombol `Start`, `Pause`, `Resume`, dan `Reset`.
- Halaman settings untuk mengubah durasi timer.
- Durasi timer disimpan menggunakan `SharedPreferences`.
- Toggle tema light/dark melalui menu aplikasi.
- Support beberapa target Flutter seperti Android, iOS, Web, Windows, macOS, dan Linux.

## Teknologi

- Flutter
- Dart
- Material Design
- Adaptive Theme
- Shared Preferences
- Percent Indicator
- Flutter Launcher Icons

## Struktur Project

```text
productivity_timer_irfan_sabrian/
|-- lib/
|   |-- main.dart
|   |-- timer.dart
|   |-- settings.dart
|   |-- timermodel.dart
|   `-- widgets.dart
|-- lib2/
|-- assets/
|   `-- icon/
|-- android/
|-- ios/
|-- web/
|-- windows/
|-- macos/
|-- linux/
|-- pubspec.yaml
`-- analysis_options.yaml
```

Keterangan:

- `lib/main.dart` adalah entry point utama aplikasi.
- `lib/timer.dart` berisi logic countdown timer.
- `lib/settings.dart` berisi halaman pengaturan durasi timer.
- `lib/timermodel.dart` berisi model data timer.
- `lib/widgets.dart` berisi komponen tombol yang dipakai ulang.
- `lib2/` berisi salinan/versi lain dari file Dart dan tidak menjadi entry point utama.
- `assets/icon/icon.png` digunakan untuk konfigurasi launcher icon.

## Dependency Utama

Dependency aplikasi didefinisikan di `pubspec.yaml`:

- `adaptive_theme`
- `percent_indicator`
- `shared_preferences`
- `flutter_launcher_icons`
- `cupertino_setting_control`

Flutter SDK yang digunakan:

```text
>=3.3.2 <4.0.0
```

## Cara Menjalankan

1. Clone repository:

   ```bash
   git clone https://github.com/IrfanSabrian/productivity_timer_irfan_sabrian.git
   cd productivity_timer_irfan_sabrian
   ```

2. Install dependency:

   ```bash
   flutter pub get
   ```

3. Jalankan aplikasi:

   ```bash
   flutter run
   ```

4. Untuk menjalankan di browser:

   ```bash
   flutter run -d chrome
   ```

5. Untuk menjalankan di Windows desktop:

   ```bash
   flutter run -d windows
   ```

## Build Aplikasi

Build Android APK:

```bash
flutter build apk
```

Build Web:

```bash
flutter build web
```

Build Windows:

```bash
flutter build windows
```

## Alur Penggunaan

1. Buka aplikasi.
2. Pilih jenis timer:
   - `Work`
   - `Short Break`
   - `Long Break`
3. Tekan tombol `Start` atau `Pause/Resume` untuk mengontrol timer.
4. Tekan `Reset` untuk mengulang timer.
5. Buka menu `Settings` untuk mengubah durasi kerja dan istirahat.
6. Gunakan menu `Switch Theme` untuk mengganti tema light/dark.

## Pengaturan Timer

Durasi timer dapat diubah dari halaman settings:

- Work: default 25 menit.
- Short Break: default 5 menit.
- Long Break: default 20 menit.

Nilai pengaturan disimpan secara lokal menggunakan `SharedPreferences`, sehingga tetap tersimpan setelah aplikasi ditutup.

## Launcher Icon

Project menggunakan `flutter_launcher_icons` dengan konfigurasi:

```yaml
flutter_launcher_icons:
  android: "launcher_icon"
  image_path: "assets/icon/icon.png"
  min_sdk_android: 21
```

Untuk membuat ulang launcher icon:

```bash
flutter pub run flutter_launcher_icons
```

## Catatan Pengembangan

- README sebelumnya masih berupa template default Flutter dan sudah diganti dengan dokumentasi project.
- Entry point utama ada di `lib/main.dart`.
- Folder `lib2/` terlihat sebagai versi cadangan/eksperimen dan tidak dipakai sebagai entry point default.
- Package `shared_preferences` digunakan untuk menyimpan setting durasi secara lokal.

## Lisensi

Lisensi belum ditentukan.
