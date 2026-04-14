# Flutter Code Quality Checklist

## Pre-Migration Checks

### Import Safety
- [ ] Always use relative imports for files within the same feature: `../bloc/`
- [ ] Use package imports for cross-feature: `package:beyou/features/auth/`
- [ ] Never use absolute paths like `lib/screens/...`
- [ ] Update all imports when moving files

### File Naming
- [ ] Use snake_case for files: `onboarding_bloc.dart`
- [ ] Use PascalCase for classes: `class OnboardingBloc`
- [ ] Use singular for single entities: `user_model.dart` not `users_model.dart`

### BLoC Pattern
- [ ] Events end with `_event.dart`: `load_onboarding_event.dart`
- [ ] States end with `_state.dart`: `onboarding_loaded_state.dart`
- [ ] Bloc single file: `onboarding_bloc.dart`
- [ ] Export events/states in bloc barrel file

### Clean Architecture Layers
```
lib/features/<feature>/
├── bloc/           # Business logic
├── data/           # Repositories, data sources
├── models/         # Data models
├── pages/          # Screen widgets
└── widgets/        # UI components
```

---

## Common Mistakes to Avoid

### 1. Broken Imports
```dart
// WRONG - hardcoded path
import '../../../screens/onboarding/bloc/onboarding_bloc.dart';

// RIGHT - new path
import 'package:beyou/features/onboarding/bloc/onboarding_bloc.dart';
```

### 2. Missing Exports
```dart
// Add to feature barrel file (exports.dart)
export 'bloc/onboarding_bloc.dart';
export 'bloc/onboarding_event.dart';
export 'bloc/onboarding_state.dart';
export 'pages/onboarding_page.dart';
```

### 3. Router Not Updated
```dart
// Update app_router.dart import
import 'package:beyou/features/onboarding/pages/onboarding_page.dart';
```

### 4. DI Not Registered
```dart
// Add to injection.dart
getIt.registerFactory<OnboardingBloc>(() => OnboardingBloc());
```

---

## Verification Commands

```bash
# Check for issues
flutter analyze

# Find broken imports
grep -r "screens/" lib/

# Find missing exports
grep -r "^export" lib/features/*/ 
```

---

## Code Style

- Use `const` constructors where possible
- Use `@immutable` for BLoC states
- Avoid `dynamic` types
- Use proper null safety
- Prefer `late` over nullable when initialized in initState
