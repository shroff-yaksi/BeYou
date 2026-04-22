import 'package:bloc/bloc.dart';
import 'package:beyou/features/fitness/data/fitness_repository.dart';
import 'package:beyou/features/fitness/models/workout.dart';
import 'package:meta/meta.dart';

part 'fitness_event.dart';
part 'fitness_state.dart';

class FitnessBloc extends Bloc<FitnessEvent, FitnessState> {
  final FitnessRepository repository;

  FitnessBloc({required this.repository}) : super(FitnessInitial()) {
    on<LoadWorkoutsEvent>(_onLoadWorkouts);
    on<FilterWorkoutsEvent>(_onFilterWorkouts);
    on<SearchWorkoutsEvent>(_onSearchWorkouts);
  }

  String _selectedCategory = 'All';
  String _selectedLevel = 'All';
  String _searchQuery = '';

  Future<void> _onLoadWorkouts(
      LoadWorkoutsEvent event, Emitter<FitnessState> emit) async {
    emit(FitnessLoading());
    try {
      await repository.seedIfNeeded();
      final workouts = await repository.loadWorkouts(
        category: _selectedCategory == 'All' ? null : _selectedCategory,
        level: _selectedLevel == 'All' ? null : _selectedLevel,
        searchQuery: _searchQuery.isEmpty ? null : _searchQuery,
      );
      emit(FitnessLoaded(
        workouts: workouts,
        selectedCategory: _selectedCategory,
        selectedLevel: _selectedLevel,
        searchQuery: _searchQuery,
      ));
    } catch (e) {
      emit(FitnessError(message: e.toString()));
    }
  }

  Future<void> _onFilterWorkouts(
      FilterWorkoutsEvent event, Emitter<FitnessState> emit) async {
    _selectedCategory = event.category ?? _selectedCategory;
    _selectedLevel = event.level ?? _selectedLevel;
    add(LoadWorkoutsEvent());
  }

  Future<void> _onSearchWorkouts(
      SearchWorkoutsEvent event, Emitter<FitnessState> emit) async {
    _searchQuery = event.query;
    add(LoadWorkoutsEvent());
  }
}
