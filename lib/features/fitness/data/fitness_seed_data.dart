import 'package:beyou/features/fitness/models/exercise.dart';
import 'package:beyou/features/fitness/models/workout.dart';

/// Static seed data for the fitness module.
/// Written to Firestore on first launch; exercises are the canonical DB,
/// workouts reference exercise IDs.
class FitnessSeedData {
  FitnessSeedData._();

  // ── Exercise IDs ─────────────────────────────────────────────────────────
  // Chest
  static const String pushUp = 'push_up';
  static const String benchPress = 'bench_press';
  static const String inclinePushUp = 'incline_push_up';
  static const String chestFly = 'chest_fly';

  // Back
  static const String pullUp = 'pull_up';
  static const String bentOverRow = 'bent_over_row';
  static const String latPulldown = 'lat_pulldown';
  static const String seatedRow = 'seated_row';

  // Legs
  static const String squat = 'squat';
  static const String lunge = 'lunge';
  static const String legPress = 'leg_press';
  static const String calfRaise = 'calf_raise';
  static const String gluteBridge = 'glute_bridge';
  static const String sumoSquat = 'sumo_squat';

  // Shoulders
  static const String shoulderPress = 'shoulder_press';
  static const String lateralRaise = 'lateral_raise';
  static const String frontRaise = 'front_raise';
  static const String arnoldPress = 'arnold_press';

  // Arms
  static const String bicepCurl = 'bicep_curl';
  static const String tricepDip = 'tricep_dip';
  static const String hammerCurl = 'hammer_curl';
  static const String tricepExtension = 'tricep_extension';

  // Core
  static const String crunch = 'crunch';
  static const String plank = 'plank';
  static const String russianTwist = 'russian_twist';
  static const String legRaise = 'leg_raise';
  static const String mountainClimber = 'mountain_climber';
  static const String bicycle = 'bicycle_crunch';

  // Cardio / HIIT
  static const String jumpingJack = 'jumping_jack';
  static const String burpee = 'burpee';
  static const String highKnee = 'high_knee';
  static const String boxJump = 'box_jump';
  static const String jumpRope = 'jump_rope';

  // Yoga
  static const String downwardDog = 'downward_dog';
  static const String warriorI = 'warrior_i';
  static const String warriorII = 'warrior_ii';
  static const String childPose = 'child_pose';
  static const String catCow = 'cat_cow';
  static const String treePose = 'tree_pose';
  static const String cobriPose = 'cobra_pose';
  static const String pigeon = 'pigeon_pose';

  // Full body / Compound
  static const String deadlift = 'deadlift';
  static const String kettlebellSwing = 'kettlebell_swing';
  static const String thruster = 'thruster';
  static const String cleanAndPress = 'clean_and_press';

