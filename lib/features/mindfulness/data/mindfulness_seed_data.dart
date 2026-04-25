import 'package:flutter/material.dart';
import 'package:beyou/features/mindfulness/models/meditation_session.dart';
import 'package:beyou/features/mindfulness/models/mental_health.dart';
import 'package:beyou/features/mindfulness/models/sleep_content.dart';
import 'package:beyou/features/mindfulness/models/sos_session.dart';

class MindfulnessSeedData {
  // ── Meditations (22 sessions across 8 categories) ────────────────
  static const List<MeditationSession> meditations = [
    MeditationSession(
      id: 'med-001',
      title: 'Morning Awakening',
      narrator: 'Anika Rao',
      category: MeditationCategory.morning,
      durationMinutes: 10,
      description:
          'A gentle 10-minute meditation to set a calm, intentional tone for the day ahead.',
      emoji: '🌅',
      accentColor: Color(0xFFFFB347),
    ),
    MeditationSession(
      id: 'med-002',
      title: 'Sunrise Intention',
      narrator: 'Vikram Joshi',
      category: MeditationCategory.morning,
      durationMinutes: 15,
      description:
          'Begin with three deep breaths and a single intention to carry through the day.',
      emoji: '☀️',
      accentColor: Color(0xFFFFC857),
    ),
    MeditationSession(
      id: 'med-003',
      title: 'Evening Wind Down',
      narrator: 'Priya Menon',
      category: MeditationCategory.evening,
      durationMinutes: 12,
      description:
          'Release the day\'s tension and prepare your mind for restorative sleep.',
      emoji: '🌙',
      accentColor: Color(0xFF6358E1),
    ),
    MeditationSession(
      id: 'med-004',
      title: 'Letting Go',
      narrator: 'Anika Rao',
      category: MeditationCategory.evening,
      durationMinutes: 20,
      description:
          'A guided release practice for thoughts and feelings that no longer serve you.',
      emoji: '🍃',
      accentColor: Color(0xFF7B68EE),
    ),
    MeditationSession(
      id: 'med-005',
      title: '4-7-8 Breath Awareness',
      narrator: 'Self-paced',
      category: MeditationCategory.breath,
      durationMinutes: 5,
      description:
          'Pranayama-inspired breath work to calm the nervous system in 5 minutes.',
      emoji: '🌬️',
      accentColor: Color(0xFF52C7E1),
    ),
    MeditationSession(
      id: 'med-006',
      title: 'Box Breathing',
      narrator: 'Self-paced',
      category: MeditationCategory.breath,
      durationMinutes: 8,
      description: 'Equal-count breathing used by athletes and Navy SEALs to focus the mind.',
      emoji: '⏹️',
      accentColor: Color(0xFF52C7E1),
    ),
    MeditationSession(
      id: 'med-007',
      title: 'Body Scan Relaxation',
      narrator: 'Vikram Joshi',
      category: MeditationCategory.body,
      durationMinutes: 25,
      description:
          'A slow, head-to-toe body scan that releases physical tension and grounds awareness.',
      emoji: '🌿',
      accentColor: Color(0xFF52C78A),
    ),
    MeditationSession(
      id: 'med-008',
      title: 'Quick Body Reset',
      narrator: 'Priya Menon',
      category: MeditationCategory.body,
      durationMinutes: 8,
      description: 'A brief body awareness practice for between meetings or after work.',
      emoji: '💆',
      accentColor: Color(0xFF8DCB95),
    ),
    MeditationSession(
      id: 'med-009',
      title: 'Loving-Kindness for Self',
      narrator: 'Anika Rao',
      category: MeditationCategory.loving,
      durationMinutes: 12,
      description:
          'Direct warmth, compassion, and forgiveness inward — the foundation of metta practice.',
      emoji: '💗',
      accentColor: Color(0xFFE91E63),
    ),
    MeditationSession(
      id: 'med-010',
      title: 'Loving-Kindness for All Beings',
      narrator: 'Vikram Joshi',
      category: MeditationCategory.loving,
      durationMinutes: 18,
      description:
          'Extend metta from yourself outward to loved ones, neutral people, difficult people, and finally all beings.',
      emoji: '🤲',
      accentColor: Color(0xFFFF7AA2),
    ),
    MeditationSession(
      id: 'med-011',
      title: 'Silent Sit — 10 min',
      narrator: 'Bell only',
      category: MeditationCategory.unguided,
      durationMinutes: 10,
      description:
          'An unguided silent meditation with opening and closing bells. For experienced practitioners.',
      emoji: '🔔',
      accentColor: Color(0xFF8F98A3),
    ),
    MeditationSession(
      id: 'med-012',
      title: 'Silent Sit — 20 min',
      narrator: 'Bell only',
      category: MeditationCategory.unguided,
      durationMinutes: 20,
      description: 'Extended silent sit with ambient bell tones every 5 minutes.',
      emoji: '🪷',
      accentColor: Color(0xFF8F98A3),
    ),
    MeditationSession(
      id: 'med-013',
      title: 'Manifest Abundance',
      narrator: 'Priya Menon',
      category: MeditationCategory.manifestation,
      durationMinutes: 15,
      description:
          'A guided visualization to cultivate a mindset of abundance and possibility.',
      emoji: '✨',
      accentColor: Color(0xFFFFD700),
    ),
    MeditationSession(
      id: 'med-014',
      title: 'Manifest Inner Peace',
      narrator: 'Anika Rao',
      category: MeditationCategory.manifestation,
      durationMinutes: 12,
      description: 'Anchor a felt sense of peace as your default state.',
      emoji: '🕊️',
      accentColor: Color(0xFFE6E6FA),
    ),
    MeditationSession(
      id: 'med-015',
      title: 'Stress Release',
      narrator: 'Vikram Joshi',
      category: MeditationCategory.guided,
      durationMinutes: 10,
      description: 'A focused practice to dissolve acute stress and reset your nervous system.',
      emoji: '🌊',
      accentColor: Color(0xFF6358E1),
    ),
    MeditationSession(
      id: 'med-016',
      title: 'Gratitude Practice',
      narrator: 'Priya Menon',
      category: MeditationCategory.guided,
      durationMinutes: 8,
      description: 'Open your heart to what is already abundant in your life.',
      emoji: '🙏',
      accentColor: Color(0xFFFCB74F),
    ),
    MeditationSession(
      id: 'med-017',
      title: 'Focus & Clarity',
      narrator: 'Vikram Joshi',
      category: MeditationCategory.guided,
      durationMinutes: 15,
      description: 'Sharpen mental focus before deep work or an important task.',
      emoji: '🎯',
      accentColor: Color(0xFF6358E1),
    ),
    MeditationSession(
      id: 'med-018',
      title: 'Self-Compassion Break',
      narrator: 'Anika Rao',
      category: MeditationCategory.loving,
      durationMinutes: 5,
      description:
          'A 5-minute Kristin Neff inspired practice for moments of suffering or self-criticism.',
      emoji: '🫶',
      accentColor: Color(0xFFFF7AA2),
    ),
    MeditationSession(
      id: 'med-019',
      title: 'Forest Walk Visualization',
      narrator: 'Priya Menon',
      category: MeditationCategory.guided,
      durationMinutes: 18,
      description: 'A sensory journey through a quiet forest to ground and restore.',
      emoji: '🌲',
      accentColor: Color(0xFF52C78A),
    ),
    MeditationSession(
      id: 'med-020',
      title: 'Pre-Sleep Wind Down',
      narrator: 'Anika Rao',
      category: MeditationCategory.evening,
      durationMinutes: 22,
      description: 'A long, slow practice designed to be played as you fall asleep.',
      emoji: '😴',
      accentColor: Color(0xFF4A5FBE),
    ),
    MeditationSession(
      id: 'med-021',
      title: '3-Minute Breathing Space',
      narrator: 'Vikram Joshi',
      category: MeditationCategory.breath,
      durationMinutes: 3,
      description: 'The classic MBSR micro-practice for any moment of the day.',
      emoji: '⏱️',
      accentColor: Color(0xFF52C7E1),
    ),
    MeditationSession(
      id: 'med-022',
      title: 'Acceptance Practice',
      narrator: 'Priya Menon',
      category: MeditationCategory.guided,
      durationMinutes: 14,
      description: 'A practice for sitting with what is, without resisting or fixing.',
      emoji: '🤍',
      accentColor: Color(0xFFB8B8FF),
    ),
  ];

