# BeYou Project Context

> Last Updated: March 6, 2026

## Project Overview
- **Name**: BeYou - Your Complete Wellness Journey
- **Type**: Flutter Mobile App (iOS/Android) + Web
- **Target Market**: India-first wellness super-app
- **Launch Target**: September 30, 2026 (Beta), January 31, 2027 (Public)

## Tech Stack
| Layer | Technology |
|-------|------------|
| Framework | Flutter 3.x + Dart 3.x |
| State Management | flutter_bloc (BLoC pattern) |
| Backend | Firebase (Auth, Firestore, Storage, Functions) |
| Navigation | GoRouter |
| Architecture | Clean Architecture (MIGRATION IN PROGRESS) |
| Local Storage | Hive |
| Dependencies | 40+ packages |

## Current Architecture Status

### Directory Structure (Before Migration)
```
lib/
├── app.dart
├── main.dart
├── firebase_options.dart
├── core/
│   ├── constants/
│   ├── di/injection.dart           # ⚠️ Almost empty
│   ├── router/
│   ├── service/                    # ⚠️ Mixed with utils, duplicates exist
│   ├── theme/
│   ├── utils/                      # ⚠️ Has duplicates with service/
│   └── widgets/
├── data/                           # ⚠️ Only data files, no repos/datasources
│   ├── workout_data.dart
│   └── exercise_data.dart
├── features/
│   └── dosha/                      # ✅ Only complete feature
└── screens/                        # ❌ All screens here - violates Clean Architecture
    ├── auth/ (sign_in, sign_up, forgot_password)
    ├── onboarding/
    ├── home/
    ├── workouts/
    ├── workout_details_screen/
    ├── start_workout/
    ├── settings/
    ├── edit_account/
    ├── change_password/
    ├── reminder/
    └── common_widgets/
```

### Target Architecture (After Migration)
```
lib/
├── main.dart
├── app.dart
├── firebase_options.dart
│
├── core/                           # Shared across app
│   ├── constants/                  # App constants, colors, strings
│   ├── di/injection.dart          # All dependencies registered
│   ├── router/                     # GoRouter config
│   ├── theme/                      # App theming
│   ├── utils/                      # Utilities & extensions
│   └── widgets/                    # Reusable UI components
│
├── data/                           # Data layer
│   ├── models/                     # Data models
│   ├── repositories/               # Repository implementations
│   ├── datasources/                # Local & Remote data sources
│   └── services/                   # External services (Firebase, APIs)
│
└── features/                       # Feature modules
    ├── auth/                       # Sign in, Sign up, Forgot password
    ├── onboarding/                  # Welcome, goals, preferences
    ├── home/                       # Main home screen
    ├── navigation/                  # Bottom navigation shell
    ├── fitness/                    # Workouts, exercises
    ├── mindfulness/               # Meditation, breathing
    ├── meal/                       # Food tracking, nutrition
    ├── profile/                   # User profile, settings
    ├── dosha/                     # Ayurvedic dosha (exists)
    └── ...
```

---

## Migration Plan

### Order: Onboarding → Auth → Home → Others

---

### PHASE 1: Onboarding Feature

**Files to Move (6 files):**
| # | Current Path | New Path |
|---|---------------|----------|
| 1 | `lib/screens/onboarding/bloc/onboarding_bloc.dart` | `lib/features/onboarding/bloc/onboarding_bloc.dart` |
| 2 | `lib/screens/onboarding/bloc/onboarding_event.dart` | `lib/features/onboarding/bloc/onboarding_event.dart` |
| 3 | `lib/screens/onboarding/bloc/onboarding_state.dart` | `lib/features/onboarding/bloc/onboarding_state.dart` |
| 4 | `lib/screens/onboarding/page/onboarding_page.dart` | `lib/features/onboarding/pages/onboarding_page.dart` |
| 5 | `lib/screens/onboarding/widget/onboarding_content.dart` | `lib/features/onboarding/widgets/onboarding_content.dart` |
| 6 | `lib/screens/onboarding/widget/onboarding_tile.dart` | `lib/features/onboarding/widgets/onboarding_tile.dart` |