  // ── Exercises ─────────────────────────────────────────────────────────────
  static final List<Exercise> exercises = [
    // ── Chest ───────────────────────────────────────────────────────────────
    Exercise.fromMap(pushUp, {
      'name': 'Push-Up',
      'muscleGroups': ['Chest', 'Triceps', 'Shoulders'],
      'equipment': ['Bodyweight'],
      'category': 'Chest',
      'difficulty': 'Beginner',
      'videoAsset': 'assets/videos/workouts/reclining.mp4',
      'instructions': [
        'Start in a high plank position, hands slightly wider than shoulder-width.',
        'Lower your chest to the floor, keeping elbows at 45°.',
        'Push back up to the starting position, fully extending your arms.',
        'Keep your core tight and body in a straight line throughout.',
      ],
    }),
    Exercise.fromMap(benchPress, {
      'name': 'Barbell Bench Press',
      'muscleGroups': ['Chest', 'Triceps', 'Shoulders'],
      'equipment': ['Barbell', 'Bench'],
      'category': 'Chest',
      'difficulty': 'Intermediate',
      'instructions': [
        'Lie on a flat bench, grip the bar just outside shoulder width.',
        'Unrack the bar and hold it over your chest with arms fully extended.',
        'Lower the bar to mid-chest in a controlled manner.',
        'Press the bar back up explosively to the starting position.',
      ],
    }),
    Exercise.fromMap(inclinePushUp, {
      'name': 'Incline Push-Up',
      'muscleGroups': ['Upper Chest', 'Triceps'],
      'equipment': ['Bodyweight', 'Bench'],
      'category': 'Chest',
      'difficulty': 'Beginner',
      'instructions': [
        'Place hands on an elevated surface, wider than shoulder-width.',
        'Walk feet back until body is in a straight line.',
        'Lower chest to the surface, keeping core tight.',
        'Push back to starting position.',
      ],
    }),
    Exercise.fromMap(chestFly, {
      'name': 'Dumbbell Chest Fly',
      'muscleGroups': ['Chest'],
      'equipment': ['Dumbbells', 'Bench'],
      'category': 'Chest',
      'difficulty': 'Intermediate',
      'instructions': [
        'Lie on a flat bench holding dumbbells over your chest.',
        'Open arms wide in an arc, maintaining a slight elbow bend.',
        'Lower until you feel a stretch in your chest.',
        'Bring arms back together, squeezing your chest at the top.',
      ],
    }),
    // ── Back ────────────────────────────────────────────────────────────────
    Exercise.fromMap(pullUp, {
      'name': 'Pull-Up',
      'muscleGroups': ['Lats', 'Biceps', 'Upper Back'],
      'equipment': ['Pull-Up Bar'],
      'category': 'Back',
      'difficulty': 'Intermediate',
      'instructions': [
        'Hang from a bar with hands slightly wider than shoulder-width, palms forward.',
        'Pull your body up until your chin clears the bar.',
        'Lower yourself in a controlled motion back to a dead hang.',
        'Avoid swinging your body for momentum.',
      ],
    }),
    Exercise.fromMap(bentOverRow, {
      'name': 'Barbell Bent-Over Row',
      'muscleGroups': ['Lats', 'Rhomboids', 'Biceps'],
      'equipment': ['Barbell'],
      'category': 'Back',
      'difficulty': 'Intermediate',
      'instructions': [
        'Hold a barbell with an overhand grip, hinge forward at hips to ~45°.',
        'Keep back flat and core tight.',
        'Pull the bar to your lower chest, driving elbows back.',
        'Lower the bar under control back to start.',
      ],
    }),
    Exercise.fromMap(latPulldown, {
      'name': 'Lat Pulldown',
      'muscleGroups': ['Lats', 'Biceps'],
      'equipment': ['Cable Machine'],
      'category': 'Back',
      'difficulty': 'Beginner',
      'instructions': [
        'Sit at a cable machine and grip the bar wider than shoulder-width.',
        'Lean back slightly and pull the bar down to your upper chest.',
        'Squeeze your lats at the bottom.',
        'Return the bar slowly to the starting position.',
      ],
    }),
    Exercise.fromMap(seatedRow, {
      'name': 'Seated Cable Row',
      'muscleGroups': ['Rhomboids', 'Lats', 'Biceps'],
      'equipment': ['Cable Machine'],
      'category': 'Back',
      'difficulty': 'Beginner',
      'instructions': [
        'Sit on the cable row machine with feet on the platform.',
        'Grip the handle and pull it to your lower abdomen.',
        'Squeeze your shoulder blades together at full contraction.',
        'Extend arms slowly back to starting position.',
      ],
    }),
    // ── Legs ────────────────────────────────────────────────────────────────
    Exercise.fromMap(squat, {
      'name': 'Barbell Squat',
      'muscleGroups': ['Quads', 'Glutes', 'Hamstrings'],
      'equipment': ['Barbell', 'Squat Rack'],
      'category': 'Legs',
      'difficulty': 'Intermediate',
      'instructions': [
        'Place the bar on your upper traps, feet shoulder-width apart.',
        'Push hips back and bend knees, lowering until thighs are parallel to the floor.',
        'Keep chest up and knees tracking over toes.',
        'Drive through your heels to stand back up.',
      ],
    }),
    Exercise.fromMap(lunge, {
      'name': 'Walking Lunge',
      'muscleGroups': ['Quads', 'Glutes', 'Hamstrings'],
      'equipment': ['Bodyweight', 'Dumbbells'],
      'category': 'Legs',
      'difficulty': 'Beginner',
      'instructions': [
        'Stand tall with feet hip-width apart.',
        'Step forward with one leg, lowering your back knee toward the floor.',
        'Keep front knee over ankle, not past toes.',
        'Push through front heel to bring rear foot forward and repeat.',
      ],
    }),
    Exercise.fromMap(gluteBridge, {
      'name': 'Glute Bridge',
      'muscleGroups': ['Glutes', 'Hamstrings', 'Core'],
      'equipment': ['Bodyweight'],
      'category': 'Legs',
      'difficulty': 'Beginner',
      'videoAsset': 'assets/videos/workouts/cow.mp4',
      'instructions': [
        'Lie on your back, knees bent, feet flat on the floor hip-width apart.',
        'Press through your heels to lift your hips off the floor.',
        'Squeeze your glutes at the top, creating a straight line from knees to shoulders.',
        'Lower hips back down in a controlled motion.',
      ],
    }),
    Exercise.fromMap(sumoSquat, {
      'name': 'Sumo Squat',
      'muscleGroups': ['Inner Thighs', 'Glutes', 'Quads'],
      'equipment': ['Bodyweight', 'Dumbbells'],
      'category': 'Legs',
      'difficulty': 'Beginner',
      'instructions': [
        'Stand with feet wider than shoulder-width, toes pointing outward.',
        'Hold a dumbbell between your legs (optional).',
        'Lower into a squat, keeping your back straight.',
        'Press through heels to return to standing.',
      ],
    }),
    Exercise.fromMap(calfRaise, {
      'name': 'Standing Calf Raise',
      'muscleGroups': ['Calves'],
      'equipment': ['Bodyweight', 'Dumbbells'],
      'category': 'Legs',
      'difficulty': 'Beginner',
      'instructions': [
        'Stand with feet hip-width apart near a wall for balance.',
        'Rise up onto your toes as high as possible.',
        'Hold for a moment at the top.',
        'Lower back down slowly.',
      ],
    }),
    // ── Shoulders ───────────────────────────────────────────────────────────
    Exercise.fromMap(shoulderPress, {
      'name': 'Dumbbell Shoulder Press',
      'muscleGroups': ['Shoulders', 'Triceps'],
      'equipment': ['Dumbbells'],
      'category': 'Shoulders',
      'difficulty': 'Beginner',
      'instructions': [
        'Sit or stand holding dumbbells at shoulder height, palms forward.',
        'Press the dumbbells overhead until arms are fully extended.',
        'Lower back to shoulder level under control.',
        'Keep core engaged throughout.',
      ],
    }),
    Exercise.fromMap(lateralRaise, {
      'name': 'Lateral Raise',
      'muscleGroups': ['Lateral Deltoid'],
      'equipment': ['Dumbbells'],
      'category': 'Shoulders',
      'difficulty': 'Beginner',
      'instructions': [
        'Stand holding light dumbbells at your sides.',
        'Raise arms out to the sides until parallel to the floor.',
        'Pause briefly at the top.',
        'Lower slowly back to starting position.',
      ],
    }),
    Exercise.fromMap(arnoldPress, {
      'name': 'Arnold Press',
      'muscleGroups': ['All Deltoid Heads', 'Triceps'],
      'equipment': ['Dumbbells'],
      'category': 'Shoulders',
      'difficulty': 'Intermediate',
      'instructions': [
        'Sit holding dumbbells at chin height, palms facing you.',
        'Rotate palms outward as you press the weights overhead.',
        'Fully extend arms at the top.',
        'Reverse the rotation as you lower back to start.',
      ],
    }),
    // ── Arms ────────────────────────────────────────────────────────────────
    Exercise.fromMap(bicepCurl, {
      'name': 'Dumbbell Bicep Curl',
      'muscleGroups': ['Biceps'],
      'equipment': ['Dumbbells'],
      'category': 'Arms',
      'difficulty': 'Beginner',
      'instructions': [
        'Stand holding dumbbells at your sides, palms forward.',
        'Curl the weights up toward your shoulders, keeping elbows fixed.',
        'Squeeze biceps at the top.',
        'Lower slowly back to the starting position.',
      ],
    }),
    Exercise.fromMap(tricepDip, {
      'name': 'Tricep Dip',
      'muscleGroups': ['Triceps', 'Chest'],
      'equipment': ['Parallel Bars', 'Bench'],
      'category': 'Arms',
      'difficulty': 'Intermediate',
      'instructions': [
        'Grip parallel bars and support your body with arms extended.',
        'Lean forward slightly and lower yourself by bending elbows.',
        'Stop when upper arms are parallel to the floor.',
        'Push back up to the starting position.',
      ],
    }),
    Exercise.fromMap(hammerCurl, {
      'name': 'Hammer Curl',
      'muscleGroups': ['Biceps', 'Brachialis'],
      'equipment': ['Dumbbells'],
      'category': 'Arms',
      'difficulty': 'Beginner',
      'instructions': [
        'Stand holding dumbbells with a neutral grip (palms facing each other).',
        'Curl the weights up while keeping palms neutral.',
        'Squeeze at the top, then lower under control.',
      ],
    }),
    // ── Core ────────────────────────────────────────────────────────────────
    Exercise.fromMap(plank, {
      'name': 'Plank',
      'muscleGroups': ['Core', 'Shoulders'],
      'equipment': ['Bodyweight'],
      'category': 'Core',
      'difficulty': 'Beginner',
      'instructions': [
        'Get into a forearm plank position, elbows under shoulders.',
        'Keep your body in a straight line from head to heels.',
        'Squeeze core, glutes, and quads.',
        'Hold for the prescribed time without letting hips sag or rise.',
      ],
    }),
    Exercise.fromMap(crunch, {
      'name': 'Crunch',
      'muscleGroups': ['Rectus Abdominis'],
      'equipment': ['Bodyweight'],
      'category': 'Core',
      'difficulty': 'Beginner',
      'instructions': [
        'Lie on your back with knees bent, feet flat, hands behind your head.',
        'Lift your shoulder blades off the floor by contracting your abs.',
        'Hold briefly at the top.',
        'Lower back down slowly without fully relaxing.',
      ],
    }),
    Exercise.fromMap(russianTwist, {
      'name': 'Russian Twist',
      'muscleGroups': ['Obliques', 'Core'],
      'equipment': ['Bodyweight', 'Weight Plate'],
      'category': 'Core',
      'difficulty': 'Beginner',
      'instructions': [
        'Sit on the floor with knees bent at 90°, leaning back slightly.',
        'Hold hands together or grip a weight in front of your chest.',
        'Rotate your torso to one side, then the other.',
        'Keep your back straight and core tight throughout.',
      ],
    }),
    Exercise.fromMap(mountainClimber, {
      'name': 'Mountain Climber',
      'muscleGroups': ['Core', 'Shoulders', 'Hip Flexors'],
      'equipment': ['Bodyweight'],
      'category': 'Core',
      'difficulty': 'Beginner',
      'instructions': [
        'Start in a high plank position, wrists under shoulders.',
        'Drive one knee toward your chest, then quickly switch legs.',
        'Keep hips level and core tight.',
        'Maintain a fast, rhythmic pace.',
      ],
    }),
    Exercise.fromMap(bicycle, {
      'name': 'Bicycle Crunch',
      'muscleGroups': ['Obliques', 'Rectus Abdominis'],
      'equipment': ['Bodyweight'],
      'category': 'Core',
      'difficulty': 'Beginner',
      'instructions': [
        'Lie on your back with hands behind your head.',
        'Lift shoulder blades off the floor and bring knees to 90°.',
        'Rotate to bring right elbow toward left knee while extending right leg.',
        'Alternate sides in a fluid pedaling motion.',
      ],
    }),
    // ── Cardio / HIIT ────────────────────────────────────────────────────────
    Exercise.fromMap(burpee, {
      'name': 'Burpee',
      'muscleGroups': ['Full Body'],
      'equipment': ['Bodyweight'],
      'category': 'Cardio',
      'difficulty': 'Intermediate',
      'instructions': [
        'Stand with feet shoulder-width apart.',
        'Drop into a squat and place hands on the floor.',
        'Jump feet back into a push-up position; do one push-up.',
        'Jump feet forward to your hands, then explode up with arms overhead.',
      ],
    }),
    Exercise.fromMap(jumpingJack, {
      'name': 'Jumping Jack',
      'muscleGroups': ['Full Body', 'Calves'],
      'equipment': ['Bodyweight'],
      'category': 'Cardio',
      'difficulty': 'Beginner',
      'instructions': [
        'Stand with feet together and arms at your sides.',
        'Jump feet out to the sides while raising arms overhead.',
        'Jump back to starting position.',
        'Repeat at a steady, rhythmic pace.',
      ],
    }),
    Exercise.fromMap(highKnee, {
      'name': 'High Knees',
      'muscleGroups': ['Quads', 'Core', 'Calves'],
      'equipment': ['Bodyweight'],
      'category': 'Cardio',
      'difficulty': 'Beginner',
      'instructions': [
        'Stand tall with feet hip-width apart.',
        'Drive one knee up to hip height while pumping the opposite arm.',
        'Quickly switch legs, maintaining a running-in-place motion.',
        'Keep core engaged and land softly on the balls of your feet.',
      ],
    }),
    Exercise.fromMap(boxJump, {
      'name': 'Box Jump',
      'muscleGroups': ['Quads', 'Glutes', 'Calves'],
      'equipment': ['Plyometric Box'],
      'category': 'Cardio',
      'difficulty': 'Intermediate',
      'instructions': [
        'Stand in front of a sturdy box, feet shoulder-width apart.',
        'Swing arms back, then explode upward, landing softly on the box.',
        'Stand tall on the box, then step or jump back down.',
        'Reset and repeat.',
      ],
    }),
    // ── Yoga ────────────────────────────────────────────────────────────────
    Exercise.fromMap(downwardDog, {
      'name': 'Downward Dog',
      'muscleGroups': ['Hamstrings', 'Calves', 'Shoulders'],
      'equipment': ['Yoga Mat'],
      'category': 'Yoga',
      'difficulty': 'Beginner',
      'videoAsset': 'assets/videos/workouts/warriorII.mp4',
      'instructions': [
        'Start on hands and knees, tuck toes and lift hips toward the sky.',
        'Press hands into the mat, straightening arms and legs as much as comfortable.',
        'Create an inverted V-shape with your body.',
        'Breathe deeply and hold for 5–10 breaths.',
      ],
    }),
    Exercise.fromMap(warriorII, {
      'name': 'Warrior II',
      'muscleGroups': ['Quads', 'Hips', 'Shoulders'],
      'equipment': ['Yoga Mat'],
      'category': 'Yoga',
      'difficulty': 'Beginner',
      'videoAsset': 'assets/videos/workouts/warriorII.mp4',
      'instructions': [
        'Step feet wide apart, turn right foot out 90° and left foot in slightly.',
        'Bend right knee over right ankle, keeping knee in line with toes.',
        'Extend arms parallel to floor, gaze over right hand.',
        'Hold for 5 breaths, then switch sides.',
      ],
    }),
    Exercise.fromMap(childPose, {
      'name': "Child's Pose",
      'muscleGroups': ['Back', 'Hips', 'Shoulders'],
      'equipment': ['Yoga Mat'],
      'category': 'Yoga',
      'difficulty': 'Beginner',
      'instructions': [
        'Kneel on the mat, sit back on your heels.',
        'Fold forward and extend arms long in front of you.',
        'Rest forehead on the mat and breathe deeply.',
        'Hold for 5–10 breaths or as long as needed.',
      ],
    }),
    Exercise.fromMap(catCow, {
      'name': 'Cat-Cow',
      'muscleGroups': ['Spine', 'Core'],
      'equipment': ['Yoga Mat'],
      'category': 'Yoga',
      'difficulty': 'Beginner',
      'videoAsset': 'assets/videos/workouts/cow.mp4',
      'instructions': [
        'Start on hands and knees, wrists under shoulders, knees under hips.',
        'Inhale, drop belly toward mat and lift chest (Cow).',
        'Exhale, round spine toward ceiling, tuck chin and pelvis (Cat).',
        'Flow between the two positions with each breath.',
      ],
    }),
    Exercise.fromMap(cobriPose, {
      'name': 'Cobra Pose',
      'muscleGroups': ['Spine', 'Chest', 'Abs'],
      'equipment': ['Yoga Mat'],
      'category': 'Yoga',
      'difficulty': 'Beginner',
      'instructions': [
        'Lie on your belly with hands under shoulders.',
        'Press into hands to lift chest off the floor.',
        'Keep elbows slightly bent and shoulders away from ears.',
        'Hold for 5 breaths, then lower back down.',
      ],
    }),
    // ── Full Body / Compound ────────────────────────────────────────────────
    Exercise.fromMap(deadlift, {
      'name': 'Deadlift',
      'muscleGroups': ['Hamstrings', 'Glutes', 'Back', 'Traps'],
      'equipment': ['Barbell'],
      'category': 'Full Body',
      'difficulty': 'Intermediate',
      'instructions': [
        'Stand with feet hip-width apart, barbell over mid-foot.',
        'Hinge at hips and grip the bar just outside your legs.',
        'Keep back flat, chest up, and drive through the floor to lift.',
        'Lock hips and knees at the top, then hinge back to lower the bar.',
      ],
    }),
    Exercise.fromMap(kettlebellSwing, {
      'name': 'Kettlebell Swing',
      'muscleGroups': ['Glutes', 'Hamstrings', 'Core', 'Shoulders'],
      'equipment': ['Kettlebell'],
      'category': 'Full Body',
      'difficulty': 'Intermediate',
      'instructions': [
        'Stand with feet shoulder-width apart, kettlebell between feet.',
        'Hinge at hips to grip the bell, then hike it back between your legs.',
        'Drive hips forward explosively to swing the bell to chest height.',
        'Let the bell fall and hike back to repeat.',
      ],
    }),
    Exercise.fromMap(thruster, {
      'name': 'Thruster',
      'muscleGroups': ['Full Body', 'Quads', 'Shoulders'],
      'equipment': ['Barbell', 'Dumbbells'],
      'category': 'Full Body',
      'difficulty': 'Advanced',
      'instructions': [
        'Hold a bar or dumbbells at shoulder height.',
        'Squat down until thighs are parallel to the floor.',
        'Drive up explosively, pressing the weight overhead.',
        'Lower back to shoulder height and squat again.',
      ],
    }),
  ];

