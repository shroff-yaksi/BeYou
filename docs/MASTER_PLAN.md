# BeYou - Master Development Plan

> **Document Type:** Single Source of Truth - Master Plan
> **Version:** 2.0
> **Updated:** March 7, 2026
> **Team:** 4 Members (Flutter Dev + Designer + Backend + Tester/Security)
> **Market:** India Only (Phase 1)

---

## All Planning Docs Are in `docs/`

| File | Purpose | Read When |
|------|---------|-----------|
| **MASTER_PLAN.md** (this file) | What to build, in what order, phase by phase | Every session |
| `App.md` | Full product vision (north star, 3-year view) | Deciding future features |
| `Dev.md` | Tech stack, architecture, learning resources | Onboarding, tech decisions |
| `Business_Analysis.md` | Business model, pricing, unit economics | Investor talks, pivots |
| `Research.md` | Market data, competitors, user personas | Marketing, positioning |
| `Finances.md` | Cost projections, revenue model, break-even | Budget decisions |
| `MIGRATION_PLAN.md` | Code reorganization tasks only | Code migration sessions |
| `STITCH_UI.md` | Complete UI spec for all current screens | Design + UI coding |

> Root files `PROJECT_CONTEXT.md` and `MIGRATION_PLAN.md` are kept for historical reference.
> `docs/` is the authoritative folder. Always read from here.

---

## The Gap: App.md vs Reality

### What App.md Promises (3-Year Vision)
- 5,000+ exercise videos
- 2,000+ guided meditations
- 1,00,000+ food database, 50,000+ recipes
- Creator platform, BeYou Store
- Wearable integration (11 brands)
- AI posture correction + body scanner

### What Exists Today
- Auth (Sign In, Sign Up, Forgot Password) - working
- Onboarding (3 pages) - working
- Home dashboard (static hardcoded data) - working
- Workouts list + details + start workout - working
- Dosha Assessment (complete) - working
- Settings + Edit Account + Change Password - working
- Reminder - working
- Architecture: messy (`lib/screens/` folder, violates clean architecture)

### The Verdict
**App.md is a 3-year vision. Do NOT build it all now.**
Business_Analysis.md says: start lean (100 workouts, 20 meditations, 500 foods), validate, then scale.

---

## Flutter Version Management (CRITICAL - READ FIRST)

### Problem
BeYou uses Dart SDK `>=3.0.0` (Flutter 3.x). Another project on this machine uses an older Flutter version. Running `flutter` globally will break one of them.

### Solution: FVM (Flutter Version Manager)

#### One-Time Setup (Do this before any Flutter work)

```bash
# Step 1: Install FVM globally
dart pub global activate fvm

# Step 2: Add FVM to PATH (add this to ~/.bashrc or ~/.zshrc)
export PATH="$PATH:$HOME/.pub-cache/bin"

# Step 3: In BeYou project root, pin the Flutter version
cd /home/kevinpatil/Desktop/BeYou
fvm install 3.27.4          # or latest stable: fvm install stable
fvm use 3.27.4              # pins this version to BeYou only

# Step 4: Verify
fvm flutter --version       # should show 3.27.4
```

#### How FVM Works Per-Project
- FVM creates `.fvm/flutter_sdk` symlink inside the project
- The `.fvm/fvm_config.json` file pins the version
- **For BeYou always use:** `fvm flutter <command>` NOT `flutter <command>`
- Your other project keeps using its own version unaffected

#### VS Code Setup
Add to `.vscode/settings.json` in the project:
```json
{
  "dart.flutterSdkPath": ".fvm/flutter_sdk",
  "dart.sdkPath": ".fvm/flutter_sdk/bin/cache/dart-sdk"
}
```

#### Files to add to `.gitignore`
```
.fvm/flutter_sdk
```
Keep `.fvm/fvm_config.json` committed so all team members use the same version.

#### Daily Commands (always use fvm prefix for BeYou)
```bash
fvm flutter pub get
fvm flutter analyze
fvm flutter build apk --debug
fvm flutter run
```

---

## CI/CD Pipeline Setup

### Overview
```
Developer pushes code
        |
        v
GitHub Actions triggers
        |
        +---> flutter analyze (lint check)
        +---> flutter test (unit tests)
        +---> flutter build apk
        |
        v
   Phase 0-1: Firebase App Distribution (internal beta)
   Phase 2+:  Play Store Internal Track -> Alpha -> Beta -> Production
              App Store TestFlight -> App Store
```

### Phase 0 Setup: GitHub Actions (Set Up Now)

Create `.github/workflows/build.yml`:

```yaml
name: BeYou CI/CD

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Setup Java
        uses: actions/setup-java@v3
        with:
          java-version: '17'
          distribution: 'temurin'

      - name: Setup Flutter (via FVM)
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.27.4'
          channel: 'stable'

      - name: Get dependencies
        run: flutter pub get

      - name: Analyze
        run: flutter analyze

      - name: Run tests
        run: flutter test

      - name: Build APK (Debug)
        run: flutter build apk --debug

      - name: Upload APK artifact
        uses: actions/upload-artifact@v3
        with:
          name: debug-apk
          path: build/app/outputs/flutter-apk/app-debug.apk
```

### Phase 1 Addition: Firebase App Distribution (Beta)

Add to the workflow after Build APK:
```yaml
      - name: Build APK (Release)
        run: flutter build apk --release
        # Requires keystore setup - see below

      - name: Upload to Firebase App Distribution
        uses: wzieba/Firebase-Distribution-Github-Action@v1
        with:
          appId: ${{ secrets.FIREBASE_APP_ID }}
          token: ${{ secrets.FIREBASE_TOKEN }}
          groups: beta-testers
          file: build/app/outputs/flutter-apk/app-release.apk
          releaseNotes: "Phase 1 Beta Build"
```

**Secrets to add in GitHub repo settings:**
- `FIREBASE_APP_ID` - from Firebase Console > Project Settings > Your Apps
- `FIREBASE_TOKEN` - run `firebase login:ci` locally to get it
- `KEYSTORE_FILE` - base64 encoded keystore
- `KEYSTORE_PASSWORD`, `KEY_ALIAS`, `KEY_PASSWORD`

### Phase 2+ Addition: Play Store Deployment

