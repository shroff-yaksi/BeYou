import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beyou/features/dosha/bloc/dosha_bloc.dart';
import 'package:beyou/features/dosha/bloc/dosha_event_state.dart';

class DoshaOnboardingView extends StatefulWidget {
  const DoshaOnboardingView({super.key});

  @override
  State<DoshaOnboardingView> createState() => _DoshaOnboardingViewState();
}

class _DoshaOnboardingViewState extends State<DoshaOnboardingView> {
  final _nameController = TextEditingController();
  bool _showError = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startAssessment() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() => _showError = true);
      return;
    }
    setState(() => _showError = false);
    context.read<DoshaBloc>().add(DoshaStarted(name));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dosha Assessment'),
        actions: [
          IconButton(
            onPressed: () => context.read<DoshaBloc>().add(const DoshaHistoryLoaded()),
            icon: const Icon(Icons.history),
            tooltip: 'History',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header icon
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.spa,
                    size: 40,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Ayurvedic Prakriti Assessment',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Discover the dominant dosha for yourself or a loved one through a guided questionnaire rooted in traditional Ayurvedic principles.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '21 questions across Physical, Mental, Lifestyle & Environmental categories.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Participant name',
                  hintText: 'e.g. Ananya Sharma',
                  errorText: _showError ? 'Please enter a name to begin' : null,
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                textInputAction: TextInputAction.done,
                onChanged: (_) {
                  if (_showError) setState(() => _showError = false);
                },
                onSubmitted: (_) => _startAssessment(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _startAssessment,
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Start Assessment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
