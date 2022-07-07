import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:uniturnip/json_schema_ui/examples/schemas.dart';
import 'package:uniturnip/json_schema_ui/json_schema_ui.dart';
import 'package:uniturnip/main.dart';

// int defaultPage = 4;
// final _schemas = Schemas.schemas;
// final _schema = Schemas.schemas[defaultPage]['schema'];
// final _ui = Schemas.schemas[defaultPage]['ui'];
// final _data = Schemas.schemas[defaultPage]['formData'];

void main() {

  group('end-to-end test', () {
    testWidgets('Renders content', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());

      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(MyHomePage), findsOneWidget);
      expect(find.text('Uniturnip'), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(14));
    });

    // testWidgets('Renders list of post', (WidgetTester tester) async {
    //   await tester.pumpWidget(MyApp);
    //
    //
    // });



  });
}
