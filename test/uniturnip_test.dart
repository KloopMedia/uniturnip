import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:uniturnip/json_schema_ui/examples/schemas.dart';
import 'package:uniturnip/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Form can be submitted', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

    });
  });
}
