import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/core/router/route_names.dart';
import 'package:beyou/features/fitness/bloc/workout_detail_bloc.dart';
import 'package:beyou/features/fitness/data/fitness_repository.dart';
import 'package:beyou/features/fitness/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WorkoutDetailPage extends StatelessWidget {
  final Workout workout;

  const WorkoutDetailPage({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WorkoutDetailBloc(repository: getIt<FitnessRepository>())
        ..add(LoadWorkoutDetailEvent(workoutId: workout.id)),
      child: _WorkoutDetailView(workout: workout),
    );
  }
}

class _WorkoutDetailView extends StatelessWidget {
  final Workout workout;

  const _WorkoutDetailView({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      body: BlocBuilder<WorkoutDetailBloc, WorkoutDetailState>(
        builder: (context, state) {
          if (state is WorkoutDetailLoading || state is WorkoutDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WorkoutDetailError) {
            return Center(child: Text(state.message));
          }
          if (state is WorkoutDetailLoaded) {
            return _buildContent(context, state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, WorkoutDetailLoaded state) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(context, state),
        SliverToBoxAdapter(child: _buildStats(state)),
        SliverToBoxAdapter(child: _buildTagRow(state)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Text(
              'Exercises',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorConstants.textBlack,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final ref = state.workout.exercises[index];
              final exercise = state.exercises[ref.exerciseId];
              return _buildExerciseTile(context, ref, exercise, index, state);
            },
            childCount: state.workout.exercises.length,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context, WorkoutDetailLoaded state) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      backgroundColor: ColorConstants.primaryColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              state.workout.imageAsset,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: ColorConstants.primaryColor.withValues(alpha: 0.3),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 16,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.workout.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.play_circle_fill, color: Colors.white, size: 28),
          tooltip: 'Start Workout',
          onPressed: () => _startWorkout(context, state),
        ),
      ],
    );
  }

  Widget _buildStats(WorkoutDetailLoaded state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          _statChip(Icons.timer_outlined, '${state.workout.durationMinutes} min'),
          const SizedBox(width: 12),
          _statChip(Icons.fitness_center, '${state.workout.exerciseCount} exercises'),
          const SizedBox(width: 12),
          _statChip(Icons.trending_up, state.workout.level),
        ],
      ),
    );
  }

  Widget _statChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: ColorConstants.primaryColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: ColorConstants.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagRow(WorkoutDetailLoaded state) {
    if (state.workout.tags.isEmpty) return const SizedBox(height: 8);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Wrap(
        spacing: 8,
        runSpacing: 6,
        children: state.workout.tags.map((tag) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: ColorConstants.textGrey.withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '#$tag',
              style: const TextStyle(fontSize: 11, color: ColorConstants.textGrey),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExerciseTile(
    BuildContext context,
    WorkoutExerciseRef ref,
    exercise,
    int index,
    WorkoutDetailLoaded state,
  ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textBlack.withValues(alpha: 0.06),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: ColorConstants.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ref.exerciseName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.textBlack,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${ref.sets} sets × ${ref.reps} reps  •  ${ref.restSeconds}s rest',
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorConstants.textGrey,
                  ),
                ),
                if (exercise != null && exercise.muscleGroups.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    exercise.muscleGroups.join(', '),
                    style: TextStyle(
                      fontSize: 11,
                      color: ColorConstants.primaryColor.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _startWorkout(BuildContext context, WorkoutDetailLoaded state) {
    context.push(
      RouteNames.activeWorkout,
      extra: {'workout': state.workout, 'exercises': state.exercises},
    );
  }
}
