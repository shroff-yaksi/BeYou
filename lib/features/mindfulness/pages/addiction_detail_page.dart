import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_bloc.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_event.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_state.dart';
import 'package:beyou/features/mindfulness/models/addiction.dart';
import 'package:beyou/features/mindfulness/pages/stress_sos_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddictionDetailPage extends StatelessWidget {
  final AddictionType type;
  const AddictionDetailPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        title: Text(type.label),
        backgroundColor: type.color,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmStop(context),
          ),
        ],
      ),
      body: BlocBuilder<MindfulnessBloc, MindfulnessState>(
        builder: (context, state) {
          if (state is! MindfulnessLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          final tracker = state.addictionTrackers
              .firstWhere((t) => t.type == type, orElse: () => _placeholder());
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _streakCard(tracker),
              const SizedBox(height: 18),
              _statsRow(tracker),
              const SizedBox(height: 24),
              _sosButton(context),
              const SizedBox(height: 24),
              const Text(
                'Health timeline',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              ...tracker.milestones.map((m) => _milestoneTile(m, tracker)),
              const SizedBox(height: 28),
              _relapseButton(context),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'A relapse is data, not failure.',
                  style: TextStyle(color: Color(0xFF8F98A3), fontSize: 12),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  AddictionTracker _placeholder() => AddictionTracker(
        type: type,
        cleanSince: DateTime.now(),
        dailyCostINR: type.defaultDailyCostINR,
      );

  Widget _streakCard(AddictionTracker t) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [t.type.color, t.type.color.withValues(alpha: 0.7)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(t.type.emoji, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 10),
          Text(
            '${t.cleanDays}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 56,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'day${t.cleanDays == 1 ? '' : 's'} clean',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 6),
          Text(
            'Since ${_fmtDate(t.cleanSince)}',
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _statsRow(AddictionTracker t) {
    return Row(
      children: [
        Expanded(
          child: _stat('₹${t.moneySavedINR}', 'Money saved'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _stat('${t.cleanDuration.inHours}', 'Hours clean'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _stat('${t.relapseCount}', 'Resets'),
        ),
      ],
    );
  }

  Widget _stat(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: Color(0xFF8F98A3), fontSize: 11)),
        ],
      ),
    );
  }

  Widget _sosButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const StressSosPage()),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFF7043),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Row(
          children: [
            Text('🆘', style: TextStyle(fontSize: 26)),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Craving SOS',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Quick 2-minute relief sessions',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _milestoneTile(HealthMilestone m, AddictionTracker t) {
    final unlocked = t.cleanDuration >= m.after;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: unlocked ? const Color(0xFF52C78A).withValues(alpha: 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: unlocked
              ? const Color(0xFF52C78A).withValues(alpha: 0.4)
              : Colors.transparent,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            unlocked ? Icons.check_circle : Icons.lock_outline,
            color: unlocked ? const Color(0xFF52C78A) : const Color(0xFF8F98A3),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  m.label,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  m.description,
                  style: const TextStyle(color: Color(0xFF8F98A3), fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _relapseButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => _confirmRelapse(context),
      icon: const Icon(Icons.refresh),
      label: const Text('I had a relapse — reset with kindness'),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: const BorderSide(color: Color(0xFF8F98A3)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _confirmRelapse(BuildContext context) {
    final bloc = context.read<MindfulnessBloc>();
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Reset your streak'),
        content: const Text(
          'Recovery is rarely linear. The fact that you\'re back here matters more than '
          'the streak count. Day 1 starts now.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Not now'),
          ),
          ElevatedButton(
            onPressed: () {
              bloc.add(AddictionRelapseRecorded(type));
              Navigator.pop(dialogCtx);
            },
            child: const Text('Begin Day 1 again'),
          ),
        ],
      ),
    );
  }

  void _confirmStop(BuildContext context) {
    final bloc = context.read<MindfulnessBloc>();
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Remove tracker?'),
        content: const Text('Your streak history for this addiction will be deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE74C3C)),
            onPressed: () {
              bloc.add(AddictionTrackerStopped(type));
              Navigator.pop(dialogCtx);
              Navigator.pop(context);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}
