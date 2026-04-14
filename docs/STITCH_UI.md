# BeYou - Complete UI Specification for Stitch

> **App Name:** BeYou - Your Complete Wellness Journey
> **Platform:** Flutter (Android/iOS)
> **Font Family:** NotoSansKR (Thin, Light, Regular, Medium, Bold, Black)
> **Orientation:** Portrait only

---

## DESIGN TOKENS

### Colors
| Name | Hex | Usage |
|------|-----|-------|
| Primary | `#6358E1` | Buttons, active states, links, accents |
| Text Black | `#1F2022` | Primary text |
| White | `#FFFFFF` | Backgrounds, button text |
| Grey | `#B6BDC6` | Placeholder text, inactive icons, secondary text |
| Loading Black | `#80000000` | Loading overlay (50% black) |
| Text Field BG | `#FBFCFF` | Input field background |
| Text Field Border | `#B9BBC5` | Input field border (40% opacity) |
| Disabled | `#E1E1E5` | Disabled button background |
| Error | `#F25252` | Error text, error borders |
| Home BG | `rgba(252,252,252,1)` | Home & workout list background |
| Text Grey | `#8F98A3` | Secondary labels |
| Cardio Color | `#FCB74F` | Cardio workout card background |
| Arms Color | `#5C9BA4` | Arms workout card background |
| Vata Color | `#6C63FF` | Dosha - Vata accent |
| Pitta Color | `#FF7043` | Dosha - Pitta accent |
| Kapha Color | `#4CAF50` | Dosha - Kapha accent |

### Typography Scale
| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| Display Large | 32px | Bold (700) | - |
| Display Medium | 28px | Bold (700) | - |
| Display Small / Headline | 24px | Bold (700) | Screen titles, section headers, workout card title |
| Headline Medium | 20px | SemiBold (600) | Sub-headers |
| Title Large | 18px | SemiBold (600) | AppBar titles, section labels, button text, settings items |
| Body Large | 16px | Regular (400) | Body text, input text, descriptions, placeholder |
| Body Medium | 14px | Regular (400) | Secondary body, hints, labels |
| Body Small | 12px | Regular (400) | Captions, helper text |
| Stats Large | 48px | Bold (700) | Big stat number (completed workouts) |
| Stats Count | 24px | Bold (700) | Count numbers in stat cards |

### Border Radii
| Value | Usage |
|-------|-------|
| 100px (full round) | FitnessButton, SettingsContainer |
| 50px | Sliding panel top corners |
| 40px | SettingsContainer |
| 30px | CustomButton, CustomTextField (core widgets) |
| 20px | Repeating day chips, workout tags, video container, dosha option cards |
| 15px | Home workout cards (horizontal), workout card image |
| 12px | Dosha option cards |
| 10px | Workout list cards, stat cards, progress card, FitnessTextField input |
| 8px | Dosha category label badge |
| 6px | Dosha distribution progress bars |
| 5px | Exercise cell image |

### Shadows
| Usage | Config |
|-------|--------|
| Card Shadow | color: textBlack @ 12% opacity, blur: 5.0, spread: 1.1 |

---

## GLOBAL REUSABLE COMPONENTS

