import 'package:flutter_bloc/flutter_bloc.dart';

import 'play_controller_event.dart';
import 'play_controller_state.dart';

class PlayControllerBloc
    extends Bloc<PlayControllerEvent, PlayControllerState> {
  PlayControllerBloc() : super(const PlayControllerState()) {
    on<PlayControllerPropsChanged>(_onPropsChanged);
  }
  void _onPropsChanged(PlayControllerPropsChanged event, emit) {
    emit(state.copyWith(properties: event.props));
  }
}