```yaml
      - name: Deploy to Play Store (Internal Track)
        uses: r0adkll/upload-google-play@v1
        with:
          serviceAccountJsonPlainText: ${{ secrets.SERVICE_ACCOUNT_JSON }}
          packageName: com.beyou.app
          releaseFiles: build/app/outputs/bundle/release/*.aab
          track: internal
          status: completed
```

### Android Keystore Setup (Do in Phase 0)

```bash
# Generate keystore (do once, store safely)
keytool -genkey -v -keystore beyou-release-key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias beyou-key

# Create android/key.properties (DO NOT COMMIT THIS FILE)
storePassword=<your-password>
keyPassword=<your-key-password>
keyAlias=beyou-key
storeFile=../beyou-release-key.jks
```

Add `android/key.properties` and `*.jks` to `.gitignore`.

---

## PHASE 0: Foundation (Weeks 1-6)

> **Goal:** Clean architecture migration + STITCH_UI implementation + CI/CD setup.

### 0A: One-Time Environment Setup

| Task | Command / Action | Owner |
|------|-----------------|-------|
| Install FVM | `dart pub global activate fvm` | Flutter Dev |
| Pin Flutter version | `fvm install 3.27.4 && fvm use 3.27.4` | Flutter Dev |
| Setup VS Code | Add dart.flutterSdkPath to .vscode/settings.json | Flutter Dev |
| Generate Android keystore | `keytool -genkey ...` (see above) | Flutter Dev |
| Setup GitHub repo secrets | FIREBASE_APP_ID, FIREBASE_TOKEN, keystore secrets | Flutter Dev |
| Create `.github/workflows/build.yml` | Use template above | Flutter Dev |
| Add FVM files to .gitignore | `.fvm/flutter_sdk` | Flutter Dev |

### 0B: Clean Architecture Migration

Follow `docs/MIGRATION_PLAN.md` step by step.

| Step | Migration Task | Files | Status |
|------|---------------|-------|--------|
| 1 | Create all feature directories | - | Pending |
| 2 | Migrate Onboarding | 6 files | Pending |
| 3 | Migrate Auth | 14 files | Pending |
| 4 | Migrate Home + Navigation | 12 files | Pending |
| 5 | Migrate Fitness | 19 files | Pending |
| 6 | Migrate Profile/Settings | 12 files | Pending |
| 7 | Migrate Reminder | 5 files | Pending |
| 8 | Data Layer Cleanup | 10+ files | Pending |

After EACH migration step, run:
```bash
fvm flutter analyze
fvm flutter build apk --debug
```

### 0C: UI Implementation

Each screen in `stitch/` has two reference files — read BOTH before writing any code for that screen:
- `screen.png` — the actual visual design
- `code.html` — Stitch-generated layout structure

> **CRITICAL design observations (actual Stitch screens differ from STITCH_UI.md):**
> - **Fitness screens** (Home, Workouts, Workout Details, Start Workout, Reminder) use **Orange** primary `#E8703A`
> - **Auth + Dosha screens** use **Purple** primary `#6358E1`
> - All input fields are **pill-shaped** (borderRadius ~30), NOT square fields
> - Bottom nav has **4 tabs** for Phase 0: Home, Workouts, Dosha, Settings
> - Sign In + Forgot Password have NO stitch files — mirror Sign Up style + follow `docs/STITCH_UI.md`

---

#### Screen 1: Onboarding
- **Reference:** `stitch/onboarding/screen.png` + `stitch/onboarding/code.html`
- **Route:** `/onboarding` | **File:** `lib/features/onboarding/pages/onboarding_page.dart`
- Purple theme. App logo top-left, "Skip" top-right. Workout image in rounded square (not full-bleed). Floating decorative icons (lightning, timer). Bold title + centered subtitle below image. Active dot = wider purple pill, inactive = small grey circles. Circular progress button bottom-center (purple ring + white arrow).

---

#### Screen 2: Sign Up
- **Reference:** `stitch/sign_up/screen.png` + `stitch/sign_up/code.html`
- **Route:** `/signup` | **File:** `lib/features/auth/pages/sign_up_page.dart`
- Light grey scaffold `#F5F5F7`. AppBar: back arrow + "Sign up" centered. "Create Account" large bold + grey subtitle. Labels above each pill field. Eye icon on password fields. Purple pill "Sign Up" button. "Already have an account? Sign In" below. Divider "OR CONTINUE WITH" + Google/iOS pill buttons at bottom.

---

#### Screen 3: Sign In
- **Reference:** NO stitch file — mirror Sign Up style + `docs/STITCH_UI.md` spec
- **Route:** `/signin` | **File:** `lib/features/auth/pages/sign_in_page.dart`
- Same grey background and pill field style as Sign Up. Fields: Email + Password only. "Forgot password?" link below password. Purple pill "Sign In" button. "Do not have an account? Sign up" at bottom.

---

#### Screen 4: Forgot Password
- **Reference:** NO stitch file — mirror Sign Up style + `docs/STITCH_UI.md` spec
- **Route:** `/forgot-password` | **File:** `lib/features/auth/pages/forgot_password_page.dart`
- Same auth style. Single Email pill field. Purple pill "Send Activation Link" button pinned to bottom.

---

#### Screen 5: Tab Bar Shell
- **Reference:** Infer from bottom nav visible in all screens
- **Route:** `/` (root shell) | **File:** `lib/features/navigation/pages/navigation_shell.dart`
- 4 tabs: Home, Workouts, Dosha, Settings. Active tab tinted in screen's primary color. Inactive = grey. Flat white nav bar, no elevation. Icon + label stacked.

---

#### Screen 6: Home
- **Reference:** `stitch/home_screen/screen.png` + `stitch/home_screen/code.html`
- **Route:** Tab 0 | **File:** `lib/features/home/pages/home_page.dart`
- White background. Top: avatar (left) + search + bell (right). "Welcome back, / Hi, User" greeting. Full-width **orange** "COMPLETED WORKOUTS" card (large count "12", trophy icon, "+3 from last week"). Two side-by-side white stat cards: "IN PROGRESS" (4) and "TIME SPENT" (5.5h). "Discover new workouts" + "View all" orange. Horizontal scroll workout cards (full-bleed image, gradient overlay, difficulty badge pill). Dark navy "Keep the progress!" card with orange progress bar + "4/5 days".

