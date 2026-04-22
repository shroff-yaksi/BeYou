import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/features/fitness/models/workout.dart';
import 'package:flutter/material.dart';

class WorkoutCardWidget extends StatelessWidget {
  final Workout workout;
  final VoidCallback onTap;

  const WorkoutCardWidget({
    super.key,
    required this.workout,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textBlack.withValues(alpha: 0.08),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                _buildImage(),
                const SizedBox(width: 14),
                Expanded(child: _buildInfo()),
                const Icon(Icons.chevron_right, color: ColorConstants.textGrey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 80,
        height: 80,
        color: ColorConstants.primaryColor.withValues(alpha: 0.08),
        child: Image.asset(
          workout.imageAsset,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.fitness_center,
            size: 36,
            color: ColorConstants.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          workout.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorConstants.textBlack,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${workout.exerciseCount} exercises  •  ${workout.durationMinutes} min',
          style: const TextStyle(fontSize: 12, color: ColorConstants.textGrey),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildTag(workout.category, ColorConstants.primaryColor),
            const SizedBox(width: 6),
            _buildTag(workout.level, _levelColor(workout.level)),
          ],
        ),
      ],
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _levelColor(String level) {
    switch (level) {
      case 'Beginner':
        return Colors.green;
      case 'Intermediate':
        return Colors.orange;
      case 'Advanced':
        return Colors.red;
      default:
        return ColorConstants.textGrey;
    }
  }
}
