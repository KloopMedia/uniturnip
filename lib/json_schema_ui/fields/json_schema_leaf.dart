import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/json_schema_ui/fields/json_schema_field.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/utils.dart';
import 'package:uniturnip/json_schema_ui/models/ui_model.dart';

import '../models/mapPath.dart';

class JSONSchemaFinalLeaf extends JSONSchemaUIField {
  JSONSchemaFinalLeaf({
    Key? key,
    required Map<String, dynamic> schema,
    Map<String, dynamic> ui = const {},
    required MapPath path,
    required dynamic pointer,
  }) : super(key: key, schema: schema, ui: ui, pointer: pointer, path: path);

  void onUpdate(BuildContext context, MapPath path, dynamic value) {
    Provider.of<UIModel>(context, listen: false).modifyData(path, value);
  }

  @override
  Widget build(BuildContext context) {
    dynamic data = context.select((UIModel uiModel) => uiModel.getDataByPath(path));
    final WidgetData widgetData = WidgetData(
      schema: schema,
      value: data,
      path: path,
      uiSchema: ui,
      onChange: onUpdate,
      readonly: ui['ui:readonly'] ?? false,
      disabled: ui['ui:disabled'] ?? false
    );
    
    Widget formWidget = Utils.formWidget(widgetData);

    return Padding(padding: EdgeInsets.symmetric(vertical: path.length() > 1 ? 2 : 4), child: formWidget);
  }
}
