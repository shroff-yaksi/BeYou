import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_bloc.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_event.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_state.dart';
import 'package:beyou/features/ayurveda/data/ayurveda_repository.dart';
import 'package:beyou/features/ayurveda/pages/dinacharya_page.dart';
import 'package:beyou/features/ayurveda/pages/dosha_profile_page.dart';
import 'package:beyou/features/ayurveda/pages/pranayama_guide_page.dart';
import 'package:beyou/features/ayurveda/pages/pranayama_page.dart';
import 'package:beyou/features/ayurveda/pages/program_detail_page.dart';
import 'package:beyou/features/ayurveda/pages/programs_page.dart';
import 'package:beyou/features/ayurveda/pages/remedies_page.dart';
import 'package:beyou/features/ayurveda/pages/ritucharya_page.dart';
import 'package:beyou/features/ayurveda/pages/yoga_page.dart';
import 'package:beyou/features/ayurveda/pages/yoga_session_page.dart';
import 'package:beyou/features/ayurveda/widgets/pranayama_card.dart';
import 'package:beyou/features/ayurveda/widgets/program_card.dart';
import 'package:beyou/features/ayurveda/widgets/yoga_session_card.dart';
import 'package:beyou/features/dosha/data/dosha_repository.dart';
import 'package:beyou/features/dosha/models/dosha_type.dart';
import 'package:beyou/features/dosha/page/dosha_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AyurvedaPage extends StatelessWidget {
  const AyurvedaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AyurvedaBloc(
        ayurvedaRepo: getIt<AyurvedaRepository>(),
        doshaRepo: getIt<DoshaRepository>(),
      )..add(AyurvedaStarted()),
      child: const _AyurvedaView(),
    );
  }
}

class _AyurvedaView extends StatelessWidget {
  const _AyurvedaView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      body: BlocBuilder<AyurvedaBloc, AyurvedaState>(
        builder: (context, state) {
          if (state is AyurvedaLoading || state is AyurvedaInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AyurvedaError) {
            return Center(child: Text(state.message));
          }
          if (state is AyurvedaLoaded) {
            return _buildContent(context, state);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, AyurvedaLoaded state) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(context, state),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Dosha Profile Banner
              _buildDoshaProfileBanner(context, state),
              const SizedBox(height: 28),

              // Yoga Section
              _buildSectionHeader(
                context,
                title: 'Yoga',
                emoji: '🧘',
                onSeeAll: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const YogaPage()),
                ),
              ),
              const SizedBox(height: 14),
              _buildYogaRow(context, state),
              const SizedBox(height: 28),

              // Pranayama Section
              _buildSectionHeader(
                context,
                title: 'Pranayama & Breathing',
                emoji: '🌬️',
                onSeeAll: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PranayamaPage()),
                ),
              ),
              const SizedBox(height: 14),
              _buildPranayamaRow(context, state),
              const SizedBox(height: 28),

              // Remedies Section
              _buildSectionHeader(
                context,
                title: 'Home Remedies',
                emoji: '🌿',
                onSeeAll: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RemediesPage()),
                ),
              ),
              const SizedBox(height: 14),
              _buildRemediesTeaser(context),
              const SizedBox(height: 28),

              // Dinacharya + Ritucharya
              _buildRoutineRow(context),
              const SizedBox(height: 28),

              // Programs
              _buildSectionHeader(
                context,
                title: 'Programs',
                emoji: '📋',
                onSeeAll: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProgramsPage()),
                ),
              ),
              const SizedBox(height: 14),
              _buildProgramsRow(context, state),
              const SizedBox(height: 30),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context, AyurvedaLoaded state) {
    final dosha = state.userDosha;
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: ColorConstants.primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ayurveda',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
            ),
            if (dosha != null)
              Text(
                'Your Dosha: ${dosha.label}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
          ],
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorConstants.primaryColor,
                ColorConstants.primaryColor.withValues(alpha: 0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDoshaProfileBanner(BuildContext context, AyurvedaLoaded state) {
    final dosha = state.userDosha;
    if (dosha == null) {
      return _buildAssessmentCTA(context);
    }
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DoshaProfilePage(dosha: dosha)),
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [dosha.accentColor, dosha.accentColor.withValues(alpha: 0.6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: dosha.accentColor.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Dosha Profile',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dosha.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'View personalized recommendations →',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Text('🌀', style: TextStyle(fontSize: 48)),
          ],
        ),
      ),
    );
  }

  Widget _buildAssessmentCTA(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DoshaPage()),
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: ColorConstants.primaryColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: ColorConstants.primaryColor.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            const Text('🪷', style: TextStyle(fontSize: 36)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Discover Your Dosha',
                    style: TextStyle(
                      color: ColorConstants.primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Take the 21-question assessment to personalize your Ayurveda experience.',
                    style: TextStyle(color: Color(0xFF8F98A3), fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: ColorConstants.primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required String emoji,
    required VoidCallback onSeeAll,
  }) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2022),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onSeeAll,
          child: Text(
            'See all',
            style: TextStyle(
              color: ColorConstants.primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildYogaRow(BuildContext context, AyurvedaLoaded state) {
    final sessions = state.yogaSessions.take(5).toList();
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: sessions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) => YogaSessionCard(
          session: sessions[i],
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => YogaSessionPage(session: sessions[i])),
          ),
        ),
      ),
    );
  }

  Widget _buildPranayamaRow(BuildContext context, AyurvedaLoaded state) {
    final techniques = state.pranayamaTechniques.take(4).toList();
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: techniques.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) => PranayamaCard(
          technique: techniques[i],
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PranayamaGuidePage(technique: techniques[i])),
          ),
        ),
      ),
    );
  }

  Widget _buildRemediesTeaser(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RemediesPage()),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F1FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Text('🌿', style: TextStyle(fontSize: 32)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '100+ Remedies',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Immunity · Digestion · Skin · Sleep · Stress and more',
                    style: TextStyle(color: Color(0xFF8F98A3), fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: ColorConstants.primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildRoutineRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildRoutineTile(
            context,
            emoji: '🌅',
            title: 'Dinacharya',
            subtitle: 'Daily Routine',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DinacharyaPage()),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildRoutineTile(
            context,
            emoji: '🍂',
            title: 'Ritucharya',
            subtitle: 'Seasonal Guide',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RitucharyaPage()),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoutineTile(
    BuildContext context, {
    required String emoji,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(color: Color(0xFF8F98A3), fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramsRow(BuildContext context, AyurvedaLoaded state) {
    final programs = state.programs.take(3).toList();
    return Column(
      children: programs
          .map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: ProgramCard(
                  program: p,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProgramDetailPage(program: p)),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
