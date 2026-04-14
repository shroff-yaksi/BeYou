import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/constants/text_constants.dart';
import 'package:beyou/data/workout_data.dart';
import 'package:beyou/screens/workouts/bloc/workouts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutCard extends StatelessWidget {
  final WorkoutData workout;
  const WorkoutCard({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WorkoutsBloc>(context);
    final progress = workout.progress > 0 ? workout.currentProgress / workout.progress : 0.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textBlack.withValues(alpha: 0.10),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => bloc.add(CardTappedEvent(workout: workout)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    workout.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workout.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.textBlack,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${workout.exercices} ${TextConstants.exercisesUppercase}  •  ${workout.minutes} ${TextConstants.minutes}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: ColorConstants.textGrey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: progress.toDouble(),
                          backgroundColor: ColorConstants.primaryColor.withValues(alpha: 0.12),
                          color: ColorConstants.primaryColor,
                          minHeight: 6,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${workout.currentProgress}/${workout.progress} completed',
                        style: const TextStyle(
                          fontSize: 11,
                          color: ColorConstants.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