  // ── Sleep Content ─────────────────────────────────────────────────
  static const List<SleepContent> sleepContent = [
    SleepContent(
      id: 'sleep-001',
      title: 'The Lighthouse Keeper',
      type: SleepContentType.story,
      durationMinutes: 35,
      narrator: 'Vikram Joshi',
      description: 'A slow tale of a quiet keeper, his lamp, and the rhythmic sea below.',
      emoji: '🗼',
    ),
    SleepContent(
      id: 'sleep-002',
      title: 'Train Through the Hills',
      type: SleepContentType.story,
      durationMinutes: 40,
      narrator: 'Priya Menon',
      description:
          'A sleepy ride aboard a slow night train winding through the Western Ghats.',
      emoji: '🚂',
    ),
    SleepContent(
      id: 'sleep-003',
      title: 'The Old Library',
      type: SleepContentType.story,
      durationMinutes: 30,
      narrator: 'Anika Rao',
      description: 'Wandering between dim shelves of forgotten books on a rainy evening.',
      emoji: '📚',
    ),
    SleepContent(
      id: 'sleep-004',
      title: 'Monsoon Rain',
      type: SleepContentType.soundscape,
      durationMinutes: 60,
      narrator: '—',
      description: 'Steady monsoon rain on a tin roof with distant thunder.',
      emoji: '🌧️',
      isLoopable: true,
    ),
    SleepContent(
      id: 'sleep-005',
      title: 'Ocean Shore',
      type: SleepContentType.soundscape,
      durationMinutes: 60,
      narrator: '—',
      description: 'Gentle waves rolling onto a quiet beach.',
      emoji: '🌊',
      isLoopable: true,
    ),
    SleepContent(
      id: 'sleep-006',
      title: 'Forest Stream',
      type: SleepContentType.soundscape,
      durationMinutes: 60,
      narrator: '—',
      description: 'A clear stream over rocks with birdsong far in the distance.',
      emoji: '🍃',
      isLoopable: true,
    ),
    SleepContent(
      id: 'sleep-007',
      title: 'White Noise',
      type: SleepContentType.soundscape,
      durationMinutes: 60,
      narrator: '—',
      description: 'Pure white noise to mask sudden sounds.',
      emoji: '⚪',
      isLoopable: true,
    ),
    SleepContent(
      id: 'sleep-008',
      title: 'Crackling Fireplace',
      type: SleepContentType.soundscape,
      durationMinutes: 60,
      narrator: '—',
      description: 'A slow wood fire on a cold winter night.',
      emoji: '🔥',
      isLoopable: true,
    ),
    SleepContent(
      id: 'sleep-009',
      title: 'Delta Wave Music',
      type: SleepContentType.music,
      durationMinutes: 45,
      narrator: '—',
      description: 'Binaural delta-wave music to ease into deep sleep.',
      emoji: '🎵',
    ),
    SleepContent(
      id: 'sleep-010',
      title: 'Yoga Nidra for Sleep',
      type: SleepContentType.meditation,
      durationMinutes: 30,
      narrator: 'Anika Rao',
      description: 'A traditional yogic sleep meditation to fully release the body.',
      emoji: '🪷',
    ),
  ];

