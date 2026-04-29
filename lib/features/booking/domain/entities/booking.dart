import 'package:equatable/equatable.dart';

/// Status of a property booking.
enum BookingStatus {
  /// Currently active booking.
  active,

  /// Completed/checked-out booking.
  completed,

  /// Cancelled booking.
  cancelled,
}

/// Represents a booking record for a property.
///
/// Domain entity — immutable and framework-agnostic.
class Booking extends Equatable {
  final String id;
  final String propertyName;
  final String propertyImage;
  final String location;
  final String checkIn;
  final String checkOut;
  final String price;
  final BookingStatus status;

  const Booking({
    required this.id,
    required this.propertyName,
    required this.propertyImage,
    required this.location,
    required this.checkIn,
    required this.checkOut,
    required this.price,
    required this.status,
  });

  @override
  List<Object?> get props =>
      [id, propertyName, propertyImage, location, checkIn, checkOut, price, status];
}
