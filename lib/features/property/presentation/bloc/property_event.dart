import 'package:equatable/equatable.dart';

/// Base class for all property-related events.
sealed class PropertyEvent extends Equatable {
  const PropertyEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered to load all properties from the repository.
class LoadProperties extends PropertyEvent {
  const LoadProperties();
}

/// Triggered when the user searches for properties by keyword.
class SearchProperties extends PropertyEvent {
  final String query;

  const SearchProperties(this.query);

  @override
  List<Object?> get props => [query];
}