---

#### Screen 7: Workouts List
- **Reference:** `stitch/workouts_list/screen.png` + `stitch/workouts_list/code.html`
- **Route:** Tab 1 | **File:** `lib/features/fitness/pages/workouts_page.dart`
- Light grey background. "Workouts" bold title + search icon. Vertical list of white rounded cards. Each card: title + "X Exercises" + "X Minutes" (left), photo rounded square (right). Orange progress bar at card bottom with "X/Y" fraction. Flat cards (no heavy shadow).

---

#### Screen 8: Workout Details
- **Reference:** `stitch/workout_details/screen.png` + `stitch/workout_details/code.html`
- **Route:** `/workout-details` | **File:** `lib/features/fitness/pages/workout_details_page.dart`
- Full-bleed hero image top, back arrow overlaid top-left. White sliding bottom panel (~60% height). Panel: workout title bold, two **orange** pill tags (clock + duration, dumbbell + count). Exercise list: thumbnail + name + duration + chevron arrow. Fixed orange "START WORKOUT" pill button at panel bottom.

---

#### Screen 9: Start Workout
- **Reference:** `stitch/start_workout/screen.png` + `stitch/start_workout/code.html`
- **Route:** Navigator push | **File:** `lib/features/fitness/pages/start_workout_page.dart`
- AppBar: "< Back" + "Start Workout" title. Video player rounded corners (purple-tinted progress bar). Exercise title bold. Grey description. "Steps" heading + numbered steps (purple circle badges). Bottom bar: "NEXT EXERCISE:" grey label + name bold + clock + time. Purple pill "Next" button full width.

---

#### Screen 10: Settings
- **Reference:** `stitch/settings/screen.png` + `stitch/settings/code.html`
- **Route:** Tab 3 | **File:** `lib/features/profile/pages/settings_page.dart`
- White background. AppBar: back arrow + "Settings". Large circular avatar + purple edit button (pen) bottom-right. Bold name centered. Setting items = rounded rectangle cards (borderRadius ~16) with purple icon + label + chevron. Items: Reminder, Rate Us, Terms & Conditions, Sign Out. "Join us in social media" + Facebook/Instagram/Twitter circle buttons.

---

#### Screen 11: Edit Account
- **Reference:** `stitch/edit_account/screen.png` + `stitch/edit_account/code.html`
- **Route:** `/edit-account` | **File:** `lib/features/profile/pages/edit_account_page.dart`
- Light grey background. AppBar: back + "Edit account". Circular avatar centered. "Edit photo" purple link below. "Full name" + "Email" labels with pill white fields. "Change Password >" purple link + chevron. Purple "Save" pill button pinned to bottom.

---

#### Screen 12: Change Password
- **Reference:** `stitch/change_password/screen.png` + `stitch/change_password/code.html`
- **Route:** `/change-password` | **File:** `lib/features/profile/pages/change_password_page.dart`
- Light grey background. AppBar: back arrow + "Change Password". "New password" + "Confirm password" pill fields with eye-slash icons. Purple "Save" pill button pinned to bottom.

---

#### Screen 13: Reminder
- **Reference:** `stitch/reminder_screen/screen.png` + `stitch/reminder_screen/code.html`
- **Route:** `/reminder` | **File:** `lib/features/reminder/pages/reminder_page.dart`
- Light grey background. AppBar: back + "Reminder" + **orange** "Save" text action. Drum-roll scroll picker: 3 columns (Hour | Minute | AM/PM), selected row = orange text + light orange highlight band. "How often repeat" section. Day chips Wrap: selected = orange filled pill, unselected = grey outlined pill. Chips: Everyday, Mon-Fri, Weekends, Monday, Tue, Wed, Thu, Fri, Sat, Sun.

---

#### Screen 14: Dosha — Onboarding View
- **Reference:** `stitch/dosha_assessment_onboarding/screen.png` + `stitch/dosha_assessment_onboarding/code.html`
- **Route:** Dosha tab, view 1 | **File:** `lib/features/dosha/pages/dosha_onboarding_page.dart`
- White background. AppBar: back + "Dosha Assessment" + history clock icon. Orange lotus icon in light-orange rounded square. "Ayurvedic Prakriti Assessment" bold centered. Description + italic sub-text. "Participant name" field with person icon prefix (rounded rect). Meditation illustration (light orange bg). Orange "▶ START ASSESSMENT" pill button at bottom.

---

#### Screen 15: Dosha — Questions View
- **Reference:** `stitch/dosha_assessment_questions/screen.png` + `stitch/dosha_assessment_questions/code.html`
- **Route:** Dosha tab, view 2 | **File:** `lib/features/dosha/pages/dosha_assessment_page.dart`
- White background. AppBar: X close icon + "Assessment . {name}" + refresh icon. "Question X/21" + "X% Complete" purple. Purple linear progress bar (pill). Grey category badge pill (e.g. PHYSICAL). Question bold large. Option cards: rounded rect, selected = purple border + light purple bg + filled purple radio, unselected = grey border + empty radio. Each option: bold label + grey description. Bottom: "< Previous" outlined + "Next Question >" purple filled (expanded).

---

#### Screen 16: Dosha — Results View
- **Reference:** `stitch/dosha_assessment_results/screen.png` + `stitch/dosha_assessment_results/code.html`
- **Route:** Dosha tab, view 3 | **File:** `lib/features/dosha/pages/dosha_results_page.dart`
- White background. AppBar: back + "Results . {name}" + history icon. Hero card (light purple bg): sparkle icon + "X dominant constitution" + colored chips (Vata=orange, Pitta=pink, Kapha=green). "Dosha Distribution" card with colored bars (Vata=purple, Pitta=red-orange, Kapha=green). "Key Traits" card with bullet list. "Recommendations" card with icon sub-sections. "View History" outlined + "Retake" purple buttons.

---

#### Screen 17: Dosha — History View
- **Reference:** `stitch/assessment_history/screen.png` + `stitch/assessment_history/code.html`
- **Route:** Dosha tab, view 4 | **File:** `lib/features/dosha/pages/dosha_history_page.dart`
- White background. AppBar: back + "Assessment History" + trash icon. Cards: participant name + "View Details" purple link + date-time. Colored dot chips: Vata (purple dot), Pitta (orange dot), Kapha (green dot) with percentages. "Dominant dosha: **X**" with X colored in its dosha color. Chevron at card bottom-right.

