import 'package:firebase_auth/firebase_auth.dart';
import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/constants/data_constants.dart';
import 'package:beyou/core/constants/path_constants.dart';
import 'package:beyou/core/constants/text_constants.dart';
import 'package:beyou/core/router/route_names.dart';
import 'package:beyou/screens/home/bloc/home_bloc.dart';
import 'package:beyou/screens/home/widget/home_statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'home_exercises_card.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.homeBackgroundColor,
      height: double.infinity,
      width: double.infinity,
      child: _createHomeBody(context),
    );
  }

  Widget _createHomeBody(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          _createProfileData(context),
          const SizedBox(height: 24),
          HomeStatistics(),
          const SizedBox(height: 28),
          _createExercisesList(context),
          const SizedBox(height: 24),
          _createProgress(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _createExercisesList(BuildContext context) {
    final cardColors = [
      ColorConstants.cardioColor,
      ColorConstants.armsColor,
      ColorConstants.eveningFlowColor,
    ];
    final cardSubtitles = ['Intermediate', 'Beginner', 'Relaxation'];
    final cardKcals = ['300 kcal', '150 kcal', '80 kcal'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TextConstants.discoverWorkouts,
                style: TextStyle(
                  color: ColorConstants.textBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'View all',
                  style: TextStyle(
                    color: ColorConstants.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: DataConstants.homeWorkouts.length,
            padding: const EdgeInsets.only(left: 20),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: index == DataConstants.homeWorkouts.length - 1 ? 20 : 15),
                child: _buildWorkoutCard(
                  context: context,
                  color: cardColors[index % cardColors.length],
                  workout: DataConstants.homeWorkouts[index],
                  subtitle: cardSubtitles[index % cardSubtitles.length],
                  kcal: cardKcals[index % cardKcals.length],
                  onTap: () => context.push(
                    RouteNames.workoutDetails,
                    extra: DataConstants.workouts[index % DataConstants.workouts.length],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWorkoutCard({
    required BuildContext context,
    required Color color,
    required workout,
    required String subtitle,
    required String kcal,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            Text(
              workout.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.timer, color: Colors.white70, size: 14),
                const SizedBox(width: 4),
                Text(
                  '${workout.minutes} mins • $kcal',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _createProfileData(BuildContext context) {
    String displayName = "User";

    try {
      final user = FirebaseAuth.instance.currentUser;
      displayName = user?.displayName ?? "User";
    } catch (_) {
      // Firebase not initialized, use defaults
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back,',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.textGrey,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Hi, $displayName',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.textBlack,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildIconButton(
                icon: Icons.search,
                onTap: () {},
              ),
              const SizedBox(width: 8),
              _buildIconButton(
                icon: Icons.notifications_outlined,
                onTap: () {},
              ),
              const SizedBox(width: 8),
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (_, currState) => currState is ReloadImageState,
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () async {
                      await context.push(RouteNames.editAccount);
                      if (context.mounted) {
                        BlocProvider.of<HomeBloc>(context).add(ReloadImageEvent());
                      }
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage(PathConstants.profile),
                      radius: 20,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.textBlack.withValues(alpha: 0.08),
              blurRadius: 4,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: Icon(icon, color: ColorConstants.textBlack, size: 20),
      ),
    );
  }

  Widget _createProgress() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textBlack.withValues(alpha: 0.12),
            blurRadius: 5.0,
            spreadRadius: 1.1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TextConstants.keepProgress,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textBlack,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "You're 80% through your weekly goal.",
                      style: TextStyle(
                        fontSize: 13,
                        color: ColorConstants.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.trending_up, color: ColorConstants.primaryColor, size: 28),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 4 / 5,
              backgroundColor: ColorConstants.disabledColor,
              color: ColorConstants.primaryColor,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '4/5 days',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.textBlack,
                ),
              ),
              Icon(Icons.fitness_center, color: ColorConstants.grey, size: 16),
            ],
          ),
        ],
      ),
    );
  }
}
