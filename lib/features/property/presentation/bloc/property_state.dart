import 'package:equatable/equatable.dart';
import '../../domain/entities/property.dart';
import '../../domain/entities/category.dart';

/// Base class for all property-related states.
sealed class PropertyState extends Equatable {
  const PropertyState();

  @override
  List<Object?> get props => [];
}

/// Initial state — no data loaded yet.
class PropertyInitial extends PropertyState {
  const PropertyInitial();
}

/// Properties are being loaded.
class PropertyLoading extends PropertyState {
  const PropertyLoading();
}

/// Properties have been loaded successfully.
class PropertyLoaded extends PropertyState {
  final List<Property> properties;
  final List<Category> categories;

  const PropertyLoaded(this.properties, this.categories);

  @override
  List<Object?> get props => [properties, categories];
}

/// An error occurred while loading properties.
class PropertyError extends PropertyState {
  final String message;

  const PropertyError(this.message);

  @override
  List<Object?> get props => [message];
}
