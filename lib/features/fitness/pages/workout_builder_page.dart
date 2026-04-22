import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/features/fitness/data/fitness_repository.dart';
import 'package:beyou/features/fitness/models/exercise.dart';
import 'package:beyou/features/fitness/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class WorkoutBuilderPage extends StatefulWidget {
  const WorkoutBuilderPage({super.key});

  @override
  State<WorkoutBuilderPage> createState() => _WorkoutBuilderPageState();
}

class _WorkoutBuilderPageState extends State<WorkoutBuilderPage> {
  final _nameController = TextEditingController();
  final _repository = getIt<FitnessRepository>();
  String _selectedCategory = 'Strength';
  String _selectedLevel = 'Beginner';

  final List<WorkoutExerciseRef> _selectedExercises = [];
  List<Exercise> _allExercises = [];
  List<Exercise> _filteredExercises = [];
  bool _isLoading = true;
  bool _isSaving = false;

  final _searchController = TextEditingController();

  static const _categories = ['Strength', 'HIIT', 'Yoga', 'Core', 'Flexibility', 'Cardio', 'Pilates', 'Full Body'];
  static const _levels = ['Beginner', 'Intermediate', 'Advanced'];

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadExercises() async {
    final exercises = await _repository.searchExercises('');
    setState(() {
      _allExercises = exercises;
      _filteredExercises = exercises;
      _isLoading = false;
    });
  }

  void _filterExercises(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredExercises = _allExercises;
      } else {
        final q = query.toLowerCase();
        _filteredExercises = _allExercises
            .where((e) =>
                e.name.toLowerCase().contains(q) ||
                e.muscleGroups.any((m) => m.toLowerCase().contains(q)))
            .toList();
      }
    });
  }

  Future<void> _saveWorkout() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a workout name')),
      );
      return;
    }
    if (_selectedExercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one exercise')),
      );
      return;
    }

    setState(() => _isSaving = true);

    final workout = Workout(
      id: const Uuid().v4(),
      title: _nameController.text.trim(),
      category: _selectedCategory,
      level: _selectedLevel,
      durationMinutes: _selectedExercises.fold<int>(
          0, (sum, e) => sum + e.sets * (e.reps ~/ 3 + e.restSeconds) ~/ 60),
      exerciseCount: _selectedExercises.length,
      imageAsset: 'assets/icons/workouts/full_body.png',
      exercises: _selectedExercises,
      tags: [_selectedCategory, _selectedLevel, 'Custom'],
      isCustom: true,
    );

    try {
      await _repository.saveCustomWorkout(workout);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Workout saved!')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: ColorConstants.primaryColor),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Build Workout',
          style: TextStyle(color: ColorConstants.textBlack, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (_isSaving)
            const Center(
              child: Padding(
                padding: EdgeInsets.only(right: 16),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            TextButton(
              onPressed: _saveWorkout,
              child: const Text(
                'Save',
                style: TextStyle(
                  color: ColorConstants.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildWorkoutConfig(),
                const Divider(height: 1),
                _buildExerciseSearch(),
                Expanded(child: _buildExerciseList()),
                if (_selectedExercises.isNotEmpty)
                  _buildSelectedBanner(),
              ],
            ),
    );
  }

  Widget _buildWorkoutConfig() {
    return Container(
      color: ColorConstants.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Workout Name',
              filled: true,
              fillColor: ColorConstants.homeBackgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  value: _selectedCategory,
                  items: _categories,
                  onChanged: (v) => setState(() => _selectedCategory = v!),
                  label: 'Category',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdown(
                  value: _selectedLevel,
                  items: _levels,
                  onChanged: (v) => setState(() => _selectedLevel = v!),
                  label: 'Level',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required String label,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: ColorConstants.homeBackgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      items: items
          .map((item) => DropdownMenuItem<String>(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildExerciseSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search exercises...',
          prefixIcon: const Icon(Icons.search, color: ColorConstants.textGrey),
          filled: true,
          fillColor: ColorConstants.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: _filterExercises,
      ),
    );
  }

  Widget _buildExerciseList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredExercises.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final exercise = _filteredExercises[index];
        final isAdded = _selectedExercises.any((e) => e.exerciseId == exercise.id);
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.fitness_center,
                color: ColorConstants.primaryColor, size: 20),
          ),
          title: Text(
            exercise.name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          subtitle: Text(
            '${exercise.category}  •  ${exercise.muscleGroups.take(2).join(", ")}',
            style: const TextStyle(fontSize: 12, color: ColorConstants.textGrey),
          ),
          trailing: IconButton(
            icon: Icon(
              isAdded ? Icons.check_circle : Icons.add_circle_outline,
              color: isAdded ? Colors.green : ColorConstants.primaryColor,
            ),
            onPressed: () => isAdded
                ? _removeExercise(exercise.id)
                : _addExercise(exercise),
          ),
        );
      },
    );
  }

  Widget _buildSelectedBanner() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textBlack.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${_selectedExercises.length} exercise${_selectedExercises.length == 1 ? '' : 's'} selected',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: ColorConstants.textBlack,
              ),
            ),
          ),
          TextButton(
            onPressed: _showSelectedSheet,
            child: const Text('Review',
                style: TextStyle(color: ColorConstants.primaryColor)),
          ),
        ],
      ),
    );
  }

  void _addExercise(Exercise exercise) {
    setState(() {
      _selectedExercises.add(WorkoutExerciseRef(
        exerciseId: exercise.id,
        exerciseName: exercise.name,
        sets: 3,
        reps: 10,
        restSeconds: 60,
      ));
    });
  }

  void _removeExercise(String exerciseId) {
    setState(() {
      _selectedExercises.removeWhere((e) => e.exerciseId == exerciseId);
    });
  }

  void _showSelectedSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          builder: (ctx, scrollController) => Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Selected Exercises',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(ctx).pop(),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ReorderableListView.builder(
                    scrollController: scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _selectedExercises.length,
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) newIndex--;
                        final item = _selectedExercises.removeAt(oldIndex);
                        _selectedExercises.insert(newIndex, item);
                      });
                      setSheetState(() {});
                    },
                    itemBuilder: (ctx, index) {
                      final ref = _selectedExercises[index];
                      return ListTile(
                        key: ValueKey(ref.exerciseId),
                        leading: const Icon(Icons.drag_handle, color: ColorConstants.textGrey),
                        title: Text(ref.exerciseName),
                        subtitle: Text('${ref.sets} × ${ref.reps} • ${ref.restSeconds}s rest'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () {
                            setState(() => _selectedExercises.removeAt(index));
                            setSheetState(() {});
                            if (_selectedExercises.isEmpty) {
                              Navigator.of(ctx).pop();
                            }
                          },
                        ),
                      );
                    },
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
