import 'package:flutter/material.dart';
import '../../../../json_schema_ui/models/widget_data.dart';

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {
    String title = widgetData.schema['title'] ?? '';

    return FormField(
      builder: (state) {
        return CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            autofocus: widgetData.autofocus,
            value: true == widgetData.value,
            onChanged: (dynamic newValue) {
              widgetData.onChange(context, widgetData.path, newValue);
            },
            title: Text(title),
            subtitle: Visibility(
              visible: widgetData.value == null,
              child: Text(
                'Required',
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
            ));
      },
      validator: (value) {
        if (widgetData.value == null) {
          return 'Required';
        } else {
          return null;
        }
      },
    );
  }
}
