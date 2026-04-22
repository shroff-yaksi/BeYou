import 'package:beyou/screens/home/bloc/home_bloc.dart';
import 'package:beyou/screens/home/widget/home_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<HomeBloc> _buildContext(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) =>
          HomeBloc()..add(LoadHomeStatsEvent()),
      child: BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (_, currState) =>
            currState is HomeInitial ||
            currState is HomeStatsLoaded ||
            currState is ReloadImageState,
        builder: (context, state) {
          return HomeContent();
        },
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }
}
