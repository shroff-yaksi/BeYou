import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_bloc.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_event.dart';
import 'package:beyou/features/mindfulness/data/mindfulness_repository.dart';
import 'package:beyou/features/mindfulness/models/meditation_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Meditation player.
///
/// We integrate the audioplayers package and feed it the session.audioUrl when
/// available. Without licensed audio in the repo we still need a usable timer
/// experience, so we run a fallback Timer.periodic that mirrors the player's
/// elapsed-time progression and lets the user mark a session complete.
class MeditationPlayerPage extends StatefulWidget {
  final String sessionId;

  const MeditationPlayerPage({super.key, required this.sessionId});

  @override
  State<MeditationPlayerPage> createState() => _MeditationPlayerPageState();
}

class _MeditationPlayerPageState extends State<MeditationPlayerPage> {
  late final MeditationSession _session;
  late final AudioPlayer _player;
  StreamSubscription<Duration>? _posSub;
  Timer? _fallbackTicker;

  Duration _elapsed = Duration.zero;
  late final Duration _total;
  bool _playing = false;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _session = getIt<MindfulnessRepository>().getMeditationById(widget.sessionId)!;
    _total = Duration(minutes: _session.durationMinutes);
    _player = AudioPlayer();
    _posSub = _player.onPositionChanged.listen((p) {
      setState(() => _elapsed = p);
      if (_elapsed >= _total) _markComplete();
    });
  }

  @override
  void dispose() {
    _fallbackTicker?.cancel();
    _posSub?.cancel();
    _player.dispose();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    if (_completed) return;
    if (_playing) {
      _fallbackTicker?.cancel();
      if (_session.audioUrl != null) await _player.pause();
      setState(() => _playing = false);
      return;
    }

    if (_session.audioUrl != null) {
      try {
        await _player.play(UrlSource(_session.audioUrl!));
      } catch (_) {
        _startFallbackTicker();
      }
    } else {
      _startFallbackTicker();
    }
    setState(() => _playing = true);
  }

  void _startFallbackTicker() {
    _fallbackTicker?.cancel();
    _fallbackTicker = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsed += const Duration(seconds: 1));
      if (_elapsed >= _total) _markComplete();
    });
  }

  void _markComplete() {
    if (_completed) return;
    _fallbackTicker?.cancel();
    _player.stop();
    setState(() {
      _completed = true;
      _playing = false;
      _elapsed = _total;
    });
    context.read<MindfulnessBloc>().add(MeditationCompleted(_session.id));
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final progress = _total.inSeconds == 0
        ? 0.0
        : (_elapsed.inSeconds / _total.inSeconds).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: _session.accentColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Text(
                    _session.category.label,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(_session.emoji, style: const TextStyle(fontSize: 88)),
            const SizedBox(height: 28),
            Text(
              _session.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Narrated by ${_session.narrator}',
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: Colors.white.withValues(alpha: 0.25),
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_fmt(_elapsed),
                          style: const TextStyle(color: Colors.white70, fontSize: 12)),
                      Text(_fmt(_total),
                          style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            GestureDetector(
              onTap: _togglePlay,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(
                  _completed
                      ? Icons.check
                      : (_playing ? Icons.pause : Icons.play_arrow),
                  size: 42,
                  color: _session.accentColor,
                ),
              ),
            ),
            const Spacer(),
            if (!_completed)
              TextButton(
                onPressed: _markComplete,
                child: const Text(
                  'Mark complete',
                  style: TextStyle(color: Colors.white70),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text(
                    'Session complete · streak updated',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
