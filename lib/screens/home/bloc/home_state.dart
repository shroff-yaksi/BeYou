part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ReloadImageState extends HomeState {}

class HomeStatsLoaded extends HomeState {
  final int weeklyWorkouts;
  final int weeklyMinutes;
  final int totalCompleted;

  HomeStatsLoaded({
    required this.weeklyWorkouts,
    required this.weeklyMinutes,
    required this.totalCompleted,
  });
}
