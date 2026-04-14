import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/features/dosha/bloc/dosha_bloc.dart';
import 'package:beyou/features/dosha/bloc/dosha_event_state.dart';
import 'package:beyou/features/dosha/models/assessment_option.dart';
import 'package:beyou/features/dosha/models/assessment_question.dart';

class DoshaAssessmentView extends StatelessWidget {
  const DoshaAssessmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoshaBloc, DoshaState>(
      buildWhen: (prev, curr) => curr is DoshaAssessing,
      builder: (context, state) {
        if (state is! DoshaAssessing) return const SizedBox.shrink();

        final question = state.currentQuestion;
        final selectedOption = state.selectedOption;

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
                        onTap: () => context.read<DoshaBloc>().add(const DoshaRestarted()),
                        child: const Icon(Icons.close, color: ColorConstants.textBlack),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Assessment • ${state.participantName}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.textBlack,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.read<DoshaBloc>().add(const DoshaRestarted()),
                        child: const Icon(Icons.refresh, color: ColorConstants.primaryColor),
                      ),
                    ],
                  ),
                ),

                // Progress section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Question ${state.progressLabel}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.textBlack,
                            ),
                          ),
                          Text(
                            '${(state.progressValue * 100).toInt()}% Complete',
                            style: const TextStyle(
                              fontSize: 12,
                              color: ColorConstants.textGrey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: state.progressValue,
                          minHeight: 6,
                          backgroundColor: ColorConstants.primaryColor.withValues(alpha: 0.12),
                          color: ColorConstants.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: ColorConstants.primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            question.category.label,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          question.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.textBlack,
                            height: 1.3,
                          ),
                        ),
                        if (question.helper != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            question.helper!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: ColorConstants.textGrey,
                            ),
                          ),
                        ],
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.separated(
                            itemCount: question.options.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final option = question.options[index];
                              final isSelected = selectedOption == option;
                              return _OptionCard(
                                option: option,
                                isSelected: isSelected,
                                onTap: () => context.read<DoshaBloc>().add(DoshaOptionSelected(option)),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Navigation buttons
                        Row(
                          children: [
                            OutlinedButton.icon(
                              onPressed: state.isOnFirstQuestion
                                  ? null
                                  : () => context.read<DoshaBloc>().add(const DoshaPreviousPressed()),
                              icon: const Icon(Icons.chevron_left),
                              label: const Text('Previous'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: ColorConstants.primaryColor,
                                side: const BorderSide(color: ColorConstants.primaryColor),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: selectedOption == null
                                    ? null
                                    : () => context.read<DoshaBloc>().add(const DoshaNextPressed()),
                                icon: Icon(
                                  state.isOnLastQuestion ? Icons.insights : Icons.chevron_right,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  state.isOnLastQuestion ? 'View Results' : 'Next Question',
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstants.primaryColor,
                                  disabledBackgroundColor: ColorConstants.disabledColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
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
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final AssessmentOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? ColorConstants.primaryColor.withValues(alpha: 0.08)
          : ColorConstants.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? ColorConstants.primaryColor : ColorConstants.textFieldBorder.withValues(alpha: 0.4),
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: isSelected ? ColorConstants.primaryColor : ColorConstants.grey,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.label,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: ColorConstants.textBlack,
                      ),
                    ),
                    if (option.description != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          option.description!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: ColorConstants.textGrey,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
