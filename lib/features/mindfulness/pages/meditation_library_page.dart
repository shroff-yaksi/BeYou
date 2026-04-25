import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_bloc.dart';
import 'package:beyou/features/mindfulness/data/mindfulness_repository.dart';
import 'package:beyou/features/mindfulness/models/meditation_session.dart';
import 'package:beyou/features/mindfulness/pages/meditation_player_page.dart';
import 'package:beyou/features/mindfulness/widgets/meditation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeditationLibraryPage extends StatefulWidget {
  const MeditationLibraryPage({super.key});

  @override
  State<MeditationLibraryPage> createState() => _MeditationLibraryPageState();
}

class _MeditationLibraryPageState extends State<MeditationLibraryPage> {
  MeditationCategory? _filter;

  @override
  Widget build(BuildContext context) {
    final repo = getIt<MindfulnessRepository>();
    final all = _filter == null
        ? repo.getAllMeditations()
        : repo.getMeditationsByCategory(_filter!);

    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        title: const Text('Meditation Library'),
        backgroundColor: ColorConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _chip('All', _filter == null, () => setState(() => _filter = null)),
                for (final c in MeditationCategory.values)
                  _chip(
                    '${c.emoji} ${c.label}',
                    _filter == c,
                    () => setState(() => _filter = c),
                  ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: all.length,
              itemBuilder: (context, i) => MeditationCard(
                session: all[i],
                wide: true,
                onTap: () => _open(context, all[i].id),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, bool active, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: active ? ColorConstants.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: ColorConstants.primaryColor.withValues(alpha: 0.3)),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: active ? Colors.white : ColorConstants.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  void _open(BuildContext context, String id) {
    final bloc = context.read<MindfulnessBloc>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: bloc,
          child: MeditationPlayerPage(sessionId: id),
        ),
      ),
    );
  }
}
