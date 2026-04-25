import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_bloc.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_event.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_state.dart';
import 'package:beyou/features/mindfulness/models/mood_entry.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoodHistoryPage extends StatelessWidget {
  const MoodHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        title: const Text('Mood History'),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<MindfulnessBloc, MindfulnessState>(
        builder: (context, state) {
          if (state is! MindfulnessLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          final entries = state.moodEntries;
          if (entries.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'No mood entries yet.\nDo your first check-in to see trends here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF8F98A3)),
                ),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _trendChart(entries),
              const SizedBox(height: 24),
              const Text(
                'Recent entries',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              ...entries.map((e) => _entryCard(context, e)),
            ],
          );
        },
      ),
    );
  }

  Widget _trendChart(List<MoodEntry> entries) {
    final last14 = entries.take(14).toList().reversed.toList();
    final spots = <FlSpot>[
      for (var i = 0; i < last14.length; i++)
        FlSpot(i.toDouble(), last14[i].mood.score.toDouble()),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '14-day mood trend',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 6,
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    color: const Color(0xFFE91E63),
                    isCurved: true,
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFFE91E63).withValues(alpha: 0.12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryCard(BuildContext context, MoodEntry e) {
    return Dismissible(
      key: Key(e.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: const Color(0xFFE74C3C),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        context.read<MindfulnessBloc>().add(MoodEntryDeleted(e.id));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(e.mood.emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${e.mood.label} · ${_friendlyDate(e.timestamp)}',
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                  if (e.emotions.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      e.emotions.join(' · '),
                      style: const TextStyle(color: Color(0xFF8F98A3), fontSize: 12),
                    ),
                  ],
                  if (e.gratitude != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      '🙏 ${e.gratitude}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                  if (e.note != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      e.note!,
                      style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _friendlyDate(DateTime t) {
    final now = DateTime.now();
    final diff = now.difference(t);
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${t.day}/${t.month}/${t.year}';
  }
}
