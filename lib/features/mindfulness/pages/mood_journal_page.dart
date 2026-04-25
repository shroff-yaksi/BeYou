import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_bloc.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_event.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_state.dart';
import 'package:beyou/features/mindfulness/models/mood_entry.dart';
import 'package:beyou/features/mindfulness/pages/mood_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class MoodJournalPage extends StatefulWidget {
  const MoodJournalPage({super.key});

  @override
  State<MoodJournalPage> createState() => _MoodJournalPageState();
}

class _MoodJournalPageState extends State<MoodJournalPage> {
  MoodLevel? _mood;
  final Set<String> _emotions = {};
  final TextEditingController _gratitudeCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();

  @override
  void dispose() {
    _gratitudeCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_mood == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Pick a mood first')));
      return;
    }
    final entry = MoodEntry(
      id: const Uuid().v4(),
      timestamp: DateTime.now(),
      mood: _mood!,
      emotions: _emotions.toList(),
      gratitude: _gratitudeCtrl.text.trim().isEmpty ? null : _gratitudeCtrl.text.trim(),
      note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
    );
    context.read<MindfulnessBloc>().add(MoodEntryAdded(entry));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Mood saved'),
        backgroundColor: ColorConstants.primaryColor,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        title: const Text('Mood Check-in'),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              final bloc = context.read<MindfulnessBloc>();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      BlocProvider.value(value: bloc, child: const MoodHistoryPage()),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'How are you feeling?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: MoodLevel.values
                .map((m) => GestureDetector(
                      onTap: () => setState(() => _mood = m),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _mood == m
                              ? m.color.withValues(alpha: 0.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: _mood == m ? m.color : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(m.emoji, style: const TextStyle(fontSize: 32)),
                            const SizedBox(height: 4),
                            Text(
                              m.label,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _mood == m ? m.color : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 28),
          const Text(
            'Tag your emotions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: kEmotionWheel.map((e) {
              final selected = _emotions.contains(e);
              return GestureDetector(
                onTap: () => setState(() {
                  selected ? _emotions.remove(e) : _emotions.add(e);
                }),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: selected
                        ? ColorConstants.primaryColor
                        : ColorConstants.primaryColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    e,
                    style: TextStyle(
                      color: selected ? Colors.white : ColorConstants.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 28),
          const Text(
            'Today I am grateful for',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _gratitudeCtrl,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'A small thing, a person, a moment...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Free writing',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _noteCtrl,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Stays private and on-device.',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _save,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE91E63),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            child: const Text('Save check-in', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 12),
          BlocBuilder<MindfulnessBloc, MindfulnessState>(
            builder: (context, state) {
              if (state is! MindfulnessLoaded || state.moodEntries.isEmpty) {
                return const SizedBox.shrink();
              }
              return Center(
                child: Text(
                  '${state.moodEntries.length} entries logged',
                  style: const TextStyle(color: Color(0xFF8F98A3), fontSize: 12),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
