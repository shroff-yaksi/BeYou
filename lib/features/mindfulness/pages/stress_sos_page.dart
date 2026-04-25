import 'dart:async';

import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/features/mindfulness/data/mindfulness_repository.dart';
import 'package:beyou/features/mindfulness/models/sos_session.dart';
import 'package:flutter/material.dart';

class StressSosPage extends StatelessWidget {
  const StressSosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessions = getIt<MindfulnessRepository>().getAllSosSessions();
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        title: const Text('Stress SOS'),
        backgroundColor: const Color(0xFFFF7043),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'You\'re here. That\'s the first step.',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 4),
          const Text(
            'Pick any session below — they\'re short and do not require headphones.',
            style: TextStyle(color: Color(0xFF8F98A3), fontSize: 13),
          ),
          const SizedBox(height: 20),
          ...sessions.map((s) => _sosCard(context, s)),
        ],
      ),
    );
  }

  Widget _sosCard(BuildContext context, SosSession s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(s.technique.emoji, style: const TextStyle(fontSize: 30)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.title,
                      style:
                          const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    Text(
                      '${s.durationMinutes} min · ${s.technique.label}',
                      style: const TextStyle(color: Color(0xFF8F98A3), fontSize: 11),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => _runSession(context, s),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7043),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                ),
                child: const Text('Start'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            s.description,
            style: const TextStyle(color: Color(0xFF8F98A3), fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _runSession(BuildContext context, SosSession s) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _SosRunSheet(session: s),
    );
  }
}

class _SosRunSheet extends StatefulWidget {
  final SosSession session;
  const _SosRunSheet({required this.session});

  @override
  State<_SosRunSheet> createState() => _SosRunSheetState();
}

class _SosRunSheetState extends State<_SosRunSheet> {
  int _stepIndex = 0;
  late Duration _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = Duration(minutes: widget.session.durationMinutes);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() => _remaining -= const Duration(seconds: 1));
      if (_remaining.inSeconds <= 0) t.cancel();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _next() {
    if (_stepIndex < widget.session.steps.length - 1) {
      setState(() => _stepIndex++);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = widget.session.steps[_stepIndex];
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFFFF7043),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              widget.session.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Step ${_stepIndex + 1} of ${widget.session.steps.length}',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                step,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.4),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _next,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFFF7043),
                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
              ),
              child: Text(
                _stepIndex == widget.session.steps.length - 1 ? 'Done' : 'Next',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
