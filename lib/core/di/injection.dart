import 'package:get_it/get_it.dart';

/// Service locator for dependency injection
final getIt = GetIt.instance;

/// Setup all dependencies for the app
Future<void> setupDependencies() async {
  // TODO: Register services, repositories, and BLoCs here as we build them
  
  // Example structure (will implement in later phases):
  // 
  // // Services
  // getIt.registerLazySingleton(() => FirebaseAuthService());
  // getIt.registerLazySingleton(() => FirebaseStorageService());
  // 
  // // Repositories
  // getIt.registerLazySingleton(() => AuthRepository(getIt()));
  // getIt.registerLazySingleton(() => UserRepository(getIt()));
  // getIt.registerLazySingleton(() => WorkoutRepository(getIt()));
  // 
  // // BLoCs (registered as factories for new instances)
  // getIt.registerFactory(() => AuthBloc(getIt()));
  // getIt.registerFactory(() => WorkoutBloc(getIt()));
}
