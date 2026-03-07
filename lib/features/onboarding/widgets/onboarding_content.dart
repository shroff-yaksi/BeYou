import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:beyou/features/onboarding/data/onboarding_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<OnboardingBloc>(context);
    return SafeArea(
      child: Column(
        children: [
          _buildTopNav(bloc),
          Expanded(child: _buildPageView(bloc)),
          _buildBottomControls(bloc),
        ],
      ),
    );
  }

  Widget _buildTopNav(OnboardingBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorConstants.primaryColor.withValues(alpha: 0.1),
            ),
            child: Icon(
              Icons.fitness_center,
              color: ColorConstants.primaryColor,
            ),
          ),
          GestureDetector(
            onTap: () => bloc.add(SkipOnboardingEvent()),
            child: const Text(
              'Skip',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageView(OnboardingBloc bloc) {
    return PageView(
      controller: bloc.pageController,
      children: OnboardingData.tiles,
      onPageChanged: (index) => bloc.add(PageSwipedEvent(index: index)),
    );
  }

  Widget _buildBottomControls(OnboardingBloc bloc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          BlocBuilder<OnboardingBloc, OnboardingState>(
            buildWhen: (_, curr) => curr is PageChangedState,
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) {
                  final isActive = i == bloc.pageIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: isActive
                          ? ColorConstants.primaryColor
                          : ColorConstants.primaryColor.withValues(alpha: 0.2),
                    ),
                  );
                }),
              );
            },
          ),
          const SizedBox(height: 32),
          BlocBuilder<OnboardingBloc, OnboardingState>(
            buildWhen: (_, curr) => curr is PageChangedState,
            builder: (context, state) {
              final percent = _getPercent(bloc.pageIndex);
              return TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: percent),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, _) {
                  return SizedBox(
                    width: 80,
                    height: 80,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: CircularProgressIndicator(
                            value: value,
                            strokeWidth: 3.5,
                            backgroundColor:
                                ColorConstants.primaryColor.withValues(alpha: 0.15),
                            valueColor: AlwaysStoppedAnimation(
                                ColorConstants.primaryColor),
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => bloc.add(PageChangedEvent()),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConstants.primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: ColorConstants.primaryColor
                                      .withValues(alpha: 0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  double _getPercent(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return 0.33;
      case 1:
        return 0.66;
      case 2:
        return 1.0;
      default:
        return 0.33;
    }
  }
}
