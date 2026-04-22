import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/features/fitness/bloc/active_workout_bloc.dart';
import 'package:beyou/features/fitness/data/fitness_repository.dart';
import 'package:beyou/features/fitness/models/exercise.dart';
import 'package:beyou/features/fitness/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActiveWorkoutPage extends StatelessWidget {
  final Workout workout;
  final Map<String, Exercise> exercises;

  const ActiveWorkoutPage({
    super.key,
    required this.workout,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ActiveWorkoutBloc(repository: getIt<FitnessRepository>())
            ..add(StartWorkoutSessionEvent(
              workout: workout,
              exercises: exercises,
            )),
      child: const _ActiveWorkoutView(),
    );
  }
}

class _ActiveWorkoutView extends StatefulWidget {
  const _ActiveWorkoutView();

  @override
  State<_ActiveWorkoutView> createState() => _ActiveWorkoutViewState();
}

class _ActiveWorkoutViewState extends State<_ActiveWorkoutView> {
  final _repsController = TextEditingController(text: '10');
  final _weightController = TextEditingController(text: '0');

  @override
  void dispose() {
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActiveWorkoutBloc, ActiveWorkoutState>(
      listenWhen: (_, s) => s is ActiveWorkoutCompleted,
      listener: (context, state) {
        if (state is ActiveWorkoutCompleted) {
          _showCompletionDialog(context, state);
        }
      },
      builder: (context, state) {
        if (state is ActiveWorkoutInProgress) {
          return _buildWorkoutScreen(context, state);
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildWorkoutScreen(BuildContext context, ActiveWorkoutInProgress state) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: ColorConstants.textBlack),
          onPressed: () => _confirmQuit(context),
        ),
        title: Text(
          state.workout.title,
          style: const TextStyle(
            color: ColorConstants.textBlack,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                state.elapsedFormatted,
                style: const TextStyle(
                  color: ColorConstants.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      body: state.isResting
          ? _buildRestScreen(context, state)
          : _buildExerciseScreen(context, state),
    );
  }

  Widget _buildExerciseScreen(BuildContext context, ActiveWorkoutInProgress state) {
    final ref = state.currentExerciseRef;
    final exercise = state.currentExercise;

    return Column(
      children: [
        // Progress bar
        LinearProgressIndicator(
          value: state.overallProgress,
          backgroundColor: ColorConstants.primaryColor.withValues(alpha: 0.12),
          color: ColorConstants.primaryColor,
          minHeight: 4,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Exercise header
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Exercise ${state.currentExerciseIndex + 1} / ${state.workout.exercises.length}',
                            style: const TextStyle(
                              color: ColorConstants.textGrey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ref.exerciseName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.textBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (exercise != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          exercise.difficulty,
                          style: const TextStyle(
                            color: ColorConstants.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                if (exercise != null && exercise.muscleGroups.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    exercise.muscleGroups.join(' • '),
                    style: const TextStyle(
                      color: ColorConstants.textGrey,
                      fontSize: 13,
                    ),
                  ),
                ],
                const SizedBox(height: 20),

                // Video/image placeholder
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: exercise?.videoAsset != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: const Center(
                            child: Icon(Icons.play_circle_outline,
                                size: 64, color: ColorConstants.primaryColor),
                          ),
                        )
                      : const Center(
                          child: Icon(Icons.fitness_center,
                              size: 64, color: ColorConstants.primaryColor),
                        ),
                ),
                const SizedBox(height: 24),

                // Set info
                Text(
                  'Set ${state.currentSetIndex + 1} of ${ref.sets}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.textBlack,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Target: ${ref.reps} reps',
                  style: const TextStyle(
                    fontSize: 14,
                    color: ColorConstants.textGrey,
                  ),
                ),
                const SizedBox(height: 20),

                // Input: reps + weight
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        label: 'Reps',
                        controller: _repsController,
                        unit: 'reps',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildInputField(
                        label: 'Weight',
                        controller: _weightController,
                        unit: 'kg',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Instructions
                if (exercise != null && exercise.instructions.isNotEmpty) ...[
                  const Text(
                    'How to perform',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.textBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...exercise.instructions.asMap().entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            decoration: const BoxDecoration(
                              color: ColorConstants.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${e.key + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              e.value,
                              style: const TextStyle(
                                color: ColorConstants.textBlack,
                                fontSize: 13,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],

                if (state.nextExerciseRef != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ColorConstants.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.skip_next, color: ColorConstants.textGrey, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          'Next: ${state.nextExerciseRef!.exerciseName}',
                          style: const TextStyle(
                            color: ColorConstants.textGrey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),

        // Bottom buttons
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () =>
                      context.read<ActiveWorkoutBloc>().add(SkipExerciseEvent()),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: ColorConstants.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Skip', style: TextStyle(color: ColorConstants.primaryColor)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    final reps = int.tryParse(_repsController.text) ?? ref.reps;
                    final weight = double.tryParse(_weightController.text) ?? 0;
                    context.read<ActiveWorkoutBloc>().add(
                          CompleteSetEvent(reps: reps, weightKg: weight),
                        );
                    _repsController.text = ref.reps.toString();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Complete Set',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRestScreen(BuildContext context, ActiveWorkoutInProgress state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Rest',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: ColorConstants.textBlack,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: ColorConstants.primaryColor, width: 4),
            ),
            child: Center(
              child: Text(
                '${state.restSecondsRemaining}s',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          if (state.nextExerciseRef != null)
            Text(
              'Next: ${state.nextExerciseRef!.exerciseName}',
              style: const TextStyle(
                color: ColorConstants.textGrey,
                fontSize: 16,
              ),
            ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () =>
                context.read<ActiveWorkoutBloc>().add(FinishRestEvent()),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Skip Rest',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String unit,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: ColorConstants.textGrey, fontSize: 12)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            suffixText: unit,
            filled: true,
            fillColor: ColorConstants.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  void _confirmQuit(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Quit Workout?'),
        content: const Text('Your progress will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Continue'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.pop();
            },
            child: const Text('Quit', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog(BuildContext context, ActiveWorkoutCompleted state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Column(
          children: [
            Icon(Icons.emoji_events, color: Colors.amber, size: 48),
            SizedBox(height: 8),
            Text('Workout Complete!', textAlign: TextAlign.center),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _statRow(Icons.timer, 'Duration', state.session.durationFormatted),
            const SizedBox(height: 8),
            _statRow(
                Icons.local_fire_department, 'Calories', '${state.session.caloriesBurned} kcal'),
            const SizedBox(height: 8),
            _statRow(Icons.fitness_center, 'Exercises',
                '${state.session.exercisesCompleted.length}'),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Pop back to workout list
                while (context.canPop()) {
                  context.pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Done',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statRow(IconData icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          Icon(icon, color: ColorConstants.primaryColor, size: 18),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: ColorConstants.textGrey)),
        ]),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
