import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class CheckboxWidget extends StatefulWidget {
  final WidgetData widgetData;

  const CheckboxWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget>{

  void _onChange(bool? value) {
    widget.widgetData.onChange(widget.widgetData.path, value);
  }

  @override
  Widget build(BuildContext context) {
    return WidgetUI(
      title: widget.widgetData.title,
      description: widget.widgetData.description,
      required: widget.widgetData.required,
      child: FormField(
        validator: (val) {
          if (val != true && widget.widgetData.required) return 'Required';
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
                CheckboxListTile(
                  activeColor: Colors.black,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  autofocus: widget.widgetData.autofocus,
                  value: true == widget.widgetData.value,
                  onChanged: (val) {
                    onChangedHandler(val);
                    widget.widgetData.disabled ? null : _onChange(val);
                  },
                  title: Text(widget.widgetData.title),
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
              ]
          );
        },
      ),
    );
  }
}
