part of '../../codde_widgets.dart';

/// Dummy Widget deactivating any gestures for children,
/// providing widget painting without any interaction
class WidgetDummy extends HudMarginComponent with IgnoreEvents {
  WidgetDummy(
      {super.position, super.margin, super.size, super.children, super.scale});
}
