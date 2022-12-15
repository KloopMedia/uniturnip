import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class CheckboxWidget extends StatelessWidget {
  final WidgetData widgetData;

  const CheckboxWidget({Key? key, required this.widgetData}) : super(key: key);

  void _onChange(bool? value) {
    widgetData.onChange(widgetData.path, value);
  }

  @override
  Widget build(BuildContext context) {
    return WidgetUI(
      title: widgetData.title,
      description: widgetData.description,
      required: widgetData.required,
      child: FormField(
        validator: (val) {
          if (widgetData.value != true && widgetData.required) return 'Required.';
          return null;
        },
        builder: (state) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  activeColor: Colors.black,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  autofocus: widgetData.autofocus,
                  value: true == widgetData.value,
                  onChanged: (val) {
                    widgetData.disabled ? null : _onChange(val);
                    state.didChange(val);
                  },
                  title: Text(widgetData.title, style: Theme.of(context).textTheme.headlineSmall,),
                ),
                Text(
                  state.errorText ?? "",
                  style: TextStyle(color: Colors.red[700], fontSize: 12.0),
                ),
              ]
          );
        },
      ),
    );
  }
}
