import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/json_schema_ui/fields/object_field.dart';
import 'package:uniturnip/json_schema_ui/fields/widget_field.dart';
import 'package:uniturnip/json_schema_ui/models/mapPath.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/utils.dart';
import 'package:uniturnip/json_schema_ui/models/ui_model.dart';

class JSONSchemaFinalLeaf extends JSONSchemaUIField {
  final bool required;
  final bool disabled;

  JSONSchemaFinalLeaf({
    Key? key,
    required Map<String, dynamic> schema,
    Map<String, dynamic> ui = const {},
    required MapPath path,
    required dynamic pointer,
    required this.required,
    required this.disabled,
  }) : super(
          key: key,
          schema: schema,
          ui: ui,
          pointer: pointer,
          path: path,
          disabled: disabled,
        );

  @override
  Widget build(BuildContext context) {
    return Consumer<UIModel>(builder: (context, uiModel, _) {
      dynamic data = uiModel.getDataByPath(path);
      final WidgetData widgetData = WidgetData(
          schema: schema,
          value: data,
          path: path,
          uiSchema: ui,
          disabled: ui['ui:disabled'] ?? uiModel.disabled,
          readonly: ui['ui:readonly'] ?? false,
          required: required,
          onChange: (path, value) {
            uiModel.modifyData(path, value);
          });

      String widgetType = Utils.getWidgetType(widgetData);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: WidgetField(
          widgetType: widgetType,
          widgetData: widgetData,
        ),
      );
    });
  }
}
