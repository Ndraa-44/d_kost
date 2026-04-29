import '../../domain/entities/category.dart';
import '../../domain/entities/property.dart';

/// Local data source that provides mock property data.
///
/// This class will be replaced by a Supabase data source
/// when the backend is connected. The [PropertyRepository]
/// abstraction ensures this swap requires zero changes in
/// the BLoC or UI layer.
class PropertyLocalDataSource {
  /// All available locations in Yogyakarta.
  static const List<String> jogjaLocations = [
    'Kota Yogyakarta',
    'Sleman',
    'Bantul',
    'Gunungkidul',
    'Kulon Progo',
  ];

  /// Property categories.
  static const List<Category> categories = [
    Category(id: '1', name: 'Kost', iconName: 'kost'),
    Category(id: '2', name: 'Villa', iconName: 'villa'),
    Category(id: '3', name: 'Homestay', iconName: 'homestay'),
  ];

  /// All available property listings.
  static const List<Property> properties = [
    // ── Kost ──
    Property(
      id: '1',
      name: 'thekost Exclusive Jakal',
      location: 'Sleman',
      price: 'Rp 1.200.000/bln',
      imageUrl:
          'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?q=80&w=500',
      rating: 4.8,
      category: 'Kost',
    ),
    Property(
      id: '2',
      name: 'Kost Putri Seturan',
      location: 'Sleman',
      price: 'Rp 950.000/bln',
      imageUrl:
          'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=500',
      rating: 4.6,
      category: 'Kost',
    ),
    Property(
      id: '3',
      name: 'Kost Prawirotaman Premium',
      location: 'Kota Yogyakarta',
      price: 'Rp 1.500.000/bln',
      imageUrl:
          'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=500',
      rating: 4.9,
      category: 'Kost',
    ),
    // ── Villa ──
    Property(
      id: '4',
      name: 'Villa Kaliurang Retreat',
      location: 'Sleman',
      price: 'Rp 850.000/malam',
      imageUrl:
          'https://images.unsplash.com/photo-1570129477492-45a003537e1f?q=80&w=500',
      rating: 4.7,
      category: 'Villa',
    ),
    Property(
      id: '5',
      name: 'Villa Pantai Baron',
      location: 'Gunungkidul',
      price: 'Rp 1.100.000/malam',
      imageUrl:
          'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?q=80&w=500',
      rating: 4.5,
      category: 'Villa',
    ),
    // ── Homestay ──
    Property(
      id: '6',
      name: 'Homestay Malioboro Stay',
      location: 'Kota Yogyakarta',
      price: 'Rp 350.000/malam',
      imageUrl:
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?q=80&w=500',
      rating: 4.4,
      category: 'Homestay',
    ),
    Property(
      id: '7',
      name: 'Homestay Kotagede Heritage',
      location: 'Bantul',
      price: 'Rp 275.000/malam',
      imageUrl:
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=500',
      rating: 4.3,
      category: 'Homestay',
    ),
  ];
}
