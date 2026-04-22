part of 'fitness_bloc.dart';

@immutable
sealed class FitnessState {}

class FitnessInitial extends FitnessState {}

class FitnessLoading extends FitnessState {}

class FitnessLoaded extends FitnessState {
  final List<Workout> workouts;
  final String selectedCategory;
  final String selectedLevel;
  final String searchQuery;

  FitnessLoaded({
    required this.workouts,
    required this.selectedCategory,
    required this.selectedLevel,
    required this.searchQuery,
  });
}

class FitnessError extends FitnessState {
  final String message;
  FitnessError({required this.message});
}
