/// Route name constants for the app
class RouteNames {
  RouteNames._(); // Private constructor

  // Onboarding & Auth
  static const String onboarding = '/onboarding';
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String forgotPassword = '/forgot-password';

  // Main navigation
  static const String home = '/';
  static const String tabBar = '/main';

  // Fitness
  static const String workouts = '/workouts';
  static const String workoutDetails = '/workout/:id';
  static const String startWorkout = '/start-workout';

  // Profile
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String editAccount = '/edit-account';
  static const String changePassword = '/change-password';

  // Reminder
  static const String reminder = '/reminder';
}
