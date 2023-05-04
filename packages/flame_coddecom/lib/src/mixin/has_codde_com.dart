import 'package:codde_com/codde_com.dart';
import 'package:flame/components.dart';
import 'package:flame_coddecom/src/flame_coddecom.dart';
import 'package:meta/meta.dart';

/// Add [IO.Socket] access and listening to a [Component]
///  from an existing Socket connection instantiated by [FlameSocketIOClient]
mixin HasCoddeCom on Component {
  late CoddeCom _com;

  /// Get the socket event handler of this component, once it has been mounted
  CoddeCom get com {
    assert(
      isMounted,
      'Cannot access the bloc instance before it has been mounted.',
    );
    return _com;
  }

  @override
  @mustCallSuper
  void onMount() {
    super.onMount();
    final comParents = ancestors().whereType<FlameCoddeCom>();
    assert(
      comParents.isNotEmpty,
      'CoddeCom Components can only be added as child of '
      'CoddeCom components',
    );
    _com = comParents.first.com;
  }

  @override
  @mustCallSuper
  void onRemove() {
    super.onRemove();
    com.disconnect();
    // TODO: not valid statement for all protocols
    // since child connections doesn't exist for the most
  }
}
