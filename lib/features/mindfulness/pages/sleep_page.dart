import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/features/mindfulness/data/mindfulness_repository.dart';
import 'package:beyou/features/mindfulness/models/sleep_content.dart';
import 'package:flutter/material.dart';

class SleepPage extends StatefulWidget {
  const SleepPage({super.key});

  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  int _sleepTimerMinutes = 0;

  static const _timerOptions = [0, 10, 20, 30, 45, 60];

  @override
  Widget build(BuildContext context) {
    final repo = getIt<MindfulnessRepository>();
    final stories = repo.getSleepByType(SleepContentType.story);
    final sounds = repo.getSleepByType(SleepContentType.soundscape);
    final music = repo.getSleepByType(SleepContentType.music);
    final meditations = repo.getSleepByType(SleepContentType.meditation);

    return Scaffold(
      backgroundColor: const Color(0xFF15192E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF15192E),
        foregroundColor: Colors.white,
        title: const Text('Sleep'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _sleepTimerCard(),
          const SizedBox(height: 26),
          _section('Sleep Stories', '📖', stories),
          const SizedBox(height: 26),
          _section('Ambient Sounds', '🌧️', sounds),
          const SizedBox(height: 26),
          _section('Sleep Music', '🎵', music),
          const SizedBox(height: 26),
          _section('Sleep Meditations', '🌙', meditations),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sleepTimerCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('⏰', style: TextStyle(fontSize: 22)),
              SizedBox(width: 10),
              Text(
                'Sleep timer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            _sleepTimerMinutes == 0
                ? 'Audio plays until session ends'
                : 'Auto-stop after $_sleepTimerMinutes min',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _timerOptions
                .map((m) => GestureDetector(
                      onTap: () => setState(() => _sleepTimerMinutes = m),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: _sleepTimerMinutes == m
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          m == 0 ? 'Off' : '$m min',
                          style: TextStyle(
                            color: _sleepTimerMinutes == m
                                ? const Color(0xFF15192E)
                                : Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, String emoji, List<SleepContent> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...items.map((c) => _sleepTile(c)),
      ],
    );
  }

  Widget _sleepTile(SleepContent c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text(c.emoji, style: const TextStyle(fontSize: 24))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${c.durationMinutes} min · ${c.narrator}',
                  style: const TextStyle(color: Colors.white60, fontSize: 11),
                ),
                const SizedBox(height: 4),
                Text(
                  c.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _sleepTimerMinutes == 0
                        ? 'Playing "${c.title}"'
                        : 'Playing "${c.title}" — auto-stop in $_sleepTimerMinutes min',
                  ),
                  backgroundColor: ColorConstants.primaryColor,
                ),
              );
            },
            icon: const Icon(Icons.play_circle_fill, color: Colors.white, size: 36),
          ),
        ],
      ),
    );
  }
}
