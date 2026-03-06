import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beyou/features/dosha/bloc/dosha_bloc.dart';
import 'package:beyou/features/dosha/bloc/dosha_event_state.dart';
import 'package:beyou/features/dosha/data/dosha_repository.dart';
import 'package:beyou/features/dosha/views/dosha_onboarding_view.dart';
import 'package:beyou/features/dosha/views/dosha_assessment_view.dart';
import 'package:beyou/features/dosha/views/dosha_results_view.dart';
import 'package:beyou/features/dosha/views/dosha_history_view.dart';

/// Main wrapper page for the Dosha feature.
/// Provides a [DoshaBloc] and renders the appropriate sub-view based on state.
class DoshaPage extends StatelessWidget {
  const DoshaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoshaBloc>(
      create: (_) => DoshaBloc(repository: DoshaRepository()),
      child: BlocBuilder<DoshaBloc, DoshaState>(
        builder: (context, state) {
          if (state is DoshaAssessing) {
            return const DoshaAssessmentView();
          }
          if (state is DoshaResults) {
            return const DoshaResultsView();
          }
          if (state is DoshaHistoryState) {
            return const DoshaHistoryView();
          }
          // Default: onboarding
          return const DoshaOnboardingView();
        },
      ),
    );
  }
}
