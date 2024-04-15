part of '../../codde_widgets.dart';

mixin HasMaterial on HasGameRef {
  BuildContext get context {
    assert(gameRef.buildContext != null);
    return gameRef.buildContext!;
  }

  ColorScheme get colorscheme => Theme.of(context).colorScheme;
}