  // ── Stress SOS Sessions ───────────────────────────────────────────
  static const List<SosSession> sosSessions = [
    SosSession(
      id: 'sos-001',
      title: 'Quick Calm Breath',
      technique: SosTechnique.breath,
      durationMinutes: 2,
      description: 'A 2-minute breath reset for the moment a wave of stress hits.',
      steps: [
        'Inhale slowly through the nose for 4 counts.',
        'Hold the breath for 7 counts.',
        'Exhale slowly through the mouth for 8 counts.',
        'Repeat for 4 cycles.',
      ],
    ),
    SosSession(
      id: 'sos-002',
      title: '5-4-3-2-1 Grounding',
      technique: SosTechnique.grounding,
      durationMinutes: 3,
      description: 'A sensory grounding technique that pulls you out of an anxious spiral.',
      steps: [
        'Name 5 things you can see right now.',
        'Name 4 things you can physically feel.',
        'Name 3 things you can hear.',
        'Name 2 things you can smell.',
        'Name 1 thing you can taste.',
      ],
    ),
    SosSession(
      id: 'sos-003',
      title: 'Progressive Muscle Relaxation',
      technique: SosTechnique.pmr,
      durationMinutes: 5,
      description: 'Tense and release muscle groups one by one to drop body-held stress.',
      steps: [
        'Sit or lie comfortably. Take 3 deep breaths.',
        'Tense your feet for 5 seconds. Release.',
        'Tense your calves and thighs. Release.',
        'Tense your hands, then arms. Release.',
        'Tense your shoulders, then face. Release.',
        'Notice the wave of relaxation through the body.',
      ],
    ),
    SosSession(
      id: 'sos-004',
      title: 'Safe Place Visualization',
      technique: SosTechnique.visualization,
      durationMinutes: 5,
      description: 'Picture a place where you feel completely safe and at peace.',
      steps: [
        'Close your eyes. Take a few slow breaths.',
        'Imagine a place — real or imagined — where you feel completely safe.',
        'Notice the colors and shapes around you.',
        'Notice the sounds of this place.',
        'Notice how your body feels here.',
        'Stay as long as you need. Open your eyes when ready.',
      ],
    ),
  ];

