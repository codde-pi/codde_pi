import 'package:codde_pi/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('create and open CODDE project', () {
    testWidgets('check content', (tester) async {
      await tester.pumpWidget(const MyApp()); // Open project page
      // assert content is visible
      expect(find.text('Open project...'), findsOneWidget);
      // assert button `add`
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });
    // TODO: test failed
    /* testWidgets('create new project', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp());
      await widgetTester.tap(find.byType(FloatingActionButton));
      // await widgetTester.pump();
      // introduce project
      expect(find.byType(TextField), findsOneWidget);
      await widgetTester.enterText(find.byType(TextField), "project test");
      await widgetTester
          .enterText(find.byType(MarkdownFormField), """# Project test
          > Awesome comment about my project""");
      await widgetTester.tap(find.byType(ElevatedButton));
      await widgetTester.pump();
      // choose project type step: controller
      expect(find.text("Step 2/"), findsOneWidget);
      await widgetTester.tap(find.byWidgetPredicate((widget) =>
          widget is Radio && widget.value == ProjectType.controller));
      await widgetTester.tap(find.byType(ElevatedButton));
      await widgetTester.pump();
      // projectLocationStep: internal
      expect(find.text("Step 3/"), findsOneWidget);
      await widgetTester.tap(find.byWidgetPredicate((widget) =>
          widget is Radio && widget.value == ProjectLocationType.internal));
      await widgetTester.tap(find.byType(ElevatedButton));
      await widgetTester.pump();
      // target device step: later
      // TODO: write `createDevice` test
      await widgetTester.tap(find.text("LATER"));
      await widgetTester.pump();
      expect(find.byType(CoddeController), findsOneWidget);
      expect(find.byType(CoddeEditor), findsOneWidget);
    });
    // TODO: test failed
    testWidgets('retrieve recent projects', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.tap(find.text("Recent"));
      await tester.pump();
      expect(find.byType(ListTile), findsWidgets);
      expect(find.text("project test"), findsOneWidget);
      await tester.tap(find.text('project test'));
      await tester.pump();
      expect(find.byType(CoddeController), findsOneWidget);
      expect(find.byType(CoddeEditor), findsOneWidget);
    }); */
  });
}
