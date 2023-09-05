import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'play_controller_state.freezed.dart';

@freezed
class PlayControllerState with _$PlayControllerState {
  const PlayControllerState._();
  const factory PlayControllerState({ControllerProperties? properties}) =
      _PlayControllerState;

  String? get executable => properties?.getValue("executable");
}