### 1. FitnessButton (Primary CTA)
- **Size:** Full width, height 55px
- **Shape:** Rounded rectangle, borderRadius 100px (pill)
- **Enabled State:** Background = Primary (#6358E1), text = White, fontSize 18, bold
- **Disabled State:** Background = Disabled (#E1E1E5), text = White
- **Interaction:** InkWell with borderRadius 100
- **Used on:** Sign In, Sign Up, Forgot Password, Edit Account, Change Password, Start Workout

### 2. CustomButton (Core alternative)
- **Size:** Full width (or custom), height 56px
- **Shape:** borderRadius 30px
- **Enabled:** Background = Primary, text = White, fontSize 16, semiBold
- **Disabled:** Grey @ 30% opacity
- **Loading State:** Shows 24x24 CircularProgressIndicator (white, strokeWidth 2)
- **Optional:** Leading icon

### 3. FitnessTextField (Auth forms)
- **Layout:** Full width, horizontal padding 20px
- **Label:** Above the field, fontSize 14, weight 500
  - Label colors: Grey (empty) -> Primary (focused) -> Error Red (error) -> TextBlack (filled)
- **Input Field:** borderRadius 10, background #FBFCFF
  - Border: #B9BBC5 @ 40% opacity (normal), Primary (focused), Error Red (error)
  - Text: fontSize 16, TextBlack
  - Hint: fontSize 16, Grey
- **Password toggle:** Eye icon (asset) positioned right, tinted Primary when filled, Grey when empty
- **Error text:** Below field, fontSize 14, Error Red

### 4. SettingsContainer (Settings row item)
- **Size:** Full width, height 50px
- **Shape:** borderRadius 40px (pill)
- **Background:** White with card shadow
- **Padding:** horizontal 20px, vertical 10px margin
- **Optional:** Right arrow icon (Icons.arrow_forward_ios, Primary, size 20)
- **Interaction:** InkWell with borderRadius 40

### 5. SettingsTextField (Inside SettingsContainer)
- **No visible border** (InputBorder.none everywhere)
- **Text:** fontWeight w600
- **Hint:** Grey, fontSize 16
- **Password toggle:** Same eye icon as FitnessTextField

### 6. FitnessLoading (Full-screen overlay)
- **Background:** Full screen, loadingBlack (#80000000) - 50% black overlay
- **Indicator:** CupertinoActivityIndicator, radius 17, dark brightness theme
- **Usage:** Stacked on top of content during loading states

### 7. ErrorDisplayWidget
- **Layout:** Centered column
- **Icon:** Icons.error_outline, size 64, red shade 300
- **Title:** "Oops!" - headlineMedium, bold
- **Message:** bodyMedium, centered
- **Optional:** "Try Again" ElevatedButton with refresh icon

### 8. LoadingWidget
- **Layout:** Centered column
- **Indicator:** CircularProgressIndicator, Primary color
- **Optional message:** bodyMedium, centered

---

## SCREEN-BY-SCREEN SPECIFICATION

---

### SCREEN 1: Onboarding (3 pages)

**Route:** `/onboarding`
**Background:** White (default scaffold)

**Layout:** SafeArea > Column
- **Top section (flex: 4):** Horizontal PageView with 3 OnboardingTiles
- **Bottom section (flex: 2):** Dots indicator + circular progress button

#### OnboardingTile (each page)
- **Padding:** horizontal 24px
- **Top spacing:** 34px
- **Image:** Expanded, asset image (fills available space)
- **Spacing:** 65px below image
- **Title:** fontSize 24, fontWeight 700, centered
- **Spacing:** 15px
- **Description:** fontSize 16, centered, horizontal padding = screenWidth/100

#### Onboarding Page Data
| Page | Title | Description | Image |
|------|-------|-------------|-------|
| 1 | "Workout anywhere" | "You can do your workout at home without any equipment, outside or at the gym." | `assets/images/onboarding/onboarding.png` |
| 2 | "Learn techniques" | "Our workout programs are made by professionals." | `assets/images/onboarding/onboarding_2.png` |
| 3 | "Stay strong & healthy" | "We want you to fully enjoy the program and stay healthy and positive." | `assets/images/onboarding/onboarding_3.png` |

#### Bottom Section
- **Spacing:** 30px top
- **DotsIndicator:** 3 dots, inactive = grey, active = Primary
- **Spacer** between dots and button
- **Circular Progress Button:**
  - CircularPercentIndicator: radius 110
  - Background ring: Primary color
  - Progress ring: White
  - Progress values: Page 0 = 25%, Page 1 = 65%, Page 2 = 100% (animated)
  - Center: Circle button (Primary bg) with right-arrow icon (Icons.east_rounded, size 38, white), padding 24
  - Animated with TweenAnimationBuilder (1 second)
- **Bottom spacing:** 30px

**Navigation:** Last page press -> goes to Sign Up (`/signup`)

---

### SCREEN 2: Sign Up

**Route:** `/signup`
**Background:** White

**Layout:** GestureDetector (tap to dismiss keyboard) > Stack [MainContent, LoadingOverlay]

#### Main Content: SafeArea > SingleChildScrollView > Column
1. **Spacing:** 20px top
2. **Title:** "Sign up" - fontSize 24, bold, TextBlack, centered
3. **Form Fields (4):**
   - Username: FitnessTextField, title "Username", placeholder "Your name", textInputAction next
   - Email: FitnessTextField, title "Email", placeholder "example@mail.com", keyboard emailAddress, textInputAction next
   - Password: FitnessTextField, title "Password", placeholder "Must be at least 6 symbols", obscureText true, textInputAction next
   - Confirm Password: FitnessTextField, title "Confirm password", placeholder "Re-enter password", obscureText true
   - **Spacing between fields:** 20px
4. **Spacing:** 40px
5. **Sign Up Button:** FitnessButton, title "Sign Up", horizontal padding 20px
   - Disabled until all fields valid
6. **Spacing:** 40px
7. **Already have account:** RichText centered
   - "Already have an account?" - fontSize 18, TextBlack
   - " Sign In" - fontSize 18, Primary, bold, tappable

**Validation Rules:**
- Username: must not be empty
- Email: valid email format
- Password: at least 6 characters
- Confirm Password: must match password

---

### SCREEN 3: Sign In

**Route:** `/signin`
**Background:** White

**Layout:** Stack [MainContent, LoadingOverlay]

#### Main Content: SafeArea > SingleChildScrollView > SizedBox (fullHeight - 30 - bottomPadding) > Column
1. **Spacing:** 20px top
2. **Title:** "Sign In" - fontSize 24, bold, TextBlack, centered
3. **Spacing:** 50px
4. **Form Fields (2):**
   - Email: FitnessTextField, title "Email", placeholder "example@mail.com", keyboard emailAddress, textInputAction next
   - **Spacing:** 20px
   - Password: FitnessTextField, title "Password", placeholder "Enter your password", obscureText true
5. **Spacing:** 20px
6. **Forgot Password Link:** left padding 21px
   - "Forgot password?" - fontSize 16, bold, Primary color
   - Tappable -> navigates to Forgot Password
7. **Spacing:** 40px
8. **Sign In Button:** FitnessButton, title "Sign In", horizontal padding 20px
   - Disabled until email + password valid
9. **Spacer** (pushes bottom text down)
10. **Don't have account:** RichText centered
    - "Do not have an account?" - fontSize 18, TextBlack
    - " Sign up" - fontSize 18, Primary, bold, tappable
11. **Spacing:** 30px bottom

---

### SCREEN 4: Forgot Password

**Route:** `/forgot-password`
**Background:** White
**AppBar:** Title "Password Reset"

**Layout:** Stack [MainContent, LoadingOverlay]

#### Main Content: SafeArea > SingleChildScrollView > SizedBox (calculated height) > Column
1. **Spacer (flex: 2)**
2. **Email Field:** FitnessTextField, title "Email", placeholder "example@mail.com", keyboard emailAddress
3. **Spacer (flex: 3)**
4. **Send Button:** FitnessButton, title "Send Activation Link", horizontal padding 20px
   - Enabled when email field has text
5. **Spacing:** 30px bottom

**Success:** Shows snackbar "Reset password link was sent on your email."

---

### SCREEN 5: Tab Bar (Main Shell)

**Route:** `/` (home/root)

**Layout:** Scaffold with body + BottomNavigationBar

#### Bottom Navigation Bar
- **Style:** fixedColor = Primary
- **4 tabs:**

| Index | Label | Icon | Icon Type |
|-------|-------|------|-----------|
| 0 | "Home" | `assets/icons/home/home_icon.png` | Image asset |
| 1 | "Workouts" | `assets/icons/home/workouts_icon.png` | Image asset |
| 2 | "Dosha" | Icons.spa | Material icon |
| 3 | "Settings" | `assets/icons/home/settings_icon.png` | Image asset |

- **Active icon tint:** Primary color
- **Inactive icon tint:** default (no tint applied)

**Body:** Switches between HomePage, WorkoutsPage, DoshaPage, SettingsScreen based on selected tab index

---

### SCREEN 6: Home

**Background:** homeBackgroundColor `rgba(252,252,252,1)`

**Layout:** SafeArea > ListView (vertical padding 20)

#### Section 1: Profile Header
- **Padding:** horizontal 20
- **Layout:** Row, spaceBetween
- **Left column:**
  - "Hi, {userName}" - fontSize 24, bold
  - Spacing: 2px
  - "Let's check your activity" - fontSize 18, weight 500
- **Right:** CircleAvatar, radius 60, backgroundImage = `assets/images/home/profile.png`
  - Tappable -> navigates to Edit Account

#### Section 2: Statistics (spacing 35px below header)
- **Padding:** horizontal 20
- **Layout:** Row, spaceBetween

**Left Card - Completed Workouts:**
- **Size:** width = screenWidth * 0.35, height 200
- **Shape:** borderRadius 10, white, card shadow
- **Padding:** 15
- **Content (column, spaceEvenly):**
  - Row: finished icon (`assets/images/home/finished.png`) + "Finished" text (fontSize 18, w500)
  - "12" - fontSize 48, w700, TextBlack (centered)
  - "Completed workouts" - fontSize 16, w500, TextGrey, centered

**Right Column - Two small cards:**

Card 1 - In Progress:
- **Size:** width = screenWidth * 0.5, height 90
- **Shape:** borderRadius 10, white, card shadow
- **Padding:** horizontal 15
- **Content (column, spaceEvenly):**
  - Row: inProgress icon + "In progress" (fontSize 18, w500)
  - Row: "2" (fontSize 24, w700) + "Workouts" (fontSize 16, w500, Grey)

Card 2 - Time Sent:
- Same layout as above
- Icon: time icon
- Title: "Time sent"
- Count: "62"
- Label: "Minutes"

**Spacing:** 20px between the two right cards

#### Section 3: Discover Workouts (spacing 30px below stats)
- **Title:** "Discover new workouts" - fontSize 18, bold, TextBlack, padding horizontal 20
- **Spacing:** 15px below title
- **Horizontal ListView:** height 160

**WorkoutCard (Home variant - colored cards):**
- **Size:** width = screenWidth * 0.6, height 160
- **Shape:** borderRadius 15, filled with color
- **Padding:** left 20, top 10, right 12
- **Layout:** Stack
  - Top-left column:
    - Title: fontSize 24, bold, White (e.g. "Cardio")
    - Spacing: 10px
    - "{X} exercises" - fontSize 16, w500, White
    - Spacing: 5px
    - "{X} minutes" - fontSize 16, w500, White
  - Bottom-right: Workout image asset (positioned)

| Card | Title | Exercises | Minutes | Color | Image |
|------|-------|-----------|---------|-------|-------|
| 1 | Cardio | 10 | 50 | Cardio (#FCB74F) | `assets/images/home/cardio.png` |
| 2 | Arms | 6 | 35 | Arms (#5C9BA4) | `assets/images/home/cardio.png` |

- **Spacing:** 15px between cards, 20px padding on sides
- **Tap:** Navigates to Workout Details

#### Section 4: Progress Card (spacing 25px)
- **Margin:** horizontal 20
- **Padding:** horizontal 20, vertical 15
- **Shape:** borderRadius 10, white, card shadow
- **Layout:** Row
  - Left: Progress icon (`assets/icons/home/progress.png`)
  - Spacing: 20px
  - Right (Flexible column):
    - "Keep the progress!" - fontSize 18, bold
    - Spacing: 3px
    - "You are more successful than 88% users." - fontSize 16, maxLines 2, ellipsis

---

### SCREEN 7: Workouts List

**Background:** homeBackgroundColor

**Layout:** Column
- **Top padding:** 50px
- **Title:** "Workouts" - fontSize 24, bold, horizontal padding 20

#### Workout List Card (vertical list)
- **Size:** full width, height 140
- **Margin:** horizontal 20, bottom 20
- **Shape:** borderRadius 10, white, card shadow
- **Padding:** horizontal 20, vertical 15
- **Layout:** Row
  - **Left (Expanded) column:**
    - Title: fontSize 18, bold (e.g. "Yoga")
    - Spacing: 3px
    - "{X} Exercises" - fontSize 16, w500, Grey
    - Spacing: 3px
    - "{X} Minutes" - fontSize 16, w500, Grey
    - Spacer
    - Progress text: "{current}/{total}" - fontSize 10
    - Spacing: 3px
    - LinearPercentIndicator: height 6, progressColor Primary, bg Primary @ 12% opacity
  - **Spacing:** 60px
  - **Right (Expanded):** Image asset, borderRadius 15, fill

#### Workout List Data
| Title | Exercises | Minutes | Progress | Image |
|-------|-----------|---------|----------|-------|
| Yoga | 16 | 52 | 10/16 | `assets/icons/workouts/yoga.png` |
| Pilates | 20 | 60 | 1/20 | `assets/icons/workouts/pilates.png` |
| Full body | 14 | 48 | 12/14 | `assets/icons/workouts/full_body.png` |
| Stretching | 8 | 35 | 0/8 | `assets/icons/workouts/stretching.png` |

**Tap:** Navigates to Workout Details with workout data

---

### SCREEN 8: Workout Details

**Route:** `/workout-details`
**Background:** White

**Layout:** SlidingUpPanel
- **minHeight:** screenHeight * 0.65
- **maxHeight:** screenHeight * 0.87
- **borderRadius:** topLeft 50, topRight 50

#### Body (behind panel): Full-screen workout image
- **Back button:** Positioned top-left (left 20, top 14 from SafeArea)
  - Image: `assets/icons/workouts/back.png`, 30x30

#### Panel Content: Column
1. **Spacing:** 15px
2. **Drag Handle:** `assets/icons/workouts/rectangle.png` image (centered)
3. **Spacing:** 15px
4. **Header:** "{WorkoutTitle}  Workout" - fontSize 24, bold, padding horizontal 20
5. **Spacing:** 20px
6. **Tags Row:** padding horizontal 10
   - WorkoutTag 1: time icon + "{minutes}:00"
   - Spacing: 15px
   - WorkoutTag 2: exercise icon + "{count} exercises"
7. **Spacing:** 20px
8. **Exercises List:** Expanded, padding horizontal 20

#### WorkoutTag Widget
- **Shape:** borderRadius 20, background Primary @ 12% opacity
- **Padding:** horizontal 17, vertical 10
- **Layout:** Row
  - Icon image: 17x17
  - Spacing: 7px
  - Text: fontSize 14, w500, Primary color

#### ExerciseCell (list item)
- **Shape:** borderRadius 10, white, card shadow
- **Padding:** left 10, right 25, vertical 10
- **Layout:** Row
  - **Left image:** 75x70 container, borderRadius 5, workout image (contain)
  - **Spacing:** 10px
  - **Center (Expanded) column:**
    - Title: fontSize 16, w700, textColor
    - "{minutes} minutes" - fontSize 14, w400, TextBlack
    - Spacing: 11px
    - LinearPercentIndicator: height 6, Primary, bg Primary @ 12%
  - **Spacing:** 10px
  - **Right arrow:** back.png rotated 180 degrees

#### Exercise Data per Workout
| Exercise | Minutes | Video |
|----------|---------|-------|
| Reclining to big toe | 12 | `assets/videos/workouts/reclining.mp4` |
| Cow Pose | 8 | `assets/videos/workouts/cow.mp4` |
| Warrior II Pose | 12 | `assets/videos/workouts/warriorII.mp4` |

**Tap exercise cell:** Navigates to Start Workout

---

### SCREEN 9: Start Workout (Exercise Detail)

**Background:** White

**Layout:** SafeArea > Column, padding horizontal 20, vertical 20

1. **Back Button Row:** padding left 10, top 8
   - back.png icon + spacing 17px + "Back" text (fontSize 18, w500)
   - Tappable -> go back

2. **Spacing:** 23px

3. **Video Player:** height 264, full width, borderRadius 20
   - Uses Chewie video player
   - Looping, not autoplay
   - Aspect ratio 15/10
   - Loading placeholder: CupertinoActivityIndicator
   - Progress bar color: Primary

4. **Spacing:** 8px

5. **Scrollable Content (Expanded ListView):**
   - **Title:** fontSize 24, bold
   - **Spacing:** 9px
   - **Description:** fontSize 14, w500
   - **Spacing:** 30px
   - **Steps:** Numbered list
     - Each step: Row
       - Number badge: 25x25, borderRadius 20, Primary @ 12% bg
         - Number text: fontSize 14, bold, Primary
       - Spacing: 10px
       - Description text: Expanded

6. **Bottom Section (fixed):**
   - **Next Exercise Info** (if exists): Row centered
     - "Next Exercise:" - fontSize 17, w600, Grey
     - Spacing: 5px
     - "{nextTitle}" - fontSize 17, w600, TextBlack
     - Spacing: 6.5px
     - Clock icon (Icons.access_time, size 20)
     - Spacing: 6.5px
     - "00:{minutes}" formatted
   - **Spacing:** 18px
   - **Button:** FitnessButton
     - Title: "Next" (if more exercises) or "Finish" (if last)
     - Tap: Navigate to next exercise or pop back

---

### SCREEN 10: Settings

**Background:** Default (white scaffold)

**Layout:** SafeArea > SingleChildScrollView > Padding (top 20, left 20, right 20) > Column

1. **Profile Image:** Center
   - CircleAvatar, radius 60
   - Asset image or network image with FadeInImage (placeholder: profile.png, size 200x120, cover)
   - **Edit button:** Positioned top-right
     - TextButton with CircleBorder shape
     - Background: Primary @ 16% opacity
     - Icon: Icons.edit, Primary color

2. **Spacing:** 15px

3. **Display Name:** fontSize 24, bold, centered

4. **Spacing:** 15px

5. **Settings Items (SettingsContainers):**

| Item | Text | Has Arrow | Action |
|------|------|-----------|--------|
| Reminder | "Reminder" (fontSize 17, w500) | Yes | Navigate to /reminder |
| Rate Us | "Rate us on Play market/App store" (fontSize 17, w500) | No | Open store URL |
| Terms | "Terms & Conditions" (fontSize 17, w500) | No | Open URL |
| Sign Out | "Sign Out" (fontSize 17, w500) | No | Sign out + navigate to /signin |

6. **Spacing:** 15px

7. **Social Media Title:** "Join us in social media" - fontSize 18, w600, centered

8. **Spacing:** 15px

9. **Social Icons Row:** centered
   - 3 TextButtons with CircleBorder, white background, elevation 1
   - Icons: `facebook.png`, `instagram.png`, `twitter.png`
   - Each opens respective URL

---

### SCREEN 11: Edit Account

**Route:** `/edit-account`
**AppBar:** Title "Edit account" (fontSize 18, black), transparent bg, back button (Icons.arrow_back_ios_new, Primary)

**Layout:** SafeArea > SingleChildScrollView > Padding (top 20, left/right 20) > SizedBox (calculated height) > Column

1. **Profile Image:** Centered CircleAvatar, radius 60 (same logic as settings)

2. **Spacing:** 15px

3. **Edit Photo Button:** TextButton centered
   - "Edit photo" - fontSize 18, bold, Primary

4. **Spacing:** 15px

5. **Full Name Section:**
   - Label: "Full name" - fontWeight w600
   - SettingsContainer > SettingsTextField (placeholder "Enter your full name")
   - Error (if invalid): "Name should contain at least 2 characters" - Error Red

6. **Email Section:**
   - Label: "Email" - fontWeight w600
   - SettingsContainer > SettingsTextField (placeholder "example@mail.com")
   - Error (if invalid): error text in Error Red

7. **Spacing:** 15px

8. **Change Password Link:** InkWell > Row
   - "Change Password" - w600, Primary, fontSize 18
   - Spacing: 10px
   - Icons.arrow_forward_ios, Primary

9. **Spacer** (pushes save button to bottom)

10. **Save Button:** FitnessButton, title "Save", always enabled

**Camera Permission Dialog (CupertinoAlertDialog):**
- Title: "Camera permission"
- Content: "This app needs camera access to take pictures for upload user profile photo"
- Actions: "Deny" (pop), "Settings" (open app settings)

---

### SCREEN 12: Change Password

**Route:** `/change-password`
**AppBar:** Title "Change Password" (fontSize 18, black), transparent bg, back button (Primary)

**Layout:** SafeArea > SingleChildScrollView > Padding (top 20, left/right 20) > SizedBox (calculated height) > Column

1. **Spacing:** 15px

2. **New Password Section:**
   - Label: "New password" - fontWeight w600
   - SettingsContainer > SettingsTextField (placeholder "Must be at least 6 symbols", obscureText true)
   - Error text if invalid (Error Red)

3. **Spacing:** 10px

4. **Confirm Password Section:**
   - Label: "Confirm password" - fontWeight w600
   - SettingsContainer > SettingsTextField (placeholder "Re-enter password", obscureText true)
   - Error text if not matching (Error Red)

5. **Spacer**

6. **Save Button:** FitnessButton, title "Save", always enabled

**Success:** SnackBar "Password successfully updated!"

---

### SCREEN 13: Reminder

**Route:** `/reminder`
**AppBar:** Title "Reminder", back button, save button
**Background:** White

**Layout:** Padding horizontal 20, vertical 20 > ListView

1. **Title:** "Please select reminder time" - fontSize 18, w600

2. **Spacing:** 20px

3. **Time Picker:** CupertinoDatePicker
   - Mode: time only
   - Height: 250px

4. **Spacing:** 20px

5. **Repeating Label:** "How often repeat" - fontSize 18, w600

6. **Spacing:** 15px

7. **Day Selection Chips:** Wrap (spacing 10, runSpacing 15)

| Chip Options |
|---|
| Everyday |
| Mon - Fri |
| Weekends |
| Monday |
| Tue |
| Wed |
| Thu |
| Fri |
| Sat |
| Sun |

**RepeatingDay Chip:**
- **Shape:** borderRadius 20
- **Padding:** horizontal 15, vertical 7
- **Selected:** bg = Primary, text = White, fontSize 16, w600
- **Unselected:** bg = Grey @ 18% opacity, text = Grey, fontSize 16, w600

---

### SCREEN 14: Dosha Assessment (4 sub-views)

**Tab:** Index 2 in BottomNavigationBar (Icon: Icons.spa, Label: "Dosha")

The Dosha feature has 4 views controlled by state:

---

#### DOSHA VIEW 1: Onboarding

**AppBar:** Title "Dosha Assessment", trailing history button (Icons.history)

**Layout:** SafeArea > SingleChildScrollView > Padding 24

1. **Header Icon:** Centered 80x80 container
   - borderRadius 20
   - Background: primaryContainer (theme)
   - Icon: Icons.spa, size 40, primary color

2. **Spacing:** 24px

3. **Title:** "Ayurvedic Prakriti Assessment" - headlineMedium, w700

4. **Spacing:** 12px

5. **Description:** "Discover the dominant dosha for yourself or a loved one through a guided questionnaire rooted in traditional Ayurvedic principles." - bodyMedium, 70% opacity

6. **Spacing:** 8px

7. **Sub-text:** "21 questions across Physical, Mental, Lifestyle & Environmental categories." - bodySmall, 50% opacity

8. **Spacing:** 32px

9. **Name TextField:** Material style
   - Label: "Participant name"
   - Hint: "e.g. Ananya Sharma"
   - Prefix icon: Icons.person_outline
   - Error: "Please enter a name to begin"

10. **Spacing:** 24px

11. **Start Button:** Full width ElevatedButton.icon
    - Icon: Icons.play_arrow_rounded
    - Label: "Start Assessment"

---

#### DOSHA VIEW 2: Assessment (21 questions)

**AppBar:**
- Title: "Assessment . {participantName}"
- Leading: Icons.close (restart)
- Trailing: Icons.refresh (restart)

**Layout:** SafeArea > Padding 24 > Column

1. **Progress header:** "Question {current}/{total}" - titleMedium, w600

2. **Spacing:** 8px

3. **Progress Bar:** LinearProgressIndicator
   - borderRadius 999 (pill), height 6
   - Value: currentIndex / totalQuestions

4. **Spacing:** 24px

5. **Category Badge:** Container with primaryContainer bg, borderRadius 8
   - Padding: horizontal 10, vertical 4
   - Text: category label (e.g. "Physical", "Mental", "Lifestyle", "Environmental") - labelLarge, w600

6. **Spacing:** 12px

7. **Question Title:** headlineSmall

8. **Helper text** (if exists): bodySmall, hintColor

9. **Spacing:** 24px

10. **Options List (Expanded):** ListView.separated, spacing 12px

**_OptionCard:**
- **Shape:** borderRadius 12, border 1px (dividerColor) or 2px (primary when selected)
- **Background:** surface (normal) or primaryContainer (selected)
- **Padding:** horizontal 16, vertical 14
- **Layout:** Row
  - Radio icon: Icons.radio_button_checked (selected, primary) / Icons.radio_button_off (unselected, hintColor)
  - Spacing: 12px
  - Column:
    - Label: bodyLarge, w600 if selected
    - Description (optional): bodySmall, hintColor, top padding 4

11. **Spacing:** 16px

12. **Navigation Row:**
    - OutlinedButton.icon: Icons.arrow_back + "Previous" (disabled on first question)
    - Spacing: 12px
    - Expanded ElevatedButton.icon:
      - Last question: Icons.insights + "View Results"
      - Other: Icons.arrow_forward + "Next Question"
      - Disabled until an option is selected

**Question Categories:** Physical (7), Mental (5), Lifestyle (5), Environmental (4) = 21 total

---

#### DOSHA VIEW 3: Results

**AppBar:**
- Title: "Results . {participantName}"
- Leading: Icons.arrow_back (back to home)
- Trailing: Icons.history

**Layout:** SafeArea > SingleChildScrollView > Padding 24

1. **Summary Card:** Card with padding 20
   - Title: "{DominantDosha} dominant constitution" - titleLarge
   - Spacing: 8px
   - Subtitle: "Primary dosha balance based on questionnaire responses." - bodyMedium
   - Spacing: 16px
   - **Score Chips Row:** spaceBetween, 3 chips
     - Each chip: Column (value "XX%" headlineSmall w700 + label labelLarge)

2. **Spacing:** 24px

3. **Dosha Distribution Card:** Card with padding 20
   - Title: "Dosha Distribution" - titleMedium
   - Spacing: 20px
   - **Per dosha bar:** (sorted by score descending)
     - Row: dosha name (bodyLarge, w600) + "XX%" (bodyLarge, w700, dosha color)
     - Spacing: 6px
     - LinearProgressIndicator: height 10, borderRadius 6
       - Colors: Vata=#6C63FF, Pitta=#FF7043, Kapha=#4CAF50
       - Background: dosha color @ 15% opacity

4. **Spacing:** 24px

5. **Key Traits Card:** Card with padding 20
   - Header row: Icons.bolt (primary) + "Key Traits" titleMedium
   - Spacing: 12px
   - Bullet list of traits ("." prefix, bodyMedium, vertical padding 6)

6. **Spacing:** 24px

7. **Recommendations Card:** Same layout as traits
   - Icon: Icons.self_improvement
   - Title: "Recommendations"

8. **Spacing:** 32px

9. **Action Buttons Row:**
   - OutlinedButton.icon: Icons.history + "View History" (expanded)
   - Spacing: 12px
   - ElevatedButton.icon: Icons.replay + "Retake" (expanded)

---

#### DOSHA VIEW 4: History

**AppBar:**
- Title: "Assessment History"
- Leading: Icons.arrow_back
- Trailing: Icons.delete_outline (clear all)

**Empty State:** Centered column
- Icon: Icons.spa_outlined, size 80, primary
- Spacing: 16px
- "No assessments yet" - fontSize 18
- Spacing: 8px
- "Complete an assessment to see history here." - bodyMedium, centered

**History List:** ListView.separated, padding 16, spacing 12

**History Card:** Card with InkWell
- Padding: 16
- **Row:** participant name (titleMedium) + timestamp (bodySmall) - spaceBetween
- Spacing: 12px
- **Dosha Chips:** Wrap (spacing 12, runSpacing 8)
  - Material Chip per dosha: "{Dosha}: XX%"
- Spacing: 12px
- "Dominant dosha: {name}" - labelLarge

**Clear History Dialog (AlertDialog):**
- Title: "Clear history?"
- Content: "This will remove all saved assessments. This action cannot be undone."
- Actions: TextButton "Cancel", FilledButton "Clear"

---

## DATA MODELS

### WorkoutData
```
title: String          (e.g. "Yoga")
exercices: String      (e.g. "16" - number of exercises)
minutes: String        (e.g. "52")
currentProgress: int   (e.g. 10)
progress: int          (e.g. 16 - total)
image: String          (asset path)
exerciseDataList: List<ExerciseData>
```

### ExerciseData
```
title: String          (e.g. "Reclining to big toe")
minutes: int           (e.g. 12)
progress: double       (0.0 to 1.0)
video: String          (asset path to mp4)
description: String    (exercise description text)
steps: List<String>    (step-by-step instructions)
```

---

## ASSET INVENTORY

### Images
| Path | Usage |
|------|-------|
| `assets/images/onboarding/onboarding.png` | Onboarding page 1 |
| `assets/images/onboarding/onboarding_2.png` | Onboarding page 2 |
| `assets/images/onboarding/onboarding_3.png` | Onboarding page 3 |
| `assets/images/auth/eye_icon.png` | Password visibility toggle |
| `assets/images/home/profile.png` | Default profile avatar |
| `assets/images/home/finished.png` | Completed workouts icon |
| `assets/images/home/cardio.png` | Cardio card image |
| `assets/images/home/arms.png` | Arms card image |
| `assets/images/exercises/recicling.png` | Exercise thumbnail |

### Icons
| Path | Usage |
|------|-------|
| `assets/icons/home/home_icon.png` | Tab bar - Home |
| `assets/icons/home/workouts_icon.png` | Tab bar - Workouts |
| `assets/icons/home/settings_icon.png` | Tab bar - Settings |
| `assets/icons/home/progress.png` | Progress card icon |
| `assets/icons/home/inProgress.png` | In-progress stat icon |
| `assets/icons/home/time.png` | Time stat icon |
| `assets/icons/workouts/yoga.png` | Yoga workout icon |
| `assets/icons/workouts/pilates.png` | Pilates workout icon |
| `assets/icons/workouts/full_body.png` | Full body workout icon |
| `assets/icons/workouts/stretching.png` | Stretching workout icon |
| `assets/icons/workouts/back.png` | Back arrow icon |
| `assets/icons/workouts/rectangle.png` | Panel drag handle |
| `assets/icons/workouts/time.png` | Time tag icon |
| `assets/icons/workouts/exercise.png` | Exercise tag icon |
| `assets/icons/social_networks/facebook.png` | Facebook icon |
| `assets/icons/social_networks/instagram.png` | Instagram icon |
| `assets/icons/social_networks/twitter.png` | Twitter icon |

### Videos
| Path | Usage |
|------|-------|
| `assets/videos/workouts/reclining.mp4` | Reclining exercise |
| `assets/videos/workouts/cow.mp4` | Cow Pose exercise |
| `assets/videos/workouts/warriorII.mp4` | Warrior II Pose exercise |

### Fonts
| Font | Weights |
|------|---------|
| NotoSansKR-Regular.otf | 400 |
| NotoSansKR-Medium.otf | 500 |
| NotoSansKR-Bold.otf | 700 |
| NotoSansKR-Light.otf | 300 |
| NotoSansKR-Thin.otf | 100 |
| NotoSansKR-Black.otf | 900 |

---

## NAVIGATION MAP

```
/onboarding
    -> /signup (after last onboarding page)

/signup
    -> /signin (already have account)
    -> / (successful signup)

/signin
    -> /signup (don't have account)
    -> /forgot-password (forgot password)
    -> / (successful signin)

/forgot-password
    -> back to /signin

/ (TabBar Shell)
    Tab 0: Home
        -> /edit-account (tap profile avatar)
        -> /workout-details (tap workout card)
    Tab 1: Workouts
        -> /workout-details (tap workout card)
    Tab 2: Dosha
        (internal state navigation: onboarding -> assessment -> results -> history)
    Tab 3: Settings
        -> /edit-account (tap edit icon)
        -> /reminder (tap reminder)
        -> /signin (sign out)

/edit-account
    -> /change-password (tap change password)
    -> back

/change-password
    -> back

/reminder
    -> back

/workout-details
    -> Start Workout (tap exercise cell, pushes via Navigator)
    -> back

Start Workout
    -> Next Exercise (replaces current route)
    -> back / Finish (pops)
```

---

## COMPLETE TEXT STRINGS

### Common
- "Start"

### Onboarding
- "Workout anywhere"
- "Learn techniques"
- "Stay strong & healthy"
- "You can do your workout at home without any equipment, outside or at the gym."
- "Our workout programs are made by professionals."
- "We want you to fully enjoy the program and stay healthy and positive."

### Auth
- "Sign up", "Sign In", "Sign Out"
- "Username", "Your name", "Text is required"
- "Email", "example@mail.com", "Email is unvalid, please enter email properly"
- "Password", "Must be at least 6 symbols", "Password should contain at least 6 characters"
- "Confirm password", "Re-enter password", "Password is not the same"
- "Already have an account?"
- "Enter your password"
- "Forgot password?"
- "Do not have an account?"
- "Password Reset"
- "Send Activation Link"
- "Reset password link was sent on your email."

### Home
- "Let's check your activity"
- "Finished", "Completed workouts"
- "In progress", "Workouts"
- "Time sent", "Minutes"
- "Discover new workouts"
- "Keep the progress!"
- "You are more successful than 88% users."

### Workouts
- "Cardio" (10 exercises, 50 min)
- "Arms" (6 exercises, 35 min)
- "Yoga" (16 exercises, 52 min)
- "Pilates" (20 exercises, 60 min)
- "Full body" (14 exercises, 48 min)
- "Stretching" (8 exercises, 35 min)

### Workout Details
- "Workout", "exercises", "Exercises"
- "Reclining to big toe" (12 min)
- "Cow Pose" (8 min)
- "Warrior II Pose" (12 min)

### Start Workout
- "Back", "Next", "Finish"
- "Next Exercise:"
- Warrior description: "Named for a fierce warrior, an incarnation of Shiva, this version of Warrior Pose increases stamina."

### Settings
- "Join us in social media"
- "Calendar", "Reminder"
- "Rate us on Play market" / "Rate us on App store"
- "Terms & Conditions"

### Edit Account
- "Edit account", "Edit photo", "Full name"
- "Name should contain at least 2 characters"
- "Change Password"
- "Camera permission"
- "This app needs camera access to take pictures for upload user profile photo"
- "Deny", "Settings"
- "Enter your full name"

### Change Password
- "New password"
- "Password successfully updated!"

### Reminder
- "Please select reminder time"
- "Save"
- "How often repeat"
- Days: "Everyday", "Mon - Fri", "Weekends", "Monday", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"

### Dosha
- "Dosha Assessment"
- "Ayurvedic Prakriti Assessment"
- "Discover the dominant dosha for yourself or a loved one through a guided questionnaire rooted in traditional Ayurvedic principles."
- "21 questions across Physical, Mental, Lifestyle & Environmental categories."
- "Participant name", "e.g. Ananya Sharma"
- "Please enter a name to begin"
- "Start Assessment"
- "Assessment . {name}"
- "Question {n}/{total}"
- "Previous", "Next Question", "View Results"
- "Results . {name}"
- "{Dosha} dominant constitution"
- "Primary dosha balance based on questionnaire responses."
- "Dosha Distribution"
- "Key Traits", "Recommendations"
- "View History", "Retake"
- "Assessment History"
- "Clear history?"
- "This will remove all saved assessments. This action cannot be undone."
- "Cancel", "Clear"
- "No assessments yet"
- "Complete an assessment to see history here."
