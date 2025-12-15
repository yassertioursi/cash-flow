<p align="center">
  <img src="assets/logo-nbg.png" alt="Cash Flow" width="120" height="120" style="border-radius: 15px;">
  <br>
  <strong style="font-size: 2.5rem;">Cash Flow</strong>
  <br>
  <em>A modern, offline-first finance tracker built with Flutter</em>
</p>

<p align="center">
  <a href="https://flutter.dev/"><img alt="Flutter" src="https://img.shields.io/badge/Flutter-3.41%2B-02569B?logo=flutter"></a>
  <a href="https://dart.dev/"><img alt="Dart" src="https://img.shields.io/badge/Dart-3.11%2B-0175C2?logo=dart"></a>
  <a href="LICENSE"><img alt="License" src="https://img.shields.io/badge/License-MIT-green"></a>
  <img alt="Platform" src="https://img.shields.io/badge/Platform-Android%20|%20iOS%20|%20Web-blue">
</p>

---

## Overview

Cash Flow is a privacy-focused personal finance app that runs entirely on your device. No cloud sync, no accounts, no data leaving your phone. Built with Flutter using Clean Architecture and BLoC for a codebase that's maintainable, testable, and portable across mobile and web.

**Design philosophy:** Dark-first "Ink & Lime" aesthetic — flat surfaces, electric lime accents, Space Grotesk + Plus Jakarta Sans typography, generous whitespace. No gradients, no noise.

---

## Features

| Feature | Description |
|---------|-------------|
| **Transactions** | Income & expense entries with categories, dates, and search |
| **Dashboard** | Real-time balance, monthly savings, weekly bar chart |
| **Eco Footprint** | CO₂ estimate & tree compensation per transaction |
| **Categories** | 8 built-in icons (Food, Transport, Bills, Health, Shopping, Entertainment, Salary, Other) |
| **Settings** | Dark/Light theme, font scaling, color-blind modes, currency format |
| **Backups** | Automatic encrypted local backups + manual export/import (JSON) |
| **Localization** | English & French (auto-detects system language) |
| **Offline-First** | SQLite on native; IndexedDB via WebAssembly on web |


## Clean Code Architecture

Feature-first Clean Architecture with strict layer separation:

```
lib/
├── core/
│   ├── config/          # AppConfig (flavor-aware)
│   ├── constants/       # App-wide constants
│   ├── database/        # DB factory (native + web conditional)
│   ├── errors/          # Failures & Exceptions
│   ├── presentation/    # Shared widgets (GlassSurface, shimmers)
│   ├── router/          # go_router + auth guard
│   ├── services/        # Notifications, Backup scheduler
│   ├── theme/           # Ink & Lime design system
│   └── usecases/        # Base UseCase + Either<L,R>
├── features/
│   ├── auth/            # Sign in/up, session persistence
│   ├── home/            # Dashboard, balance card, eco card
│   ├── login/           # Email/password auth
│   ├── register/        # Account creation
│   ├── settings/        # Preferences, profile, backups
│   ├── transactions/    # List, filter, search
│   ├── user/            # Profile management
│   └── wallet/          # Balance, transactions CRUD
├── l10n/                # ARB files (en, fr)
├── injection_container.dart  # get_it + injectable
└── main.dart
```

**Key patterns:**
- **BLoC** for all state — predictable, testable, reactive
- **fpdart** `Either` for functional error handling (no exceptions in business logic)
- **Repository interfaces** in Domain; concrete impls in Data
- **Conditional exports** for native/web parity (DB, IO, platform channels)

---

## Tech Stack

| Category | Package |
|----------|---------|
| State | `flutter_bloc` |
| Navigation | `go_router` |
| Database | `sqflite` + `sqflite_common_ffi_web` |
| DI | `get_it` + `injectable` |
| Functional | `fpdart` |
| Charts | `fl_chart` |
| Icons | `font_awesome_flutter` |
| Fonts | `google_fonts` (Plus Jakarta Sans, Space Grotesk) |
| Notifications | `flutter_local_notifications` |
| Backup/Export | `file_picker` + custom encryption |

---

## Getting Started

### Prerequisites
- Flutter SDK ≥ 3.41
- Chrome (for web) or Android/iOS emulator/device

### Install & Generate
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

### Run
```bash
# Web (Chrome)
flutter run -d chrome

# Android
flutter run -d <device-id>

# iOS
flutter run -d <device-id>
```

### Production Web Build
```bash
flutter build web --release
python3 -m http.server 8080 --directory build/web
# Open http://localhost:8080
```

### Android APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

---

## Project Structure

```
cashflow/
├── android/              # Android project (launcher icons generated)
├── ios/                  # iOS project (launcher icons generated)
├── assets/
│   ├── logo.png          # Original logo (with background)
│   ├── logo-nbg.png      # No-background logo (used in-app & launcher)
│   └── fonts/            # Space Grotesk (400–700)
├── lib/                  # Application source
├── design/               # Before/after screenshots
├── l10n.yaml             # Localization config
├── analysis_options.yaml # Lint rules
└── pubspec.yaml
```

---

## Contributing

1. Fork the repo
2. Create a feature branch: `git checkout -b feat/your-feature`
3. Run `flutter analyze` and `flutter test` before committing
4. Open a PR with a clear description

---

## License

MIT License — see [LICENSE](LICENSE) for details.