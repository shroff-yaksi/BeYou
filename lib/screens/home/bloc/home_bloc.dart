import 'package:bloc/bloc.dart';
import 'package:beyou/features/fitness/data/fitness_repository.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FitnessRepository _fitnessRepository;

  HomeBloc({FitnessRepository? fitnessRepository})
      : _fitnessRepository = fitnessRepository ?? FitnessRepository(),
        super(HomeInitial()) {
    on<ReloadImageEvent>(_onReloadImage);
    on<LoadHomeStatsEvent>(_onLoadStats);
  }

  void _onReloadImage(ReloadImageEvent event, Emitter<HomeState> emit) {
    emit(ReloadImageState());
  }

  Future<void> _onLoadStats(
      LoadHomeStatsEvent event, Emitter<HomeState> emit) async {
    try {
      final weekSessions = await _fitnessRepository.loadWeekSessions();
      final allSessions = await _fitnessRepository.loadWorkoutHistory(limit: 200);

      final weeklyMinutes = weekSessions.fold<int>(
        0, (sum, s) => sum + s.durationSeconds ~/ 60);

      emit(HomeStatsLoaded(
        weeklyWorkouts: weekSessions.length,
        weeklyMinutes: weeklyMinutes,
        totalCompleted: allSessions.length,
      ));
    } catch (_) {
      // Non-fatal: home screen shows static fallback values
    }
  }
}
