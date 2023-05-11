import 'package:codde_com/codde_com.dart';
import 'package:controller_widget_api/controller_widget_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';

void main() {
  test('Edit an XML map', () {
    final repo = ControllerWidgetRepository(
        ControllerWidgetApi(map: ControllerMap(path: 'api_map_test.tmx')));
    // some map edition
    repo.saveMap();
    // expect map as specific modified values, and the same child number as before
  });
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
            backgrounds: [],
            nextLayerId: 1,
            nextObjectId: 1,
            properties:
                ControllerProperties(protocol: CoddeProtocol.socketio))));
    repo.createMap();
    final dartFile = Glob("api_map_test.tmx");
    expect(dartFile.listSync().isNotEmpty, true);

    // TODO: expect all standard attributes are here
    // TODO: expect datalayer exists
  });
}
