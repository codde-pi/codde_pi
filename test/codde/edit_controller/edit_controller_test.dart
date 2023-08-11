import 'package:codde_com/codde_com.dart';
import 'package:codde_pi/components/codde_controller/views/edit_controller_page.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';

void main() {
  group('Create map from scratch and load it', () {
    test('Create map from scratch', () {
      var repo = ControllerWidgetRepository(
          ControllerWidgetApi(map: ControllerMap(path: 'api_map_test.tmx')));
      expect(() => repo.createMap(), throwsAssertionError);
      // provide all properties
      repo = ControllerWidgetRepository(ControllerWidgetApi(
          map: ControllerMap(
              path: 'api_map_test.tmx',
              height: 60,
              width: 40,
              nextLayerId: 1,
              nextObjectId: 2,
              properties:
                  ControllerProperties(protocol: CoddeProtocol.socketio)),
          widgets: {
            1: ControllerWidget(
                id: 1,
                class_: ControllerClass.simple_button,
                nickname: 'Cool simple button',
                x: 10,
                y: 10)
          }));
      repo.createMap();
      final dartFile = Glob("api_map_test.tmx");
      expect(dartFile.listSync().isNotEmpty, true);
    });
    testWidgets('MyWidget has a title and message', (tester) async {
      // Create the widget by telling the tester to build it.
      await tester.pumpWidget(
          MaterialApp(home: EditControllerPage(path: 'api_map_test.tmx')));
    });
    // TODO: expect widget exists and widget position is 10, 10
  });
}
