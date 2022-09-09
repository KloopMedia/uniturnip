import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../json_schema_ui/models/widget_data.dart';
import 'widget_ui.dart';

class NumberWidget extends StatefulWidget {
  final WidgetData widgetData;

  const NumberWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  State<NumberWidget> createState() => _NumberWidgetState();
}

class _NumberWidgetState extends State<NumberWidget> {
  late final TextEditingController textControl;
  late final String title;
  late final String description;

  @override
  void initState() {
    final dynamic value = widget.widgetData.value;
    final String text = value != null ? value.toString() : '';
    textControl = TextEditingController(text: text);
    textControl.selection = TextSelection.fromPosition(
      TextPosition(offset: textControl.text.length),
    );
    super.initState();
  }

  @override
  void dispose() {
    textControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    title = widget.widgetData.title;
    description = widget.widgetData.description;

    return WidgetUI(
      title: title,
      description: description,
      required: widget.widgetData.required,
      child: Column(children: <Widget>[
        TextFormField(
          controller: textControl,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (val) => widget.widgetData.onChange(widget.widgetData.path, val),
          enabled: !widget.widgetData.disabled,
          autofocus: widget.widgetData.autofocus,
          readOnly: widget.widgetData.readonly,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.5, color: Colors.black45)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2.0, color: Colors.white70)),
          ),
          validator: RequiredValidator(errorText: 'Required'),
        ),
      ]),
    );
  }
}
