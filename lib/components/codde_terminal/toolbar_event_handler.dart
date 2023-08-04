import 'package:codde_pi/components/toolbar/toolbar_event.dart';

String? handleEvent(ToolBarEvent event) {
  // TODO:  ctrl, alt keys
  switch (event) {
    case ToolBarEvent.tab:
      return '\t';
    default:
      return '';
  }
}
