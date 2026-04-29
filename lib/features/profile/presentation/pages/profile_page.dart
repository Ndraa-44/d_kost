import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/login_prompt_widget.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

/// Profile page showing user info, account settings, and support.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return _ProfileContent(user: state.user);
        }
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(title: const Text(AppStrings.profile)),
          body: LoginPromptWidget(
            title: AppStrings.notLoggedIn,
            subtitle: AppStrings.loginPromptProfile,
            icon: Icons.person_rounded,
            onLoginPressed: () => context.push(AppRouter.loginPath),
          ),
        );
      },
    );
  }
}

// ─────────────── SUDAH LOGIN ───────────────
class _ProfileContent extends StatelessWidget {
  /// Strongly typed [User] instead of dynamic.
  final User user;

  const _ProfileContent({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: AppSpacing.lg),
            _buildMenuSection(context),
            const SizedBox(height: AppSpacing.md),
            _buildSupportSection(context),
            const SizedBox(height: AppSpacing.md),
            _buildLogoutButton(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Blue background
        Container(
          width: double.infinity,
          height: 220,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(AppSpacing.radiusXxl),
              bottomRight: Radius.circular(AppSpacing.radiusXxl),
            ),
          ),
        ),
        // White Card
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
            top: 150,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
          ),
          padding: const EdgeInsets.only(
            top: 56,
            bottom: AppSpacing.lg,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
          ),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            boxShadow: [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                user.email,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                user.phoneNumber,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        // Avatar
        Positioned(
          top: 106,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFFE2E8F0),
              child: Icon(Icons.person_outline,
                  size: 40, color: Color(0xFF64748B)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return _buildCardSection(
      title: AppStrings.accountSection,
      items: [
        _MenuItem(
          icon: Icons.person_add_alt_1,
          label: AppStrings.startRenting,
          subtitle: AppStrings.startRentingSub,
          onTap: () => _showComingSoon(context, AppStrings.startRenting),
        ),
        _MenuItem(
          icon: Icons.receipt_long,
          label: AppStrings.myOrders,
          onTap: () => _showComingSoon(context, AppStrings.myOrders),
        ),
        _MenuItem(
          icon: Icons.admin_panel_settings_outlined,
          label: AppStrings.verifyAccount,
          subtitle: AppStrings.verifyAccountSub,
          hasWarning: true,
          onTap: () => _showComingSoon(context, AppStrings.verifyAccount),
        ),
        _MenuItem(
          icon: Icons.person_outline_rounded,
          label: AppStrings.editProfile,
          onTap: () => _showComingSoon(context, AppStrings.editProfile),
        ),
        _MenuItem(
          icon: Icons.lock_outline_rounded,
          label: AppStrings.paymentMethod,
          onTap: () => _showComingSoon(context, AppStrings.paymentMethod),
        ),
        _MenuItem(
          icon: Icons.notifications_outlined,
          label: AppStrings.notifications,
          onTap: () => _showComingSoon(context, AppStrings.notifications),
        ),
      ],
    );
  }

  Widget _buildSupportSection(BuildContext context) {
    return _buildCardSection(
      title: AppStrings.supportSection,
      items: [
        _MenuItem(
          icon: Icons.help_outline_rounded,
          label: AppStrings.helpCenter,
          onTap: () => _showComingSoon(context, AppStrings.helpCenter),
        ),
        _MenuItem(
          icon: Icons.description_outlined,
          label: AppStrings.termsConditions,
          onTap: () => _showComingSoon(context, AppStrings.termsConditions),
        ),
        _MenuItem(
          icon: Icons.shield_outlined,
          label: AppStrings.privacyPolicy,
          onTap: () => _showComingSoon(context, AppStrings.privacyPolicy),
        ),
      ],
    );
  }

  Widget _buildCardSection({
    required String title,
    required List<_MenuItem> items,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl - 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: AppSpacing.sm),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: items.asMap().entries.map((entry) {
                final idx = entry.key;
                final item = entry.value;
                return Column(
                  children: [
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.08),
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusSm + 2),
                        ),
                        child: Icon(item.icon,
                            color: AppColors.primary, size: 20),
                      ),
                      title: RichText(
                        text: TextSpan(
                          text: item.label,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                          children: [
                            if (item.hasWarning)
                              const TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: AppColors.error,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                      ),
                      subtitle: item.subtitle != null
                          ? Text(
                              item.subtitle!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            )
                          : null,
                      trailing: Icon(Icons.chevron_right_rounded,
                          color: Colors.grey.shade400),
                      onTap: item.onTap,
                    ),
                    if (idx < items.length - 1)
                      Divider(
                        height: 1,
                        indent: 60,
                        color: Colors.grey.shade100,
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl - 4),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: OutlinedButton(
          onPressed: () => _showLogoutDialog(context),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.error, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd + 2),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout_rounded, color: AppColors.error, size: 20),
              SizedBox(width: AppSpacing.sm),
              Text(
                AppStrings.logoutButton,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        ),
        title: const Text(
          AppStrings.logoutTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(AppStrings.logoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              AppStrings.cancel,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AuthBloc>().add(const LogoutRequested());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
            ),
            child: const Text(
              AppStrings.logoutTitle,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppStrings.comingSoon(feature)),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm + 2),
        ),
      ),
    );
  }
}

/// Data class for menu items in profile sections.
class _MenuItem {
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;
  final bool hasWarning;

  const _MenuItem({
    required this.icon,
    required this.label,
    this.subtitle,
    required this.onTap,
    this.hasWarning = false,
  });
}
