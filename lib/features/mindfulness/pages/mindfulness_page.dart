import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_bloc.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_event.dart';
import 'package:beyou/features/mindfulness/bloc/mindfulness_state.dart';
import 'package:beyou/features/mindfulness/data/mindfulness_repository.dart';
import 'package:beyou/features/mindfulness/models/mood_entry.dart';
import 'package:beyou/features/mindfulness/pages/focus_timer_page.dart';
import 'package:beyou/features/mindfulness/pages/i_am_clean_page.dart';
import 'package:beyou/features/mindfulness/pages/meditation_library_page.dart';
import 'package:beyou/features/mindfulness/pages/meditation_player_page.dart';
import 'package:beyou/features/mindfulness/pages/mental_health_hub_page.dart';
import 'package:beyou/features/mindfulness/pages/mood_journal_page.dart';
import 'package:beyou/features/mindfulness/pages/sleep_page.dart';
import 'package:beyou/features/mindfulness/pages/stress_sos_page.dart';
import 'package:beyou/features/mindfulness/widgets/feature_tile.dart';
import 'package:beyou/features/mindfulness/widgets/meditation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MindfulnessPage extends StatelessWidget {
  const MindfulnessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MindfulnessBloc(repo: getIt<MindfulnessRepository>())
        ..add(const MindfulnessStarted()),
      child: const _MindfulnessView(),
    );
  }
}

class _MindfulnessView extends StatelessWidget {
  const _MindfulnessView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      body: BlocBuilder<MindfulnessBloc, MindfulnessState>(
        builder: (context, state) {
          if (state is MindfulnessLoading || state is MindfulnessInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MindfulnessError) {
            return Center(child: Text(state.message));
          }
          if (state is MindfulnessLoaded) {
            return _buildContent(context, state);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, MindfulnessLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<MindfulnessBloc>().add(const MindfulnessRefreshed());
      },
      child: CustomScrollView(
        slivers: [
          _buildAppBar(state),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildStreakCard(context, state),
                const SizedBox(height: 24),

                _sectionHeader(
                  context,
                  emoji: '🧘',
                  title: 'Meditate',
                  onSeeAll: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MeditationLibraryPage()),
                  ),
                ),
                const SizedBox(height: 14),
                _meditationRow(context, state),
                const SizedBox(height: 28),

                _sectionHeader(context, emoji: '🌟', title: 'Practices'),
                const SizedBox(height: 14),
                _practicesGrid(context),
                const SizedBox(height: 28),

                _sosBanner(context),
                const SizedBox(height: 24),

                _sectionHeader(context, emoji: '💚', title: 'Mental Health Hub'),
                const SizedBox(height: 14),
                _mentalHealthBanner(context),
                const SizedBox(height: 30),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(MindfulnessLoaded state) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFF4A5FBE),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mindfulness',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
            ),
            Text(
              'Be where you are',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A5FBE), Color(0xFF6358E1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStreakCard(BuildContext context, MindfulnessLoaded state) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFFF7043).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(child: Text('🔥', style: TextStyle(fontSize: 28))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${state.meditationStreak} day${state.meditationStreak == 1 ? '' : 's'}',
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
                ),
                const Text(
                  'Meditation streak',
                  style: TextStyle(color: Color(0xFF8F98A3), fontSize: 12),
                ),
              ],
            ),
          ),
          if (state.moodEntries.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  state.moodEntries.first.mood.emoji,
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Today\'s mood',
                  style: TextStyle(color: Color(0xFF8F98A3), fontSize: 11),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _sectionHeader(
    BuildContext context, {
    required String emoji,
    required String title,
    VoidCallback? onSeeAll,
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
        if (onSeeAll != null)
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

  Widget _meditationRow(BuildContext context, MindfulnessLoaded state) {
    final featured = state.meditations.take(6).toList();
    return SizedBox(
      height: 170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: featured.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) => MeditationCard(
          session: featured[i],
          onTap: () => _openPlayer(context, featured[i].id),
        ),
      ),
    );
  }

  void _openPlayer(BuildContext context, String sessionId) {
    final bloc = context.read<MindfulnessBloc>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: bloc,
          child: MeditationPlayerPage(sessionId: sessionId),
        ),
      ),
    );
  }

  Widget _practicesGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.05,
      children: [
        FeatureTile(
          title: 'Sleep',
          subtitle: 'Stories, sounds, sleep meditations',
          emoji: '🌙',
          color: const Color(0xFF4A5FBE),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SleepPage()),
          ),
        ),
        FeatureTile(
          title: 'Mood Journal',
          subtitle: 'Daily check-in & gratitude',
          emoji: '📓',
          color: const Color(0xFFE91E63),
          onTap: () => _openWithBloc(context, const MoodJournalPage()),
        ),
        FeatureTile(
          title: 'I Am Clean',
          subtitle: 'Streak tracker for any addiction',
          emoji: '🌿',
          color: const Color(0xFF52C78A),
          onTap: () => _openWithBloc(context, const IAmCleanPage()),
        ),
        FeatureTile(
          title: 'Focus Timer',
          subtitle: 'Pomodoro for deep work',
          emoji: '🎯',
          color: const Color(0xFF6358E1),
          onTap: () => _openWithBloc(context, const FocusTimerPage()),
        ),
      ],
    );
  }

  void _openWithBloc(BuildContext context, Widget page) {
    final bloc = context.read<MindfulnessBloc>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(value: bloc, child: page),
      ),
    );
  }

  Widget _sosBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const StressSosPage()),
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF7043), Color(0xFFE91E63)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE91E63).withValues(alpha: 0.3),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            const Text('🆘', style: TextStyle(fontSize: 36)),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stress SOS',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '2–5 min relief sessions when you need them',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _mentalHealthBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MentalHealthHubPage()),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF52C78A).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const Text('🩺', style: TextStyle(fontSize: 32)),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Self-assessments, CBT/DBT, helplines',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Validated tools and India crisis resources, always free',
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
}
