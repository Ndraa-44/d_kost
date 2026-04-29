import '../../domain/entities/booking.dart';

/// Contract for booking data access.
///
/// Swap implementation to connect to Supabase without
/// touching the presentation layer.
abstract class BookingRepository {
  /// Returns all bookings for the current user.
  Future<List<Booking>> getBookings();

  /// Returns bookings filtered by [status].
  Future<List<Booking>> getBookingsByStatus(BookingStatus status);
}
