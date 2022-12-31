import 'package:codde_pi/core/components/view.dart';
import 'package:codde_pi/services/providers/controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../app/pages/editor.dart';

DocumentProvider useDocProvider({required String path, optionBuilder}) {
  final doc = useMemoized(() => DocumentProvider());
  doc.openFile(path);

  return doc;
}

ValueNotifier<List> useFileContent() {
  final content = useState([]);
  content.value.add(FileContent('Form', TabSubject.form, const CddPage('', TabSubject.form), ''));
  return content;
}

/*ControllerProvider useReadCJson(String path) {
  final provider = useMemoized(() => ControllerProvider());
  provider.openFile(path);
  return provider;
}*/

ValueNotifier<List> useListWidgets(Function function) {
  final state = useState([]);
  final list = function(); // TODO: useemoized ?
  state.value = list;
  return state;
}