import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beyou/features/dosha/bloc/dosha_bloc.dart';
import 'package:beyou/features/dosha/bloc/dosha_event_state.dart';
import 'package:beyou/features/dosha/models/assessment_option.dart';
import 'package:beyou/features/dosha/models/assessment_question.dart';

class DoshaAssessmentView extends StatelessWidget {
  const DoshaAssessmentView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<DoshaBloc, DoshaState>(
      buildWhen: (prev, curr) => curr is DoshaAssessing,
      builder: (context, state) {
        if (state is! DoshaAssessing) return const SizedBox.shrink();

        final question = state.currentQuestion;
        final selectedOption = state.selectedOption;

        return Scaffold(
          appBar: AppBar(
            title: Text('Assessment • ${state.participantName}'),
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => context.read<DoshaBloc>().add(const DoshaRestarted()),
            ),
            actions: [
              IconButton(
                tooltip: 'Restart assessment',
                onPressed: () => context.read<DoshaBloc>().add(const DoshaRestarted()),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${state.progressLabel}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: state.progressValue,
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      question.category.label,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    question.title,
                    style: theme.textTheme.headlineSmall,
                  ),
                  if (question.helper != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      question.helper!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      itemCount: question.options.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
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
                  Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: state.isOnFirstQuestion
                            ? null
                            : () => context.read<DoshaBloc>().add(const DoshaPreviousPressed()),
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Previous'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: selectedOption == null
                              ? null
                              : () => context.read<DoshaBloc>().add(const DoshaNextPressed()),
                          icon: Icon(
                            state.isOnLastQuestion ? Icons.insights : Icons.arrow_forward,
                          ),
                          label: Text(
                            state.isOnLastQuestion ? 'View Results' : 'Next Question',
                          ),
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
    final theme = Theme.of(context);
    return Material(
      color: isSelected ? theme.colorScheme.primaryContainer : theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? theme.colorScheme.primary : theme.dividerColor,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: isSelected ? theme.colorScheme.primary : theme.hintColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.label,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                    if (option.description != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          option.description!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.hintColor,
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
