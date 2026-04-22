import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/features/fitness/bloc/metrics_bloc.dart';
import 'package:beyou/features/fitness/data/fitness_repository.dart';
import 'package:beyou/features/fitness/models/body_metric.dart';
import 'package:beyou/features/fitness/models/personal_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BodyMetricsPage extends StatelessWidget {
  const BodyMetricsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          MetricsBloc(repository: getIt<FitnessRepository>())
            ..add(LoadMetricsEvent()),
      child: const _MetricsView(),
    );
  }
}

class _MetricsView extends StatefulWidget {
  const _MetricsView();

  @override
  State<_MetricsView> createState() => _MetricsViewState();
}

class _MetricsViewState extends State<_MetricsView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          'Body Metrics',
          style: TextStyle(color: ColorConstants.textBlack, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: ColorConstants.primaryColor,
          unselectedLabelColor: ColorConstants.textGrey,
          indicatorColor: ColorConstants.primaryColor,
          tabs: const [
            Tab(text: 'Measurements'),
            Tab(text: 'Personal Records'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMetricSheet(context),
        backgroundColor: ColorConstants.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: BlocBuilder<MetricsBloc, MetricsState>(
        builder: (context, state) {
          if (state is MetricsLoading || state is MetricsInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MetricsError) {
            return Center(child: Text(state.message));
          }
          if (state is MetricsLoaded) {
            return TabBarView(
              controller: _tabController,
              children: [
                _buildMeasurementsTab(context, state),
                _buildPRsTab(state),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildMeasurementsTab(BuildContext context, MetricsLoaded state) {
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<MetricsBloc>().add(LoadMetricsEvent()),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (state.latest != null) _buildLatestCard(state.latest!),
          const SizedBox(height: 20),
          const Text(
            'History',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorConstants.textBlack,
            ),
          ),
          const SizedBox(height: 12),
          if (state.metrics.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'No measurements logged yet.\nTap + to add your first entry.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ColorConstants.textGrey),
                ),
              ),
            )
          else
            ...state.metrics.map((m) => _buildMetricRow(context, m)),
        ],
      ),
    );
  }

  Widget _buildLatestCard(BodyMetric metric) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Latest Measurement',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            metric.dateFormatted,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (metric.weightKg != null)
                _latestStat('${metric.weightKg!.toStringAsFixed(1)} kg', 'Weight'),
              if (metric.bodyFatPct != null)
                _latestStat('${metric.bodyFatPct!.toStringAsFixed(1)}%', 'Body Fat'),
              if (metric.waist != null)
                _latestStat('${metric.waist!.toStringAsFixed(1)} cm', 'Waist'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _latestStat(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildMetricRow(BuildContext context, BodyMetric metric) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textBlack.withValues(alpha: 0.05),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                metric.dateFormatted,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.textBlack,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _buildMetricSummary(metric),
                style: const TextStyle(
                  color: ColorConstants.textGrey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: ColorConstants.textGrey, size: 20),
            onPressed: () => context
                .read<MetricsBloc>()
                .add(DeleteBodyMetricEvent(metricId: metric.id)),
          ),
        ],
      ),
    );
  }

  String _buildMetricSummary(BodyMetric m) {
    final parts = <String>[];
    if (m.weightKg != null) parts.add('${m.weightKg!.toStringAsFixed(1)} kg');
    if (m.bodyFatPct != null) parts.add('${m.bodyFatPct!.toStringAsFixed(1)}% BF');
    if (m.waist != null) parts.add('${m.waist!.toStringAsFixed(0)}cm waist');
    return parts.join('  •  ');
  }

  Widget _buildPRsTab(MetricsLoaded state) {
    if (state.personalRecords.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.emoji_events, size: 64, color: ColorConstants.textGrey),
            SizedBox(height: 16),
            Text(
              'No personal records yet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Complete workouts to set your PRs.',
              style: TextStyle(color: ColorConstants.textGrey),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: state.personalRecords.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return _PRCard(pr: state.personalRecords[index]);
      },
    );
  }

  void _showAddMetricSheet(BuildContext context) {
    final weightCtrl = TextEditingController();
    final bfCtrl = TextEditingController();
    final chestCtrl = TextEditingController();
    final waistCtrl = TextEditingController();
    final hipsCtrl = TextEditingController();
    final armsCtrl = TextEditingController();
    final thighsCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => BlocProvider.value(
        value: context.read<MetricsBloc>(),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetCtx).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Log Measurements',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.textBlack,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _sheetField(weightCtrl, 'Weight (kg)', '70.0'),
                  _sheetField(bfCtrl, 'Body Fat (%)', '18.0'),
                  _sheetField(chestCtrl, 'Chest (cm)', ''),
                  _sheetField(waistCtrl, 'Waist (cm)', ''),
                  _sheetField(hipsCtrl, 'Hips (cm)', ''),
                  _sheetField(armsCtrl, 'Arms (cm)', ''),
                  _sheetField(thighsCtrl, 'Thighs (cm)', ''),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<MetricsBloc>().add(
                              SaveBodyMetricEvent(
                                weightKg: double.tryParse(weightCtrl.text),
                                bodyFatPct: double.tryParse(bfCtrl.text),
                                chest: double.tryParse(chestCtrl.text),
                                waist: double.tryParse(waistCtrl.text),
                                hips: double.tryParse(hipsCtrl.text),
                                arms: double.tryParse(armsCtrl.text),
                                thighs: double.tryParse(thighsCtrl.text),
                              ),
                            );
                        Navigator.of(sheetCtx).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save',
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
          ),
        ),
      ),
    );
  }

  Widget _sheetField(
      TextEditingController ctrl, String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: ColorConstants.homeBackgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _PRCard extends StatelessWidget {
  final PersonalRecord pr;

  const _PRCard({required this.pr});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.emoji_events, color: Colors.amber, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pr.exerciseName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: ColorConstants.textBlack,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Set on ${pr.dateFormatted}',
                  style: const TextStyle(
                    color: ColorConstants.textGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                pr.weightFormatted,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: ColorConstants.primaryColor,
                ),
              ),
              Text(
                '${pr.bestReps} reps',
                style: const TextStyle(
                  color: ColorConstants.textGrey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
