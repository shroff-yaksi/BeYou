import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/core/router/route_names.dart';
import 'package:beyou/features/fitness/bloc/progress_bloc.dart';
import 'package:beyou/features/fitness/data/fitness_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProgressChartsPage extends StatelessWidget {
  const ProgressChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProgressBloc(repository: getIt<FitnessRepository>())
            ..add(LoadProgressEvent()),
      child: const _ProgressView(),
    );
  }
}

class _ProgressView extends StatefulWidget {
  const _ProgressView();

  @override
  State<_ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<_ProgressView>
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
          'Progress',
          style: TextStyle(color: ColorConstants.textBlack, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => context.push(RouteNames.bodyMetrics),
            icon: const Icon(Icons.monitor_weight_outlined,
                color: ColorConstants.primaryColor, size: 18),
            label: const Text('Metrics',
                style: TextStyle(color: ColorConstants.primaryColor)),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: ColorConstants.primaryColor,
          unselectedLabelColor: ColorConstants.textGrey,
          indicatorColor: ColorConstants.primaryColor,
          tabs: const [
            Tab(text: 'Workouts'),
            Tab(text: 'Body Weight'),
          ],
        ),
      ),
      body: BlocBuilder<ProgressBloc, ProgressState>(
        builder: (context, state) {
          if (state is ProgressLoading || state is ProgressInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProgressError) {
            return Center(child: Text(state.message));
          }
          if (state is ProgressLoaded) {
            return TabBarView(
              controller: _tabController,
              children: [
                _buildWorkoutsTab(state),
                _buildWeightTab(state),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildWorkoutsTab(ProgressLoaded state) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Summary cards
        Row(
          children: [
            Expanded(
              child: _summaryCard(
                  '${state.thisWeekCount}', 'This Week', Icons.fitness_center),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _summaryCard(
                  '${state.thisWeekMinutes}m', 'Time Trained', Icons.timer),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Workouts per Week',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorConstants.textBlack,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Last 8 weeks',
          style: TextStyle(color: ColorConstants.textGrey, fontSize: 12),
        ),
        const SizedBox(height: 16),
        _buildBarChart(state.weeklyWorkoutCounts),
        const SizedBox(height: 24),
        const Text(
          'Recent Workouts',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorConstants.textBlack,
          ),
        ),
        const SizedBox(height: 12),
        if (state.sessions.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'No workouts completed yet.',
                style: TextStyle(color: ColorConstants.textGrey),
              ),
            ),
          )
        else
          ...state.sessions.take(5).map((s) => _recentWorkoutRow(s.workoutTitle,
              s.dateFormatted, '${s.durationSeconds ~/ 60}m')),
      ],
    );
  }

  Widget _buildBarChart(List<int> counts) {
    final maxY = (counts.reduce((a, b) => a > b ? a : b)).toDouble().clamp(3, 10);
    final weekLabels = ['W1', 'W2', 'W3', 'W4', 'W5', 'W6', 'W7', 'W8'];

    return Container(
      height: 200,
      padding: const EdgeInsets.fromLTRB(0, 12, 16, 0),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textBlack.withValues(alpha: 0.06),
            blurRadius: 6,
          ),
        ],
      ),
      child: BarChart(
        BarChartData(
          maxY: maxY + 1,
          minY: 0,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= weekLabels.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      weekLabels[index],
                      style: const TextStyle(
                        fontSize: 11,
                        color: ColorConstants.textGrey,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  if (value % 1 != 0) return const SizedBox.shrink();
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      fontSize: 11,
                      color: ColorConstants.textGrey,
                    ),
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) => FlLine(
              color: ColorConstants.textGrey.withValues(alpha: 0.1),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: counts.asMap().entries.map((e) {
            return BarChartGroupData(
              x: e.key,
              barRods: [
                BarChartRodData(
                  toY: e.value.toDouble(),
                  color: e.key == 7
                      ? ColorConstants.primaryColor
                      : ColorConstants.primaryColor.withValues(alpha: 0.45),
                  width: 18,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildWeightTab(ProgressLoaded state) {
    final trend = state.weightTrend;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        if (trend.isEmpty) ...[
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  Icon(Icons.monitor_weight_outlined,
                      size: 64, color: ColorConstants.textGrey),
                  SizedBox(height: 16),
                  Text(
                    'No weight data yet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Log your body metrics to track weight over time.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ColorConstants.textGrey),
                  ),
                ],
              ),
            ),
          )
        ] else ...[
          const Text(
            'Weight Trend',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorConstants.textBlack,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Last 30 entries',
            style: TextStyle(color: ColorConstants.textGrey, fontSize: 12),
          ),
          const SizedBox(height: 16),
          _buildWeightChart(trend),
        ],
      ],
    );
  }

  Widget _buildWeightChart(
      List<({DateTime date, double weight})> trend) {
    final spots = trend.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.weight);
    }).toList();

    final weights = trend.map((t) => t.weight).toList();
    final minY = weights.reduce((a, b) => a < b ? a : b) - 2;
    final maxY = weights.reduce((a, b) => a > b ? a : b) + 2;

    return Container(
      height: 220,
      padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textBlack.withValues(alpha: 0.06),
            blurRadius: 6,
          ),
        ],
      ),
      child: LineChart(
        LineChartData(
          minY: minY,
          maxY: maxY,
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((s) {
                  return LineTooltipItem(
                    '${s.y.toStringAsFixed(1)} kg',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList();
              },
            ),
          ),
          gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (v) => FlLine(
              color: ColorConstants.textGrey.withValues(alpha: 0.1),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                getTitlesWidget: (v, meta) => Text(
                  v.toStringAsFixed(0),
                  style: const TextStyle(
                    fontSize: 11,
                    color: ColorConstants.textGrey,
                  ),
                ),
              ),
            ),
            bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: ColorConstants.primaryColor,
              barWidth: 3,
              dotData: FlDotData(
                show: trend.length <= 10,
                getDotPainter: (s, _, __, ___) => FlDotCirclePainter(
                  radius: 4,
                  color: ColorConstants.primaryColor,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                color: ColorConstants.primaryColor.withValues(alpha: 0.08),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textBlack.withValues(alpha: 0.06),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: ColorConstants.primaryColor, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: ColorConstants.textBlack,
            ),
          ),
          Text(label,
              style: const TextStyle(
                  color: ColorConstants.textGrey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _recentWorkoutRow(String title, String date, String duration) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: ColorConstants.primaryColor, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.textBlack,
                    fontSize: 14)),
          ),
          Text('$date · $duration',
              style: const TextStyle(
                  color: ColorConstants.textGrey, fontSize: 12)),
        ],
      ),
    );
  }
}
