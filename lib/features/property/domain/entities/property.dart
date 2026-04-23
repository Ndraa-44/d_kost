class Property {
  final String id;
  final String name;
  final String location;
  final String price;
  final String imageUrl;
  final double rating;
  final String category; // Kost, Villa, Homestay

  Property({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.category,
  });
}
