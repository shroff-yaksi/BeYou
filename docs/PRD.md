# BeYou — Product Requirements Document
**v2.0 | April 2026 | Market: India**

> **Status:** Confirmed baseline. This document is the single source of truth for what BeYou is and what it will become.
> Features may evolve during development. Any deviation from this plan should be flagged, discussed, and updated here if agreed.

---

## 1. Vision

BeYou is a holistic wellness super-app that replaces fragmented health apps with one unified platform, rooted in Ayurvedic philosophy. It covers Fitness, Ayurveda, Mindfulness, Nutrition, Health tracking, and Community — personalized through your Dosha type, progressing through gamification, and eventually enhanced by AI.

**Tagline:** *Your Complete Wellness Journey*

---

## 2. Navigation Architecture

```
[ Fitness ] [ Ayurveda ] [ Mindfulness ] [ Nutrition ] [ Health ] [ Community ]
                                    + Store (secondary surface)
                                    + Blog/News (secondary surface)
```

---

## 3. Modules

---

### 3.1 Authentication & Onboarding
- Email/password + Google Sign-In
- Forgot password / password reset
- 3-page welcome carousel
- Goal & fitness level selection
- Dosha quick-assessment at entry (full assessment available later)
- First-time profile setup (name, DOB, height, weight, gender)

---

### 3.2 Home Dashboard
- Daily summary: calories, workouts done, meditation streak, "I Am Clean" streak
- Quick-start card: recommended workout or Ayurveda session based on Dosha
- Today's focus (mindfulness prompt)
- Weekly progress ring
- Personalized feed based on Dosha type + goals
- Notification bell + settings shortcut

---

### 3.3 Fitness
- **Workout Library:** 100+ programs filterable by level, type (HIIT, Strength, Cardio, Yoga, Dance, Combat, Aquatic, Sports-Specific, Rehabilitation, Prenatal/Postnatal, Senior, Adaptive), equipment, duration
- **Exercise Database:** sourced from free open-source DBs (yuhonas/free-exercise-db, Wger, ExerciseDB — 800–11,000+ exercises with GIFs/images)
- **Workout Detail:** exercise list, sets/reps/rest, muscle targeting diagram
- **Active Workout:** full-screen timer, rest intervals, video/GIF per exercise, rest skip
- **Workout History:** past sessions with date, duration, calories, exercises
- **Progress Tracking:** body weight, measurements, PRs per exercise, progress charts (weekly/monthly)
- **Custom Workout Builder:** drag-and-drop exercise selection, supersets, circuits, save & share
- **GPS & Outdoor:** real-time tracking for runs and walks, route map, pace, elevation, audio coaching *(Phase 3+)*
- **Scheduling:** workout calendar, recurring templates, rest day recommendations, calendar sync

---

### 3.4 Ayurveda *(The Differentiator — Way of Living)*
- **Dosha System:** Vata / Pitta / Kapha full assessment, personalized profile, re-assessment, history
- **Yoga:** Hatha, Vinyasa, Ashtanga, Kundalini, Yin, Restorative, Prenatal, Postnatal — guided sessions with video
- **Pranayama / Breathing:** Box, 4-7-8, Wim Hof, Kapalbhati, Anulom Vilom, Bhramari, Ujjayi, Breath of Fire — animated visual guides, haptic feedback, custom patterns
- **Postnatal Care Programs:** pregnancy-safe workouts, postpartum recovery, hormonal guidance
- **Anxiety & Stress Programs:** Ayurvedic approach to anxiety, nervous system regulation, adaptogen guides
- **Home Remedies Library:** 2,000+ remedies across immunity, digestion, cold/cough, skin, hair, sleep, stress, pain relief, women's health, men's health, weight management
- **Dinacharya (Daily Routine):** Dosha-personalized morning/evening routine guides
- **Ritucharya (Seasonal Guidance):** lifestyle and diet adjustments per season
- **Panchakarma & Self-Therapy:** Abhyanga, Shirodhara, Swedana — informational guides + home practice

---

