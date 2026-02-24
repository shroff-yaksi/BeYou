# BeYou — Your Complete Wellness Journey

> **Platform:** Flutter (iOS & Android) · **Stage:** In Development · **Target Beta:** September 2026  
> **Market:** India-first · **Team:** 4 members

BeYou is a comprehensive wellness super-app combining **Fitness**, **Mindfulness**, **Nutrition**, **Community**, and **Commerce** into one unified platform — replacing the need for 5+ separate apps.

---

## Modules

| Module | Core Features |
|--------|--------------|
| 🏋️ **Fitness** | 800+ exercises, workout programs, active workout timer, GPS tracking, progress charts, streak tracking |
| 🧘 **Mindfulness** | Guided meditation, breathing exercises, sleep sounds, mood journaling, "I Am Clean" addiction tracker, Ayurvedic wellness |
| 🥗 **Meal & Nutrition** | Food logging (manual, barcode, photo AI), macro tracking, 50,000+ recipes, intermittent fasting timer, meal plans |
| 👥 **Community** | Social feed, workout challenges, groups, leaderboards, live sessions, accountability partners |
| 🛒 **Store** | Gym equipment, Ayurvedic herbs, books, coach directory, workout program marketplace |

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter (Dart) |
| State Management | flutter_bloc (BLoC pattern) |
| Backend | Firebase (Auth, Firestore, Storage, Functions) |
| Navigation | GoRouter |
| Architecture | Clean Architecture (`core/` · `data/` · `features/`) |
| Local DB | Hive |
| Charts | fl_chart |
| Payments | Razorpay |

---

## Project Status

> ⚠️ **Phase 1 — Foundation** (In Progress, Feb 1 – Mar 31, 2026)

The current codebase is a **forked Flutter fitness starter** (Perpetio). Clean Architecture refactoring is in progress on the `refactor/clean-architecture` branch.

See [`REMAINING_TASKS.md`](./REMAINING_TASKS.md) for the full phased roadmap.

---

## Getting Started

```bash
# Prerequisites: Flutter SDK, Firebase CLI

flutter pub get
flutter run
```

> Firebase is configured (`firebase_options.dart` exists) but services are not fully wired yet.

---

## Roadmap Overview

| Phase | Timeline | Focus |
|-------|----------|-------|
| Phase 1 | Feb – Mar 2026 | Foundation, Auth, Design System |
| Phase 2 | Apr – May 2026 | Fitness Module |
| Phase 3 | Jun – Jul 2026 | Mindfulness Module |
| Phase 4 | Jul – Aug 2026 | Meal & Nutrition Module |
| Phase 5 (Beta) | Sep 2026 | QA, Polish, App Store submission |
| Phase 6+ | Oct 2026+ | Community, Store, Subscriptions |

---

*Target: India-first wellness super-app · Public launch Jan 31, 2027*