**Files to Create (1 file):**
- `lib/features/onboarding/data/onboarding_data.dart` - Extract from DataConstants

**Files to Update (2 files):**
- `lib/core/router/app_router.dart` - Update import path
- `lib/features/onboarding/pages/onboarding_page.dart` - Fix internal imports

---

### PHASE 2: Auth Feature

**Files to Move (12 files):**
| # | Current Path | New Path |
|---|---------------|----------|
| 1 | `lib/screens/sign_in/bloc/sign_in_bloc.dart` | `lib/features/auth/bloc/sign_in_bloc.dart` |
| 2 | `lib/screens/sign_in/bloc/sign_in_event.dart` | `lib/features/auth/bloc/sign_in_event.dart` |
| 3 | `lib/screens/sign_in/bloc/sign_in_state.dart` | `lib/features/auth/bloc/sign_in_state.dart` |
| 4 | `lib/screens/sign_in/page/sign_in_page.dart` | `lib/features/auth/pages/sign_in_page.dart` |
| 5 | `lib/screens/sign_in/widget/sign_in_content.dart` | `lib/features/auth/widgets/sign_in_content.dart` |
| 6 | `lib/screens/sign_up/bloc/signup_bloc.dart` | `lib/features/auth/bloc/signup_bloc.dart` |
| 7 | `lib/screens/sign_up/bloc/signup_event.dart` | `lib/features/auth/bloc/signup_event.dart` |
| 8 | `lib/screens/sign_up/bloc/signup_state.dart` | `lib/features/auth/bloc/signup_state.dart` |
| 9 | `lib/screens/sign_up/page/sign_up_page.dart` | `lib/features/auth/pages/sign_up_page.dart` |
| 10 | `lib/screens/sign_up/widget/sign_up_content.dart` | `lib/features/auth/widgets/sign_up_content.dart` |
| 11 | `lib/screens/forgot_password/page/forgot_password_page.dart` | `lib/features/auth/pages/forgot_password_page.dart` |
| 12 | `lib/screens/forgot_password/widget/forgot_password_content.dart` | `lib/features/auth/widgets/forgot_password_content.dart` |

**Files to Create (2 files):**
- `lib/features/auth/data/auth_repository.dart` - Auth repository
- `lib/features/auth/models/user_model.dart` - User model

**Files to Update (3 files):**
- `lib/core/router/app_router.dart` - Update import paths
- `lib/core/di/injection.dart` - Register AuthRepository

---

### PHASE 3: Home Feature

**Files to Move (10 files):**
| # | Current Path | New Path |
|---|---------------|----------|
| 1 | `lib/screens/home/bloc/home_bloc.dart` | `lib/features/home/bloc/home_bloc.dart` |
| 2 | `lib/screens/home/bloc/home_event.dart` | `lib/features/home/bloc/home_event.dart` |
| 3 | `lib/screens/home/bloc/home_state.dart` | `lib/features/home/bloc/home_state.dart` |
| 4 | `lib/screens/home/page/home_page.dart` | `lib/features/home/pages/home_page.dart` |
| 5 | `lib/screens/home/widget/home_content.dart` | `lib/features/home/widgets/home_content.dart` |
| 6 | `lib/screens/home/widget/home_exercises_card.dart` | `lib/features/home/widgets/home_exercises_card.dart` |
| 7 | `lib/screens/home/widget/home_statistics.dart` | `lib/features/home/widgets/home_statistics.dart` |
| 8 | `lib/screens/tab_bar/bloc/tab_bar_bloc.dart` | `lib/features/navigation/bloc/tab_bar_bloc.dart` |
| 9 | `lib/screens/tab_bar/bloc/tab_bar_event.dart` | `lib/features/navigation/bloc/tab_bar_event.dart` |
| 10 | `lib/screens/tab_bar/bloc/tab_bar_state.dart` | `lib/features/navigation/bloc/tab_bar_state.dart` |
| 11 | `lib/screens/tab_bar/page/tab_bar_page.dart` | `lib/features/navigation/pages/navigation_shell.dart` |

