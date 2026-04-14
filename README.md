<div align="center">

<br/>

```
██████╗ ███████╗██╗   ██╗ ██████╗ ██╗   ██╗
██╔══██╗██╔════╝╚██╗ ██╔╝██╔═══██╗██║   ██║
██████╔╝█████╗   ╚████╔╝ ██║   ██║██║   ██║
██╔══██╗██╔══╝    ╚██╔╝  ██║   ██║██║   ██║
██████╔╝███████╗   ██║   ╚██████╔╝╚██████╔╝
╚═════╝ ╚══════╝   ╚═╝    ╚═════╝  ╚═════╝
```

### Your Complete Wellness Journey

*Fitness · Mindfulness · Nutrition · Community · Ayurveda*

<br/>

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=apple&logoColor=white)](https://apps.apple.com)
[![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)](https://play.google.com)

<br/>

![Status](https://img.shields.io/badge/Status-Active_Development-6358E1?style=flat-square)
![Platform](https://img.shields.io/badge/Platform-iOS_%7C_Android_%7C_Web-6358E1?style=flat-square)
![Phase](https://img.shields.io/badge/Phase-Initial_(P0_Complete)-brightgreen?style=flat-square)
![License](https://img.shields.io/badge/License-Private-red?style=flat-square)

</div>

---

## What is BeYou?

BeYou is a **premium wellness super-app** built for India — one unified platform replacing five different health apps. Think of it as the intersection of fitness tracking, guided meditation, Ayurvedic wisdom, food logging, and community — all designed with an India-first mindset.

The goal: help 100 million Indians build sustainable wellness habits, one day at a time.

---

## Feature Modules

<table>
<tr>
<td width="50%">

### 🏋️ Fitness
- 800+ exercises (open-source database)
- Workout programs (strength, HIIT, yoga, cardio)
- Active workout timer with rest intervals
- Set / rep / weight logging
- Progress charts & streak tracking
- GPS for outdoor sessions

</td>
<td width="50%">

### 🧘 Mindfulness
- Guided meditation library (20+ sessions)
- Breathing exercises (4-7-8, box, Wim Hof)
- Sleep sounds & bedtime routines
- Daily mood check-in & journal
- **I Am Clean** — addiction recovery tracker
- Dosha assessment (Vata / Pitta / Kapha)

</td>
</tr>
<tr>
<td width="50%">

### 🥗 Nutrition
- Open Food Facts API integration
- Indian food database (500+ items, growing)
- Macro & micronutrient tracking
- Barcode scanner & photo recognition
- Fasting timer (16:8, 18:6, OMAD)
- Recipe library with step-by-step guides

</td>
<td width="50%">

### 👥 Community *(Phase 6)*
- Social feed & progress sharing
- Challenges & leaderboards
- Group clubs by interest/location
- Live workout & meditation sessions
- Accountability partner matching
- Creator platform for trainers & coaches

</td>
</tr>
</table>

---

## Tech Stack

| Layer | Technology | Why |
|-------|-----------|-----|
| **Framework** | Flutter 3.x (Dart) | Single codebase for iOS, Android, Web |
| **State Management** | flutter_bloc (BLoC pattern) | Predictable, testable, event-driven |
| **Backend** | Firebase (Auth, Firestore, Storage) | Realtime, scalable, India-region support |
| **Navigation** | GoRouter + auth redirect | Deep linking, auth guards, type-safe routes |
| **DI** | GetIt (service locator) | Lazy singletons, fast startup |
| **Local Storage** | Hive | Offline support, encrypted health data |
| **Media** | Chewie + video_player | Workout demo videos |
| **Charts** | fl_chart *(Phase 2)* | Progress visualization |
| **Payments** | Razorpay *(Phase 6)* | UPI, cards, wallets — India native |
| **Notifications** | flutter_local_notifications | Workout & mindfulness reminders |

---

## Architecture

```
lib/
├── core/                   # Shared kernel
│   ├── constants/          # Colors, text, paths, data
│   ├── di/                 # GetIt dependency injection
│   ├── router/             # GoRouter + auth redirect
│   ├── service/            # Auth, User, Notification, Validation
│   ├── theme/              # AppTheme, ColorScheme, typography
│   └── utils/              # Exceptions, date helpers
│
├── data/                   # Data models (WorkoutData, ExerciseData)
│
├── features/               # Clean Architecture modules
│   ├── dosha/              # ← Reference implementation
│   │   ├── data/           # DoshaRepository, DoshaResult model
│   │   ├── bloc/           # DoshaBloc (on<Event> pattern)
│   │   └── views/          # Onboarding → Assessment → Results → History
│   └── onboarding/         # Welcome screens
│
└── screens/                # Legacy screens (migrating to features/)
    ├── home/               # Dashboard, stats, workout cards
    ├── workouts/           # Workout list, cards
    ├── sign_in/            # Auth BLoC + UI
    ├── sign_up/            # Auth BLoC + UI
    ├── settings/           # Profile, sign out
    └── tab_bar/            # Bottom navigation
```

> **Architecture Rule:** `lib/features/dosha/` is the **reference implementation** for all new modules. Each feature gets its own `data/` + `bloc/` + `views/` triad, registered via GetIt.

---

## Design System

BeYou uses a **flat, touch-first, premium mobile** design language.

| Token | Value | Usage |
|-------|-------|-------|
| **Primary** | `#6358E1` | Buttons, active states, highlights |
| **Background** | `#FCFCFC` | Screen background |
| **Surface** | `#FFFFFF` | Cards, sheets |
| **Text Primary** | `#1A1A2E` | Headlines, body |
| **Text Secondary** | `#64748B` | Captions, muted labels |
| **Error** | `#DC2626` | Destructive actions, validation |
| **Dosha Vata** | `#6C63FF` | Air & Ether |
| **Dosha Pitta** | `#FF7043` | Fire & Water |
| **Dosha Kapha** | `#4CAF50` | Earth & Water |

**Typography:** NotoSansKR (current) → DM Sans (migration planned for premium feel)

**Motion:** 150–300ms micro-interactions, `ease-out` enter, `ease-in` exit, spring physics for sheets

**Icons:** Material Icons throughout — no emoji as structural icons

---

## Getting Started

### Prerequisites

```bash
flutter --version   # Flutter 3.x required
firebase --version  # Firebase CLI (optional, for backend work)
```

### Run Locally

```bash
# 1. Clone & install
git clone https://github.com/shroff-yaksi/beyou.git
cd beyou
flutter pub get

# 2. Run on Chrome (web)
flutter run -d chrome --web-port 3001

# 3. Run on iOS (release, avoids JIT block on iOS 26+)
flutter run -d <device-id> --release

# 4. Run on Android
flutter run -d <device-id>
```

### iOS Setup Notes

> iOS 26+ (beta) blocks Dart JIT in debug mode (`EXC_BAD_ACCESS code=50`).
> Always use `--release` flag for physical iPhone testing.

```bash
# Get device ID
flutter devices

# Run release build
flutter run -d 00008150-XXXXXXXXXXXXXX --release
```

### Firebase

The app uses `lib/firebase_options.dart` (auto-generated via FlutterFire CLI).
Firebase project: `fitnessfinal-3e6fa` (Auth + Firestore + Storage enabled).

For Google Sign-In on iOS, add `REVERSED_CLIENT_ID` URL scheme in Xcode:
`Targets → Runner → Info → URL Types`

---

## Development Phases

| Phase | Focus | Status |
|-------|-------|--------|
| **P0 — Foundation** | Firebase Auth, GoRouter guards, Firestore user docs, Google Sign-In | ✅ Complete |
| **P1 — User Profile** | Profile editing, avatar upload, real home data, goal onboarding | 🔄 Next |
| **P2 — Fitness Module** | Exercise DB, active workout, history, progress charts, streaks | ⏳ Planned |
| **P3 — Mindfulness** | Meditation player, breathing, mood journal, I Am Clean | ⏳ Planned |
| **P4 — Nutrition** | Food logging, Open Food Facts, macros, fasting timer, recipes | ⏳ Planned |
| **P5 — MVP Launch** | Analytics, Crashlytics, App Store + Play Store beta | ⏳ Planned |
| **P6+ — Scale** | Community, Challenges, Razorpay, Creator platform, Wearables | 🔮 Future |

---

## Key Design Decisions

**Why BLoC?** Enforces strict separation between UI and business logic. Every user action is an explicit event — no magic state mutations.

**Why GoRouter with `refreshListenable`?** Auth-aware routing out of the box. When Firebase auth state changes (sign in / sign out), the router automatically redirects without any manual `Navigator.push` calls.

**Why `--release` on iPhone?** iOS 26 beta blocks Dart's JIT compiler for security. Release mode uses AOT compilation which is actually faster and eliminates this issue entirely.

**Why Dosha as the reference feature?** It's self-contained (no network calls), covers the full BLoC lifecycle (loading → success → error), uses GoRouter properly, and has a complete 4-screen flow that demonstrates the pattern.

---

## Project Documents

All planning documents live in `docs/`:

| Document | Purpose |
|----------|---------|
| [`docs/MASTER_PLAN.md`](docs/MASTER_PLAN.md) | Phase-by-phase build plan |
| [`docs/App.md`](docs/App.md) | Full product vision (3-year north star) |
| [`docs/Dev.md`](docs/Dev.md) | Tech stack details & architecture rules |
| [`docs/Business_Analysis.md`](docs/Business_Analysis.md) | Business model, pricing, unit economics |
| [`docs/Research.md`](docs/Research.md) | Market data, competitors, user personas |
| [`docs/Finances.md`](docs/Finances.md) | Cost projections & revenue model |
| [`docs/STITCH_UI.md`](docs/STITCH_UI.md) | UI spec for all 14 screens |

---

## Stitch Designs

All 14 screen mockups are in `stitch/` — these are the **source of truth for UI**:

```
stitch/
├── home_screen/           ✅ Implemented
├── workouts_list/         ✅ Implemented
├── workout_details/       ✅ Implemented
├── start_workout/         ✅ Implemented
├── dosha_assessment_onboarding/  ✅ Implemented
├── dosha_assessment_questions/   ✅ Implemented
├── dosha_assessment_results/     ✅ Implemented
├── assessment_history/    ✅ Implemented
├── settings/              ✅ Implemented
├── edit_account/          ✅ Implemented
├── change_password/       ✅ Implemented
├── reminder_screen/       ✅ Implemented
├── sign_up/               ✅ Implemented
└── onboarding/            ✅ Implemented
```

---

<div align="center">

**Built with 💜 for India's wellness revolution**

*Target: 1,00,000 active users by January 2027*

</div>
