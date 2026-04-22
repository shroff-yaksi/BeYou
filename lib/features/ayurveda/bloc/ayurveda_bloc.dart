import 'package:beyou/features/ayurveda/bloc/ayurveda_event.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_state.dart';
import 'package:beyou/features/ayurveda/data/ayurveda_repository.dart';
import 'package:beyou/features/ayurveda/models/home_remedy.dart';
import 'package:beyou/features/dosha/data/dosha_repository.dart';
import 'package:beyou/features/dosha/models/dosha_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AyurvedaBloc extends Bloc<AyurvedaEvent, AyurvedaState> {
  final AyurvedaRepository _ayurvedaRepo;
  final DoshaRepository _doshaRepo;

  AyurvedaBloc({
    required AyurvedaRepository ayurvedaRepo,
    required DoshaRepository doshaRepo,
  })  : _ayurvedaRepo = ayurvedaRepo,
        _doshaRepo = doshaRepo,
        super(AyurvedaInitial()) {
    on<AyurvedaStarted>(_onStarted);
    on<AyurvedaYogaFilterChanged>(_onYogaFilterChanged);
    on<AyurvedaRemedySearchChanged>(_onRemedySearchChanged);
    on<AyurvedaRemedyCategoryChanged>(_onRemedyCategoryChanged);
    on<AyurvedaDoshaFilterChanged>(_onDoshaFilterChanged);
  }

  Future<void> _onStarted(AyurvedaStarted event, Emitter<AyurvedaState> emit) async {
    emit(AyurvedaLoading());
    try {
      // Load user's dosha from history
      final history = await _doshaRepo.loadHistory();
      DoshaType? userDosha;
      if (history.isNotEmpty) {
        final dominant = history.last.dominantDosha().toLowerCase();
        userDosha = DoshaType.values.firstWhere(
          (d) => d.name == dominant,
          orElse: () => DoshaType.vata,
        );
      }

      emit(AyurvedaLoaded(
        yogaSessions: _ayurvedaRepo.getAllYogaSessions(),
        pranayamaTechniques: _ayurvedaRepo.getAllPranayama(),
        remedies: _ayurvedaRepo.getAllRemedies(),
        morningRoutine: _ayurvedaRepo.getMorningRoutine(),
        eveningRoutine: _ayurvedaRepo.getEveningRoutine(),
        programs: _ayurvedaRepo.getAllPrograms(),
        userDosha: userDosha,
      ));
    } catch (e) {
      emit(AyurvedaError(e.toString()));
    }
  }

  void _onYogaFilterChanged(AyurvedaYogaFilterChanged event, Emitter<AyurvedaState> emit) {
    final current = state as AyurvedaLoaded;
    final style = event.style;
    final sessions = style == null
        ? _ayurvedaRepo.getAllYogaSessions()
        : _ayurvedaRepo.getYogaByStyle(style);

    emit(current.copyWith(
      yogaSessions: sessions,
      activeYogaFilter: style,
      clearYogaFilter: style == null,
    ));
  }

  void _onRemedySearchChanged(AyurvedaRemedySearchChanged event, Emitter<AyurvedaState> emit) {
    final current = state as AyurvedaLoaded;
    final remedies = event.query.isEmpty
        ? _applyCategory(current.activeRemedyCategory)
        : _ayurvedaRepo.searchRemedies(event.query);

    emit(current.copyWith(remedies: remedies, remedySearchQuery: event.query));
  }

  void _onRemedyCategoryChanged(AyurvedaRemedyCategoryChanged event, Emitter<AyurvedaState> emit) {
    final current = state as AyurvedaLoaded;
    final remedies = _applyCategory(event.category);

    emit(current.copyWith(
      remedies: remedies,
      activeRemedyCategory: event.category,
      clearRemedyCategory: event.category == null,
      remedySearchQuery: '',
    ));
  }

  void _onDoshaFilterChanged(AyurvedaDoshaFilterChanged event, Emitter<AyurvedaState> emit) {
    final current = state as AyurvedaLoaded;
    final dosha = event.dosha;
    final sessions = dosha == null
        ? _ayurvedaRepo.getAllYogaSessions()
        : _ayurvedaRepo.getYogaForDosha(dosha);
    final remedies = dosha == null
        ? _applyCategory(current.activeRemedyCategory)
        : _ayurvedaRepo.getRemediesForDosha(dosha);

    emit(current.copyWith(yogaSessions: sessions, remedies: remedies));
  }

  List<HomeRemedy> _applyCategory(RemedyCategory? category) {
    return category == null
        ? _ayurvedaRepo.getAllRemedies()
        : _ayurvedaRepo.getRemediesByCategory(category);
  }
}
