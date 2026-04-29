import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/login_prompt_widget.dart';
import '../../../../core/widgets/property_list_card.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../property/data/datasources/property_local_datasource.dart';
import '../../../property/domain/entities/property.dart';

/// Saved / Favorites page showing user's saved properties.
class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  late List<Property> _savedProperties;

  @override
  void initState() {
    super.initState();
    // Mock: take first 3 properties as favorites
    _savedProperties = List.from(PropertyLocalDataSource.properties.take(3));
  }

  void _removeSaved(Property prop) {
    setState(() {
      _savedProperties.remove(prop);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppStrings.removedFromFavorite(prop.name)),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm + 2),
        ),
        action: SnackBarAction(
          label: AppStrings.undoAction,
          textColor: Colors.white,
          onPressed: () {
            setState(() => _savedProperties.add(prop));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return _buildContent();
        }
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(title: const Text(AppStrings.favorites)),
          body: LoginPromptWidget(
            title: AppStrings.savedLoginTitle,
            subtitle: AppStrings.savedLoginSubtitle,
            icon: Icons.favorite_rounded,
            iconColor: AppColors.error,
            onLoginPressed: () => context.push(AppRouter.loginPath),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.favorites),
        actions: [
          if (_savedProperties.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.md),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Text(
                    '${_savedProperties.length} item',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: _savedProperties.isEmpty ? _buildEmpty() : _buildList(),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border_rounded,
              size: 72, color: Colors.grey.shade300),
          const SizedBox(height: AppSpacing.md),
          const Text(
            AppStrings.noFavorites,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            AppStrings.favoriteHint,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade500, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.xl - 4),
      itemCount: _savedProperties.length,
      itemBuilder: (context, index) {
        final prop = _savedProperties[index];
        return Dismissible(
          key: Key(prop.id),
          direction: DismissDirection.endToStart,
          onDismissed: (_) => _removeSaved(prop),
          background: Container(
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: AppSpacing.lg),
            decoration: BoxDecoration(
              color: Colors.red.shade400,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: const Icon(Icons.delete_rounded,
                color: Colors.white, size: 28),
          ),
          child: PropertyListCard(
            property: prop,
            onTap: () => context.push(
              AppRouter.propertyDetailPath,
              extra: prop,
            ),
            trailing: GestureDetector(
              onTap: () => _removeSaved(prop),
              child: const Icon(Icons.favorite_rounded,
                  color: Colors.red, size: 22),
            ),
          ),
        );
      },
    );
  }
}