**Files to Create (1 file):**
- `lib/features/navigation/widgets/bottom_nav_bar.dart` - Extract bottom nav widget

**Files to Update (2 files):**
- `lib/core/router/app_router.dart` - Update import paths
- `lib/features/home/widgets/home_content.dart` - Fix internal imports

---

### PHASE 4: Fitness Feature

**Files to Move (15 files):**
| # | Current Path | New Path |
|---|---------------|----------|
| 1 | `lib/screens/workouts/bloc/workouts_bloc.dart` | `lib/features/fitness/bloc/workouts_bloc.dart` |
| 2 | `lib/screens/workouts/bloc/workouts_event.dart` | `lib/features/fitness/bloc/workouts_event.dart` |
| 3 | `lib/screens/workouts/bloc/workouts_state.dart` | `lib/features/fitness/bloc/workouts_state.dart` |
| 4 | `lib/screens/workouts/page/workouts_page.dart` | `lib/features/fitness/pages/workouts_page.dart` |
| 5 | `lib/screens/workouts/widget/workout_content.dart` | `lib/features/fitness/widgets/workout_content.dart` |
| 6 | `lib/screens/workouts/widget/workout_card.dart` | `lib/features/fitness/widgets/workout_card.dart` |
| 7 | `lib/screens/workout_details_screen/bloc/workoutdetails_bloc.dart` | `lib/features/fitness/bloc/workout_details_bloc.dart` |
| 8 | `lib/screens/workout_details_screen/bloc/workoutdetails_event.dart` | `lib/features/fitness/bloc/workout_details_event.dart` |
| 9 | `lib/screens/workout_details_screen/bloc/workoutdetails_state.dart` | `lib/features/fitness/bloc/workout_details_state.dart` |
| 10 | `lib/screens/workout_details_screen/page/workout_details_page.dart` | `lib/features/fitness/pages/workout_details_page.dart` |
| 11 | `lib/screens/workout_details_screen/widget/workout_details_content.dart` | `lib/features/fitness/widgets/workout_details_content.dart` |
| 12 | `lib/screens/workout_details_screen/widget/workout_details_body.dart` | `lib/features/fitness/widgets/workout_details_body.dart` |
| 13 | `lib/screens/start_workout/bloc/start_workout_bloc.dart` | `lib/features/fitness/bloc/start_workout_bloc.dart` |
| 14 | `lib/screens/start_workout/bloc/start_workout_event.dart` | `lib/features/fitness/bloc/start_workout_event.dart` |
| 15 | `lib/screens/start_workout/bloc/start_workout_state.dart` | `lib/features/fitness/bloc/start_workout_state.dart` |
| 16 | `lib/screens/start_workout/page/start_workout_page.dart` | `lib/features/fitness/pages/start_workout_page.dart` |
| 17 | `lib/screens/start_workout/widget/start_workout_content.dart` | `lib/features/fitness/widgets/start_workout_content.dart` |
| 18 | `lib/screens/start_workout/widget/start_workout_timer.dart` | `lib/features/fitness/widgets/start_workout_timer.dart` |
| 19 | `lib/screens/start_workout/widget/start_workout_video.dart` | `lib/features/fitness/widgets/start_workout_video.dart` |

**Files to Create (2 files):**
- `lib/features/fitness/data/workout_repository.dart`
- `lib/features/fitness/models/exercise_model.dart`

---

### PHASE 5: Profile/Settings Feature

