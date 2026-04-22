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

  // Fitness (legacy)
  static const String workouts = '/workouts';
  static const String workoutDetails = '/workout-details';
  static const String startWorkout = '/start-workout';

  // Fitness (Phase 2 — features/fitness/)
  static const String workoutDetail = '/fitness/workout-detail';
  static const String activeWorkout = '/fitness/active-workout';
  static const String workoutHistory = '/fitness/history';
  static const String bodyMetrics = '/fitness/body-metrics';
  static const String progressCharts = '/fitness/progress';
  static const String workoutBuilder = '/fitness/builder';

  // Profile
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String editAccount = '/edit-account';
  static const String changePassword = '/change-password';

  // Ayurveda (Phase 3)
  static const String ayurvedaDoshaProfile = '/ayurveda/dosha-profile';
  static const String ayurvedaYoga = '/ayurveda/yoga';
  static const String ayurvedaYogaSession = '/ayurveda/yoga-session';
  static const String ayurvedaPranayama = '/ayurveda/pranayama';
  static const String ayurvedaPranayamaGuide = '/ayurveda/pranayama-guide';
  static const String ayurvedaRemedies = '/ayurveda/remedies';
  static const String ayurvedaRemedyDetail = '/ayurveda/remedy-detail';
  static const String ayurvedaDinacharya = '/ayurveda/dinacharya';
  static const String ayurvedaRitucharya = '/ayurveda/ritucharya';
  static const String ayurvedaPrograms = '/ayurveda/programs';
  static const String ayurvedaProgramDetail = '/ayurveda/program-detail';

  // Reminder
  static const String reminder = '/reminder';

  // Onboarding goals (post sign-up)
  static const String goalSelection = '/goals';
}
