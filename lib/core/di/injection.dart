import 'package:get_it/get_it.dart';
import 'package:beyou/features/ayurveda/data/ayurveda_repository.dart';
import 'package:beyou/features/dosha/data/dosha_repository.dart';
import 'package:beyou/features/fitness/data/fitness_repository.dart';

/// Service locator for dependency injection
final getIt = GetIt.instance;

/// Setup all dependencies for the app
Future<void> setupDependencies() async {
  // Repositories
  getIt.registerLazySingleton(() => DoshaRepository());
  getIt.registerLazySingleton(() => FitnessRepository());
  getIt.registerLazySingleton(() => AyurvedaRepository());
}
