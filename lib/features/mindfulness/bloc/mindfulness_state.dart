import 'package:beyou/features/mindfulness/models/addiction.dart';
import 'package:beyou/features/mindfulness/models/focus_session.dart';
import 'package:beyou/features/mindfulness/models/meditation_session.dart';
import 'package:beyou/features/mindfulness/models/mood_entry.dart';
import 'package:equatable/equatable.dart';

abstract class MindfulnessState extends Equatable {
  const MindfulnessState();
  @override
  List<Object?> get props => [];
}

class MindfulnessInitial extends MindfulnessState {
  const MindfulnessInitial();
}

class MindfulnessLoading extends MindfulnessState {
  const MindfulnessLoading();
}

class MindfulnessError extends MindfulnessState {
  final String message;
  const MindfulnessError(this.message);
  @override
  List<Object?> get props => [message];
}

class MindfulnessLoaded extends MindfulnessState {
  final List<MeditationSession> meditations;
  final List<MoodEntry> moodEntries;
  final List<AddictionTracker> addictionTrackers;
  final List<FocusSession> focusSessions;
  final int meditationStreak;

  const MindfulnessLoaded({
    required this.meditations,
    required this.moodEntries,
    required this.addictionTrackers,
    required this.focusSessions,
    required this.meditationStreak,
  });

  MindfulnessLoaded copyWith({
    List<MeditationSession>? meditations,
    List<MoodEntry>? moodEntries,
    List<AddictionTracker>? addictionTrackers,
    List<FocusSession>? focusSessions,
    int? meditationStreak,
  }) {
    return MindfulnessLoaded(
      meditations: meditations ?? this.meditations,
      moodEntries: moodEntries ?? this.moodEntries,
      addictionTrackers: addictionTrackers ?? this.addictionTrackers,
      focusSessions: focusSessions ?? this.focusSessions,
      meditationStreak: meditationStreak ?? this.meditationStreak,
    );
  }

  @override
  List<Object?> get props =>
      [meditations, moodEntries, addictionTrackers, focusSessions, meditationStreak];
}
