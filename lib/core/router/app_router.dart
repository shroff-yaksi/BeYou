import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:beyou/core/router/route_names.dart';
import 'package:beyou/core/service/go_router_refresh_stream.dart';
import 'package:beyou/data/workout_data.dart';
import 'package:beyou/features/onboarding/pages/onboarding_page.dart';
import 'package:beyou/features/onboarding/pages/goal_selection_page.dart';
import 'package:beyou/screens/tab_bar/page/tab_bar_page.dart';
import 'package:beyou/screens/sign_in/page/sign_in_page.dart';
import 'package:beyou/screens/sign_up/page/sign_up_page.dart';
import 'package:beyou/screens/forgot_password/page/forgot_password_page.dart';
import 'package:beyou/screens/settings/settings_screen.dart';
import 'package:beyou/screens/edit_account/edit_account_screen.dart';
import 'package:beyou/screens/change_password/change_password_page.dart';
import 'package:beyou/screens/reminder/page/reminder_page.dart';
import 'package:beyou/screens/workout_details_screen/page/workout_details_page.dart';

/// Public routes — accessible without authentication
const _publicRoutes = [
  RouteNames.onboarding,
  RouteNames.signIn,
  RouteNames.signUp,
  RouteNames.forgotPassword,
  RouteNames.goalSelection,
];

/// GoRouter configuration for app navigation
class AppRouter {
  AppRouter._(); // Private constructor

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.onboarding,
    debugLogDiagnostics: false,
    refreshListenable: GoRouterRefreshStream(
      FirebaseAuth.instance.authStateChanges(),
    ),
    redirect: (BuildContext context, GoRouterState state) {
      final loggedIn = FirebaseAuth.instance.currentUser != null;
      final location = state.matchedLocation;
      final isPublic = _publicRoutes.contains(location);

      // Not logged in and trying to access a protected route → sign in
      if (!loggedIn && !isPublic) return RouteNames.signIn;

      // Logged in but on a public route → home
      if (loggedIn && isPublic) return RouteNames.home;

      return null; // no redirect
    },
    routes: [
      // Home/Tab Bar (Main Screen)
      GoRoute(
        path: RouteNames.home,
        name: 'home',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const TabBarPage(),
        ),
      ),

      // Onboarding
      GoRoute(
        path: RouteNames.onboarding,
        name: 'onboarding',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const OnboardingPage(),
        ),
      ),

      // Auth Routes
      GoRoute(
        path: RouteNames.signIn,
        name: 'signIn',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SignInPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.signUp,
        name: 'signUp',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: SignUpPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        name: 'forgotPassword',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ForgotPasswordPage(),
        ),
      ),

      // Profile Routes
      GoRoute(
        path: RouteNames.settings,
        name: 'settings',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SettingsScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.editAccount,
        name: 'editAccount',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: EditAccountScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.changePassword,
        name: 'changePassword',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: ChangePasswordScreen(),
        ),
      ),

      // Goal Selection (post sign-up onboarding)
      GoRoute(
        path: RouteNames.goalSelection,
        name: 'goalSelection',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const GoalSelectionPage(),
        ),
      ),

      // Reminder
      GoRoute(
        path: RouteNames.reminder,
        name: 'reminder',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ReminderPage(),
        ),
      ),

      // Workout Details (receives WorkoutData via extra)
      GoRoute(
        path: RouteNames.workoutDetails,
        name: 'workoutDetails',
        pageBuilder: (context, state) {
          final workout = state.extra as WorkoutData;
          return MaterialPage(
            key: state.pageKey,
            child: WorkoutDetailsPage(workout: workout),
          );
        },
      ),
    ],

    // Error page
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              state.uri.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(RouteNames.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
