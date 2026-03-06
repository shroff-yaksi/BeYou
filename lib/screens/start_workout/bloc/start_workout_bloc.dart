import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'start_workout_event.dart';
part 'start_workout_state.dart';

class StartWorkoutBloc extends Bloc<StartWorkoutEvent, StartWorkoutState> {
  StartWorkoutBloc() : super(StartWorkoutInitial()) {
    on<BackTappedEvent>(_onBackTapped);
    on<PlayTappedEvent>(_onPlayTapped);
    on<PauseTappedEvent>(_onPauseTapped);
  }

  int time = 0;

  void _onBackTapped(BackTappedEvent event, Emitter<StartWorkoutState> emit) {
    emit(BackTappedState());
  }

  void _onPlayTapped(PlayTappedEvent event, Emitter<StartWorkoutState> emit) {
    time = event.time;
    emit(PlayTimerState(time: event.time));
  }

  void _onPauseTapped(PauseTappedEvent event, Emitter<StartWorkoutState> emit) {
    time = event.time;
    emit(PauseTimerState(currentTime: time));
  }
}