  // ── CBT / DBT Exercises ───────────────────────────────────────────
  static const List<CBTExercise> cbtExercises = [
    CBTExercise(
      id: 'cbt-001',
      title: 'Thought Record',
      category: CBTCategory.cbt,
      durationMinutes: 10,
      description: 'Catch and challenge an unhelpful thought using the 7-column method.',
      steps: [
        'Identify the situation that triggered you.',
        'Write down the automatic thought.',
        'Note the emotion and rate its intensity (0–100).',
        'List evidence FOR the thought.',
        'List evidence AGAINST the thought.',
        'Write a balanced alternative thought.',
        'Re-rate the emotion.',
      ],
      emoji: '📝',
    ),
    CBTExercise(
      id: 'cbt-002',
      title: 'Cognitive Distortions Check',
      category: CBTCategory.cbt,
      durationMinutes: 8,
      description:
          'Identify which of the 10 common distortions is shaping your current thinking.',
      steps: [
        'Write down the thought making you feel bad.',
        'Check the list: all-or-nothing, overgeneralization, mental filter, disqualifying the positive, jumping to conclusions, magnification, emotional reasoning, should statements, labeling, personalization.',
        'Name which distortion is at play.',
        'Restate the thought without that distortion.',
      ],
      emoji: '🔍',
    ),
    CBTExercise(
      id: 'cbt-003',
      title: 'Behavioral Activation',
      category: CBTCategory.cbt,
      durationMinutes: 15,
      description:
          'When low mood pulls you into withdrawal, schedule small acts of meaning and pleasure.',
      steps: [
        'List 3 small activities you used to enjoy or that feel meaningful.',
        'Pick the smallest one — even 5 minutes counts.',
        'Schedule it in the next 24 hours.',
        'Rate your mood before and after.',
        'Notice — action precedes motivation, not the other way around.',
      ],
      emoji: '🌱',
    ),
    CBTExercise(
      id: 'cbt-004',
      title: 'TIPP — Crisis Skill',
      category: CBTCategory.dbt,
      durationMinutes: 5,
      description:
          'A DBT distress tolerance skill: Temperature, Intense exercise, Paced breathing, Paired muscle relaxation.',
      steps: [
        'TEMPERATURE: splash cold water on your face or hold ice for 30 seconds.',
        'INTENSE exercise: 60 seconds of jumping jacks or fast walking.',
        'PACED breathing: exhale longer than you inhale for 1 minute.',
        'PAIRED relaxation: tense and release each muscle group.',
      ],
      emoji: '❄️',
    ),
    CBTExercise(
      id: 'cbt-005',
      title: 'Wise Mind Meditation',
      category: CBTCategory.dbt,
      durationMinutes: 10,
      description:
          'A DBT practice for finding the integration point between emotion mind and reasonable mind.',
      steps: [
        'Sit quietly. Take a few breaths.',
        'Notice your emotion mind — what does it want?',
        'Notice your reasonable mind — what does it think?',
        'Drop into the still space between them.',
        'Ask: "What does my wise mind know?"',
      ],
      emoji: '🧠',
    ),
    CBTExercise(
      id: 'cbt-006',
      title: 'PLEASE — Body Care for Mood',
      category: CBTCategory.dbt,
      durationMinutes: 5,
      description:
          'A DBT acronym for protecting emotional vulnerability through physical care.',
      steps: [
        'PL — treat physical iLlness.',
        'E — balanced Eating.',
        'A — avoid mood-Altering substances.',
        'S — balanced Sleep.',
        'E — get Exercise.',
        'Pick one to prioritize this week.',
      ],
      emoji: '🛡️',
    ),
    CBTExercise(
      id: 'cbt-007',
      title: 'Box Grounding',
      category: CBTCategory.grounding,
      durationMinutes: 4,
      description: 'A simple grounding box for moments of dissociation or panic.',
      steps: [
        'Press your feet firmly into the floor.',
        'Name 4 things you can see.',
        'Touch 4 things and describe their texture.',
        'Take 4 slow breaths.',
      ],
      emoji: '📦',
    ),
    CBTExercise(
      id: 'cbt-008',
      title: 'Worry Postponement',
      category: CBTCategory.cbt,
      durationMinutes: 5,
      description:
          'Schedule worry to a fixed daily window so it stops dictating the rest of your day.',
      steps: [
        'Choose a 15-minute "worry window" (not before bed).',
        'When a worry arises outside the window, jot it down.',
        'Tell yourself: "I\'ll think about this at 6pm."',
        'During the window, work through the list.',
        'After the window, let the worries go.',
      ],
      emoji: '⏰',
    ),
  ];

