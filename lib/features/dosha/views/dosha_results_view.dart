import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beyou/features/dosha/bloc/dosha_bloc.dart';
import 'package:beyou/features/dosha/bloc/dosha_event_state.dart';
import 'package:beyou/features/dosha/models/dosha_type.dart';

class DoshaResultsView extends StatelessWidget {
  const DoshaResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<DoshaBloc, DoshaState>(
      buildWhen: (prev, curr) => curr is DoshaResults,
      builder: (context, state) {
        if (state is! DoshaResults) return const SizedBox.shrink();

        return Scaffold(
          appBar: AppBar(
            title: Text('Results • ${state.participantName}'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.read<DoshaBloc>().add(const DoshaBackToHome()),
            ),
            actions: [
              IconButton(
                tooltip: 'History',
                onPressed: () => context.read<DoshaBloc>().add(const DoshaHistoryLoaded()),
                icon: const Icon(Icons.history),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${state.primaryDoshaLabel} dominant constitution',
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Primary dosha balance based on questionnaire responses.',
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: state.sortedScores.map((entry) {
                              return _ScoreChip(label: entry.key, value: entry.value);
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Dosha bar chart
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dosha Distribution', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 20),
                          ...state.sortedScores.map((entry) {
                            final color = _doshaColor(entry.key);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(entry.key, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                                      Text('${entry.value.toStringAsFixed(0)}%', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700, color: color)),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: LinearProgressIndicator(
                                      value: entry.value / 100,
                                      minHeight: 10,
                                      backgroundColor: color.withOpacity(0.15),
                                      valueColor: AlwaysStoppedAnimation<Color>(color),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Traits
                  _ContentSection(
                    title: 'Key Traits',
                    icon: Icons.bolt,
                    children: state.primaryTraits.map((t) => _BulletItem(text: t)).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Recommendations
                  _ContentSection(
                    title: 'Recommendations',
                    icon: Icons.self_improvement,
                    children: state.recommendations.map((r) => _BulletItem(text: r)).toList(),
                  ),
                  const SizedBox(height: 32),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => context.read<DoshaBloc>().add(const DoshaHistoryLoaded()),
                          icon: const Icon(Icons.history),
                          label: const Text('View History'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => context.read<DoshaBloc>().add(const DoshaRestarted()),
                          icon: const Icon(Icons.replay),
                          label: const Text('Retake'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _doshaColor(String label) {
    for (final type in DoshaType.values) {
      if (type.label == label) return type.accentColor;
    }
    return Colors.blueGrey;
  }
}

class _ContentSection extends StatelessWidget {
  const _ContentSection({required this.title, required this.icon, required this.children});
  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(title, style: theme.textTheme.titleMedium),
            ]),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  const _BulletItem({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• '),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }
}

class _ScoreChip extends StatelessWidget {
  const _ScoreChip({required this.label, required this.value});
  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${value.toStringAsFixed(0)}%',
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(label, style: theme.textTheme.labelLarge),
      ],
    );
  }
}