---

### PHASE 0 - HUMAN TASKS (After all work above is done)

#### Step 1: Run the app locally
```bash
cd /home/kevinpatil/Desktop/BeYou
fvm flutter pub get
fvm flutter analyze                      # Must show 0 errors
fvm flutter run                          # Run on connected device or emulator
```

#### Step 2: Manual test checklist
```
ONBOARDING
  [ ] Swipe through all 3 pages
  [ ] Progress ring animates correctly
  [ ] Last page -> navigates to Sign Up

AUTH
  [ ] Sign Up: fill all fields, validation works, account created
  [ ] Sign In: sign in with created account, reaches Home
  [ ] Forgot Password: email sent confirmation appears
  [ ] Invalid inputs show proper error messages

HOME
  [ ] Hi, {username} shows correctly
  [ ] Stat cards display
  [ ] Horizontal workout cards scroll
  [ ] Tap workout card -> goes to Workout Details

WORKOUTS
  [ ] Workout list loads
  [ ] Tap workout -> Workout Details with sliding panel
  [ ] Tap exercise in panel -> Start Workout
  [ ] Video plays in Start Workout
  [ ] Next/Finish button works

SETTINGS
  [ ] Profile image loads
  [ ] Reminder -> opens Reminder screen, save works
  [ ] Edit Account -> can change name/email, save works
  [ ] Change Password -> works
  [ ] Sign Out -> goes to Sign In

DOSHA
  [ ] Start Assessment -> questions load
  [ ] Complete all 21 questions
  [ ] Results screen shows dosha breakdown
  [ ] History saves and shows
```

#### Step 3: Build release APK
```bash
fvm flutter build apk --release
# APK at: build/app/outputs/flutter-apk/app-release.apk
```

#### Step 4: Trigger CI/CD
```bash
git add .
git commit -m "phase-0: clean architecture + STITCH_UI implementation"
git push origin main
# Go to GitHub -> Actions -> watch build pass
```

#### Step 5: Verify CI passes
- GitHub Actions build must go green
- Download the APK artifact from the Actions run
- Install on a real Android device and smoke test

#### Phase 0 done when:
- [ ] `fvm flutter analyze` = 0 errors
- [ ] All screens match STITCH_UI.md visually
- [ ] All files in `lib/features/` (no `lib/screens/` remaining)
- [ ] All navigation routes work end-to-end
- [ ] GitHub Actions CI is green
- [ ] APK installs and runs on real device

---

## PHASE 1: MVP Beta (Weeks 7-16)

> **Goal:** Expand content, add Mindfulness + "I Am Clean", real Firebase data, ship to beta testers.
> **Deployment target:** Firebase App Distribution to 50-100 beta testers.

### 1A: Expand Fitness Content

**Current:** 4 hardcoded workouts
**Target:** 30-50 real workouts from open-source databases

| Task | Details | Owner |
|------|---------|-------|
| Integrate `yuhonas/free-exercise-db` | 800+ exercises, public domain JSON | Flutter Dev |
| OR integrate Wger REST API | `https://wger.de/api/v2/` free, open-source | Flutter Dev |
| Categories | Chest, Back, Shoulders, Core, Legs, Full Body, Cardio, Yoga, Pilates | Flutter Dev |
| Real progress tracking | Persist completed workouts to Firestore subcollection | Backend Dev |
| Workout history page | New screen listing past sessions | Flutter Dev |

**New files:**
```
lib/features/fitness/pages/exercise_library_page.dart
lib/features/fitness/pages/workout_history_page.dart
lib/features/fitness/data/workout_repository.dart       # Firestore reads/writes
```

**Firestore structure:**
```
users/{uid}/
  workoutHistory/{sessionId}/
    workoutId: string
    completedAt: timestamp
    exercisesCompleted: int
    durationMinutes: int
```

### 1B: Mindfulness Module (NEW Feature)

Start text-based only (no audio files needed).

```
lib/features/mindfulness/
├── bloc/
│   ├── mindfulness_bloc.dart
│   ├── mindfulness_event.dart
│   └── mindfulness_state.dart
├── pages/
│   ├── mindfulness_home_page.dart     # Hub page
│   ├── breathing_page.dart            # Animated breathing exercise
│   └── meditation_session_page.dart   # Text-guided meditation
├── widgets/
│   ├── breathing_circle.dart          # Expanding/contracting circle animation
│   ├── meditation_card.dart
│   └── technique_tile.dart
└── data/
    └── mindfulness_data.dart          # Static content for v1
```

**Breathing techniques (5):**
| Technique | Pattern | Duration |
|-----------|---------|----------|
| Box Breathing | 4s in / 4s hold / 4s out / 4s hold | 5 min |
| 4-7-8 | 4s in / 7s hold / 8s out | 5 min |
| Anulom Vilom | Alternate nostril (text-guided) | 10 min |
| Kapalbhati | 1s forceful exhale rhythm (text-guided) | 5 min |
| Bhramari | Humming breath (text-guided) | 5 min |

**Meditation sessions (10):** 5-min, 10-min, 15-min text-script sessions covering stress, sleep, focus, morning, evening.

### 1C: "I Am Clean" Streak Tracker (NEW Feature)

BeYou's unique differentiator. Simple v1.

```
lib/features/clean/
├── bloc/
│   ├── clean_bloc.dart
│   ├── clean_event.dart
│   └── clean_state.dart
├── pages/
│   └── clean_home_page.dart
├── widgets/
│   ├── streak_counter_widget.dart     # Large number + days label
│   ├── milestone_card.dart            # Celebration card at milestones
│   └── addiction_type_picker.dart
└── data/
    └── clean_repository.dart          # Firestore persistence
```

**v1 scope:**
- Pick addiction type (Smoking, Alcohol, Substances, Social Media, Gambling)
- Counter shows days clean
- Milestone banners: 1 day, 3 days, 1 week, 2 weeks, 1 month, 3 months, 6 months, 1 year
- "Reset" button with compassionate message (no judgment)
- Private - not visible in community feed

