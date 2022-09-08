import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class SelectWidget extends StatelessWidget {
  const SelectWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  void _onChange(dynamic value) {
    widgetData.onChange(widgetData.path, value);
  }

  @override
  Widget build(BuildContext context) {
    String title = widgetData.title;
    String description = widgetData.description;

    String type = widgetData.schema['type'];

    List items = [null];
    List names = [""];

    if (type == 'boolean') {
      items.addAll([true, false]);
      if (widgetData.schema['enumNames'] == null) {
        names.addAll(['Yes', 'No']);
      }
    } else {
      items.addAll(widgetData.schema['enum']);
      if (widgetData.schema['enumNames'] != null) {
        names.addAll(widgetData.schema['enumNames']);
      }
    }

    return WidgetUI(
      title: title,
      description: description,
      required: widgetData.required,
      child: DropdownButtonFormField(
        autofocus: widgetData.autofocus,
        hint: const Text('Select item'),
        value: widgetData.value,
        isExpanded: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.5, color: Colors.black45)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2.0, color: Colors.white70)),
        ),
        onChanged: widgetData.disabled ? null : _onChange,
        items: items.mapIndexed<DropdownMenuItem>(
          (index, item) {
            return DropdownMenuItem(
              alignment: AlignmentDirectional.centerStart,
              enabled: !widgetData.disabled,
              value: item,
              child: Text(names.asMap().containsKey(index) ? names[index] : item.toString()),
            );
          },
        ).toList(),
      ),
    );
  }
}
