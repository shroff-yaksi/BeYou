part of 'fitness_bloc.dart';

@immutable
sealed class FitnessEvent {}

class LoadWorkoutsEvent extends FitnessEvent {}

class FilterWorkoutsEvent extends FitnessEvent {
  final String? category;
  final String? level;
  FilterWorkoutsEvent({this.category, this.level});
}

class SearchWorkoutsEvent extends FitnessEvent {
  final String query;
  SearchWorkoutsEvent({required this.query});
}
