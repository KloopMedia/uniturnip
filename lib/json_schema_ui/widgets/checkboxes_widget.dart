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
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int index = 0; index < items.length; index++)
                CheckboxListTile(
                  activeColor: Colors.black,
                  controlAffinity: ListTileControlAffinity.leading,
                  autofocus: widget.widgetData.autofocus,
                  title: Text(items[index], style: Theme.of(context).textTheme.headlineSmall,),
                  value: values.contains(items[index]),
                  onChanged: (val) {
                    widget.widgetData.disabled ? null : _onChange(items[index], val!);
                    state.didChange(val);
                  },
                ),
              Text(
                state.errorText ?? "",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.red[700]),
              ),
            ],
          );
        },
      ),
    );
  }
}
