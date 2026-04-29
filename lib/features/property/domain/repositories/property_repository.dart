import '../../domain/entities/property.dart';
import '../../domain/entities/category.dart';

/// Contract for property data access.
///
/// This abstraction allows the app to switch between different
/// data sources (local mock → Supabase → any other API) without
/// modifying the BLoC or UI layer.
///
/// ### How to migrate to Supabase:
/// 1. Create `PropertySupabaseDataSource` in `data/datasources/`.
/// 2. Create `PropertyRepositorySupabase` implementing this contract.
/// 3. Swap the implementation in the dependency injection (main.dart).
abstract class PropertyRepository {
  /// Returns all available properties.
  Future<List<Property>> getProperties();

  /// Returns all property categories.
  Future<List<Category>> getCategories();

  /// Returns all available location names.
  Future<List<String>> getLocations();

  /// Searches properties by [query] string.
  /// Matches against property name or location.
  Future<List<Property>> searchProperties(String query);
}
