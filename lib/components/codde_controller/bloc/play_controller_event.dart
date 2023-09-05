import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flame_tiled/flame_tiled.dart';

abstract class PlayControllerEvent {
  const PlayControllerEvent();
}

class PlayControllerPropsChanged extends PlayControllerEvent {
  const PlayControllerPropsChanged(this.props);
  final ControllerProperties? props;
}
