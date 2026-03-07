import 'package:beyou/core/router/route_names.dart';
import 'package:beyou/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:beyou/features/onboarding/widgets/onboarding_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<OnboardingBloc>(
        create: (_) => OnboardingBloc(),
        child: BlocConsumer<OnboardingBloc, OnboardingState>(
          listenWhen: (_, curr) => curr is NextScreenState,
          listener: (context, state) {
            context.go(RouteNames.signUp);
          },
          buildWhen: (_, curr) => curr is OnboardingInitial,
          builder: (context, state) {
            return const OnboardingContent();
          },
        ),
      ),
    );
  }
}
