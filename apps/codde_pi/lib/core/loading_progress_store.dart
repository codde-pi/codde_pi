import 'package:mobx/mobx.dart';

part 'loading_progress_store.g.dart';

class LoadingProgressStore = _LoadingProgressStore with _$LoadingProgressStore;

abstract class _LoadingProgressStore with Store {
  @observable
  double progress = 0.0;

  void updateProgress(double value) {
    progress = (value * 100);
  }

  bool get noProgress => progress == 0.0;
}
