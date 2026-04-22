import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_bloc.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_event.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_state.dart';
import 'package:beyou/features/ayurveda/data/ayurveda_repository.dart';
import 'package:beyou/features/ayurveda/models/ayurveda_program.dart';
import 'package:beyou/features/ayurveda/pages/program_detail_page.dart';
import 'package:beyou/features/ayurveda/widgets/program_card.dart';
import 'package:beyou/features/dosha/data/dosha_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgramsPage extends StatelessWidget {
  const ProgramsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AyurvedaBloc(
        ayurvedaRepo: getIt<AyurvedaRepository>(),
        doshaRepo: getIt<DoshaRepository>(),
      )..add(AyurvedaStarted()),
      child: const _ProgramsView(),
    );
  }
}

class _ProgramsView extends StatelessWidget {
  const _ProgramsView();

  static const _categories = ProgramCategory.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1F2022),
        elevation: 0,
        title: const Text('Ayurveda Programs', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: BlocBuilder<AyurvedaBloc, AyurvedaState>(
        builder: (context, state) {
          if (state is! AyurvedaLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          return _buildCategoryGroups(context, state.programs);
        },
      ),
    );
  }

  Widget _buildCategoryGroups(BuildContext context, List<AyurvedaProgram> programs) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _categories.map((cat) {
        final catPrograms = programs.where((p) => p.category == cat).toList();
        if (catPrograms.isEmpty) return const SizedBox();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Text(cat.emoji, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Text(
                    cat.label,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            ...catPrograms.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ProgramCard(
                    program: p,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ProgramDetailPage(program: p)),
                    ),
                  ),
                )),
            const SizedBox(height: 4),
          ],
        );
      }).toList(),
    );
  }
}