  // ── India Crisis Resources ────────────────────────────────────────
  static const List<CrisisResource> crisisResources = [
    CrisisResource(
      name: 'iCall',
      description:
          'Free psychosocial helpline run by TISS. Counsellors trained in mental health.',
      phone: '9152987821',
      website: 'icallhelpline.org',
      hours: 'Mon–Sat, 8 AM – 10 PM',
      kind: CrisisResourceKind.helpline,
    ),
    CrisisResource(
      name: 'Vandrevala Foundation',
      description: 'Free 24/7 mental health helpline in multiple Indian languages.',
      phone: '18602662345',
      website: 'vandrevalafoundation.com',
      hours: '24/7',
      kind: CrisisResourceKind.helpline,
    ),
    CrisisResource(
      name: 'AASRA',
      description: 'Suicide prevention helpline. Confidential, 24/7.',
      phone: '9820466726',
      website: 'aasra.info',
      hours: '24/7',
      kind: CrisisResourceKind.helpline,
    ),
    CrisisResource(
      name: 'NIMHANS Helpline',
      description: 'National Institute of Mental Health and Neurosciences helpline.',
      phone: '08046110007',
      website: 'nimhans.ac.in',
      hours: '24/7',
      kind: CrisisResourceKind.helpline,
    ),
    CrisisResource(
      name: 'KIRAN — Govt of India',
      description:
          'Government of India\'s national mental health rehabilitation helpline. Toll-free, multilingual.',
      phone: '18005990019',
      hours: '24/7',
      kind: CrisisResourceKind.helpline,
    ),
    CrisisResource(
      name: 'Snehi',
      description: 'Confidential emotional support and suicide prevention.',
      phone: '9582208181',
      website: 'snehi.org',
      hours: 'Daily, 10 AM – 10 PM',
      kind: CrisisResourceKind.helpline,
    ),
    CrisisResource(
      name: 'Sneha India',
      description: 'Suicide prevention helpline based in Chennai.',
      phone: '04424640050',
      website: 'snehaindia.org',
      hours: '24/7',
      kind: CrisisResourceKind.helpline,
    ),
    CrisisResource(
      name: 'Police / Emergency',
      description: 'For immediate physical danger, call the unified emergency number.',
      phone: '112',
      hours: '24/7',
      kind: CrisisResourceKind.emergency,
    ),
  ];

