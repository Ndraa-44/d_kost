import '../../domain/entities/booking.dart';

/// Local data source that provides mock booking data.
///
/// Will be replaced by a Supabase data source in the future.
class BookingLocalDataSource {
  /// Mock booking records.
  static const List<Booking> bookings = [
    // ── Aktif ──
    Booking(
      id: 'B001',
      propertyName: "D'Kost Exclusive Jakal",
      propertyImage:
          'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?q=80&w=500',
      location: 'Sleman',
      checkIn: '24 Apr 2026',
      checkOut: '24 Mei 2026',
      price: 'Rp 1.200.000',
      status: BookingStatus.active,
    ),
    Booking(
      id: 'B002',
      propertyName: 'Homestay Malioboro Stay',
      propertyImage:
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?q=80&w=500',
      location: 'Kota Yogyakarta',
      checkIn: '25 Apr 2026',
      checkOut: '27 Apr 2026',
      price: 'Rp 700.000',
      status: BookingStatus.active,
    ),
    // ── Selesai ──
    Booking(
      id: 'B003',
      propertyName: 'Villa Kaliurang Retreat',
      propertyImage:
          'https://images.unsplash.com/photo-1570129477492-45a003537e1f?q=80&w=500',
      location: 'Sleman',
      checkIn: '10 Mar 2026',
      checkOut: '12 Mar 2026',
      price: 'Rp 1.700.000',
      status: BookingStatus.completed,
    ),
    Booking(
      id: 'B004',
      propertyName: 'Kost Prawirotaman Premium',
      propertyImage:
          'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=500',
      location: 'Kota Yogyakarta',
      checkIn: '01 Feb 2026',
      checkOut: '01 Mar 2026',
      price: 'Rp 1.500.000',
      status: BookingStatus.completed,
    ),
    // ── Dibatalkan ──
    Booking(
      id: 'B005',
      propertyName: 'Villa Pantai Baron',
      propertyImage:
          'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?q=80&w=500',
      location: 'Gunungkidul',
      checkIn: '15 Jan 2026',
      checkOut: '17 Jan 2026',
      price: 'Rp 2.200.000',
      status: BookingStatus.cancelled,
    ),
  ];
}
