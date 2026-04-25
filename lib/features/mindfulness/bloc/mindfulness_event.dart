import 'package:beyou/features/mindfulness/models/addiction.dart';
import 'package:beyou/features/mindfulness/models/focus_session.dart';
import 'package:beyou/features/mindfulness/models/mood_entry.dart';
import 'package:equatable/equatable.dart';

abstract class MindfulnessEvent extends Equatable {
  const MindfulnessEvent();
  @override
  List<Object?> get props => [];
}

class MindfulnessStarted extends MindfulnessEvent {
  const MindfulnessStarted();
}

class MindfulnessRefreshed extends MindfulnessEvent {
  const MindfulnessRefreshed();
}

class MoodEntryAdded extends MindfulnessEvent {
  final MoodEntry entry;
  const MoodEntryAdded(this.entry);
  @override
  List<Object?> get props => [entry];
}

class MoodEntryDeleted extends MindfulnessEvent {
  final String id;
  const MoodEntryDeleted(this.id);
  @override
  List<Object?> get props => [id];
}

class AddictionTrackerStarted extends MindfulnessEvent {
  final AddictionType type;
  final int dailyCostINR;
  const AddictionTrackerStarted({required this.type, required this.dailyCostINR});
  @override
  List<Object?> get props => [type, dailyCostINR];
}

class AddictionRelapseRecorded extends MindfulnessEvent {
  final AddictionType type;
  const AddictionRelapseRecorded(this.type);
  @override
  List<Object?> get props => [type];
}

class AddictionTrackerStopped extends MindfulnessEvent {
  final AddictionType type;
  const AddictionTrackerStopped(this.type);
  @override
  List<Object?> get props => [type];
}

class MeditationCompleted extends MindfulnessEvent {
  final String sessionId;
  const MeditationCompleted(this.sessionId);
  @override
  List<Object?> get props => [sessionId];
}

class FocusSessionLogged extends MindfulnessEvent {
  final FocusSession session;
  const FocusSessionLogged(this.session);
  @override
  List<Object?> get props => [session];
}
