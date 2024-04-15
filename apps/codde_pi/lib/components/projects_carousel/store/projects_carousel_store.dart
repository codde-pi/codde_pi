import 'package:mobx/mobx.dart';

part 'projects_carousel_store.g.dart';

class ProjectsCarouselStore = _ProjectsCarouselStore
    with _$ProjectsCarouselStore;

abstract class _ProjectsCarouselStore with Store {
  @observable
  int currentPage = 0;

  @action
  void setPage(int page) {
    currentPage = page;
  }
}
