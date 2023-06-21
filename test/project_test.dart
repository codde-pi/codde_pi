import 'dart:io';

import 'package:codde_pi/components/project_launcher/steps/choose_project_type_step.dart';
import 'package:codde_pi/components/project_launcher/steps/project_location_step.dart';
import 'package:codde_pi/main.dart';
import 'package:codde_pi/services/db/device.dart';
import 'package:codde_pi/services/db/device_model.dart';
import 'package:codde_pi/services/db/host.dart';
import 'package:codde_pi/services/db/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_markdown_editor/widgets/markdown_form_field.dart';

Future initHive() async {
  var path = Directory.current.path;
  await Hive.initFlutter(path + '/test/hive_testing_path');
  Hive
    ..registerAdapter(DeviceModelAdapter())
    ..registerAdapter(DeviceProtocolAdapter())
    ..registerAdapter(DeviceAdapter());
  await Hive.openBox<Device>('devices');
  Hive.registerAdapter(HostAdapter());
  await Hive.openBox<Host>('hosts');
  Hive.registerAdapter(ProjectAdapter());
  await Hive.openBox<Project>(projectsBox);
}

void main() {
  group('create and open CODDE project', () {
    Box? box;
    Box? box1;
    Box? box2;
    // Box? box3;
    setUp(() async {
      final temp = await Directory.systemTemp.createTemp();
      Hive.init(temp.path);
      // Hive
      //   ..registerAdapter(DeviceModelAdapter())
      //   ..registerAdapter(DeviceProtocolAdapter())
      //   ..registerAdapter(DeviceAdapter());
      box = await Hive.openBox<Device>('devices');
      // Hive.registerAdapter(HostAdapter());
      box1 = await Hive.openBox<Host>('hosts');
      // Hive.registerAdapter(ProjectAdapter());
      box2 = await Hive.openBox<Project>(projectsBox);
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    tearDown(() async {
      if (box != null) {
        await box!.clear();
        await box!.deleteFromDisk();
      }
      if (box1 != null) {
        await box1!.clear();
        await box1!.deleteFromDisk();
      }
      if (box2 != null) {
        await box2!.clear();
        await box2!.deleteFromDisk();
      }
      /* if (box3 != null) {
        await box3.clear();
        await box3.deleteFromDisk();
      } */
    });

    testWidgets('check content', (tester) async {
      await tester.pumpWidget(const MyApp()); // Open project page
      // assert content is visible
      expect(find.text('Open project...'), findsOneWidget);
      // assert button `add`
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('create new project', (widgetTester) async {
      // widgetTester.runAsync(() => initHive());

      await widgetTester.pumpWidget(const MyApp());
      await widgetTester.tap(find.byType(FloatingActionButton));
      await widgetTester.pumpAndSettle();
      // introduce project
      expect(find.byType(TextField), findsOneWidget);
      await widgetTester.enterText(find.byType(TextField), "project test");
      await widgetTester
          .enterText(find.byType(MarkdownFormField), """# Project test
          > Awesome comment about my project""");
      await widgetTester.tap(find.byType(ElevatedButton));
      await widgetTester.pumpAndSettle();
      // choose project type step: controller
      // expect(find.text("Step 2/"), findsOneWidget);
      await widgetTester.tap(find.byWidgetPredicate((widget) =>
          widget is Radio && widget.value == ProjectType.controller));
      await widgetTester.tap(find.byType(ElevatedButton));
      await widgetTester.pumpAndSettle();
      // projectLocationStep: internal
      // expect(find.text("Step 3/"), findsOneWidget);
      await widgetTester.tap(find.byWidgetPredicate((widget) =>
          widget is Radio && widget.value == ProjectLocationType.internal));
      await widgetTester.tap(find.byType(ElevatedButton));
      // Hive use need `runAsync` statement
      await widgetTester.runAsync(() => widgetTester.pumpAndSettle());
      // target device step: later
      // TODO: write `createDevice` test
      await widgetTester.tap(find.text("LATER"));
      // await widgetTester.pumpAndSettle();
      await widgetTester.runAsync(() => widgetTester.pumpAndSettle());
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      /* // FIXME: Flutter issue with FutureBuilder testing: https://github.com/flutter/flutter/issues/75249
      await widgetTester.runAsync(() => widgetTester.pumpAndSettle());
      expect(find.byType(CoddeController), findsOneWidget);
      expect(find.byType(CoddeEditor), findsOneWidget); */
    });
    // TODO: Check README.md file content
    /* 
    // FIXME: No project Added since FutureBuilder is not awaited until project is created
    //  testing: https://github.com/flutter/flutter/issues/75249
    testWidgets('retrieve recent projects', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.tap(find.text("Recent"));
      await tester.runAsync(() => tester.pumpAndSettle());
      expect(find.byType(ListTile), findsWidgets);
      expect(find.text("project test"), findsOneWidget);
      await tester.tap(find.text('project test'));
      await tester.runAsync(() => tester.pumpAndSettle());
      expect(find.byType(CoddeController), findsOneWidget);
      expect(find.byType(CoddeEditor), findsOneWidget);
    }); */
  });
}