### 3.5 Mindfulness
- **Meditation:** 20+ guided sessions (expanding to 2,000+), multiple voice options, background sounds, offline download, session history, streak tracking
- **Sleep Support:** sleep stories, ambient sounds (rain, ocean, forest, white noise), sleep music, binaural beats, sleep meditations, smart alarm, sleep score, bedtime reminders
- **Mood Journal:** daily check-in, emotion wheel, mood patterns, gratitude prompts, free writing, private encrypted storage, export
- **"I Am Clean" Tracker:** 10 addiction types (smoking, alcohol, substances, gambling, social media, gaming, porn, food, shopping, workaholism), streak counter, milestone celebrations, craving SOS, health recovery timeline, money saved calculator, anonymous peer support, relapse reset with compassion
- **Focus Timer:** Pomodoro-style, focus music, session stats, daily/weekly goals
- **Stress SOS:** 2–5 min quick relief sessions, grounding exercises, progressive muscle relaxation
- **Mental Health Hub:**
  - Self-assessment tools (anxiety, depression, stress screening)
  - CBT & DBT exercises
  - Educational article library
  - Crisis resources & helplines (India-specific)
  - Therapist/counselor directory with credentials
  - In-app consultation booking *(links to Consultation module)*
  - Video therapy sessions

---

### 3.6 Nutrition
- **Food Database:** 1,00,000+ foods — Indian cuisine priority (25,000+ dishes across all states + street food + festival foods), international (50,000+), packaged items (30,000+)
- **Food Logging:** text search, barcode scanner, AI photo recognition, voice entry, quick add from history, meal copy
- **Macro & Calorie Tracking:** daily targets, protein/carbs/fats/micros breakdown, meal timing analysis
- **Water & Hydration:** custom daily goals, intake log, reminders, weekly reports
- **Meal Plans:** weight loss, muscle gain, maintenance, diabetic-friendly, Keto, Vegan, Sattvic, Jain, Halal, Kosher, Gluten-free, Pregnancy, Athletic
- **Recipe Library:** 50,000+ recipes with step-by-step instructions, nutrition info, serving size adjuster, diet filters, favorites, ratings
- **Intermittent Fasting Timer:** 16:8, 18:6, 20:4, OMAD, 5:2 protocols, streak tracking, fasting history, educational content
- **Grocery List:** auto-generate from meal plans, manual creation, aisle organization, check-off, sharing
- **Allergy & Dietary Alerts:** personal allergy profile, ingredient warnings, safe alternatives
- **Nutritionist Consultation:** directory, booking, video consultations *(links to Consultation module)*

---

### 3.7 Health *(like Google Fit / Apple Health)*
- **Body Metrics:** weight, height, BMI, body fat %, muscle mass, body measurements — manual log + wearable sync
- **Vitals:** heart rate, HRV, resting heart rate, blood oxygen, blood pressure, temperature
- **Activity Summary:** steps, distance, floors, active minutes, calories burned — aggregated across all sources
- **Sleep Data:** duration, stages, quality score — manual or wearable
- **Women's Health:** menstrual cycle tracking, fertile window, ovulation, symptoms, PMS log
- **Men's Health:** basic tracking hooks (vitals, body metrics, no dedicated content)
- **Health Reports:** weekly/monthly summaries, trend graphs, anomaly alerts
- **Wearable Integration:** Apple HealthKit, Google Health Connect, Fitbit, Garmin, Samsung, Xiaomi/Amazfit, Whoop, Oura *(Phase 4+)*
- **Data Export:** CSV/PDF health reports

---

### 3.8 Community
- **Social Feed:** text, photo, video posts — progress updates, workout shares, recipe shares, before/after, achievement celebrations, reactions, comments, hashtags, moderation
- **Challenges:** platform-hosted + community-created — step, workout, meditation, nutrition, team challenges — leaderboards, badges, duration options
- **Groups & Clubs:** interest-based, location-based, private invite-only, group feeds, group challenges, group events, admin tools
- **Leaderboards:** global, friends, category-specific, weekly/monthly rankings
- **Messaging:** 1:1 and group DMs, media sharing, voice messages, read receipts
- **Live Sessions:** live workouts, guided meditations, cooking classes, Q&As — real-time chat, session replays, creator tipping, reminders
- **Accountability Partners:** buddy matching, shared goals, regular check-ins, buddy challenges
- **Q&A Forums:** question posting, expert answers, community responses, upvoting, topic categories
- **Events:** virtual workshops, local meetups, RSVP, event calendar