**Files to Move (10 files):**
| # | Current Path | New Path |
|---|---------------|----------|
| 1 | `lib/screens/settings/bloc/bloc/settings_bloc.dart` | `lib/features/profile/bloc/settings_bloc.dart` |
| 2 | `lib/screens/settings/bloc/bloc/settings_event.dart` | `lib/features/profile/bloc/settings_event.dart` |
| 3 | `lib/screens/settings/bloc/bloc/settings_state.dart` | `lib/features/profile/bloc/settings_state.dart` |
| 4 | `lib/screens/settings/settings_screen.dart` | `lib/features/profile/pages/settings_page.dart` |
| 5 | `lib/screens/edit_account/bloc/edit_account_bloc.dart` | `lib/features/profile/bloc/edit_account_bloc.dart` |
| 6 | `lib/screens/edit_account/bloc/edit_account_event.dart` | `lib/features/profile/bloc/edit_account_event.dart` |
| 7 | `lib/screens/edit_account/bloc/edit_account_state.dart` | `lib/features/profile/bloc/edit_account_state.dart` |
| 8 | `lib/screens/edit_account/edit_account_screen.dart` | `lib/features/profile/pages/edit_account_page.dart` |
| 9 | `lib/screens/change_password/bloc/change_password_bloc.dart` | `lib/features/profile/bloc/change_password_bloc.dart` |
| 10 | `lib/screens/change_password/bloc/change_password_event.dart` | `lib/features/profile/bloc/change_password_event.dart` |
| 11 | `lib/screens/change_password/bloc/change_password_state.dart` | `lib/features/profile/bloc/change_password_state.dart` |
| 12 | `lib/screens/change_password/change_password_page.dart` | `lib/features/profile/pages/change_password_page.dart` |

---

### PHASE 6: Reminder Feature

**Files to Move (3 files):**
| # | Current Path | New Path |
|---|---------------|----------|
| 1 | `lib/screens/reminder/bloc/reminder_bloc.dart` | `lib/features/reminder/bloc/reminder_bloc.dart` |
| 2 | `lib/screens/reminder/bloc/reminder_event.dart` | `lib/features/reminder/bloc/reminder_event.dart` |
| 3 | `lib/screens/reminder/bloc/reminder_state.dart` | `lib/features/reminder/bloc/reminder_state.dart` |
| 4 | `lib/screens/reminder/page/reminder_page.dart` | `lib/features/reminder/pages/reminder_page.dart` |
| 5 | `lib/screens/reminder/widget/reminder_content.dart` | `lib/features/reminder/widgets/reminder_content.dart` |

---

### PHASE 7: Common Widgets & Data Layer

**Common Widgets to Move:**
- `lib/screens/common_widgets/fitness_button.dart` → `lib/core/widgets/`
- `lib/screens/common_widgets/fitness_text_field.dart` → `lib/core/widgets/`
- `lib/screens/common_widgets/fitness_loading.dart` → `lib/core/widgets/`
- `lib/screens/common_widgets/settings_container.dart` → `lib/core/widgets/`
- `lib/screens/common_widgets/settings_textfield.dart` → `lib/core/widgets/`

**Data Layer:**
- `lib/data/workout_data.dart` → `lib/data/models/workout_data.dart`
- `lib/data/exercise_data.dart` → `lib/data/models/exercise_data.dart`

**Service Consolidation:**
- Move `lib/core/service/*.dart` → `lib/data/services/`
- Delete duplicates in `lib/core/utils/`

---

## Files to Update After All Phases

| File | Changes Needed |
|------|---------------|
| `lib/core/router/app_router.dart` | Update all feature imports |
| `lib/core/di/injection.dart` | Register all repositories & services |
| `lib/core/router/route_names.dart` | May need new route constants |

---

## Verification Steps

After each phase:
1. Run `flutter analyze` to check for errors
2. Test navigation to all affected screens
3. Verify all imports resolve correctly

---

## Status

| Phase | Feature | Status |
|-------|---------|--------|
| 1 | Onboarding | Pending |
| 2 | Auth | Pending |
| 3 | Home | Pending |
| 4 | Fitness | Pending |
| 5 | Profile/Settings | Pending |
| 6 | Reminder | Pending |
| 7 | Data Layer Cleanup | Pending |

---

## Notes
- Keep old `screens/` as backup during migration
- Use git to track all changes
- Test each phase before proceeding
- Keep BLoC pattern as-is (already working)
- Keep GoRouter configuration
