import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/login_prompt_widget.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../data/datasources/booking_local_datasource.dart';
import '../../domain/entities/booking.dart';

/// Booking / Orders page showing user's bookings.
class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return const _BookingContent();
        }
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(title: const Text(AppStrings.myBookings)),
          body: LoginPromptWidget(
            title: AppStrings.bookingLoginTitle,
            subtitle: AppStrings.bookingLoginSubtitle,
            icon: Icons.receipt_long_rounded,
            onLoginPressed: () => context.push(AppRouter.loginPath),
          ),
        );
      },
    );
  }
}

// ─────────────── SUDAH LOGIN ───────────────
class _BookingContent extends StatelessWidget {
  const _BookingContent();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text(AppStrings.myBookings),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            labelStyle: TextStyle(fontWeight: FontWeight.w600),
            tabs: [
              Tab(text: AppStrings.bookingActive),
              Tab(text: AppStrings.bookingCompleted),
              Tab(text: AppStrings.bookingCancelled),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _BookingListView(status: BookingStatus.active),
            _BookingListView(status: BookingStatus.completed),
            _BookingListView(status: BookingStatus.cancelled),
          ],
        ),
      ),
    );
  }
}

class _BookingListView extends StatelessWidget {
  final BookingStatus status;

  const _BookingListView({required this.status});

  @override
  Widget build(BuildContext context) {
    final bookings = BookingLocalDataSource.bookings
        .where((b) => b.status == status)
        .toList();

    if (bookings.isEmpty) return _buildEmpty();

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.xl - 4),
      itemCount: bookings.length,
      itemBuilder: (_, i) => _BookingCard(booking: bookings[i]),
    );
  }

  Widget _buildEmpty() {
    final messages = {
      BookingStatus.active: AppStrings.noActiveBooking,
      BookingStatus.completed: AppStrings.noCompletedBooking,
      BookingStatus.cancelled: AppStrings.noCancelledBooking,
    };
    final icons = {
      BookingStatus.active: Icons.hourglass_empty_rounded,
      BookingStatus.completed: Icons.check_circle_outline_rounded,
      BookingStatus.cancelled: Icons.cancel_outlined,
    };

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icons[status], size: 64, color: Colors.grey.shade300),
          const SizedBox(height: AppSpacing.md),
          Text(
            messages[status]!,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

// ─────────────── CARD PESANAN ───────────────
class _BookingCard extends StatelessWidget {
  final Booking booking;

  const _BookingCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Image + Badge
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSpacing.radiusLg),
            ),
            child: Stack(
              children: [
                Image.network(
                  booking.propertyImage,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: _buildStatusBadge(),
                ),
              ],
            ),
          ),
          // Info
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.propertyName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 14, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(
                      booking.location,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md - 4),
                // Dates row
                Row(
                  children: [
                    _buildDateChip(
                      Icons.login_rounded,
                      AppStrings.checkIn,
                      booking.checkIn,
                    ),
                    const SizedBox(width: AppSpacing.md - 4),
                    _buildDateChip(
                      Icons.logout_rounded,
                      AppStrings.checkOut,
                      booking.checkOut,
                    ),
                  ],
                ),
                const Divider(height: AppSpacing.lg),
                // Price + Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.total,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          booking.price,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    if (booking.status == BookingStatus.active)
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusSm + 2),
                          ),
                        ),
                        child: const Text(AppStrings.viewDetail),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    final Color bgColor;
    final Color textColor;
    final String label;

    switch (booking.status) {
      case BookingStatus.active:
        bgColor = Colors.green.shade50;
        textColor = Colors.green.shade700;
        label = AppStrings.bookingActive;
      case BookingStatus.completed:
        bgColor = Colors.blue.shade50;
        textColor = Colors.blue.shade700;
        label = AppStrings.bookingCompleted;
      case BookingStatus.cancelled:
        bgColor = Colors.red.shade50;
        textColor = Colors.red.shade700;
        label = AppStrings.bookingCancelled;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDateChip(IconData icon, String label, String date) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm + 2),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: AppColors.primary),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