---

### 3.9 Consultation Booking *(Cross-module)*
- Directory of verified practitioners: personal trainers, Ayurvedic doctors, nutritionists/dietitians, yoga instructors, therapists, life coaches
- Profile pages: credentials, specializations, ratings, reviews, sample content
- Booking flow: calendar availability, session type (video/chat), duration, price
- In-app video call or chat session
- Session notes + follow-up
- Payment via UPI, cards, wallets

---

### 3.10 BeYou Store
- **Coach & Expert Programs:** purchasable workout programs, meal plans, meditation courses, transformation challenges, combo packages
- **Gym Equipment:** strength, cardio, recovery, accessories
- **Ayurvedic Herbs & Supplements:** raw herbs, powders (Churna), capsules, oils (Tailam), Kadha mixes
- **Books & Media:** fitness, nutrition, Ayurveda, mental health — physical, e-book, audiobook
- **Wellness Products:** meditation tools, aromatherapy, sleep aids, apparel
- **Store Features:** search + filters, wishlists, reviews with photos, UPI/cards/wallets/COD, order tracking, returns, AI recommendations, bundle deals, subscription boxes

---

### 3.11 Blog & News
- **Categories:** Fitness, Nutrition, Mental Health, Ayurveda, Sports, Health Tech, Science, Lifestyle
- **Content Types:** long-form articles, quick tips, listicles, infographics, video blogs, podcasts, research summaries, expert opinions
- **Reader Features:** personalized feed, bookmarking, reading history, text-to-speech, offline reading, social sharing, comments
- **Sources:** BeYou editorial, expert columnists, creator blogs, guest posts, athlete interviews

---

### 3.12 Gamification *(Cross-module, runs throughout)*
- **Points:** workout complete (50–200), meal log (10–30), meditation (20–50), daily check-in (10), challenge win (100–500), streak milestone (50–500)
- **Tiers:** Bronze (0–999) → Silver (1K–4.9K) → Gold (5K–19.9K) → Platinum (20K–49.9K) → Diamond (50K+)
- **Badges:** workout milestones (10/50/100/500), streaks (7/30/100/365 days), challenge wins, community contributions, special events
- **Rewards:** subscription discounts, store credits, exclusive content unlocks, physical merch, partner offers

---

## 4. Ayurvedic Intelligence Layer *(flows into every module)*

Your Dosha type (Vata/Pitta/Kapha) personalizes:
- Recommended workouts
- Food suggestions + foods to avoid
- Meditation styles
- Yoga sequences
- Daily routine (Dinacharya)
- Seasonal guidance (Ritucharya)
- Supplement recommendations
- Home remedy suggestions

---

## 5. Technical Stack

| Layer | Choice |
|---|---|
| Framework | Flutter (Dart SDK ≥3.0.0) |
| State Management | flutter_bloc |
| Navigation | GoRouter |
| DI | GetIt |
| Backend | Firebase (Auth, Firestore, Storage) |
| Local Storage | Hive + SharedPreferences |
| Architecture | Clean Architecture (`features/`) — `features/dosha/` is reference |
| Media | Chewie/video_player, audio_players |
| Notifications | flutter_local_notifications |
| Payment | Razorpay |
| External APIs | Open Food Facts, ExerciseDB/Wger, future: OpenAI |
| Offline | Hive for local content, download manager for media |

---

## 6. Non-Functional Requirements

- Cold start < 3s, 60fps animations throughout
- Offline access for core workouts, Ayurveda content, meditation sessions
- DPDP (India) compliance, end-to-end encryption for health + therapy data
- English first; Hindi, Tamil, Telugu in Phase 5+
- Android primary, iOS secondary, Web for dev/testing
- Screen reader support, adjustable text, high contrast *(Phase 6+)*

---

## 7. Change Log

| Version | Date | Change |
|---|---|---|
| 1.0 | Apr 2026 | Initial PRD draft |
| 2.0 | Apr 2026 | Ayurveda elevated to top-level pillar; Health module added (Google Fit-style); Mental Health Hub moved under Mindfulness; "I Am Clean" under Mindfulness; Blog/News + Consultation Booking added; Daily Planner removed |
