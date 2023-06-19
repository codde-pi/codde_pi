import 'package:codde_pi/components/dynamic_bar/models/dynamic_bar_destination.dart';
import 'package:codde_pi/components/dynamic_bar/models/dynamic_fab.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DynamicBarController extends GetxController {
  List<DynamicBarDestination> destinations;
  DynamicFab? fab;
  int currentPage;

  DynamicBarController(
      {required this.destinations, this.fab, this.currentPage = 0});

  List<DynamicBarDestination> get paged {
    List<DynamicBarDestination> list = List.of(destinations)
      ..sort((a, b) => a.index.compareTo(b.index));
    return list;
  }

  List<Widget> get pages {
    List list = paged;
    return list.map<Widget>((e) => e.widget).toList();
  }

  List<IconData> get icons {
    List list = paged;
    return list.map<IconData>((e) => e.iconData).toList();
  }

  void setPage(DynamicBarDestination page) {
    currentPage = page.index;
    update();
  }

  void setFab({required IconData iconData, required Function action}) {
    fab = DynamicFab(iconData: iconData, action: action);
    update();
  }

  void defineDestinations(List<DynamicBarDestination> destinations) {
    this.destinations = destinations;
    update();
  }
}

void setFab({required IconData iconData, required Function action}) {
  WidgetsBinding.instance.addPostFrameCallback(
    (_) => Get.find<DynamicBarController>()
        .setFab(iconData: iconData, action: action),
  );
}
