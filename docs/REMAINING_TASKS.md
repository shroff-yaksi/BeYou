# 📋 BeYou — Remaining Tasks
> Last updated: February 24, 2026
> Project start: February 1, 2026 | Target launch: September 30, 2026 (Beta)

---

## 🔴 Phase 1 — Foundation (Feb 1 – Mar 31)
> **Currently in progress. Only basic boilerplate/screens exist. Clean Architecture not yet applied.**

### ❌ Project Setup & Refactoring
- [ ] Apply Clean Architecture folder structure (`core/`, `data/`, `features/`)
- [ ] Migrate screens from `lib/screens/` into feature modules
- [ ] Configure Firebase project (Auth, Firestore, Storage, Functions)
- [ ] Setup GitHub repo + CI/CD (GitHub Actions)

### ❌ Design System
- [ ] Create app theme (colors, typography, spacing tokens)
- [ ] Build reusable widgets (buttons, cards, inputs, loaders)
- [ ] Setup navigation with GoRouter + bottom navigation bar

### ❌ Authentication (BLoC pattern)
- [ ] Email/Password sign in & registration
- [ ] Google Sign-In
- [ ] Password reset flow
- [ ] Auth state management via `flutter_bloc`

### ❌ User Profile
- [ ] Profile creation flow
- [ ] Profile picture upload (Firebase Storage)
- [ ] Firestore user document schema
- [ ] Profile editing screen

### ❌ Onboarding
- [ ] Welcome screens
- [ ] Goal selection
- [ ] Fitness level assessment
- [ ] Preferences setup
- [ ] Home screen shell

---

## 🔴 Phase 2 — Fitness Module (Apr 1 – May 31)
- [ ] Exercise data model + Firestore collection (seed 50–100 exercises)
- [ ] Exercise browse + search + filter + detail screen
- [ ] Video player for demo videos (chewie)
- [ ] Workout builder (add exercises, create custom workouts)
- [ ] Active workout screen: timer, sets/reps, rest timer
- [ ] Workout completion screen
- [ ] 10–20 pre-made workout programs
- [ ] Workout history storage + history list screen
- [ ] Progress charts (`fl_chart`)
- [ ] Streak tracking
- [ ] Health Connect integration (Android) for calorie sync

---

## 🔴 Phase 3 — Mindfulness Module (Jun 1 – Jul 15)
- [ ] Audio player setup + background audio support
- [ ] Meditation library (seed 20–30 free meditations)
- [ ] Meditation browse + player screen
- [ ] Breathing exercise patterns (4-7-8, box breathing) with animated circle
- [ ] Sleep sounds library (background playback + sleep timer)
- [ ] Mood tracking (daily check-in) + journal entry/history
- [ ] "I Am Clean" addiction tracker: streak counter, milestones, relapse handling

---

## 🔴 Phase 4 — Meal Module (Jul 16 – Aug 31)
- [ ] Integrate Open Food Facts API
- [ ] Build initial Indian food database (500 items)
- [ ] Food search + detail screen
- [ ] Daily food logging + quantity adjustment
- [ ] Daily nutrition summary + macro breakdown
- [ ] Water tracking with reminders
- [ ] Recipe library (seed 50–100 recipes, favorites)
- [ ] Fasting timer (16:8, 18:6, etc.) with history

---

## 🟡 Phase 5 — MVP Launch (Sep 1 – Sep 30)
- [ ] Full QA + bug fixes across all modules
- [ ] UI polish (loading states, empty states, animations)
- [ ] App icon + screenshots for stores
- [ ] Privacy policy + Terms of Service pages
- [ ] Submit to Google Play (beta)
- [ ] Submit to App Store (testflight)
- [ ] Setup Firebase Analytics + Crashlytics

---

## 🟢 Phase 6–8 — Post-launch (Oct 2026 – Jan 2027)
- [ ] Community: social feed, likes, comments, public profiles
- [ ] Challenges: leaderboards, join/track challenges
- [ ] Razorpay payment integration
- [ ] Subscription tiers (Free / Basic / Pro) with feature gating
- [ ] E-commerce store basics (product list → cart → checkout)
- [ ] AdMob banner ads (free tier)
- [ ] Performance optimization (launch time, memory, battery)
- [ ] HealthKit integration (iOS)
- [ ] Home screen widget
- [ ] Product Hunt + public launch (Jan 31, 2027)

---

## 🐛 Known Issues
- The current codebase is a **forked fitness starter app** (Perpetio), not a custom build. All screens in `lib/screens/` are placeholder boilerplate and need to be replaced.
- No Clean Architecture has been applied yet — the directory structure does not match the plan in `docs/Dev.md`.
- Firebase is configured (`firebase_options.dart` exists) but services are not wired up.

---

## 📌 Notes
- Target: India-first wellness app on Flutter + Firebase
- Team: 4 members (Flutter Dev, Designer, Backend, Tester)
- Full timeline: Feb 1, 2026 → Jan 31, 2027
