import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class RadioWidget extends StatefulWidget {
  const RadioWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {

  String _getName(List items, List names, int index) {
    if (index < names.length && names[index] != null) {
      return names[index].toString();
    } else {
      return items[index].toString();
    }
  }

  void _onChange(String? value) {
    widget.widgetData.onChange(widget.widgetData.path, value);
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.widgetData.title;
    final String description = widget.widgetData.description;
    final String type = widget.widgetData.type;

    final List items = [];
    final List names = [];

    if (type == 'boolean') {
      items.addAll([true, false]);
      if (!widget.widgetData.schema.containsKey('enumNames')) {
        names.addAll(['Yes', 'No']);
      }
    } else {
      items.addAll(widget.widgetData.schema['enum']);
      if (widget.widgetData.schema.containsKey('enumNames')) {
        names.addAll(widget.widgetData.schema['enumNames']);
      }
    }

    return WidgetUI(
      title: title,
      description: description,
      required: widget.widgetData.required,
      child: FormField(
        validator: (val) {
          if (val == null && widget.widgetData.required) return 'Required';
          return null;
        },
        builder: (FormFieldState<String> state) {
          void onChangedHandler(String? value) {
            setState(() {
              state.didChange(value);
            });
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int index = 0; index < items.length; index++)
                RadioListTile(
                  activeColor: Colors.black,
                  title: Text(
                    _getName(items, names, index),
                    style: const TextStyle(fontFamily: 'Open-Sans', fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  value: items[index],
                  groupValue: widget.widgetData.value,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (dynamic val) {
                    onChangedHandler(val);
                    widget.widgetData.disabled ? null : _onChange(val);
                  },
                ),
              state.isValid
                  ? const SizedBox.shrink()
                  : Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      state.errorText ?? "",
                      style: TextStyle(color: Colors.red[700], fontSize: 12.0),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}
