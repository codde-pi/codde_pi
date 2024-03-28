import 'package:carousel_slider/carousel_slider.dart';
import 'package:codde_backend/codde_backend.dart';
import 'package:codde_pi/components/codde_controller/flame/overview_controller_flame.dart';
import 'package:codde_pi/components/projects_carousel/store/projects_carousel_store.dart';
import 'package:codde_pi/core/utils.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:codde_pi/theme.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
                      Stack(
                children: [
                  GameWidget(
                    // TODO: if unable to connect, show nothing, else instantiate remote backend
                    game: OverviewControllerFlame(
                        path: getControllerName(
                            projectList.elementAt(itemIndex).path),
                        backend: CoddeBackend(BackendLocation
                            .local)), // TODO: catch SFTP scenario `if project.host != null`
                  ),
                  Positioned(
                    top: 0.0,
                    // left: 0.0,
                    right: 0.0,
                    child: PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          child: const Text('Delete'),
                          onTap: () => deleteProject(context, focusedProject),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      /* child: Container(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .darken(0.7)
                        .withOpacity(0.5), */
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(widgetGutter),
                          child: Text(
                            projectList.elementAt(itemIndex).name.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 1.5,
                aspectRatio: MediaQuery.of(context).devicePixelRatio,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) => store.setPage(index),
              ),
            ),
          ),
          Observer(
            builder: (context) => Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: projectList
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Container(
                            width: 10.0,
                            height: 10.0,
                            color: store.currentPage ==
                                    projectList.toList().indexOf(e)
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).unselectedWidgetColor,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: widgetGutter),
            child: FloatingActionButton.extended(
                label: const Text("SELECT"),
                onPressed: () => Navigator.of(context).pop(focusedProject)),
          ),
        ],
      ),
    );
  }
}
