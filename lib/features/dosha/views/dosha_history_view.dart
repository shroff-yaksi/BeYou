import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beyou/features/dosha/bloc/dosha_bloc.dart';
import 'package:beyou/features/dosha/bloc/dosha_event_state.dart';

class DoshaHistoryView extends StatelessWidget {
  const DoshaHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<DoshaBloc, DoshaState>(
      buildWhen: (prev, curr) => curr is DoshaHistoryState,
      builder: (context, state) {
        if (state is! DoshaHistoryState) return const SizedBox.shrink();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Assessment History'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.read<DoshaBloc>().add(const DoshaBackToHome()),
            ),
            actions: [
              IconButton(
                tooltip: 'Clear history',
                onPressed: () => _confirmClear(context),
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
          body: SafeArea(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.history.isEmpty
                    ? _EmptyHistory(theme: theme)
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.history.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final result = state.history[index];
                          final dominant = result.dominantDosha();
                          final timestamp = _formatTimestamp(result.timestamp);
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () => context.read<DoshaBloc>().add(DoshaHistoryResultTapped(result)),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(result.participantName, style: theme.textTheme.titleMedium),
                                        Text(timestamp, style: theme.textTheme.bodySmall),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Wrap(
                                      spacing: 12,
                                      runSpacing: 8,
                                      children: result.doshaPercentages.entries
                                          .map((e) => Chip(label: Text('${e.key}: ${e.value.toStringAsFixed(0)}%')))
                                          .toList(),
                                    ),
                                    const SizedBox(height: 12),
                                    Text('Dominant dosha: $dominant', style: theme.textTheme.labelLarge),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        );
      },
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final date = '${timestamp.day.toString().padLeft(2, '0')}/'
        '${timestamp.month.toString().padLeft(2, '0')}/'
        '${timestamp.year}';
    final time = '${timestamp.hour.toString().padLeft(2, '0')}:'
        '${timestamp.minute.toString().padLeft(2, '0')}';
    return '$date $time';
  }

  void _confirmClear(BuildContext context) async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Clear history?'),
            content: const Text('This will remove all saved assessments. This action cannot be undone.'),
            actions: [
              TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
              FilledButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Clear')),
            ],
          ),
        ) ??
        false;
    if (confirmed && context.mounted) {
      context.read<DoshaBloc>().add(const DoshaHistoryCleared());
    }
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.spa_outlined, size: 80, color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          const Text('No assessments yet', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text(
            'Complete an assessment to see history here.',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
