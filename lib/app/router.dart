import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/home/presentation/pages/main_screen.dart';
import '../features/splash/presentation/pages/splash_screen.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/property/domain/entities/property.dart';
import '../features/property/presentation/pages/property_detail_page.dart';
import '../features/property/presentation/pages/search_result_page.dart';

/// Centralized routing configuration using GoRouter.
///
/// ### How GoRouter Works (Penjelasan untuk pemula):
///
/// GoRouter adalah package routing resmi yang direkomendasikan oleh tim Flutter.
/// Berbeda dengan `Navigator.push()` yang imperatif, GoRouter menggunakan
/// pendekatan **deklaratif** — Anda mendefinisikan semua routes di satu tempat,
/// lalu navigasi menggunakan path string (mirip URL di web).
///
/// **Keuntungan:**
/// 1. Semua routes terdefinisi di satu file — mudah di-maintain
/// 2. Mendukung deep linking (buka halaman tertentu dari link)
/// 3. Type-safe navigation dengan `context.go()` atau `context.push()`
/// 4. Mudah menambah route baru tanpa mengubah file lain
///
/// **Cara navigasi:**
/// ```dart
/// // Push ke halaman baru (bisa back)
/// context.push(AppRouter.loginPath);
///
/// // Replace halaman (tidak bisa back)
/// context.go(AppRouter.homePath);
///
/// // Push dengan data (extra)
/// context.push(AppRouter.propertyDetailPath, extra: property);
/// ```
class AppRouter {
  AppRouter._(); // Prevent instantiation

  // ── Route Paths ──
  static const String splashPath = '/';
  static const String homePath = '/home';
  static const String loginPath = '/login';
  static const String propertyDetailPath = '/property-detail';
  static const String searchResultPath = '/search-result';

  /// The GoRouter instance used by [MaterialApp.router].
  static final GoRouter router = GoRouter(
    initialLocation: splashPath,
    routes: [
      GoRoute(
        path: splashPath,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: homePath,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: loginPath,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: propertyDetailPath,
        builder: (context, state) {
          final property = state.extra as Property;
          return PropertyDetailPage(property: property);
        },
      ),
      GoRoute(
        path: searchResultPath,
        builder: (context, state) {
          final params = state.extra as Map<String, String>;
          return SearchResultPage(
            location: params['location']!,
            category: params['category']!,
          );
        },
      ),
    ],
  );
}