**Firestore structure:**
```
users/{uid}/cleanStreak/
  addictionType: string
  startDate: timestamp
  isActive: boolean
  streakHistory: [{resetDate, reason}]
```

### 1D: Navigation Update (5 tabs)

| Index | Label | Icon | Feature |
|-------|-------|------|---------|
| 0 | Home | home_icon.png | Home |
| 1 | Fitness | workouts_icon.png | Fitness |
| 2 | Mind | Icons.self_improvement | Mindfulness |
| 3 | Dosha | Icons.spa | Dosha Assessment |
| 4 | Profile | settings_icon.png | Settings |

### 1E: Replace Static Data with Firestore

| Data | Change |
|------|--------|
| Workout list | Firestore collection `workouts/` |
| User profile (name, photo) | Firestore `users/{uid}` document |
| Workout progress | Firestore `users/{uid}/workoutHistory/` |
| Reminder time + days | Firestore `users/{uid}/reminder` |

### 1F: Legal Pages (Required before beta)

Before distributing to ANY external beta tester:
- Add in-app `Terms of Service` screen (link to web page)
- Add `Privacy Policy` screen (link to web page)
- Add health disclaimer on first workout start: "Consult a doctor before starting any fitness program. BeYou is not a medical device."

### 1G: Firebase App Distribution Setup

```bash
# Install Firebase CLI
npm install -g firebase-tools
firebase login
firebase login:ci               # Copy token -> GitHub secret FIREBASE_TOKEN

# Get App ID from Firebase Console -> Project Settings -> Your Apps
# Add to GitHub secrets as FIREBASE_APP_ID
```

Update `.github/workflows/build.yml` to add Firebase App Distribution step (see CI/CD section above).

---

### PHASE 1 - HUMAN TASKS

#### Step 1: Run locally and test all new features
```bash
fvm flutter pub get
fvm flutter analyze              # Must show 0 errors
fvm flutter run
```

**Manual test checklist:**
```
FITNESS
  [ ] Workouts load from Firestore (not hardcoded)
  [ ] Exercise library shows categories
  [ ] Complete a workout -> appears in history
  [ ] Workout history screen shows past sessions

MINDFULNESS
  [ ] Mindfulness tab opens
  [ ] Breathing exercise: circle animates expand/contract
  [ ] Timer counts down correctly
  [ ] Meditation session loads text content
  [ ] Session completes and navigates back

"I AM CLEAN"
  [ ] Pick addiction type
  [ ] Counter starts and shows days
  [ ] Milestones show banner at correct intervals
  [ ] Reset button works with compassionate message
  [ ] Data persists after app restart

NAVIGATION
  [ ] All 5 tabs work
  [ ] Icons display correctly for each tab
  [ ] Deep navigation works (tab -> sub-screen -> back -> still on tab)

FIREBASE
  [ ] All data survives app restart (no in-memory only data)
  [ ] Sign out and sign back in -> data preserved
  [ ] Two devices with same account see same data
```

#### Step 2: Build and deploy to Firebase App Distribution
```bash
# Build release APK
fvm flutter build apk --release

# Deploy manually if CI is not ready
firebase appdistribution:distribute \
  build/app/outputs/flutter-apk/app-release.apk \
  --app $FIREBASE_APP_ID \
  --groups beta-testers \
  --release-notes "Phase 1 Beta - Mindfulness + I Am Clean"
```

#### Step 3: Trigger CI/CD pipeline
```bash
git add .
git commit -m "phase-1: mindfulness, I Am Clean, Firestore data, 30+ workouts"
git push origin main
# GitHub Actions will build + upload to Firebase App Distribution automatically
```

#### Step 4: Beta tester onboarding
- Share Firebase App Distribution invite link to 50-100 testers
- Create a WhatsApp group for beta feedback
- Collect feedback for 2 weeks before Phase 2

#### Phase 1 done when:
- [ ] `fvm flutter analyze` = 0 errors
- [ ] All new features working (Fitness expand, Mindfulness, I Am Clean)
- [ ] Data persists in Firestore
- [ ] CI/CD pipeline builds + deploys automatically on push
- [ ] Firebase App Distribution delivers APK to beta testers
- [ ] Legal pages (ToS, Privacy Policy, Health Disclaimer) in place
- [ ] 50+ beta testers installed and using the app

---

## PHASE 2: Nutrition + Community + Payments (Weeks 17-24)

> **Goal:** Food logging, community seed, Razorpay payments live.
> **Deployment target:** Play Store Internal Track (first public release).

### 2A: Basic Food Logging

```
lib/features/meal/
├── bloc/
│   ├── meal_bloc.dart
│   ├── meal_event.dart
│   └── meal_state.dart
├── pages/
│   ├── meal_home_page.dart         # Daily log: Breakfast/Lunch/Dinner/Snacks
│   ├── food_search_page.dart       # Search bar + results
│   └── nutrition_summary_page.dart # Macro ring chart + daily breakdown
├── widgets/
│   ├── food_log_item.dart
│   ├── macro_ring_chart.dart       # Custom painter donut chart
│   ├── meal_section_header.dart
│   └── add_food_sheet.dart         # Bottom sheet to confirm + add food
└── data/
    ├── meal_repository.dart
    └── food_api_service.dart       # Open Food Facts API
```

**API:** Open Food Facts - `https://world.openfoodfacts.org/api/v2/search`
- Free, no API key needed
- 2M+ products including Indian foods

**Pre-load 500 Indian staples** into Firestore `foods/` collection:
Dal, Roti, Rice (white, brown), Sabzi (common ones), Paneer, Idli, Dosa, Poha, Upma, Paratha, Curd, Milk, Eggs, Chicken, Fish, etc.

**Firestore structure:**
```
users/{uid}/foodLog/{date}/
  meals: {
    breakfast: [{foodId, name, quantity, unit, calories, protein, carbs, fat}],
    lunch: [...],
    dinner: [...],
    snacks: [...]
  }
  totalCalories: int
  totalProtein: double
  totalCarbs: double
  totalFat: double
```

### 2B: Water Tracking

Simple widget on Home screen:
- 8 glass circles, tap to fill
- Shows "X / 8 glasses"
- Daily reset at midnight
- Stored in Firestore `users/{uid}/waterLog/{date}`

