import 'package:codde_pi/components/project_launcher/cubit/project_launcher_cubit.dart';
import 'package:codde_pi/components/project_launcher/cubit/project_launcher_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectLauncher extends StatelessWidget {
  final List<Widget> steps;

  ProjectLauncher({required this.steps});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ProjectLauncherCubit(),
        child: ProjectLauncherView(steps: steps));
  }
}

class ProjectLauncherView extends StatelessWidget {
  final List<Widget> steps;
  ProjectLauncherView({super.key, required this.steps});

  final PageController _stepController = PageController();

  int get currentPage =>
      _stepController.positions.isNotEmpty ? _stepController.page!.toInt() : 0;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectLauncherCubit, ProjectLauncherState>(
      listenWhen: (previous, current) =>
          previous.currentPage != current.currentPage,
      listener: (BuildContext context, ProjectLauncherState state) {
        _stepController.jumpToPage(state.currentPage);
      },
      child: Scaffold(
        body: PageView(controller: _stepController, children: steps),
        bottomNavigationBar: BottomAppBar(
          child: Center(
            child: Text("Step $currentPage/${steps.length}"),
          ),
          // TODO: create bottom bar button with assignable content
        ),
      ),
    );
  }
}
