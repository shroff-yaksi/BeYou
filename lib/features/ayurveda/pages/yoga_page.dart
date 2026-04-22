import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_bloc.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_event.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_state.dart';
import 'package:beyou/features/ayurveda/data/ayurveda_repository.dart';
import 'package:beyou/features/ayurveda/models/yoga_session.dart';
import 'package:beyou/features/ayurveda/pages/yoga_session_page.dart';
import 'package:beyou/features/dosha/data/dosha_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YogaPage extends StatelessWidget {
  const YogaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AyurvedaBloc(
        ayurvedaRepo: getIt<AyurvedaRepository>(),
        doshaRepo: getIt<DoshaRepository>(),
      )..add(AyurvedaStarted()),
      child: const _YogaView(),
    );
  }
}

class _YogaView extends StatelessWidget {
  const _YogaView();

  static const _styles = YogaStyle.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1F2022),
        elevation: 0,
        title: const Text('Yoga', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: BlocBuilder<AyurvedaBloc, AyurvedaState>(
        builder: (context, state) {
          if (state is! AyurvedaLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              _buildFilterRow(context, state),
              Expanded(child: _buildSessionGrid(context, state.yogaSessions)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterRow(BuildContext context, AyurvedaLoaded state) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _FilterChip(
              label: 'All',
              selected: state.activeYogaFilter == null,
              onTap: () => context.read<AyurvedaBloc>().add(AyurvedaYogaFilterChanged(null)),
            ),
            ..._styles.map((style) => Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: _FilterChip(
                    label: style.label,
                    selected: state.activeYogaFilter == style,
                    onTap: () =>
                        context.read<AyurvedaBloc>().add(AyurvedaYogaFilterChanged(style)),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionGrid(BuildContext context, List<YogaSession> sessions) {
    if (sessions.isEmpty) {
      return const Center(child: Text('No sessions found'));
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: sessions.length,
      itemBuilder: (context, i) {
        final session = sessions[i];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => YogaSessionPage(session: session)),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorConstants.primaryColor.withValues(alpha: 0.85),
                  ColorConstants.primaryColor.withValues(alpha: 0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(session.emoji, style: const TextStyle(fontSize: 28)),
                const Spacer(),
                Text(
                  session.title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${session.durationMinutes} min · ${session.level.label}',
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    session.style.label,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? ColorConstants.primaryColor : const Color(0xFFF3F1FF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xFF6358E1),
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
