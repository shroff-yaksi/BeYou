import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beyou/core/constants/color_constants.dart';
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
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Dosha Assessment',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => context.read<DoshaBloc>().add(const DoshaHistoryLoaded()),
                    icon: const Icon(Icons.history, color: ColorConstants.primaryColor),
                    tooltip: 'History',
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero icon
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(
                          Icons.self_improvement,
                          size: 52,
                          color: ColorConstants.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    const Text(
                      'Ayurvedic Prakriti Assessment',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.textBlack,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Discover the dominant dosha for yourself or a loved one through a guided questionnaire rooted in traditional Ayurvedic principles.',
                      style: TextStyle(
                        fontSize: 15,
                        color: ColorConstants.textGrey,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: ColorConstants.primaryColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '21 questions across Physical, Mental, Lifestyle & Environmental categories.',
                        style: TextStyle(
                          fontSize: 13,
                          color: ColorConstants.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Name input
                    const Text(
                      'Participant name',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.textGrey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.textFieldBackground,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _showError
                              ? ColorConstants.errorColor
                              : ColorConstants.textFieldBorder.withValues(alpha: 0.4),
                        ),
                      ),
                      child: TextField(
                        controller: _nameController,
                        style: const TextStyle(fontSize: 16, color: ColorConstants.textBlack),
                        decoration: InputDecoration(
                          hintText: 'e.g. Ananya Sharma',
                          hintStyle: const TextStyle(color: ColorConstants.grey),
                          prefixIcon: const Icon(Icons.person_outline, color: ColorConstants.grey),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                          errorText: _showError ? 'Please enter a name to begin' : null,
                        ),
                        textInputAction: TextInputAction.done,
                        onChanged: (_) {
                          if (_showError) setState(() => _showError = false);
                        },
                        onSubmitted: (_) => _startAssessment(),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Start button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: _startAssessment,
                        icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
                        label: const Text(
                          'Start Assessment',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
