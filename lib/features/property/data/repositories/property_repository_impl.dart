import '../../domain/entities/category.dart';
import '../../domain/entities/property.dart';
import '../../domain/repositories/property_repository.dart';
import '../datasources/property_local_datasource.dart';

/// Implementation of [PropertyRepository] using local mock data.
///
/// When migrating to Supabase, create a new implementation
/// (e.g. `PropertyRepositorySupabase`) and inject it instead.
class PropertyRepositoryImpl implements PropertyRepository {
  @override
  Future<List<Property>> getProperties() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return PropertyLocalDataSource.properties;
  }

  @override
  Future<List<Category>> getCategories() async {
    return PropertyLocalDataSource.categories;
  }

  @override
  Future<List<String>> getLocations() async {
    return PropertyLocalDataSource.jogjaLocations;
  }

  @override
  Future<List<Property>> searchProperties(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final lowerQuery = query.toLowerCase();
    return PropertyLocalDataSource.properties
        .where((p) =>
            p.name.toLowerCase().contains(lowerQuery) ||
            p.location.toLowerCase().contains(lowerQuery))
        .toList();
  }
}
