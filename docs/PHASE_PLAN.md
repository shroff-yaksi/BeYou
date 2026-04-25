# BeYou — Phase-Wise Development Plan
**v1.0 | April 2026**

> Tied to `PRD.md`. Any feature deviation should be flagged, discussed, and reflected in both documents.
> **Phase 0, Phase 1, and Phase 2 are DONE.**

---

## Status Legend
| Symbol | Meaning |
|---|---|
| ✅ | Done |
| 🔄 | In Progress |
| ⬜ | Not Started |

---

## Phase 0 — Foundation ✅ DONE

**Goal:** Working app skeleton with auth, navigation, theme, and DI in place.

| Deliverable | Status |
|---|---|
| Firebase project setup (Auth, Firestore, Storage) | ✅ |
| GoRouter with auth guards + redirect logic | ✅ |
| Material 3 theme with BeYou color system (#6358E1) | ✅ |
| GetIt dependency injection setup | ✅ |
| NotoSansKR font + color constants | ✅ |
| Sign In (email + Google) | ✅ |
| Sign Up (email + Google) | ✅ |
| Forgot Password | ✅ |
| Core utilities (ValidationService, DateService, exceptions) | ✅ |
| Core widgets (CustomButton, CustomTextField, LoadingWidget, ErrorWidget) | ✅ |
| FVM setup for Flutter version pinning | ✅ |
| GitHub Actions CI/CD pipeline | ✅ |

---

## Phase 1 — Clean Architecture + Onboarding + Profile ✅ DONE

**Goal:** Establish the clean architecture pattern, complete onboarding, and user profile.

| Deliverable | Status |
|---|---|
| Clean Architecture folder structure (`features/`) | ✅ |
| Dosha feature as full reference implementation | ✅ |
| BLoC pattern migrated to `on<Event>` syntax across all screens | ✅ |
| 3-page onboarding carousel | ✅ |
| Goal & fitness level selection page | ✅ |
| Settings screen | ✅ |
| Edit Account (profile editing + avatar upload to Firebase Storage) | ✅ |
| Change Password | ✅ |
| Reminder setup screen (UI) | ✅ |
| Tab bar navigation shell | ✅ |
| Home dashboard (static data) | ✅ |
| Workouts list + detail + active workout (hardcoded data) | ✅ |
| Dosha assessment — onboarding, questions, results, history (Hive) | ✅ |
| 14 screen mockups in `stitch/` as UI source of truth | ✅ |

---

## Phase 2 — Fitness Module (Real Data + Tracking) ✅ DONE

**Goal:** Replace hardcoded workout data with real Firestore backend. Add workout history, progress tracking, and charts.

| Deliverable | Status |
|---|---|
| Firestore schema for workouts, exercises, programs | ✅ |
| Seed Firestore with 40+ exercises + 12+ workout programs on first launch | ✅ |
| Workout list pulls live from Firestore (replace hardcoded) | ✅ |
| Workout detail pulls live exercises from Firestore | ✅ |
| Save completed workout session to Firestore (history) | ✅ |
| Workout history screen (past sessions, date, duration, calories) | ✅ |
| Body metrics logging screen (weight, measurements) | ✅ |
| PR (personal record) tracking per exercise | ✅ |
| Progress charts (weekly/monthly) — fl_chart | ✅ |
| Migrate `screens/workouts/` → `features/fitness/` (clean arch) | ✅ |
| Notification scheduling for workout reminders (existing UI already wired) | ✅ |
| Home dashboard wired to real user data (workouts this week, time trained) | ✅ |
| Custom workout builder (drag-and-drop, save to Firestore) | ✅ |

---

## Phase 3 — Ayurveda Module 🔄 IN PROGRESS

**Goal:** Expand the existing Dosha foundation into a full Ayurveda pillar.

| Deliverable | Status |
|---|---|
| Ayurveda tab added to main navigation | ✅ |
| Dosha profile page (personalized based on assessment result) | ✅ |
| Yoga section — session cards, filter by style (12 sessions × 8 styles) | ✅ |
| Pranayama / Breathing — animated visual guides per technique (8 techniques) | ✅ |
| Home Remedies Library — searchable, categorized (103 remedies, 11 categories) | ✅ |
| Dinacharya (Daily Routine) — Dosha-personalized morning/evening guide | ✅ |
| Ritucharya (Seasonal Guidance) — all 6 seasons with food/lifestyle/herb guides | ✅ |
| Anxiety & Stress programs (Ayurvedic approach, 2 programs) | ✅ |
| Postnatal care program section | ✅ |
| Panchakarma & self-therapy guides (Panchakarma + 2 self-therapy programs) | ✅ |
| Dosha intelligence wired to Fitness recommendations | ⬜ |
| Dosha intelligence wired to Nutrition suggestions | ⬜ |

---

## Phase 4 — Mindfulness Module 🔄 IN PROGRESS

**Goal:** Build the full Mindfulness pillar with media playback, journaling, and the "I Am Clean" tracker.

| Deliverable | Status |
|---|---|
| Mindfulness tab added to main navigation | ✅ |
| Meditation player — audio_players integration, background sounds, timer | ✅ |
| 20+ seed meditation sessions (audio content + metadata in Firestore) | ✅ *(22 seeded statically; Firestore migration deferred until audio assets land)* |
| Meditation session history + streak tracking | ✅ |
| Sleep support — sleep stories, ambient sounds, sleep timer | ✅ |
| Mood journal — daily check-in, emotion wheel, gratitude prompts, free writing | ✅ |
| Mood history + pattern visualization | ✅ |
| "I Am Clean" tracker — streak, milestones, SOS, health timeline, money saved | ✅ |
| "I Am Clean" — 10 addiction types, relapse reset flow | ✅ |
| Focus timer (Pomodoro) with focus music | ✅ *(Pomodoro done; focus music deferred — needs licensed audio)* |
| Stress SOS — quick 2–5 min relief sessions | ✅ |
| Mental Health Hub — self-assessments (anxiety, depression, stress) | ✅ *(GAD-7, PHQ-9, PSS-10 — validated instruments)* |
| Mental Health Hub — CBT/DBT exercises (static content) | ✅ |
| Mental Health Hub — crisis resources + India helplines | ✅ *(8 verified India helplines + 112 emergency)* |
| Offline download for meditation sessions | ⬜ *(deferred — needs licensed audio CDN)* |

**PRD deviations / deferred:**
- Meditation audio is currently metadata-only; the player integrates `audioplayers` with a fallback timer so the UX is complete, but actual audio assets are pending licensing/CDN setup.
- Phase 3 leftovers (Dosha → Fitness/Nutrition wiring) remain; Nutrition wiring is blocked until Phase 5.

---

## Phase 5 — Nutrition Module

**Goal:** Full nutrition tracking with Indian food database, meal plans, and fasting.

| Deliverable | Status |
|---|---|
| Nutrition tab added to main navigation | ⬜ |
| Open Food Facts API integration | ⬜ |
| Food search (text) with 1,00,000+ database | ⬜ |
| Barcode scanner for packaged food logging | ⬜ |
| Food log — breakfast, lunch, dinner, snacks, custom meals | ⬜ |
| Macro & calorie tracking — daily targets, protein/carbs/fats breakdown | ⬜ |
| Micronutrient tracking | ⬜ |
| Water intake logging + reminders | ⬜ |
| Meal plans — 5+ diet types to start (Vegetarian, Vegan, Sattvic, Diabetic, Keto) | ⬜ |
| Recipe library — 100+ recipes to start, sourced + seeded | ⬜ |
| Intermittent fasting timer (16:8, 5:2, OMAD) with streak | ⬜ |
| Grocery list — manual + auto-generate from meal plan | ⬜ |
| Allergy profile + ingredient alerts | ⬜ |
| Nutrition data wired to Home dashboard (daily calories) | ⬜ |

---

## Phase 6 — Health Module

**Goal:** Build the Google Fit/Apple Health-style health tracking hub.

| Deliverable | Status |
|---|---|
| Health tab added to main navigation | ⬜ |
| Body metrics logging (weight, BMI, body fat %, measurements) | ⬜ |
| Vitals logging (heart rate, blood pressure, blood oxygen) | ⬜ |
| Activity summary (steps, distance, calories — manual entry) | ⬜ |
| Sleep data logging (duration, quality — manual entry) | ⬜ |
| Women's health — cycle tracking, fertile window, symptoms | ⬜ |
| Health reports — weekly/monthly summaries, trend graphs | ⬜ |
| Data export (CSV/PDF) | ⬜ |
| Apple HealthKit integration (iOS) | ⬜ |
| Google Health Connect integration (Android) | ⬜ |
| Wearable sync — Fitbit, Garmin, Samsung (via Health Connect) | ⬜ |

---

## Phase 7 — Community Module

**Goal:** Build the social layer — feed, challenges, groups, messaging, and live sessions.

| Deliverable | Status |
|---|---|
| Community tab added to main navigation | ⬜ |
| Social feed — posts, photos, reactions, comments, hashtags | ⬜ |
| Content moderation (report, block, mute) | ⬜ |
| Challenges — platform-hosted (step, workout, meditation, nutrition) | ⬜ |
| Challenge leaderboards (global + friends) | ⬜ |
| Groups & clubs — create, join, group feed, group challenges | ⬜ |
| 1:1 messaging (text + media) | ⬜ |
| Group messaging | ⬜ |
| Live sessions — scheduling, notification, replay storage | ⬜ |
| Live session chat | ⬜ |
| Accountability partner matching | ⬜ |
| Q&A forums with upvoting | ⬜ |
| Events — RSVP, calendar, reminders | ⬜ |

---

## Phase 8 — Consultation + Store + Blog

**Goal:** Monetisation surface, expert marketplace, and content engine.

| Deliverable | Status |
|---|---|
| Consultation — practitioner directory (trainers, Ayurveda doctors, nutritionists, therapists) | ⬜ |
| Consultation — practitioner profiles, credentials, ratings | ⬜ |
| Consultation — booking flow (calendar, session type, duration, price) | ⬜ |
| Consultation — in-app video/chat session | ⬜ |
| Consultation — Razorpay payment integration | ⬜ |
| BeYou Store — browse programs (workout, meal, meditation) | ⬜ |
| BeYou Store — Ayurvedic herbs & supplements catalogue | ⬜ |
| BeYou Store — gym equipment catalogue | ⬜ |
| BeYou Store — books & media (e-book reader in-app) | ⬜ |
| BeYou Store — cart, checkout, UPI/cards/wallets/COD | ⬜ |
| BeYou Store — order tracking + returns | ⬜ |
| Blog & News — article feed, categories, personalized | ⬜ |
| Blog & News — bookmarking, reading history, offline reading | ⬜ |
| Blog & News — CMS integration for editorial team | ⬜ |
| Gamification rewards redemption (points → discounts/credits) | ⬜ |

---

## Phase 9 — AI + Scale

**Goal:** Intelligence layer, language support, accessibility, and performance hardening.

| Deliverable | Status |
|---|---|
| AI photo food recognition (nutrition logging) | ⬜ |
| AI smart workout generator (based on goals, equipment, time) | ⬜ |
| AI camera posture correction (real-time form analysis) | ⬜ |
| AI body scanner (photo-based composition analysis) | ⬜ |
| Dosha-powered recommendation engine (cross-module ML) | ⬜ |
| Hindi language support | ⬜ |
| Tamil language support | ⬜ |
| Telugu language support | ⬜ |
| Full accessibility audit (screen reader, high contrast, adjustable text) | ⬜ |
| GPS & outdoor activity tracking (runs, walks, routes) | ⬜ |
| Corporate/B2B wellness accounts | ⬜ |
| Creator Platform — content upload, analytics, monetization | ⬜ |
| Performance audit (cold start <3s, 60fps guarantee) | ⬜ |

---

## Ongoing (Every Phase)

| Task | Notes |
|---|---|
| Gamification points wired per feature as each module launches | Points added as each action becomes available |
| Badges added per module launch | Streak, milestone, and challenge badges per module |
| Clean Architecture migration | Move any remaining `screens/` code to `features/` |
| Widget tests + BLoC unit tests | Test coverage alongside each feature |
| Firestore security rules updated per module | Enforce rules as new collections are added |
| PRD.md updated for any scope changes | Flag deviations, agree, update |
