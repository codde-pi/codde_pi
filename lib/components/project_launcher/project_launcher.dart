import 'package:codde_pi/components/project_launcher/cubit/project_launcher_cubit.dart';
import 'package:codde_pi/components/project_launcher/cubit/project_launcher_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

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
      listenWhen: (previous, current) => current.projectInstance != null,
      listener: (context, state) async {
        Get.offNamed('/codde', arguments: state.projectInstance);
      },
      child: BlocConsumer<ProjectLauncherCubit, ProjectLauncherState>(
        listenWhen: (previous, current) =>
            previous.currentPage != current.currentPage,
        listener: (BuildContext context, ProjectLauncherState state) {
          _stepController.jumpToPage(state.currentPage);
        },
        buildWhen: (previous, current) =>
            previous.currentPage != current.currentPage,
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: PageView(controller: _stepController, children: steps),
          bottomNavigationBar: BottomAppBar(
            child: Center(
              child: Text("Step ${state.currentPage}/${steps.length}"),
            ),
            // TODO: create bottom bar button with assignable content
          ),
        ),
      ),
    );
  }
}
