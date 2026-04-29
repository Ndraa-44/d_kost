import '../../domain/entities/booking.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_local_datasource.dart';

/// Local implementation of [BookingRepository] using mock data.
class BookingRepositoryImpl implements BookingRepository {
  @override
  Future<List<Booking>> getBookings() async {
    return BookingLocalDataSource.bookings;
  }

  @override
  Future<List<Booking>> getBookingsByStatus(BookingStatus status) async {
    return BookingLocalDataSource.bookings
        .where((b) => b.status == status)
        .toList();
  }
}
