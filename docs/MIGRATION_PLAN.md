# BeYou Clean Architecture Migration Plan

> **Last Updated:** March 6, 2026  
> **Approach:** Incremental feature-by-feature migration  
> **Order:** Onboarding → Auth → Home → Others

---

## Migration Strategy

### What Will Change
1. **Directory Structure** - Screens move from `lib/screens/` to `lib/features/<feature>/`
2. **Imports** - All imports update to new paths
3. **Router** - Update imports in `app_router.dart`
4. **DI Container** - Register new repositories/services
5. **Models** - Move to `lib/data/models/`

### What Stays the Same
- BLoC pattern (already in use)
- GoRouter (already configured)
- GetIt for DI (already setup)
- Core utilities (theme, constants, widgets)

---

## HUMAN TASKS (Do these yourself)
- [ ] Verify Flutter dependencies installed: `flutter pub get`
- [ ] Confirm branch is ready: `git status`
- [ ] Test initial build: `flutter build apk --debug`

---

## PHASE 1: Onboarding Feature

### Current Location
```
lib/screens/onboarding/
├── bloc/
│   ├── onboarding_bloc.dart
│   ├── onboarding_event.dart
│   └── onboarding_state.dart
├── page/
│   └── onboarding_page.dart
└── widget/
    ├── onboarding_content.dart
    └── onboarding_tile.dart
```

### Target Location
```
lib/features/onboarding/
├── bloc/
│   ├── onboarding_bloc.dart
│   ├── onboarding_event.dart
│   └── onboarding_state.dart
├── pages/
│   └── onboarding_page.dart
├── widgets/
│   ├── onboarding_content.dart
│   └── onboarding_tile.dart
└── data/
    └── onboarding_data.dart        # NEW - Move from DataConstants
```

### Files to Create
- `lib/features/onboarding/data/onboarding_data.dart` - Extract from DataConstants

### Files to Move (5)
1. `lib/screens/onboarding/bloc/onboarding_bloc.dart` → `lib/features/onboarding/bloc/`
2. `lib/screens/onboarding/bloc/onboarding_event.dart` → `lib/features/onboarding/bloc/`
3. `lib/screens/onboarding/bloc/onboarding_state.dart` → `lib/features/onboarding/bloc/`
4. `lib/screens/onboarding/page/onboarding_page.dart` → `lib/features/onboarding/pages/`
5. `lib/screens/onboarding/widget/onboarding_content.dart` → `lib/features/onboarding/widgets/`
6. `lib/screens/onboarding/widget/onboarding_tile.dart` → `lib/features/onboarding/widgets/`

### Files to Update (3)
1. `lib/core/router/app_router.dart` - Change import path
2. `lib/features/onboarding/bloc/onboarding_bloc.dart` - Fix import path
3. `lib/features/onboarding/pages/onboarding_page.dart` - Fix import path

### HUMAN TASKS AFTER AGENT COMPLETES:
- [ ] Run: `flutter analyze`
- [ ] Test: Navigate to onboarding screen
- [ ] Verify: No broken imports
- [ ] Say: "all done properly" when verified

---

## PHASE 2: Auth Feature

### Current Location
```
lib/screens/
├── sign_in/
│   ├── bloc/
│   │   ├── sign_in_bloc.dart
│   │   ├── sign_in_event.dart
│   │   └── sign_in_state.dart
│   ├── page/
│   │   └── sign_in_page.dart
│   └── widget/
│       └── sign_in_content.dart
├── sign_up/
│   ├── bloc/
│   │   ├── signup_bloc.dart
│   │   ├── signup_event.dart
│   │   └── signup_state.dart
│   ├── page/
│   │   └── sign_up_page.dart
│   └── widget/
│       └── sign_up_content.dart
└── forgot_password/
    ├── bloc/
    │   ├── forgot_password_bloc.dart
    │   ├── forgot_password_event.dart
    │   └── forgot_password_state.dart
    ├── page/
    │   └── forgot_password_page.dart
    └── widget/
        └── forgot_password_content.dart
```

### Target Location
```
lib/features/auth/
├── bloc/
│   ├── auth_bloc.dart              # MERGE - Combine all auth blocs
│   ├── auth_event.dart
│   └── auth_state.dart
├── pages/
│   ├── sign_in_page.dart
│   ├── sign_up_page.dart
│   └── forgot_password_page.dart
├── widgets/
│   ├── sign_in_content.dart
│   ├── sign_up_content.dart
│   └── forgot_password_content.dart
├── data/
│   └── auth_repository.dart        # NEW - Create repository
└── models/
    └── user_model.dart             # NEW - User model
```

