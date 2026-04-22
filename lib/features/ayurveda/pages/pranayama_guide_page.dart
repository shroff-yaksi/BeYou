import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/features/ayurveda/models/pranayama_technique.dart';
import 'package:flutter/material.dart';

class PranayamaGuidePage extends StatefulWidget {
  final PranayamaTechnique technique;

  const PranayamaGuidePage({super.key, required this.technique});

  @override
  State<PranayamaGuidePage> createState() => _PranayamaGuidePageState();
}

class _PranayamaGuidePageState extends State<PranayamaGuidePage>
    with TickerProviderStateMixin {
  late AnimationController _breathController;
  late Animation<double> _breathAnimation;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  bool _isRunning = false;
  int _currentPhaseIndex = 0;
  int _secondsRemaining = 0;
  int _cycleCount = 0;

  @override
  void initState() {
    super.initState();
    _breathController = AnimationController(vsync: this);
    _breathAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _initPhase();
  }

  void _initPhase() {
    final phases = widget.technique.phases;
    if (phases.isEmpty) return;
    _currentPhaseIndex = 0;
    _secondsRemaining = phases[0].seconds;
  }

  void _startSession() {
    setState(() {
      _isRunning = true;
      _cycleCount = 0;
      _initPhase();
    });
    _runPhase();
  }

  void _stopSession() {
    _breathController.stop();
    setState(() {
      _isRunning = false;
      _initPhase();
    });
  }

  void _runPhase() async {
    final phases = widget.technique.phases;
    if (!_isRunning || phases.isEmpty) return;

    final phase = phases[_currentPhaseIndex];
    final label = phase.label.toLowerCase();

    // Animate breath circle
    if (label.contains('inhale')) {
      _breathController.duration = Duration(seconds: phase.seconds);
      _breathController.forward(from: 0.0);
    } else if (label.contains('exhale') || label.contains('hum')) {
      _breathController.duration = Duration(seconds: phase.seconds);
      _breathController.reverse(from: 1.0);
    } else {
      // Hold — keep current
      _breathController.stop();
    }

    for (int i = phase.seconds; i > 0; i--) {
      if (!_isRunning) return;
      setState(() => _secondsRemaining = i);
      await Future.delayed(const Duration(seconds: 1));
    }

    if (!_isRunning) return;

    // Next phase
    final nextPhase = (_currentPhaseIndex + 1) % phases.length;
    final completedCycle = nextPhase == 0;

    setState(() {
      _currentPhaseIndex = nextPhase;
      if (completedCycle) _cycleCount++;
    });

    if (completedCycle && _cycleCount >= widget.technique.cyclesPerSession) {
      _onSessionComplete();
    } else {
      _runPhase();
    }
  }

  void _onSessionComplete() {
    setState(() => _isRunning = false);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Session Complete 🎉', textAlign: TextAlign.center),
        content: Text(
          'You completed ${widget.technique.cyclesPerSession} cycles of ${widget.technique.name}. Take a moment to sit in stillness.',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _breathController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  String get _currentPhaseLabel {
    if (!_isRunning) return 'Ready';
    final phases = widget.technique.phases;
    if (phases.isEmpty) return '';
    return phases[_currentPhaseIndex].label;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0B2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0B2A),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(widget.technique.name,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Phase label
              Text(
                _currentPhaseLabel,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 40),

              // Animated breath circle
              Center(child: _buildBreathCircle()),
              const SizedBox(height: 40),

              // Cycle counter
              if (_isRunning)
                Text(
                  'Cycle ${_cycleCount + 1} of ${widget.technique.cyclesPerSession}',
                  style: const TextStyle(color: Colors.white54, fontSize: 14),
                ),
              const SizedBox(height: 32),

              // Start / Stop button
              _buildControlButton(),
              const SizedBox(height: 40),

              // Instructions card
              _buildInstructionsCard(),
              const SizedBox(height: 16),

              // Benefits
              _buildBenefitsCard(),
              if (widget.technique.caution != null) ...[
                const SizedBox(height: 16),
                _buildCautionCard(),
              ],
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBreathCircle() {
    return AnimatedBuilder(
      animation: _isRunning ? _breathAnimation : _pulseAnimation,
      builder: (context, _) {
        final scale = _isRunning ? _breathAnimation.value : _pulseAnimation.value;
        return Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow
            Container(
              width: 220 * scale,
              height: 220 * scale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstants.primaryColor.withValues(alpha: 0.1),
              ),
            ),
            // Middle ring
            Container(
              width: 180 * scale,
              height: 180 * scale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstants.primaryColor.withValues(alpha: 0.2),
              ),
            ),
            // Inner circle
            Container(
              width: 140 * scale,
              height: 140 * scale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    ColorConstants.primaryColor.withValues(alpha: 0.9),
                    ColorConstants.primaryColor.withValues(alpha: 0.6),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isRunning ? '$_secondsRemaining' : widget.technique.emoji,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (_isRunning)
                    const Text(
                      'sec',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildControlButton() {
    return GestureDetector(
      onTap: _isRunning ? _stopSession : _startSession,
      child: Container(
        width: 180,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: _isRunning ? const Color(0xFFE53935) : ColorConstants.primaryColor,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: (_isRunning ? const Color(0xFFE53935) : ColorConstants.primaryColor)
                  .withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Text(
          _isRunning ? 'Stop' : 'Begin',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionsCard() {
    final phases = widget.technique.phases;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Instructions',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
          const SizedBox(height: 10),
          Text(
            widget.technique.instructions,
            style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.6),
          ),
          if (phases.isNotEmpty) ...[
            const SizedBox(height: 14),
            const Text('Breath Pattern',
                style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: phases
                  .map((p) => Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: ColorConstants.primaryColor.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Text('${p.seconds}s',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14)),
                              const SizedBox(height: 2),
                              Text(p.label,
                                  style: const TextStyle(color: Colors.white70, fontSize: 9),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBenefitsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Benefits',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
          const SizedBox(height: 10),
          ...widget.technique.benefits.map((b) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                            color: ColorConstants.primaryColor, shape: BoxShape.circle)),
                    const SizedBox(width: 10),
                    Text(b, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCautionCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFF9800).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFF9800).withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('⚠️', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.technique.caution!,
              style: const TextStyle(color: Color(0xFFFFCC80), fontSize: 12, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
