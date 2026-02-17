import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beyou/app.dart';
import 'package:beyou/core/di/injection.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Firebase initialization - will enable in Phase 8
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  
  // Setup dependency injection
  await setupDependencies();
  
  // Run the app
  runApp(const BeYouApp());
}