### 2C: Community Activity Feed (Read-only v1)

```
lib/features/community/
├── bloc/
│   ├── feed_bloc.dart
│   ├── feed_event.dart
│   └── feed_state.dart
├── pages/
│   └── feed_page.dart
├── widgets/
│   ├── activity_card.dart          # Workout completed, streak milestone, etc.
│   └── like_button.dart
└── data/
    └── feed_repository.dart
```

**Activity types auto-posted to feed:**
- Workout completed: "Rahul completed Yoga (52 min)"
- Streak milestone: "Priya is 30 days clean!"
- Workout milestone: "Suresh completed 50 workouts!"

### 2D: Razorpay Integration

```
lib/features/subscription/
├── bloc/
│   ├── subscription_bloc.dart
│   ├── subscription_event.dart
│   └── subscription_state.dart
├── pages/
│   ├── upgrade_page.dart           # Pricing page with tier comparison
│   └── subscription_status_page.dart
├── widgets/
│   ├── pricing_card.dart
│   └── paywall_bottom_sheet.dart   # Shows when free user hits gated feature
└── data/
    └── subscription_repository.dart
```

**Tier gating logic:**
| Feature | Free | Basic (Rs.49) | Pro (Rs.99) |
|---------|------|--------------|-------------|
| Workouts (50 base) | 10 only | All | All |
| Meditations | 3 | All | All |
| Food logging | Yes | Yes | Yes |
| "I Am Clean" | Basic | Full | Full |
| Community | View | Post | Post |
| AI features (Phase 4) | No | No | Yes |
| Offline downloads (Phase 3) | No | No | Yes |

**Razorpay setup:**
- Register at `razorpay.com`
- Add `razorpay_flutter: ^1.3.7` to pubspec.yaml
- Test with Razorpay test keys first
- Switch to live keys only after testing

### 2E: Play Store Setup (Do at start of Phase 2)

```bash
# Build App Bundle for Play Store
fvm flutter build appbundle --release

# First upload: do manually via Play Console
# go to play.google.com/console
# Create new app -> Upload .aab -> Internal Testing
```

Add to CI/CD workflow for automatic Play Store uploads (see CI/CD section above).

### 2F: Add a New Nav Tab for Meal + Community

| Index | Label | Feature |
|-------|-------|---------|
| 0 | Home | Home |
| 1 | Fitness | Fitness |
| 2 | Meal | Meal Tracking |
| 3 | Mind | Mindfulness |
| 4 | More | Dosha / Community / I Am Clean (sub-menu) |

---

### PHASE 2 - HUMAN TASKS

#### Step 1: Run locally
```bash
fvm flutter pub get
fvm flutter analyze
fvm flutter run
```

**Manual test checklist:**
```
FOOD LOGGING
  [ ] Search for "dal" -> results appear
  [ ] Tap result -> add to Breakfast/Lunch/Dinner/Snacks
  [ ] Daily macro summary updates correctly
  [ ] Data persists after restart

WATER TRACKING
  [ ] 8 glasses show on Home
  [ ] Tap to fill each glass
  [ ] Resets next day

COMMUNITY FEED
  [ ] Complete a workout -> appears in feed
  [ ] Hit a streak milestone -> appears in feed
  [ ] Like button taps correctly

PAYMENTS
  [ ] Open a gated feature -> paywall sheet appears
  [ ] Tap upgrade -> Razorpay sheet opens
  [ ] Complete test payment -> subscription activates
  [ ] After subscription: gated features unlock
  [ ] Test with Razorpay test card: 4111 1111 1111 1111
```

#### Step 2: Build App Bundle + upload to Play Store
```bash
fvm flutter build appbundle --release
# Upload to Play Console -> Internal Testing -> Create new release
# Share internal testing link with team (4 people)
# Test on multiple Android devices
```

#### Step 3: Trigger CI/CD
```bash
git add .
git commit -m "phase-2: food logging, water tracking, community feed, Razorpay payments"
git push origin main
# CI builds + uploads to Play Store Internal Track automatically
```

#### Step 4: Promote to Alpha track (after team testing passes)
```
Play Console -> Release -> Testing -> Alpha
-> Add 20 trusted testers
-> Monitor crash rate and reviews
```

#### Phase 2 done when:
- [ ] Food logging works end-to-end with API + Firestore
- [ ] Water tracking works
- [ ] Community feed shows real activity
- [ ] Razorpay payments working in test mode
- [ ] Razorpay switched to LIVE after one real test payment
- [ ] App on Play Store Alpha track
- [ ] `fvm flutter analyze` = 0 errors
- [ ] CI/CD deploys to Play Store automatically on push to main

---

## PHASE 3: Polish + Analytics + Growth (Weeks 25-32)

> **Goal:** Analytics, gamification, push notifications, offline support. Get to 5,000 users.
> **Deployment target:** Play Store Beta track + App Store TestFlight.

### 3A: Firebase Analytics Setup (Do FIRST)

```dart
// Add to every key action
FirebaseAnalytics.instance.logEvent(name: 'workout_completed', parameters: {
  'workout_name': workout.title,
  'duration_minutes': duration,
});
```

**Events to instrument:**
```
signup_complete, signin, signout
workout_started, workout_completed, workout_abandoned
meditation_started, meditation_completed
food_logged, water_logged
clean_streak_started, clean_milestone_hit, clean_reset
subscription_started, subscription_cancelled
paywall_shown, paywall_dismissed
```

### 3B: Firebase Crashlytics

```bash
# Already in firebase_options.dart - just enable:
fvm flutter pub add firebase_crashlytics
```

Add to `main.dart`:
```dart
FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
```

### 3C: Gamification

**Points system (Firestore `users/{uid}/points`):**
| Action | Points |
|--------|--------|
| Complete workout | 50-200 (based on duration) |
| Log all 3 meals | 30 |
| Meditation session | 25 |
| Clean streak day | 20 |
| Daily app open | 5 |

**Badges (Firestore `users/{uid}/badges`):**
| Badge | Trigger |
|-------|---------|
| First Workout | Complete first workout |
| 7-Day Warrior | 7-day workout streak |
| 30-Day Champion | 30-day workout streak |
| 100-Day Legend | 100-day workout streak |
| Clean Week | 7 days clean |
| Clean Month | 30 days clean |
| Nutrition Novice | Log food for 7 days |