### Files to Create (2)
1. `lib/features/auth/data/auth_repository.dart` - Create repository
2. `lib/features/auth/models/user_model.dart` - User model

### Files to Move (12)
- All sign_in, sign_up, forgot_password files

### Files to Merge (3 → 1)
- Combine 3 BLoCs into single `AuthBloc`

### Files to Update (4)
1. `lib/core/router/app_router.dart` - Update imports
2. `lib/core/di/injection.dart` - Register AuthRepository
3. Create `lib/features/auth/exports.dart` - Barrel file

### HUMAN TASKS AFTER AGENT COMPLETES:
- [ ] Run: `flutter analyze`
- [ ] Test: Sign in, Sign up, Forgot password flows
- [ ] Verify: AuthBloc works correctly
- [ ] Say: "all done properly" when verified

---

## PHASE 3: Home Feature

### Current Location
```
lib/screens/
├── home/
│   ├── bloc/
│   │   ├── home_bloc.dart
│   │   ├── home_event.dart
│   │   └── home_state.dart
│   ├── page/
│   │   └── home_page.dart
│   └── widget/
│       ├── home_content.dart
│       ├── home_exercises_card.dart
│       └── home_statistics.dart
└── tab_bar/
    ├── bloc/
    │   ├── tab_bar_bloc.dart
    │   ├── tab_bar_event.dart
    │   └── tab_bar_state.dart
    └── page/
        └── tab_bar_page.dart
```

### Target Location
```
lib/features/home/
├── bloc/
│   ├── home_bloc.dart
│   ├── home_event.dart
│   └── home_state.dart
├── pages/
│   └── home_page.dart
└── widgets/
    ├── home_content.dart
    ├── home_exercises_card.dart
    └── home_statistics.dart

lib/features/navigation/
├── bloc/
│   ├── navigation_bloc.dart
│   ├── navigation_event.dart
│   └── navigation_state.dart
├── pages/
│   └── navigation_shell.dart       # NEW - Main tab bar shell
└── widgets/
    └── bottom_nav_bar.dart         # NEW - Extract from tab_bar_page
```

### Notes
- `TabBarPage` contains both navigation AND acts as shell for home
- Split into: Navigation feature + Home feature
- TabBarPage becomes the shell that holds bottom navigation

### Files to Create (2)
1. `lib/features/navigation/pages/navigation_shell.dart` - Main app shell
2. `lib/features/navigation/widgets/bottom_nav_bar.dart` - Extract bottom nav

### Files to Move (10)
- Move home/ and tab_bar/ to features/

### Files to Update (5)
1. `lib/core/router/app_router.dart` - Update imports, use navigation_shell
2. `lib/core/di/injection.dart` - Register repositories

### HUMAN TASKS AFTER AGENT COMPLETES:
- [ ] Run: `flutter analyze`
- [ ] Test: Home screen and bottom navigation
- [ ] Verify: Navigation shell works
- [ ] Say: "all done properly" when verified

---

## PHASE 4: Fitness Feature

### Current Location
```
lib/screens/
├── workouts/
│   ├── bloc/
│   │   ├── workouts_bloc.dart
│   │   ├── workouts_event.dart
│   │   └── workouts_state.dart
│   ├── page/
│   │   └── workouts_page.dart
│   └── widget/
│       ├── workout_content.dart
│       └── workout_card.dart
├── workout_details_screen/
│   ├── bloc/
│   │   ├── workoutdetails_bloc.dart
│   │   ├── workoutdetails_event.dart
│   │   └── workoutdetails_state.dart
│   ├── page/
│   │   └── workout_details_page.dart
│   └── widget/
│       ├── workout_details_content.dart
│       ├── workout_details_body.dart
│       └── panel/
│           ├── exercises_list.dart
│           ├── workout_details_panel.dart
│           └── workout_tag.dart
└── start_workout/
    ├── bloc/
    │   ├── start_workout_bloc.dart
    │   ├── start_workout_event.dart
    │   └── start_workout_state.dart
    ├── page/
    │   └── start_workout_page.dart
    └── widget/
        ├── start_workout_content.dart
        ├── start_workout_timer.dart
        └── start_workout_video.dart
```

