import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/core/router/route_names.dart';
import 'package:beyou/features/fitness/bloc/fitness_bloc.dart';
import 'package:beyou/features/fitness/data/fitness_repository.dart';
import 'package:beyou/features/fitness/widgets/workout_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FitnessPage extends StatelessWidget {
  const FitnessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          FitnessBloc(repository: getIt<FitnessRepository>())
            ..add(LoadWorkoutsEvent()),
      child: const _FitnessView(),
    );
  }
}

class _FitnessView extends StatefulWidget {
  const _FitnessView();

  @override
  State<_FitnessView> createState() => _FitnessViewState();
}

class _FitnessViewState extends State<_FitnessView> {
  final _searchController = TextEditingController();

  static const _categories = [
    'All', 'Strength', 'HIIT', 'Yoga', 'Pilates', 'Core', 'Flexibility', 'Cardio'
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildSearch(context),
            _buildFilters(context),
            Expanded(child: _buildList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(RouteNames.workoutBuilder),
        backgroundColor: ColorConstants.primaryColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Build', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Workouts',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: () => context.push(RouteNames.workoutHistory),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'History',
                style: TextStyle(
                  color: ColorConstants.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => context.push(RouteNames.progressCharts),
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
                  ),
                ],
              ),
              child: const Icon(Icons.bar_chart, color: ColorConstants.primaryColor, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search workouts...',
          prefixIcon: const Icon(Icons.search, color: ColorConstants.textGrey),
          suffixIcon: _searchController.text.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    context
                        .read<FitnessBloc>()
                        .add(SearchWorkoutsEvent(query: ''));
                  },
                  child: const Icon(Icons.close, color: ColorConstants.textGrey),
                )
              : null,
          filled: true,
          fillColor: ColorConstants.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (q) =>
            context.read<FitnessBloc>().add(SearchWorkoutsEvent(query: q)),
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    return BlocBuilder<FitnessBloc, FitnessState>(
      buildWhen: (_, s) => s is FitnessLoaded,
      builder: (context, state) {
        final selected =
            state is FitnessLoaded ? state.selectedCategory : 'All';
        return SizedBox(
          height: 38,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _categories.length,
            itemBuilder: (context, i) {
              final cat = _categories[i];
              final isSelected = cat == selected;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => context
                      .read<FitnessBloc>()
                      .add(FilterWorkoutsEvent(category: cat)),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ColorConstants.primaryColor
                          : ColorConstants.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? ColorConstants.primaryColor
                            : ColorConstants.textGrey.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        color: isSelected ? Colors.white : ColorConstants.textGrey,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildList() {
    return BlocBuilder<FitnessBloc, FitnessState>(
      builder: (context, state) {
        if (state is FitnessLoading || state is FitnessInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is FitnessError) {
          return Center(child: Text(state.message));
        }
        if (state is FitnessLoaded) {
          if (state.workouts.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.fitness_center, size: 64, color: ColorConstants.textGrey),
                  SizedBox(height: 16),
                  Text('No workouts found',
                      style: TextStyle(color: ColorConstants.textGrey)),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: state.workouts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final workout = state.workouts[index];
              return WorkoutCardWidget(
                workout: workout,
                onTap: () => context.push(
                  RouteNames.workoutDetail,
                  extra: workout,
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
