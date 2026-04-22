import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/di/injection.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_bloc.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_event.dart';
import 'package:beyou/features/ayurveda/bloc/ayurveda_state.dart';
import 'package:beyou/features/ayurveda/data/ayurveda_repository.dart';
import 'package:beyou/features/ayurveda/models/dinacharya_item.dart';
import 'package:beyou/features/dosha/data/dosha_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DinacharyaPage extends StatelessWidget {
  const DinacharyaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AyurvedaBloc(
        ayurvedaRepo: getIt<AyurvedaRepository>(),
        doshaRepo: getIt<DoshaRepository>(),
      )..add(AyurvedaStarted()),
      child: const _DinacharyaView(),
    );
  }
}

class _DinacharyaView extends StatefulWidget {
  const _DinacharyaView();

  @override
  State<_DinacharyaView> createState() => _DinacharyaViewState();
}

class _DinacharyaViewState extends State<_DinacharyaView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
        title: const Text('Dinacharya', style: TextStyle(fontWeight: FontWeight.w700)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: ColorConstants.primaryColor,
          unselectedLabelColor: const Color(0xFF8F98A3),
          indicatorColor: ColorConstants.primaryColor,
          tabs: const [
            Tab(text: '🌅 Morning'),
            Tab(text: '🌙 Evening'),
          ],
        ),
      ),
      body: BlocBuilder<AyurvedaBloc, AyurvedaState>(
        builder: (context, state) {
          if (state is! AyurvedaLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          return TabBarView(
            controller: _tabController,
            children: [
              _buildRoutineList(state.morningRoutine),
              _buildRoutineList(state.eveningRoutine),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRoutineList(List<DinacharyaItem> items) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 4),
      itemBuilder: (context, i) {
        final item = items[i];
        final isLast = i == items.length - 1;
        return _DinacharyaItemTile(item: item, isLast: isLast, index: i);
      },
    );
  }
}

class _DinacharyaItemTile extends StatefulWidget {
  final DinacharyaItem item;
  final bool isLast;
  final int index;

  const _DinacharyaItemTile({
    required this.item,
    required this.isLast,
    required this.index,
  });

  @override
  State<_DinacharyaItemTile> createState() => _DinacharyaItemTileState();
}

class _DinacharyaItemTileState extends State<_DinacharyaItemTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(widget.item.emoji, style: const TextStyle(fontSize: 18)),
              ),
            ),
            if (!widget.isLast)
              Container(
                width: 2,
                height: 20,
                color: ColorConstants.primaryColor.withValues(alpha: 0.2),
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.item.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                      ),
                      Icon(
                        _expanded ? Icons.expand_less : Icons.expand_more,
                        color: const Color(0xFFB6BDC6),
                        size: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.item.timeRange,
                    style: TextStyle(
                        color: ColorConstants.primaryColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  ),
                  if (_expanded) ...[
                    const SizedBox(height: 10),
                    Text(
                      widget.item.description,
                      style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF4A5568),
                          height: 1.6),
                    ),
                    if (widget.item.durationMinutes > 0) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              size: 12, color: ColorConstants.primaryColor),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.item.durationMinutes} minutes',
                            style: TextStyle(
                                color: ColorConstants.primaryColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
