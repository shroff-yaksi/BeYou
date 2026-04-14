import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/features/dosha/bloc/dosha_bloc.dart';
import 'package:beyou/features/dosha/bloc/dosha_event_state.dart';
import 'package:beyou/features/dosha/models/dosha_type.dart';

class DoshaHistoryView extends StatelessWidget {
  const DoshaHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoshaBloc, DoshaState>(
      buildWhen: (prev, curr) => curr is DoshaHistoryState,
      builder: (context, state) {
        if (state is! DoshaHistoryState) return const SizedBox.shrink();

        return Scaffold(
          backgroundColor: ColorConstants.homeBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.read<DoshaBloc>().add(const DoshaBackToHome()),
                        child: const Icon(Icons.arrow_back, color: ColorConstants.textBlack),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Assessment History',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _confirmClear(context),
                        child: const Icon(Icons.delete_outline, color: ColorConstants.errorColor),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: state.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: ColorConstants.primaryColor),
                        )
                      : state.history.isEmpty
                          ? _EmptyHistory()
                          : ListView.separated(
                              padding: const EdgeInsets.all(16),
                              itemCount: state.history.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final result = state.history[index];
                                final dominant = result.dominantDosha();
                                final dominantColor = _doshaColor(dominant);
                                final timestamp = _formatTimestamp(result.timestamp);

                                return Material(
                                  color: ColorConstants.white,
                                  borderRadius: BorderRadius.circular(14),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(14),
                                    onTap: () => context.read<DoshaBloc>().add(DoshaHistoryResultTapped(result)),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorConstants.textBlack.withValues(alpha: 0.07),
                                            blurRadius: 5,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  result.participantName,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: ColorConstants.textBlack,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                timestamp,
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  color: ColorConstants.textGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            'View Details',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: ColorConstants.primaryColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 6,
                                            children: result.doshaPercentages.entries.map((e) {
                                              final c = _doshaColor(e.key);
                                              return Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: c.withValues(alpha: 0.1),
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  '${e.key}: ${e.value.toStringAsFixed(0)}%',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: c,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                'Dominant dosha: ',
                                                style: const TextStyle(fontSize: 13, color: ColorConstants.textGrey),
                                              ),
                                              Text(
                                                dominant,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: dominantColor,
                                                ),
                                              ),
                                              const Spacer(),
                                              const Icon(Icons.chevron_right, color: ColorConstants.grey, size: 18),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ],
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

  String _formatTimestamp(DateTime timestamp) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final date = '${months[timestamp.month - 1]} ${timestamp.day}, ${timestamp.year}';
    final hour = timestamp.hour;
    final min = timestamp.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$date • ${displayHour.toString().padLeft(2, '0')}:$min $period';
  }

  void _confirmClear(BuildContext context) async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Clear history?'),
            content: const Text('This will remove all saved assessments. This action cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: ColorConstants.errorColor),
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Clear'),
              ),
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
  const _EmptyHistory();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.spa_outlined, size: 40, color: ColorConstants.primaryColor),
          ),
          const SizedBox(height: 20),
          const Text(
            'No assessments yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorConstants.textBlack),
          ),
          const SizedBox(height: 8),
          const Text(
            'Complete an assessment to see history here.',
            style: TextStyle(fontSize: 14, color: ColorConstants.textGrey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
