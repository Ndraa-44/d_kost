# TheKost — thekost Mobile App

> Aplikasi pencarian kost, villa, dan homestay di Yogyakarta.

## 🛠 Tech Stack

| Technology | Purpose |
|---|---|
| [Flutter](https://flutter.dev) | Cross-platform UI framework |
| [flutter_bloc](https://pub.dev/packages/flutter_bloc) | State management (BLoC pattern) |
| [equatable](https://pub.dev/packages/equatable) | Value-based equality for entities & states |
| [go_router](https://pub.dev/packages/go_router) | Declarative routing |

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.11.5`
- Dart SDK (included with Flutter)
- Android Studio / VS Code
- Android Emulator or physical device

### Run the app
```bash
# Install dependencies
flutter pub get

# Run in debug mode
flutter run

# Build debug APK
flutter build apk --debug
```

### Code analysis
```bash
flutter analyze
```

## 📁 Project Structure

```
lib/
├── app/                           # Application-level configs
│   ├── app.dart                   # Root widget (DI + theme + router)
│   └── router.dart                # GoRouter centralized routing
│
├── core/                          # Shared utilities
│   ├── constants/
│   │   ├── app_colors.dart        # Color palette
│   │   ├── app_spacing.dart       # Spacing & radius values
│   │   └── app_strings.dart       # All UI text (i18n-ready)
│   ├── theme/
│   │   └── app_theme.dart         # Material ThemeData
│   └── widgets/                   # Reusable widgets
│       ├── login_prompt_widget.dart
│       └── property_list_card.dart
│
├── features/                      # Feature-based modules
│   ├── auth/                      # Authentication
│   │   ├── data/                  # Data sources & repository impl
│   │   ├── domain/                # Entities & repository contracts
│   │   └── presentation/         # BLoC & UI
│   ├── booking/                   # Booking management
│   ├── home/                      # Main screen (bottom nav)
│   ├── profile/                   # User profile
│   ├── property/                  # Property listings
│   ├── saved/                     # Favorites
│   └── splash/                    # Splash screen
│
└── main.dart                      # Entry point
```

## 🏗 Architecture

This project follows **Feature-first Clean Architecture** with 3 layers:

1. **Data Layer** — Data sources & repository implementations
2. **Domain Layer** — Entities & repository contracts (abstractions)
3. **Presentation Layer** — BLoC state management & UI widgets

See [ARCHITECTURE.md](ARCHITECTURE.md) for a detailed explanation.

## 📝 License

Private project — all rights reserved.
