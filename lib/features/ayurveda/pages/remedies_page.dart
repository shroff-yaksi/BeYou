import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_bloc.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_event.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_state.dart';
import 'package:beyou/features/ayurveda/data/ayurveda_repository.dart';
import 'package:beyou/features/ayurveda/models/home_remedy.dart';
import 'package:beyou/features/ayurveda/pages/remedy_detail_page.dart';
import 'package:beyou/features/ayurveda/widgets/remedy_card.dart';
import 'package:beyou/features/dosha/data/dosha_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemediesPage extends StatelessWidget {
  const RemediesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AyurvedaBloc(
        ayurvedaRepo: getIt<AyurvedaRepository>(),
        doshaRepo: getIt<DoshaRepository>(),
      )..add(AyurvedaStarted()),
      child: const _RemediesView(),
    );
  }
}

class _RemediesView extends StatefulWidget {
  const _RemediesView();

  @override
  State<_RemediesView> createState() => _RemediesViewState();
}

class _RemediesViewState extends State<_RemediesView> {
  final _searchController = TextEditingController();

  static const _categories = RemedyCategory.values;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1F2022),
        elevation: 0,
        title: const Text('Home Remedies', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: BlocBuilder<AyurvedaBloc, AyurvedaState>(
        builder: (context, state) {
          if (state is! AyurvedaLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              _buildSearchBar(context),
              _buildCategoryFilter(context, state),
              Expanded(child: _buildRemedyList(context, state.remedies)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: TextField(
        controller: _searchController,
        onChanged: (q) => context.read<AyurvedaBloc>().add(AyurvedaRemedySearchChanged(q)),
        decoration: InputDecoration(
          hintText: 'Search remedies, ingredients...',
          hintStyle: const TextStyle(color: Color(0xFFB6BDC6), fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: Color(0xFFB6BDC6), size: 20),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 18),
                  onPressed: () {
                    _searchController.clear();
                    context.read<AyurvedaBloc>().add(AyurvedaRemedySearchChanged(''));
                  },
                )
              : null,
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(BuildContext context, AyurvedaLoaded state) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _CategoryChip(
              label: 'All',
              emoji: '🌿',
              selected: state.activeRemedyCategory == null,
              onTap: () =>
                  context.read<AyurvedaBloc>().add(AyurvedaRemedyCategoryChanged(null)),
            ),
            ..._categories.map((cat) => Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: _CategoryChip(
                    label: cat.label,
                    emoji: cat.emoji,
                    selected: state.activeRemedyCategory == cat,
                    onTap: () =>
                        context.read<AyurvedaBloc>().add(AyurvedaRemedyCategoryChanged(cat)),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildRemedyList(BuildContext context, List<HomeRemedy> remedies) {
    if (remedies.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('🌿', style: TextStyle(fontSize: 48)),
            SizedBox(height: 16),
            Text('No remedies found', style: TextStyle(color: Color(0xFF8F98A3))),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: remedies.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) => RemedyCard(
        remedy: remedies[i],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => RemedyDetailPage(remedy: remedies[i])),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final String emoji;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.emoji,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? ColorConstants.primaryColor : const Color(0xFFF3F1FF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 13)),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : const Color(0xFF6358E1),
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