  // ── Mental Health Assessments (validated instruments) ──────────────
  static MentalHealthAssessment get gad7 => const MentalHealthAssessment(
        type: AssessmentType.gad7,
        questions: [
          AssessmentQuestion(
            text: 'Feeling nervous, anxious, or on edge',
            options: ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
            scores: [0, 1, 2, 3],
          ),
          AssessmentQuestion(
            text: 'Not being able to stop or control worrying',
            options: ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
            scores: [0, 1, 2, 3],
          ),
          AssessmentQuestion(
            text: 'Worrying too much about different things',
            options: ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
            scores: [0, 1, 2, 3],
          ),
          AssessmentQuestion(
            text: 'Trouble relaxing',
            options: ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
            scores: [0, 1, 2, 3],
          ),
          AssessmentQuestion(
            text: 'Being so restless that it is hard to sit still',
            options: ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
            scores: [0, 1, 2, 3],
          ),
          AssessmentQuestion(
            text: 'Becoming easily annoyed or irritable',
            options: ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
            scores: [0, 1, 2, 3],
          ),
          AssessmentQuestion(
            text: 'Feeling afraid as if something awful might happen',
            options: ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
            scores: [0, 1, 2, 3],
          ),
        ],
        bands: [
          (
            min: 0,
            max: 4,
            severity: 'Minimal anxiety',
            guidance:
                'Your symptoms are within normal range. Continue your wellness practices.',
          ),
          (
            min: 5,
            max: 9,
            severity: 'Mild anxiety',
            guidance:
                'Some anxiety is present. Mindfulness, breathwork, and CBT exercises may help.',
          ),
          (
            min: 10,
            max: 14,
            severity: 'Moderate anxiety',
            guidance:
                'Consider speaking to a mental health professional. Use the crisis resources to find support.',
          ),
          (
            min: 15,
            max: 21,
            severity: 'Severe anxiety',
            guidance:
                'Please reach out to a mental health professional soon. The helplines listed in this app can connect you to free support.',
          ),
        ],
      );

  static MentalHealthAssessment get phq9 => const MentalHealthAssessment(
        type: AssessmentType.phq9,
        questions: [
          AssessmentQuestion(
            text: 'Little interest or pleasure in doing things',
            options: ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
            scores: [0, 1, 2, 3],
          ),
          AssessmentQuestion(
            text: 'Feeling down, depressed, or hopeless',
            options: ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
            scores: [0, 1, 2, 3],
          ),
          AssessmentQuestion(
            text: 'Trouble falling asleep, staying asleep, or sleeping too much',
            options: ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
            scores: [0, 1, 2, 3],
          ),
          AssessmentQuestion(
            text: 'Feeling tired or having little energy',
            options: ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
            scores: [0, 1, 2, 3],
          ),
          AssessmentQuestion(
            text: 'Poor appetite or overeating',
            options: ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
            scores: [0, 1, 2, 3],
          ),
          AssessmentQuestion(
            text:
                'Feeling bad about yourself — that you are a failure or have let yourself or your family down',
            options: ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
            scores: [0, 1, 2, 3],
          ),
          AssessmentQuestion(
            text:
                'Trouble concentrating on things, such as reading or watching television',
            options: ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
            scores: [0, 1, 2, 3],
          ),
          AssessmentQuestion(
            text:
                'Moving or speaking so slowly that other people could have noticed, or being so fidgety or restless that you have been moving around a lot more than usual',
            options: ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
            scores: [0, 1, 2, 3],
          ),
          AssessmentQuestion(
            text:
                'Thoughts that you would be better off dead, or of hurting yourself in some way',
            options: ['Not at all', 'Several days', 'More than half the days', 'Nearly every day'],
            scores: [0, 1, 2, 3],
          ),
        ],
        bands: [
          (
            min: 0,
            max: 4,
            severity: 'Minimal depression',
            guidance: 'Symptoms are within normal range.',
          ),
          (
            min: 5,
            max: 9,
            severity: 'Mild depression',
            guidance: 'Watchful waiting; revisit in 2 weeks. Build a daily mindfulness habit.',
          ),
          (
            min: 10,
            max: 14,
            severity: 'Moderate depression',
            guidance: 'Treatment with counselling or medication is often helpful at this level.',
          ),
          (
            min: 15,
            max: 19,
            severity: 'Moderately severe depression',
            guidance: 'Active treatment is recommended. Please reach out to a professional.',
          ),
          (
            min: 20,
            max: 27,
            severity: 'Severe depression',
            guidance:
                'Immediate clinical attention is recommended. The crisis helplines in this app can connect you to free, confidential support.',
          ),
        ],
      );