  // ── Workout Programs ───────────────────────────────────────────────────────
  static final List<Workout> workouts = [
    Workout(
      id: 'beginner_full_body',
      title: 'Beginner Full Body',
      category: 'Strength',
      level: 'Beginner',
      durationMinutes: 30,
      exerciseCount: 6,
      imageAsset: 'assets/icons/workouts/full_body.png',
      tags: ['Beginner', 'Full Body', 'No Equipment'],
      exercises: [
        WorkoutExerciseRef(exerciseId: pushUp, exerciseName: 'Push-Up', sets: 3, reps: 10, restSeconds: 60),
        WorkoutExerciseRef(exerciseId: squat, exerciseName: 'Barbell Squat', sets: 3, reps: 12, restSeconds: 60),
        WorkoutExerciseRef(exerciseId: lunge, exerciseName: 'Walking Lunge', sets: 3, reps: 10, restSeconds: 60),
        WorkoutExerciseRef(exerciseId: plank, exerciseName: 'Plank', sets: 3, reps: 30, restSeconds: 45, notes: '30 seconds hold'),
        WorkoutExerciseRef(exerciseId: gluteBridge, exerciseName: 'Glute Bridge', sets: 3, reps: 15, restSeconds: 45),
        WorkoutExerciseRef(exerciseId: crunch, exerciseName: 'Crunch', sets: 3, reps: 20, restSeconds: 45),
      ],
    ),
    Workout(
      id: 'hiit_blast',
      title: 'HIIT Cardio Blast',
      category: 'HIIT',
      level: 'Intermediate',
      durationMinutes: 25,
      exerciseCount: 5,
      imageAsset: 'assets/images/home/cardio.png',
      tags: ['HIIT', 'Cardio', 'Fat Burn', 'No Equipment'],
      exercises: [
        WorkoutExerciseRef(exerciseId: burpee, exerciseName: 'Burpee', sets: 4, reps: 10, restSeconds: 30),
        WorkoutExerciseRef(exerciseId: jumpingJack, exerciseName: 'Jumping Jack', sets: 4, reps: 30, restSeconds: 20),
        WorkoutExerciseRef(exerciseId: highKnee, exerciseName: 'High Knees', sets: 4, reps: 20, restSeconds: 20, notes: '20 per leg'),
        WorkoutExerciseRef(exerciseId: mountainClimber, exerciseName: 'Mountain Climber', sets: 4, reps: 20, restSeconds: 30),
        WorkoutExerciseRef(exerciseId: squat, exerciseName: 'Jump Squat', sets: 4, reps: 15, restSeconds: 30),
      ],
    ),
    Workout(
      id: 'morning_yoga',
      title: 'Morning Yoga Flow',
      category: 'Yoga',
      level: 'Beginner',
      durationMinutes: 20,
      exerciseCount: 6,
      imageAsset: 'assets/icons/workouts/yoga.png',
      tags: ['Yoga', 'Flexibility', 'Morning', 'Relaxation'],
      exercises: [
        WorkoutExerciseRef(exerciseId: childPose, exerciseName: "Child's Pose", sets: 1, reps: 5, restSeconds: 0, notes: '5 breaths'),
        WorkoutExerciseRef(exerciseId: catCow, exerciseName: 'Cat-Cow', sets: 1, reps: 10, restSeconds: 0, notes: '10 cycles'),
        WorkoutExerciseRef(exerciseId: downwardDog, exerciseName: 'Downward Dog', sets: 1, reps: 8, restSeconds: 0, notes: '8 breaths'),
        WorkoutExerciseRef(exerciseId: warriorII, exerciseName: 'Warrior II', sets: 2, reps: 5, restSeconds: 10, notes: '5 breaths each side'),
        WorkoutExerciseRef(exerciseId: cobriPose, exerciseName: 'Cobra Pose', sets: 1, reps: 5, restSeconds: 0, notes: '5 breaths'),
        WorkoutExerciseRef(exerciseId: childPose, exerciseName: "Child's Pose", sets: 1, reps: 8, restSeconds: 0, notes: '8 breaths, cool down'),
      ],
    ),
    Workout(
      id: 'upper_body_strength',
      title: 'Upper Body Strength',
      category: 'Strength',
      level: 'Intermediate',
      durationMinutes: 45,
      exerciseCount: 8,
      imageAsset: 'assets/images/home/arms.png',
      tags: ['Upper Body', 'Strength', 'Gym'],
      exercises: [
        WorkoutExerciseRef(exerciseId: benchPress, exerciseName: 'Barbell Bench Press', sets: 4, reps: 8, restSeconds: 90),
        WorkoutExerciseRef(exerciseId: bentOverRow, exerciseName: 'Barbell Bent-Over Row', sets: 4, reps: 8, restSeconds: 90),
        WorkoutExerciseRef(exerciseId: shoulderPress, exerciseName: 'Dumbbell Shoulder Press', sets: 3, reps: 10, restSeconds: 75),
        WorkoutExerciseRef(exerciseId: pullUp, exerciseName: 'Pull-Up', sets: 3, reps: 8, restSeconds: 90),
        WorkoutExerciseRef(exerciseId: inclinePushUp, exerciseName: 'Incline Push-Up', sets: 3, reps: 12, restSeconds: 60),
        WorkoutExerciseRef(exerciseId: lateralRaise, exerciseName: 'Lateral Raise', sets: 3, reps: 15, restSeconds: 60),
        WorkoutExerciseRef(exerciseId: bicepCurl, exerciseName: 'Dumbbell Bicep Curl', sets: 3, reps: 12, restSeconds: 60),
        WorkoutExerciseRef(exerciseId: tricepDip, exerciseName: 'Tricep Dip', sets: 3, reps: 12, restSeconds: 60),
      ],
    ),
    Workout(
      id: 'leg_day',
      title: 'Leg Day Destroyer',
      category: 'Strength',
      level: 'Intermediate',
      durationMinutes: 50,
      exerciseCount: 7,
      imageAsset: 'assets/icons/workouts/full_body.png',
      tags: ['Legs', 'Glutes', 'Gym'],
      exercises: [
        WorkoutExerciseRef(exerciseId: squat, exerciseName: 'Barbell Squat', sets: 5, reps: 5, restSeconds: 120),
        WorkoutExerciseRef(exerciseId: deadlift, exerciseName: 'Deadlift', sets: 3, reps: 6, restSeconds: 120),
        WorkoutExerciseRef(exerciseId: lunge, exerciseName: 'Walking Lunge', sets: 3, reps: 12, restSeconds: 75, notes: '12 per leg'),
        WorkoutExerciseRef(exerciseId: legPress, exerciseName: 'Leg Press', sets: 3, reps: 15, restSeconds: 90),
        WorkoutExerciseRef(exerciseId: gluteBridge, exerciseName: 'Glute Bridge', sets: 3, reps: 15, restSeconds: 60),
        WorkoutExerciseRef(exerciseId: sumoSquat, exerciseName: 'Sumo Squat', sets: 3, reps: 12, restSeconds: 60),
        WorkoutExerciseRef(exerciseId: calfRaise, exerciseName: 'Standing Calf Raise', sets: 4, reps: 20, restSeconds: 45),
      ],
    ),
    Workout(
      id: 'core_crusher',
      title: 'Core Crusher',
      category: 'Core',
      level: 'Beginner',
      durationMinutes: 20,
      exerciseCount: 6,
      imageAsset: 'assets/icons/workouts/stretching.png',
      tags: ['Core', 'Abs', 'No Equipment'],
      exercises: [
        WorkoutExerciseRef(exerciseId: plank, exerciseName: 'Plank', sets: 3, reps: 45, restSeconds: 30, notes: '45 seconds'),
        WorkoutExerciseRef(exerciseId: crunch, exerciseName: 'Crunch', sets: 3, reps: 25, restSeconds: 30),
        WorkoutExerciseRef(exerciseId: russianTwist, exerciseName: 'Russian Twist', sets: 3, reps: 20, restSeconds: 30),
        WorkoutExerciseRef(exerciseId: legRaise, exerciseName: 'Leg Raise', sets: 3, reps: 15, restSeconds: 30),
        WorkoutExerciseRef(exerciseId: bicycle, exerciseName: 'Bicycle Crunch', sets: 3, reps: 20, restSeconds: 30),
        WorkoutExerciseRef(exerciseId: mountainClimber, exerciseName: 'Mountain Climber', sets: 3, reps: 30, restSeconds: 45),
      ],
    ),
    Workout(
      id: 'pilates_core',
      title: 'Pilates Core & Flex',
      category: 'Pilates',
      level: 'Beginner',
      durationMinutes: 30,
      exerciseCount: 6,
      imageAsset: 'assets/icons/workouts/pilates.png',
      tags: ['Pilates', 'Core', 'Flexibility'],
      exercises: [
        WorkoutExerciseRef(exerciseId: childPose, exerciseName: "Child's Pose", sets: 1, reps: 5, restSeconds: 0),
        WorkoutExerciseRef(exerciseId: catCow, exerciseName: 'Cat-Cow', sets: 2, reps: 10, restSeconds: 15),
        WorkoutExerciseRef(exerciseId: gluteBridge, exerciseName: 'Glute Bridge', sets: 3, reps: 20, restSeconds: 30),
        WorkoutExerciseRef(exerciseId: plank, exerciseName: 'Plank', sets: 3, reps: 30, restSeconds: 30, notes: '30 seconds'),
        WorkoutExerciseRef(exerciseId: crunch, exerciseName: 'Crunch', sets: 3, reps: 15, restSeconds: 30),
        WorkoutExerciseRef(exerciseId: russianTwist, exerciseName: 'Russian Twist', sets: 3, reps: 16, restSeconds: 30),
      ],
    ),
    Workout(
      id: 'evening_stretch',
      title: 'Evening Stretch & Recovery',
      category: 'Flexibility',
      level: 'Beginner',
      durationMinutes: 20,
      exerciseCount: 6,
      imageAsset: 'assets/icons/workouts/stretching.png',
      tags: ['Stretching', 'Recovery', 'Evening', 'Relaxation'],
      exercises: [
        WorkoutExerciseRef(exerciseId: childPose, exerciseName: "Child's Pose", sets: 1, reps: 10, restSeconds: 0),
        WorkoutExerciseRef(exerciseId: catCow, exerciseName: 'Cat-Cow', sets: 1, reps: 10, restSeconds: 0),
        WorkoutExerciseRef(exerciseId: cobriPose, exerciseName: 'Cobra Pose', sets: 2, reps: 5, restSeconds: 15),
        WorkoutExerciseRef(exerciseId: downwardDog, exerciseName: 'Downward Dog', sets: 2, reps: 8, restSeconds: 15),
        WorkoutExerciseRef(exerciseId: warriorII, exerciseName: 'Warrior II', sets: 2, reps: 5, restSeconds: 10),
        WorkoutExerciseRef(exerciseId: childPose, exerciseName: "Child's Pose", sets: 1, reps: 10, restSeconds: 0),
      ],
    ),
    Workout(
      id: 'power_hiit',
      title: 'Power HIIT Advanced',
      category: 'HIIT',
      level: 'Advanced',
      durationMinutes: 35,
      exerciseCount: 6,
      imageAsset: 'assets/images/home/cardio.png',
      tags: ['HIIT', 'Advanced', 'Fat Burn'],
      exercises: [
        WorkoutExerciseRef(exerciseId: burpee, exerciseName: 'Burpee', sets: 5, reps: 15, restSeconds: 20),
        WorkoutExerciseRef(exerciseId: boxJump, exerciseName: 'Box Jump', sets: 4, reps: 12, restSeconds: 30),
        WorkoutExerciseRef(exerciseId: thruster, exerciseName: 'Thruster', sets: 4, reps: 10, restSeconds: 45),
        WorkoutExerciseRef(exerciseId: kettlebellSwing, exerciseName: 'Kettlebell Swing', sets: 4, reps: 15, restSeconds: 30),
        WorkoutExerciseRef(exerciseId: mountainClimber, exerciseName: 'Mountain Climber', sets: 4, reps: 30, restSeconds: 20),
        WorkoutExerciseRef(exerciseId: highKnee, exerciseName: 'High Knees', sets: 4, reps: 30, restSeconds: 20),
      ],
    ),
    Workout(
      id: 'arnold_split_chest_back',
      title: 'Arnold Split: Chest & Back',
      category: 'Strength',
      level: 'Advanced',
      durationMinutes: 60,
      exerciseCount: 8,
      imageAsset: 'assets/icons/workouts/full_body.png',
      tags: ['Bodybuilding', 'Chest', 'Back', 'Gym'],
      exercises: [
        WorkoutExerciseRef(exerciseId: benchPress, exerciseName: 'Barbell Bench Press', sets: 4, reps: 6, restSeconds: 120),
        WorkoutExerciseRef(exerciseId: bentOverRow, exerciseName: 'Barbell Bent-Over Row', sets: 4, reps: 6, restSeconds: 120),
        WorkoutExerciseRef(exerciseId: inclinePushUp, exerciseName: 'Incline Push-Up', sets: 3, reps: 12, restSeconds: 75),
        WorkoutExerciseRef(exerciseId: pullUp, exerciseName: 'Pull-Up', sets: 4, reps: 8, restSeconds: 90),
        WorkoutExerciseRef(exerciseId: chestFly, exerciseName: 'Dumbbell Chest Fly', sets: 3, reps: 12, restSeconds: 75),
        WorkoutExerciseRef(exerciseId: latPulldown, exerciseName: 'Lat Pulldown', sets: 3, reps: 12, restSeconds: 75),
        WorkoutExerciseRef(exerciseId: seatedRow, exerciseName: 'Seated Cable Row', sets: 3, reps: 12, restSeconds: 60),
        WorkoutExerciseRef(exerciseId: plank, exerciseName: 'Plank', sets: 3, reps: 45, restSeconds: 30, notes: '45 seconds'),
      ],
    ),
    Workout(
      id: 'no_equipment_30',
      title: '30-Min No-Equipment Burn',
      category: 'HIIT',
      level: 'Beginner',
      durationMinutes: 30,
      exerciseCount: 7,
      imageAsset: 'assets/images/home/cardio.png',
      tags: ['No Equipment', 'Home Workout', 'Fat Burn'],
      exercises: [
        WorkoutExerciseRef(exerciseId: jumpingJack, exerciseName: 'Jumping Jack', sets: 3, reps: 30, restSeconds: 20),
        WorkoutExerciseRef(exerciseId: pushUp, exerciseName: 'Push-Up', sets: 3, reps: 15, restSeconds: 30),
        WorkoutExerciseRef(exerciseId: squat, exerciseName: 'Bodyweight Squat', sets: 3, reps: 20, restSeconds: 30),
        WorkoutExerciseRef(exerciseId: lunge, exerciseName: 'Walking Lunge', sets: 3, reps: 12, restSeconds: 30),
        WorkoutExerciseRef(exerciseId: mountainClimber, exerciseName: 'Mountain Climber', sets: 3, reps: 20, restSeconds: 30),
        WorkoutExerciseRef(exerciseId: crunch, exerciseName: 'Crunch', sets: 3, reps: 20, restSeconds: 30),
        WorkoutExerciseRef(exerciseId: burpee, exerciseName: 'Burpee', sets: 3, reps: 8, restSeconds: 45),
      ],
    ),
    Workout(
      id: 'shoulder_arms',
      title: 'Shoulders & Arms Sculpt',
      category: 'Strength',
      level: 'Intermediate',
      durationMinutes: 40,
      exerciseCount: 7,
      imageAsset: 'assets/images/home/arms.png',
      tags: ['Arms', 'Shoulders', 'Gym'],
      exercises: [
        WorkoutExerciseRef(exerciseId: arnoldPress, exerciseName: 'Arnold Press', sets: 4, reps: 10, restSeconds: 75),
        WorkoutExerciseRef(exerciseId: lateralRaise, exerciseName: 'Lateral Raise', sets: 4, reps: 15, restSeconds: 60),
        WorkoutExerciseRef(exerciseId: frontRaise, exerciseName: 'Front Raise', sets: 3, reps: 12, restSeconds: 60),
        WorkoutExerciseRef(exerciseId: bicepCurl, exerciseName: 'Dumbbell Bicep Curl', sets: 4, reps: 12, restSeconds: 60),
        WorkoutExerciseRef(exerciseId: hammerCurl, exerciseName: 'Hammer Curl', sets: 3, reps: 12, restSeconds: 60),
        WorkoutExerciseRef(exerciseId: tricepDip, exerciseName: 'Tricep Dip', sets: 4, reps: 12, restSeconds: 60),
        WorkoutExerciseRef(exerciseId: tricepExtension, exerciseName: 'Tricep Extension', sets: 3, reps: 12, restSeconds: 60),
      ],
    ),
  ];
}