### Target Location
```
lib/features/fitness/
├── bloc/
│   ├── workouts_bloc.dart
│   ├── workouts_event.dart
│   ├── workouts_state.dart
│   ├── workout_details_bloc.dart
│   ├── workout_details_event.dart
│   ├── workout_details_state.dart
│   ├── start_workout_bloc.dart
│   ├── start_workout_event.dart
│   └── start_workout_state.dart
├── pages/
│   ├── workouts_page.dart
│   ├── workout_details_page.dart
│   └── start_workout_page.dart
├── widgets/
│   ├── workout_content.dart
│   ├── workout_card.dart
│   ├── workout_details_content.dart
│   ├── workout_details_body.dart
│   ├── start_workout_content.dart
│   ├── start_workout_timer.dart
│   ├── start_workout_video.dart
│   └── panel/
│       ├── exercises_list.dart
│       ├── workout_details_panel.dart
│       └── workout_tag.dart
└── data/
    └── workout_repository.dart     # NEW
```

### Files to Create (1)
1. `lib/features/fitness/data/workout_repository.dart` - Create repository

### Files to Move (19)
- All workouts/, workout_details_screen/, start_workout/ files

### Profile/Settings Feature
```
lib/features/profile/
├── bloc/
│   ├── settings_bloc.dart
│   ├── edit_account_bloc.dart
│   └── change_password_bloc.dart
├── pages/
│   ├── settings_page.dart
│   ├── edit_account_page.dart
│   └── change_password_page.dart
└── widgets/
```

### HUMAN TASKS AFTER AGENT COMPLETES:
- [ ] Run: `flutter analyze`
- [ ] Test: Settings, Edit Account, Change Password screens
- [ ] Verify: Profile flows work
- [ ] Say: "all done properly" when verified

---

### Reminder Feature
```
lib/features/reminder/
├── bloc/
├── pages/
│   └── reminder_page.dart
└── widgets/
```

### HUMAN TASKS AFTER AGENT COMPLETES:
- [ ] Run: `flutter analyze`
- [ ] Test: Reminder screen
- [ ] Verify: All reminder functionality works
- [ ] Say: "all done properly" when verified

---

## PHASE 5: Data Layer Cleanup

### Create Missing Directories
```
lib/data/
├── models/
│   ├── user_model.dart
│   ├── workout_model.dart
│   ├── exercise_model.dart
│   └── meal_model.dart
├── repositories/
│   ├── auth_repository.dart
│   ├── workout_repository.dart
│   ├── user_repository.dart
│   └── meal_repository.dart
├── datasources/
│   ├── local/                      # Hive data sources
│   └── remote/                     # Firebase data sources
└── services/
    └── firebase_service.dart       # NEW - Central Firebase service
```

### Consolidate Services
- Move `core/service/*.dart` → `data/services/`
- Delete duplicates in `core/utils/`

### HUMAN TASKS AFTER AGENT COMPLETES:
- [ ] Run: `flutter analyze`
- [ ] Run: `flutter build apk --debug`
- [ ] Test: Full app functionality
- [ ] Verify: No broken imports anywhere
- [ ] Say: "all done properly" when verified

---

## Implementation Order

| Step | Feature | Files | Status |
|------|---------|-------|--------|
| 1 | Create feature directories | - | Pending |
| 2 | Onboarding | 6 files | Pending |
| 3 | Auth | 14 files | Pending |
| 4 | Home | 12 files | Pending |
| 5 | Fitness | 15 files | Pending |
| 6 | Profile/Settings | 10 files | Pending |
| 7 | Reminder | 3 files | Pending |
| 8 | Data Layer | 10+ files | Pending |

---

## Verification Steps After Each Phase

1. **Build check**: `flutter build apk --debug`
2. **Router check**: All routes work correctly
3. **Import check**: No broken imports
4. **BLoC check**: All state management works

---

## Estimated Time

- **Phase 1 (Onboarding)**: ~15 minutes
- **Phase 2 (Auth)**: ~30 minutes
- **Phase 3 (Home)**: ~25 minutes
- **Phase 4-5 (Others)**: ~45 minutes
- **Total**: ~2 hours

---

## Rollback Plan

If issues occur:
1. Keep old `screens/` as backup during migration
2. Use git to track changes
3. Test each phase before proceeding

---

## Ready to Start?

Confirm and I'll begin with **Phase 1: Onboarding Feature**.