### 3D: Push Notifications (FCM)

```
lib/core/services/notification_service.dart
```

| Notification | When |
|-------------|------|
| Workout reminder | User's set time from Reminder screen |
| Streak at risk | 8pm if no workout logged that day |
| Milestone unlocked | Immediately on achievement |
| Weekly report | Sunday 9am - "You completed X workouts this week!" |

### 3E: Offline Support (Hive)

```
lib/data/datasources/local/
├── workout_local_datasource.dart    # Cache workout list + exercises
├── food_local_datasource.dart       # Cache 500 common Indian foods
└── user_local_datasource.dart       # Cache user profile
```

**Offline behavior:**
- Workout list: serve from Hive cache, refresh when online
- Food log: queue offline entries, sync when connected
- Meditation text: cached on first load

### 3F: iOS App Store Setup

```bash
# Requires macOS + Xcode
fvm flutter build ipa --release
# Upload via Transporter app or Xcode Organizer to App Store Connect
# Set up TestFlight -> add testers
```

---

### PHASE 3 - HUMAN TASKS

#### Step 1: Run locally
```bash
fvm flutter pub get
fvm flutter analyze
fvm flutter run
```

**Manual test checklist:**
```
ANALYTICS (verify in Firebase Console)
  [ ] Complete a workout -> see workout_completed event in DebugView
  [ ] Subscribe -> see subscription_started in DebugView
  [ ] Crashlytics: force a test crash, verify it appears in console
    (add `FirebaseCrashlytics.instance.crash()` temporarily)

GAMIFICATION
  [ ] Complete workout -> points added
  [ ] Reach badge trigger -> badge appears in profile
  [ ] Point total updates correctly

PUSH NOTIFICATIONS
  [ ] Set reminder to 2 mins from now -> notification fires
  [ ] Tap notification -> opens app to correct screen
  [ ] Test FCM directly: Firebase Console -> Cloud Messaging -> Send test message

OFFLINE
  [ ] Enable airplane mode
  [ ] Open app -> workouts still load from cache
  [ ] Log food offline -> data queued
  [ ] Re-enable network -> queued food log syncs
```

#### Step 2: Play Store Beta deployment
```bash
fvm flutter build appbundle --release
git add .
git commit -m "phase-3: analytics, gamification, push notifications, offline support"
git push origin main
# CI automatically deploys to Play Store
```

**Play Store promotion:**
```
Internal -> Alpha -> Beta
Go to Play Console -> Testing -> Open Testing (Beta)
This opens to any Play Store user who opts in
```

#### Step 3: App Store TestFlight (requires macOS)
```bash
# On macOS:
fvm flutter build ipa --release
# Upload to App Store Connect -> TestFlight
# Add external testers (up to 10,000)
```

#### Phase 3 done when:
- [ ] Firebase Analytics tracking all key events
- [ ] Crashlytics live and receiving reports
- [ ] Gamification: points + badges working
- [ ] Push notifications fire on schedule
- [ ] Offline mode works for workouts and food log
- [ ] App on Play Store Open Beta
- [ ] App on TestFlight (if iOS device available)
- [ ] 5,000 downloads milestone hit
- [ ] `fvm flutter analyze` = 0 errors

---

## PHASE 4: Advanced Features (Weeks 33-40)

> **Gate: Only proceed if Phase 3 metrics are met:** 5,000+ users, NPS > 40, < 30% monthly churn.
> **Deployment target:** Play Store Production + App Store Production.

### 4A: AI Features (via Claude/GPT-4 API)

```
lib/features/ai/
├── pages/
│   ├── smart_workout_page.dart     # "Generate a workout for me"
│   └── ai_meal_suggestion_page.dart
└── data/
    └── ai_service.dart             # API calls to Claude claude-sonnet-4-6
```

**Features:**
| Feature | Prompt inputs | Cost estimate |
|---------|--------------|---------------|
| Smart workout generator | goals, equipment, time available, fitness level | ~Rs.0.50/call |
| Meal suggestions | dosha type, calorie goal, dietary restrictions | ~Rs.0.10/call |
| Meditation recommendation | mood check-in (1-5 scale), stress level | ~Rs.0.05/call |

**Use Claude claude-sonnet-4-6** for cost-efficiency on these tasks.

### 4B: Wearable Integration

```bash
fvm flutter pub add health
```

```
lib/features/wearables/
├── pages/
│   └── wearable_setup_page.dart
└── data/
    └── health_service.dart    # Uses health package
```

**Sync:**
| Platform | Data |
|----------|------|
| Apple HealthKit (iOS) | Steps, heart rate, sleep, calories |
| Google Health Connect (Android) | Steps, heart rate, sleep, calories |

**Defer:** Fitbit, Garmin, Whoop, Oura to Phase 5.

### 4C: Content Scale

| Content | Phase 4 Target | Source |
|---------|---------------|--------|
| Workouts | 100+ | Wger API automation |
| Meditations | 30+ | Partner with 1-2 local creators (revenue share) |
| Indian foods | 2,000+ | Open Food Facts + manual seeding |
| Recipes | 200+ | Partnership with food bloggers |

### 4D: GPS Outdoor Activities

```
lib/features/outdoor/
├── pages/
│   ├── outdoor_home_page.dart
│   └── active_session_page.dart    # Live map + stats
└── widgets/
    ├── map_widget.dart
    └── live_stats_bar.dart         # Speed, distance, pace
```

```bash
fvm flutter pub add geolocator google_maps_flutter
```

---

### PHASE 4 - HUMAN TASKS

#### Step 1: Run locally
```bash
fvm flutter pub get
fvm flutter analyze
fvm flutter run
```

**Manual test checklist:**
```
AI FEATURES
  [ ] Smart workout generator returns a real workout plan
  [ ] Meal suggestion returns relevant Indian meals
  [ ] Response time < 5 seconds
  [ ] Error handled if API is down

WEARABLES
  [ ] iOS: HealthKit permission prompt appears
  [ ] Android: Health Connect permission prompt appears
  [ ] Steps synced correctly (compare with device native app)
  [ ] Heart rate data appears in app

GPS OUTDOOR
  [ ] Location permission requested
  [ ] Map loads with current location
  [ ] Start run/walk -> route draws on map
  [ ] Distance/pace stats update in real-time
  [ ] Stop -> session saved to history
```

