import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_bloc.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_event.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_state.dart';
import 'package:beyou/features/ayurveda/data/ayurveda_repository.dart';
import 'package:beyou/features/ayurveda/models/pranayama_technique.dart';
import 'package:beyou/features/ayurveda/pages/pranayama_guide_page.dart';
import 'package:beyou/features/dosha/data/dosha_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PranayamaPage extends StatelessWidget {
  const PranayamaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AyurvedaBloc(
        ayurvedaRepo: getIt<AyurvedaRepository>(),
        doshaRepo: getIt<DoshaRepository>(),
      )..add(AyurvedaStarted()),
      child: const _PranayamaView(),
    );
  }
}

class _PranayamaView extends StatelessWidget {
  const _PranayamaView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1F2022),
        elevation: 0,
        title: const Text('Pranayama & Breathing', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: BlocBuilder<AyurvedaBloc, AyurvedaState>(
        builder: (context, state) {
          if (state is! AyurvedaLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.pranayamaTechniques.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final t = state.pranayamaTechniques[i];
              return _PranayamaListTile(
                technique: t,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PranayamaGuidePage(technique: t)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _PranayamaListTile extends StatelessWidget {
  final PranayamaTechnique technique;
  final VoidCallback onTap;

  const _PranayamaListTile({required this.technique, required this.onTap});

  Color get _difficultyColor {
    switch (technique.difficulty) {
      case 'Beginner':
        return const Color(0xFF4CAF50);
      case 'Intermediate':
        return const Color(0xFFFF9800);
      case 'Advanced':
        return const Color(0xFFE53935);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(technique.emoji, style: const TextStyle(fontSize: 26)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    technique.name,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    technique.sanskritName,
                    style: const TextStyle(
                        color: Color(0xFF8F98A3), fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: _difficultyColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          technique.difficulty,
                          style: TextStyle(
                              color: _difficultyColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${technique.cyclesPerSession} cycles',
                        style: const TextStyle(color: Color(0xFF8F98A3), fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFFB6BDC6)),
          ],
        ),
      ),
    );
  }
}