  static MentalHealthAssessment get pss10 => const MentalHealthAssessment(
        type: AssessmentType.pss10,
        questions: [
          AssessmentQuestion(
            text: 'In the last month, how often have you been upset because of something that happened unexpectedly?',
            options: ['Never', 'Almost never', 'Sometimes', 'Fairly often', 'Very often'],
            scores: [0, 1, 2, 3, 4],
          ),
          AssessmentQuestion(
            text: 'In the last month, how often have you felt that you were unable to control the important things in your life?',
            options: ['Never', 'Almost never', 'Sometimes', 'Fairly often', 'Very often'],
            scores: [0, 1, 2, 3, 4],
          ),
          AssessmentQuestion(
            text: 'In the last month, how often have you felt nervous and stressed?',
            options: ['Never', 'Almost never', 'Sometimes', 'Fairly often', 'Very often'],
            scores: [0, 1, 2, 3, 4],
          ),
          AssessmentQuestion(
            text: 'In the last month, how often have you felt confident about your ability to handle your personal problems?',
            options: ['Never', 'Almost never', 'Sometimes', 'Fairly often', 'Very often'],
            scores: [4, 3, 2, 1, 0],
          ),
          AssessmentQuestion(
            text: 'In the last month, how often have you felt that things were going your way?',
            options: ['Never', 'Almost never', 'Sometimes', 'Fairly often', 'Very often'],
            scores: [4, 3, 2, 1, 0],
          ),
          AssessmentQuestion(
            text: 'In the last month, how often have you found that you could not cope with all the things that you had to do?',
            options: ['Never', 'Almost never', 'Sometimes', 'Fairly often', 'Very often'],
            scores: [0, 1, 2, 3, 4],
          ),
          AssessmentQuestion(
            text: 'In the last month, how often have you been able to control irritations in your life?',
            options: ['Never', 'Almost never', 'Sometimes', 'Fairly often', 'Very often'],
            scores: [4, 3, 2, 1, 0],
          ),
          AssessmentQuestion(
            text: 'In the last month, how often have you felt that you were on top of things?',
            options: ['Never', 'Almost never', 'Sometimes', 'Fairly often', 'Very often'],
            scores: [4, 3, 2, 1, 0],
          ),
          AssessmentQuestion(
            text: 'In the last month, how often have you been angered because of things that happened that were outside of your control?',
            options: ['Never', 'Almost never', 'Sometimes', 'Fairly often', 'Very often'],
            scores: [0, 1, 2, 3, 4],
          ),
          AssessmentQuestion(
            text: 'In the last month, how often have you felt difficulties were piling up so high that you could not overcome them?',
            options: ['Never', 'Almost never', 'Sometimes', 'Fairly often', 'Very often'],
            scores: [0, 1, 2, 3, 4],
          ),
        ],
        bands: [
          (
            min: 0,
            max: 13,
            severity: 'Low perceived stress',
            guidance: 'Your stress level appears manageable. Maintain your wellness routines.',
          ),
          (
            min: 14,
            max: 26,
            severity: 'Moderate perceived stress',
            guidance:
                'Stress is meaningfully affecting you. Build daily breath, movement, and rest into your week.',
          ),
          (
            min: 27,
            max: 40,
            severity: 'High perceived stress',
            guidance:
                'Stress is high. Consider professional support and use the crisis resources if needed.',
          ),
        ],
      );
}
