import 'package:beyou/features/mindfulness/bloc/mindfulness_event.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_state.dart';
import 'package:beyou/features/mindfulness/data/mindfulness_repository.dart';
import 'package:beyou/features/mindfulness/models/addiction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MindfulnessBloc extends Bloc<MindfulnessEvent, MindfulnessState> {
  final MindfulnessRepository _repo;

  MindfulnessBloc({required MindfulnessRepository repo})
      : _repo = repo,
        super(const MindfulnessInitial()) {
    on<MindfulnessStarted>(_onStarted);
    on<MindfulnessRefreshed>(_onRefreshed);
    on<MoodEntryAdded>(_onMoodAdded);
    on<MoodEntryDeleted>(_onMoodDeleted);
    on<AddictionTrackerStarted>(_onAddictionStarted);
    on<AddictionRelapseRecorded>(_onRelapseRecorded);
    on<AddictionTrackerStopped>(_onAddictionStopped);
    on<MeditationCompleted>(_onMeditationCompleted);
    on<FocusSessionLogged>(_onFocusLogged);
  }

  Future<void> _loadAll(Emitter<MindfulnessState> emit) async {
    final moodEntries = await _repo.getMoodEntries();
    final trackers = await _repo.getAddictionTrackers();
    final focusSessions = await _repo.getFocusSessions();
    final streak = await _repo.getMeditationStreak();

    emit(MindfulnessLoaded(
      meditations: _repo.getAllMeditations(),
      moodEntries: moodEntries,
      addictionTrackers: trackers,
      focusSessions: focusSessions,
      meditationStreak: streak,
    ));
  }

  Future<void> _onStarted(
    MindfulnessStarted event,
    Emitter<MindfulnessState> emit,
  ) async {
    emit(const MindfulnessLoading());
    try {
      await _loadAll(emit);
    } catch (e) {
      emit(MindfulnessError(e.toString()));
    }
  }

  Future<void> _onRefreshed(
    MindfulnessRefreshed event,
    Emitter<MindfulnessState> emit,
  ) async {
    if (state is! MindfulnessLoaded) return;
    try {
      await _loadAll(emit);
    } catch (e) {
      emit(MindfulnessError(e.toString()));
    }
  }

  Future<void> _onMoodAdded(
    MoodEntryAdded event,
    Emitter<MindfulnessState> emit,
  ) async {
    await _repo.saveMoodEntry(event.entry);
    final entries = await _repo.getMoodEntries();
    if (state is MindfulnessLoaded) {
      emit((state as MindfulnessLoaded).copyWith(moodEntries: entries));
    }
  }

  Future<void> _onMoodDeleted(
    MoodEntryDeleted event,
    Emitter<MindfulnessState> emit,
  ) async {
    await _repo.deleteMoodEntry(event.id);
    final entries = await _repo.getMoodEntries();
    if (state is MindfulnessLoaded) {
      emit((state as MindfulnessLoaded).copyWith(moodEntries: entries));
    }
  }

  Future<void> _onAddictionStarted(
    AddictionTrackerStarted event,
    Emitter<MindfulnessState> emit,
  ) async {
    final tracker = AddictionTracker(
      type: event.type,
      cleanSince: DateTime.now(),
      dailyCostINR: event.dailyCostINR,
    );
    await _repo.saveAddictionTracker(tracker);
    final all = await _repo.getAddictionTrackers();
    if (state is MindfulnessLoaded) {
      emit((state as MindfulnessLoaded).copyWith(addictionTrackers: all));
    }
  }

  Future<void> _onRelapseRecorded(
    AddictionRelapseRecorded event,
    Emitter<MindfulnessState> emit,
  ) async {
    if (state is! MindfulnessLoaded) return;
    final current = (state as MindfulnessLoaded)
        .addictionTrackers
        .firstWhere((t) => t.type == event.type);
    final reset = current.resetRelapse(DateTime.now());
    await _repo.saveAddictionTracker(reset);
    final all = await _repo.getAddictionTrackers();
    emit((state as MindfulnessLoaded).copyWith(addictionTrackers: all));
  }

  Future<void> _onAddictionStopped(
    AddictionTrackerStopped event,
    Emitter<MindfulnessState> emit,
  ) async {
    await _repo.deleteAddictionTracker(event.type);
    final all = await _repo.getAddictionTrackers();
    if (state is MindfulnessLoaded) {
      emit((state as MindfulnessLoaded).copyWith(addictionTrackers: all));
    }
  }

  Future<void> _onMeditationCompleted(
    MeditationCompleted event,
    Emitter<MindfulnessState> emit,
  ) async {
    await _repo.logMeditationCompletion(event.sessionId);
    final streak = await _repo.getMeditationStreak();
    if (state is MindfulnessLoaded) {
      emit((state as MindfulnessLoaded).copyWith(meditationStreak: streak));
    }
  }

  Future<void> _onFocusLogged(
    FocusSessionLogged event,
    Emitter<MindfulnessState> emit,
  ) async {
    await _repo.saveFocusSession(event.session);
    final all = await _repo.getFocusSessions();
    if (state is MindfulnessLoaded) {
      emit((state as MindfulnessLoaded).copyWith(focusSessions: all));
    }
  }
}
