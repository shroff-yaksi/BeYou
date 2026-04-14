import 'package:firebase_auth/firebase_auth.dart';
import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/router/route_names.dart';
import 'package:beyou/core/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoalSelectionPage extends StatefulWidget {
  const GoalSelectionPage({super.key});

  @override
  State<GoalSelectionPage> createState() => _GoalSelectionPageState();
}

class _GoalSelectionPageState extends State<GoalSelectionPage> {
  final Set<String> _selectedGoals = {};
  String _fitnessLevel = 'Beginner';
  bool _loading = false;

  static const _goals = [
    _GoalOption(icon: Icons.monitor_weight_outlined, label: 'Lose Weight', value: 'lose_weight'),
    _GoalOption(icon: Icons.fitness_center, label: 'Build Muscle', value: 'build_muscle'),
    _GoalOption(icon: Icons.directions_run, label: 'Stay Active', value: 'stay_active'),
    _GoalOption(icon: Icons.self_improvement, label: 'Reduce Stress', value: 'reduce_stress'),
    _GoalOption(icon: Icons.restaurant_menu, label: 'Eat Healthy', value: 'eat_healthy'),
    _GoalOption(icon: Icons.bedtime_outlined, label: 'Sleep Better', value: 'sleep_better'),
  ];

  static const _levels = ['Beginner', 'Intermediate', 'Advanced'];

  Future<void> _continue() async {
    if (_selectedGoals.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick at least one goal')),
      );
      return;
    }
    setState(() => _loading = true);
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await UserService.saveGoals(
          uid: uid,
          goals: _selectedGoals.toList(),
          fitnessLevel: _fitnessLevel,
        );
      }
    } catch (_) {}
    if (mounted) context.go(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: ColorConstants.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Almost there',
                      style: TextStyle(
                        color: ColorConstants.primaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'What are your\nwellness goals?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select all that apply — we\'ll personalise your experience.',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGoalGrid(),
                    const SizedBox(height: 32),
                    Text(
                      'Fitness Level',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.textBlack,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildLevelSelector(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _loading ? null : _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: _loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: _goals.map((goal) {
        final selected = _selectedGoals.contains(goal.value);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (selected) {
                _selectedGoals.remove(goal.value);
              } else {
                _selectedGoals.add(goal.value);
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: selected ? ColorConstants.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected
                    ? ColorConstants.primaryColor
                    : Colors.grey.shade200,
                width: 1.5,
              ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: ColorConstants.primaryColor.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(
                  goal.icon,
                  size: 22,
                  color: selected ? Colors.white : ColorConstants.primaryColor,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    goal.label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : ColorConstants.textBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLevelSelector() {
    return Row(
      children: _levels.map((level) {
        final selected = _fitnessLevel == level;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _fitnessLevel = level),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(
                right: level != _levels.last ? 10 : 0,
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: selected ? ColorConstants.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selected
                      ? ColorConstants.primaryColor
                      : Colors.grey.shade200,
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    level == 'Beginner'
                        ? Icons.emoji_events_outlined
                        : level == 'Intermediate'
                            ? Icons.trending_up
                            : Icons.local_fire_department_outlined,
                    size: 20,
                    color: selected ? Colors.white : ColorConstants.primaryColor,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    level,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : ColorConstants.textBlack,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _GoalOption {
  final IconData icon;
  final String label;
  final String value;
  const _GoalOption({required this.icon, required this.label, required this.value});
}