#### Step 2: Play Store Production deployment
```bash
fvm flutter build appbundle --release
git add .
git commit -m "phase-4: AI features, wearables, GPS, content scale"
git push origin main
# CI builds + submits to Play Store
```

**Play Store promotion flow:**
```
Beta -> Production (Staged rollout 10% -> 25% -> 50% -> 100%)
Play Console -> Release -> Production -> Create release
Set rollout to 10% initially
Monitor crash rate for 48h -> increase rollout
```

**App Store submission:**
```
App Store Connect -> My Apps -> + New App
Submit for App Review (takes 1-7 days)
```

#### Phase 4 done when:
- [ ] AI features working end-to-end with live API
- [ ] Wearable sync tested on real Apple Watch / Android wearable
- [ ] GPS tracking tested on real outdoor run
- [ ] 100+ workouts in app
- [ ] App live on Play Store Production (staged rollout)
- [ ] App approved on App Store
- [ ] 10,000 downloads milestone hit
- [ ] `fvm flutter analyze` = 0 errors

---

## PHASE 5: Scale (Year 2+)

> Only plan in detail when Phase 4 targets are hit. Full specs in `docs/App.md`.

| Feature | Source Doc | When |
|---------|------------|------|
| Creator Platform | App.md Section 8 | 50K users |
| BeYou Store | App.md Section 6 | 50K users |
| B2B Corporate Wellness | Business_Analysis.md | 50K users |
| Hindi + Regional Languages | Business_Analysis.md | 25K users |
| WhatsApp Integration | Business_Analysis.md | 25K users |
| Live Sessions | App.md Section 4.7 | 50K users |
| Community Groups + Challenges | App.md Section 4.2 | 25K users |
| Full wearable ecosystem (11 devices) | App.md Section 7 | Year 2 |
| Mood journaling | App.md Section 2.4 | Year 2 |
| Sleep stories + sounds | App.md Section 2.3 | Year 2 |

---

## Continuous Update Cycle (After Phase 1)

Once CI/CD is live, every feature update follows this cycle:

```
1. Code on feature branch
        |
        v
2. fvm flutter analyze (must pass)
        |
        v
3. fvm flutter test (all tests pass)
        |
        v
4. Pull Request -> code review by team
        |
        v
5. Merge to main
        |
        v
6. GitHub Actions triggers automatically:
   - flutter analyze
   - flutter test
   - flutter build appbundle
   - Upload to Firebase App Distribution (beta) OR Play Store
        |
        v
7. Manual smoke test on real device (15 min)
        |
        v
8. Promote build: Internal -> Alpha -> Beta -> Production
   (each promotion = verify metrics + crash rate)
```

**Hotfix flow (for critical bugs):**
```bash
git checkout -b hotfix/crash-on-login
# fix the bug
git commit -m "fix: crash on login when user has no profile document"
git push origin hotfix/crash-on-login
# Create PR -> merge to main -> CI auto-deploys
```

---

## Decision Framework

```
Is this a Flutter version / environment issue?
  -> docs/MASTER_PLAN.md (FVM section)

Is this a code reorganization task?
  -> docs/MIGRATION_PLAN.md

Is this a UI screen to implement?
  -> docs/STITCH_UI.md

Is this a new feature question?
  -> Check which phase it belongs to above
     Phase 0-1: Build now
     Phase 2-3: Plan it, don't build yet
     Phase 4+: Write it down, ignore for now

Is this a tech / architecture decision?
  -> docs/Dev.md

Is this a business / pricing decision?
  -> docs/Business_Analysis.md or docs/Finances.md

Is this a market / competitor question?
  -> docs/Research.md
```

---

## Tech Constraints (Non-Negotiable)

| Decision | Choice | Reason |
|----------|--------|--------|
| Flutter version management | FVM | Other project on same machine uses different version |
| State management | BLoC (keep existing) | Already working, no migration needed |
| Navigation | GoRouter (keep existing) | Already configured |
| Backend | Firebase only | Team capacity, free tier covers up to 10K users |
| Database | Firestore + Hive (offline) | Firebase ecosystem |
| Payments | Razorpay | UPI support, India-first |
| Content | Open-source APIs first | Cannot produce 5000 videos in-house |
| AI | Claude claude-sonnet-4-6 API | Cost-efficient for Phase 4 feature set |
| CI/CD | GitHub Actions (free) | Already in Finances.md cost model |
| Beta distribution | Firebase App Distribution | Free, easy |
| Languages | English only until Phase 3 | Focus before adding Hindi |

---

## Non-Negotiables Before Beta Launch (Phase 1)

1. **Legal:** Terms of Service + Privacy Policy pages in-app (can link to web page)
2. **Health Disclaimer:** "BeYou is not a medical device. Consult a doctor before starting any fitness program." - show before first workout
3. **Analytics:** Firebase Analytics instrumented from Phase 1
4. **Firebase Billing Alerts:** Set at Rs.500, Rs.1,000, Rs.2,000 in Firebase Console
5. **Exit Criteria:** If 6 months post-launch < 1,000 users, stop and pivot

---

## Phase Summary

| Phase | What | Duration | Deployment | Target |
|-------|------|----------|------------|--------|
| 0 | Clean arch + STITCH_UI + CI/CD setup | Weeks 1-6 | APK artifact | Working polished app |
| 1 | Mindfulness + I Am Clean + Firestore | Weeks 7-16 | Firebase App Distribution | 500 beta testers |
| 2 | Food log + Community + Razorpay | Weeks 17-24 | Play Store Internal/Alpha | 2,000 users, first revenue |
| 3 | Analytics + Gamification + Offline | Weeks 25-32 | Play Store Beta + TestFlight | 5,000 users |
| 4 | AI + Wearables + GPS + Content scale | Weeks 33-40 | Play Store Production + App Store | 10,000 users, public launch |
| 5 | Creator, Store, B2B, Languages | Year 2+ | Continuous | 50K+ users |

---

*End of Master Plan v2.0*
