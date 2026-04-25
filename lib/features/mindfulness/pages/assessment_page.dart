import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/features/mindfulness/data/mindfulness_repository.dart';
import 'package:beyou/features/mindfulness/models/mental_health.dart';
import 'package:flutter/material.dart';

class AssessmentPage extends StatefulWidget {
  final AssessmentType type;
  const AssessmentPage({super.key, required this.type});

  @override
  State<AssessmentPage> createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  late final MentalHealthAssessment _assessment;
  final List<int> _answers = [];
  int _q = 0;

  @override
  void initState() {
    super.initState();
    _assessment = getIt<MindfulnessRepository>().getAssessment(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    if (_q >= _assessment.questions.length) {
      final result = _assessment.score(_answers);
      return _resultView(result);
    }
    final q = _assessment.questions[_q];
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        title: Text(widget.type.label),
        backgroundColor: const Color(0xFF52C78A),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (_q + 1) / _assessment.questions.length,
              backgroundColor: const Color(0xFFEDEDED),
              color: const Color(0xFF52C78A),
            ),
            const SizedBox(height: 8),
            Text(
              'Question ${_q + 1} of ${_assessment.questions.length}',
              style: const TextStyle(color: Color(0xFF8F98A3), fontSize: 12),
            ),
            const SizedBox(height: 24),
            Text(
              q.text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, height: 1.3),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                itemCount: q.options.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _answers.add(q.scores[i]);
                      _q++;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFEDEDED)),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text(q.options[i])),
                        const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF8F98A3)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultView(AssessmentResult result) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        title: const Text('Your result'),
        backgroundColor: const Color(0xFF52C78A),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF52C78A), Color(0xFF27AE60)],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Score',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  Text(
                    '${result.score}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 56,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    result.severity,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'What this means',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(result.guidance, style: const TextStyle(height: 1.5)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Note: This is a screening tool, not a diagnosis. Please consult a qualified '
                'mental health professional for clinical assessment.',
                style: TextStyle(fontSize: 11, color: Color(0xFF6E6A52)),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF52C78A),
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text('Done', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}
