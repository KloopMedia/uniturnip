import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:uniturnip/json_schema_ui/models/ui_model.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/examples/schemas.dart';
import 'package:uniturnip/json_schema_ui/models/mapPath.dart';

import 'package:provider/provider.dart';

int defaultPage = 4;
// final _data = List<Map<String, dynamic>>.from(Schemas.schemas[defaultPage]['formData']);
final _schema = Map<String, dynamic>.from(Schemas.schemas[defaultPage]['schema']);

MapPath path = MapPath();

void onUpdate(BuildContext context, MapPath path, dynamic value) {
  Provider.of<UIModel>(context, listen: false).modifyData(path, value);
}

void main() {
  late UIModel uiModel;
  setUpAll(() {
    uiModel = UIModel();
  });

  final WidgetData widgetData;
  widgetData = WidgetData(schema: _schema, path: path, onChange: onUpdate, disabled: false);
  test('disabled test', () {
    UIModel().setData(widgetData, widgetData.value);
    final result = uiModel.tester;
    expect(result, isTrue);
  });

}