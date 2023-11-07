import 'package:carousel_slider/carousel_slider.dart';
import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/components/codde_controller/flame/overview_controller_flame.dart';
import 'package:codde_pi/components/projects_carousel/store/projects_carousel_store.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProjectsCarousel extends StatelessWidget {
  // final Iterable<Project> projectList;
  final CarouselController _carouselController = CarouselController();
  final store = ProjectsCarouselStore();

  ProjectsCarousel({super.key});

  Iterable<Project> get projectList => Hive.box<Project>(projectsBox).values;
  Project get focusedProject => projectList.elementAt(store.currentPage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () =>
                Hive.box<Project>(projectsBox).deleteAt(store.currentPage),
            icon: const Icon(Icons.delete))
      ]),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueListenableBuilder(
            valueListenable: Hive.box<Project>(projectsBox).listenable(),
            builder: (context, box, widget) => CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: projectList.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      GameWidget(
                game: OverviewControllerFlame(
                    path: getControllerName(
                        projectList.elementAt(itemIndex).path),
                    backend: CoddeBackend(BackendLocation
                        .local)), // TODO: catch SFTP scenario `if project.host != null`
              ),
              options: CarouselOptions(
                height: 400,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: false,
              ),
            ),
          ),
          Center(
            child: Row(
              children: projectList
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Container(
                          color: store.currentPage ==
                                  projectList.toList().indexOf(e)
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).unselectedWidgetColor,
                        ),
                      ))
                  .toList(),
            ),
          ),
          ElevatedButton(
              child: const Text("SELECT"),
              onPressed: () => Navigator.of(context).pop(focusedProject)),
        ],
      ),
    );
  }
}
