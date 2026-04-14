import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/features/dosha/bloc/dosha_bloc.dart';
import 'package:beyou/features/dosha/bloc/dosha_event_state.dart';
import 'package:beyou/features/dosha/models/dosha_type.dart';

class DoshaResultsView extends StatelessWidget {
  const DoshaResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoshaBloc, DoshaState>(
      buildWhen: (prev, curr) => curr is DoshaResults,
      builder: (context, state) {
        if (state is! DoshaResults) return const SizedBox.shrink();

        final primaryColor = _doshaColor(state.primaryDoshaLabel);

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
                      Expanded(
                        child: Text(
                          'Results • ${state.participantName}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.read<DoshaBloc>().add(const DoshaHistoryLoaded()),
                        child: const Icon(Icons.history, color: ColorConstants.primaryColor),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Primary dosha hero card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: primaryColor.withValues(alpha: 0.3)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.auto_awesome, color: primaryColor, size: 40),
                              const SizedBox(height: 12),
                              Text(
                                '${state.primaryDoshaLabel} dominant constitution',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Primary dosha balance defines your creative energy and movement.',
                                style: TextStyle(fontSize: 13, color: ColorConstants.textGrey),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: state.sortedScores.map((entry) {
                                  return Column(
                                    children: [
                                      Text(
                                        '${entry.value.toStringAsFixed(0)}%',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: _doshaColor(entry.key),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        entry.key,
                                        style: const TextStyle(fontSize: 12, color: ColorConstants.textGrey),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Distribution chart
                        _buildCard(
                          icon: Icons.analytics,
                          title: 'Dosha Distribution',
                          child: Column(
                            children: state.sortedScores.map((entry) {
                              final color = _doshaColor(entry.key);
                              final subtitle = _doshaSubtitle(entry.key);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${ entry.key} ($subtitle)',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: ColorConstants.textBlack,
                                          ),
                                        ),
                                        Text(
                                          '${entry.value.toStringAsFixed(0)}%',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: color,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: LinearProgressIndicator(
                                        value: entry.value / 100,
                                        minHeight: 8,
                                        backgroundColor: color.withValues(alpha: 0.15),
                                        valueColor: AlwaysStoppedAnimation<Color>(color),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Key traits
                        _buildCard(
                          icon: Icons.bolt,
                          title: 'Key Traits',
                          child: Column(
                            children: state.primaryTraits.map((t) => _BulletItem(text: t)).toList(),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Recommendations
                        _buildCard(
                          icon: Icons.self_improvement,
                          title: 'Recommendations',
                          child: Column(
                            children: state.recommendations.map((r) => _BulletItem(text: r)).toList(),
                          ),
                        ),

                        const SizedBox(height: 24),

                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => context.read<DoshaBloc>().add(const DoshaHistoryLoaded()),
                                icon: const Icon(Icons.history),
                                label: const Text('View History'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: ColorConstants.primaryColor,
                                  side: const BorderSide(color: ColorConstants.primaryColor),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => context.read<DoshaBloc>().add(const DoshaRestarted()),
                                icon: const Icon(Icons.replay, color: Colors.white),
                                label: const Text('Retake', style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstants.primaryColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard({required IconData icon, required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textBlack.withValues(alpha: 0.08),
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
              Icon(icon, color: ColorConstants.primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.textBlack,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Color _doshaColor(String label) {
    for (final type in DoshaType.values) {
      if (type.label == label) return type.accentColor;
    }
    return Colors.blueGrey;
  }

  String _doshaSubtitle(String label) {
    switch (label) {
      case 'Vata':
        return 'Air & Ether';
      case 'Pitta':
        return 'Fire & Water';
      case 'Kapha':
        return 'Earth & Water';
      default:
        return '';
    }
  }
}

class _BulletItem extends StatelessWidget {
  const _BulletItem({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.circle, size: 6, color: ColorConstants.primaryColor),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: ColorConstants.textBlack, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
