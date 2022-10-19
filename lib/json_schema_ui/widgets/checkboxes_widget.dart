import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class CheckboxesWidget extends StatefulWidget {
  final WidgetData widgetData;

  const CheckboxesWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  State<CheckboxesWidget> createState() => _CheckboxesWidgetState();
}

class _CheckboxesWidgetState extends State<CheckboxesWidget> {
  late List checkedItems;
  late List items;

  @override
  void initState() {
    checkedItems = [];
    items = widget.widgetData.schema['enum'] ?? [];
    super.initState();
  }

  void _onChange(String value, bool checked) {
    checked ? checkedItems.add(value) : checkedItems.remove(value);
    widget.widgetData.onChange(widget.widgetData.path, checkedItems);
  }

  @override
  Widget build(BuildContext context) {
    List values = widget.widgetData.value ?? [];

    return WidgetUI(
      title: widget.widgetData.title,
      description: widget.widgetData.description,
      required: widget.widgetData.required,
      child: FormField(
        validator: (val) {
          if (widget.widgetData.required && values.isEmpty) return 'Required';
          return null;
        },
        builder: (FormFieldState<bool> state) {
          void onChangedHandler(bool? value) {
            setState(() {
              state.didChange(value);
            });
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int index = 0; index < items.length; index++)
                CheckboxListTile(
                  activeColor: Colors.black,
                  controlAffinity: ListTileControlAffinity.leading,
                  autofocus: widget.widgetData.autofocus,
                  title: Text(items[index]),
                  value: values.contains(items[index]),
                  onChanged: (val) {
                    onChangedHandler(val);
                    widget.widgetData.disabled ? null : _onChange(items[index], val!);
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
