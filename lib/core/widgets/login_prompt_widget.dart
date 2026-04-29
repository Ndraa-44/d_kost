import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

/// A reusable login prompt widget shown when a feature
/// requires authentication but the user is not logged in.
///
/// Used by: BookingPage, SavedPage, ProfilePage.
/// This eliminates the copy-paste duplication of login prompts.
class LoginPromptWidget extends StatelessWidget {
  /// Title text displayed below the icon.
  final String title;

  /// Subtitle/description text.
  final String subtitle;

  /// Icon displayed in the circular container.
  final IconData icon;

  /// Color used for the icon container background.
  final Color iconColor;

  /// Callback when the login button is pressed.
  final VoidCallback onLoginPressed;

  const LoginPromptWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onLoginPressed,
    this.iconColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon circle
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 64,
                color: iconColor.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Subtitle
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade500,
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Login button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onLoginPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd + 2),
                  ),
                ),
                child: const Text(
                  'Masuk Sekarang',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
