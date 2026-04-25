import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_bloc.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_event.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_state.dart';
import 'package:beyou/features/mindfulness/models/addiction.dart';
import 'package:beyou/features/mindfulness/pages/addiction_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IAmCleanPage extends StatelessWidget {
  const IAmCleanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        title: const Text('I Am Clean'),
        backgroundColor: const Color(0xFF52C78A),
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<MindfulnessBloc, MindfulnessState>(
        builder: (context, state) {
          if (state is! MindfulnessLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          final activeTypes = state.addictionTrackers.map((t) => t.type).toSet();
          final available =
              AddictionType.values.where((t) => !activeTypes.contains(t)).toList();

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (state.addictionTrackers.isEmpty)
                _onboardingCard()
              else ...[
                const Text(
                  'Your trackers',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                ...state.addictionTrackers.map(
                  (t) => _trackerCard(context, t),
                ),
              ],
              const SizedBox(height: 28),
              const Text(
                'Start a new tracker',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: available
                    .map((t) => _addCard(context, t))
                    .toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _onboardingCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF52C78A).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF52C78A).withValues(alpha: 0.3)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('🌱', style: TextStyle(fontSize: 36)),
          SizedBox(height: 10),
          Text(
            'Start your clean journey',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
          SizedBox(height: 6),
          Text(
            'Pick what you want to step away from. We\'ll track your streak, '
            'celebrate health milestones, and show what you\'re saving — '
            'with no judgement on relapse.',
            style: TextStyle(color: Color(0xFF8F98A3), fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _trackerCard(BuildContext context, AddictionTracker t) {
    final next = t.nextMilestone;
    return GestureDetector(
      onTap: () {
        final bloc = context.read<MindfulnessBloc>();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: bloc,
              child: AddictionDetailPage(type: t.type),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: t.type.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(child: Text(t.type.emoji, style: const TextStyle(fontSize: 26))),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.type.label,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      Text(
                        '${t.cleanDays} day${t.cleanDays == 1 ? '' : 's'} clean',
                        style: TextStyle(color: t.type.color, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                if (t.dailyCostINR > 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹${t.moneySavedINR}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Color(0xFF52C78A),
                        ),
                      ),
                      const Text('saved', style: TextStyle(fontSize: 10, color: Color(0xFF8F98A3))),
                    ],
                  ),
              ],
            ),
            if (next != null) ...[
              const SizedBox(height: 12),
              Text(
                'Next milestone: ${next.label}',
                style: const TextStyle(fontSize: 12, color: Color(0xFF8F98A3)),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _addCard(BuildContext context, AddictionType type) {
    return GestureDetector(
      onTap: () => _confirmStart(context, type),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: type.color.withValues(alpha: 0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(type.emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 6),
            Text(
              type.label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmStart(BuildContext context, AddictionType type) {
    final bloc = context.read<MindfulnessBloc>();
    showDialog(
      context: context,
      builder: (dialogCtx) {
        final costCtrl = TextEditingController(text: type.defaultDailyCostINR.toString());
        return AlertDialog(
          title: Text('Start: ${type.label}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Optional — daily cost (₹) for "money saved" calculation:'),
              const SizedBox(height: 8),
              TextField(
                controller: costCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(prefixText: '₹ '),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final cost = int.tryParse(costCtrl.text) ?? type.defaultDailyCostINR;
                bloc.add(AddictionTrackerStarted(type: type, dailyCostINR: cost));
                Navigator.pop(dialogCtx);
              },
              child: const Text('Begin Day 1'),
            ),
          ],
        );
      },
    );
  }
}
