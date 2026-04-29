import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/constants/app_strings.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/property/data/repositories/property_repository_impl.dart';
import '../features/property/domain/repositories/property_repository.dart';
import '../features/property/presentation/bloc/property_bloc.dart';
import 'router.dart';

/// Root widget of the TheKost application.
///
/// Responsible for:
/// - Setting up dependency injection (repositories → BLoCs)
/// - Configuring the app theme
/// - Connecting GoRouter for navigation
class TheKostApp extends StatelessWidget {
  const TheKostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepositoryImpl(),
        ),
        RepositoryProvider<PropertyRepository>(
          create: (_) => PropertyRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              repository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<PropertyBloc>(
            create: (context) => PropertyBloc(
              repository: context.read<PropertyRepository>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          title: AppStrings.appTitle,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
