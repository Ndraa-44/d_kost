import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/property_repository.dart';
import 'property_event.dart';
import 'property_state.dart';

/// Manages property listing state (load, search).
///
/// Depends on [PropertyRepository] abstraction — the data source
/// can be swapped (local → Supabase) without modifying this class.
class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final PropertyRepository _repository;

  PropertyBloc({required PropertyRepository repository})
      : _repository = repository,
        super(const PropertyInitial()) {
    on<LoadProperties>(_onLoadProperties);
    on<SearchProperties>(_onSearchProperties);
  }

  Future<void> _onLoadProperties(
    LoadProperties event,
    Emitter<PropertyState> emit,
  ) async {
    emit(const PropertyLoading());
    try {
      final properties = await _repository.getProperties();
      final categories = await _repository.getCategories();
      emit(PropertyLoaded(properties, categories));
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  Future<void> _onSearchProperties(
    SearchProperties event,
    Emitter<PropertyState> emit,
  ) async {
    emit(const PropertyLoading());
    try {
      final filtered = await _repository.searchProperties(event.query);
      final categories = await _repository.getCategories();
      emit(PropertyLoaded(filtered, categories));
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }
}
