import 'package:equatable/equatable.dart';

/// Represents a property category (e.g. Kost, Villa, Homestay).
///
/// Uses [iconName] as a string key instead of [IconData] to keep
/// this domain entity decoupled from the Flutter framework.
/// The UI layer is responsible for mapping [iconName] to an actual icon.
class Category extends Equatable {
  final String id;
  final String name;

  /// Icon identifier — mapped to [IconData] in the UI layer.
  ///
  /// Examples: 'apartment', 'villa', 'cottage'
  final String iconName;

  const Category({
    required this.id,
    required this.name,
    required this.iconName,
  });

  @override
  List<Object?> get props => [id, name, iconName];
}
