import 'package:equatable/equatable.dart';

/// Represents a property listing (kost, villa, or homestay).
///
/// Domain entity — framework-agnostic, immutable, and uses
/// [Equatable] for value-based equality comparison.
class Property extends Equatable {
  final String id;
  final String name;
  final String location;
  final String price;
  final String imageUrl;
  final double rating;

  /// Category type: 'Kost', 'Villa', or 'Homestay'.
  final String category;

  const Property({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.category,
  });

  @override
  List<Object?> get props =>
      [id, name, location, price, imageUrl, rating, category];
}
