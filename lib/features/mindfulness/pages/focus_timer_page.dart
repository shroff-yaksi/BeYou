import 'dart:async';

import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_bloc.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_event.dart';
import 'package:beyou/features/mindfulness/models/focus_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class FocusTimerPage extends StatefulWidget {
  const FocusTimerPage({super.key});

  @override
  State<FocusTimerPage> createState() => _FocusTimerPageState();
}

class _FocusTimerPageState extends State<FocusTimerPage> {
  FocusPreset _preset = FocusPreset.classic;
  late Duration _remaining;
  bool _running = false;
  bool _onBreak = false;
  int _completedPomodoros = 0;
  Timer? _timer;
  final TextEditingController _taskCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _remaining = Duration(minutes: _preset.focusMinutes);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _taskCtrl.dispose();
    super.dispose();
  }

  void _selectPreset(FocusPreset p) {
    if (_running) return;
    setState(() {
      _preset = p;
      _onBreak = false;
      _remaining = Duration(minutes: p.focusMinutes);
    });
  }

  void _toggle() {
    if (_running) {
      _timer?.cancel();
      setState(() => _running = false);
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() => _remaining -= const Duration(seconds: 1));
        if (_remaining.inSeconds <= 0) _onPhaseEnd();
      });
      setState(() => _running = true);
    }
  }

  void _onPhaseEnd() {
    _timer?.cancel();
    if (!_onBreak) {
      _completedPomodoros++;
      _logSession();
      setState(() {
        _onBreak = true;
        _remaining = Duration(minutes: _preset.breakMinutes);
        _running = false;
      });
      _showFlash('Pomodoro complete · take a ${_preset.breakMinutes} min break');
    } else {
      setState(() {
        _onBreak = false;
        _remaining = Duration(minutes: _preset.focusMinutes);
        _running = false;
      });
      _showFlash('Break over · ready for the next focus block');
    }
  }

  void _logSession() {
    context.read<MindfulnessBloc>().add(FocusSessionLogged(
          FocusSession(
            id: const Uuid().v4(),
            startedAt: DateTime.now(),
            focusMinutes: _preset.focusMinutes,
            completedPomodoros: 1,
            task: _taskCtrl.text.trim().isEmpty ? null : _taskCtrl.text.trim(),
          ),
        ));
  }

  void _showFlash(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: ColorConstants.primaryColor),
    );
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _onBreak = false;
      _running = false;
      _remaining = Duration(minutes: _preset.focusMinutes);
    });
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final totalSec = _onBreak
        ? _preset.breakMinutes * 60
        : _preset.focusMinutes * 60;
    final progress = totalSec == 0 ? 0.0 : _remaining.inSeconds / totalSec;

    return Scaffold(
      backgroundColor: _onBreak ? const Color(0xFF52C78A) : ColorConstants.primaryColor,
      appBar: AppBar(
        title: const Text('Focus Timer'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: FocusPreset.values
                      .where((p) => p != FocusPreset.custom)
                      .map((p) => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () => _selectPreset(p),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: _preset == p
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${p.label} · ${p.focusMinutes}/${p.breakMinutes}',
                                  style: TextStyle(
                                    color: _preset == p
                                        ? ColorConstants.primaryColor
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 240,
                height: 240,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox.expand(
                      child: CircularProgressIndicator(
                        value: 1 - progress,
                        strokeWidth: 10,
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _onBreak ? 'BREAK' : 'FOCUS',
                          style: const TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _fmt(_remaining),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 56,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$_completedPomodoros completed today',
                          style: const TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              TextField(
                controller: _taskCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'What are you focusing on?',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _running ? null : _reset,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Colors.white70),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Reset', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _toggle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: ColorConstants.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        _running ? 'Pause' : 'Start',
                        style: const TextStyle(fontWeight: FontWeight.w800),
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
  }
}
