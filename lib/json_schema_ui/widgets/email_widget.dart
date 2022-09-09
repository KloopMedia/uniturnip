import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class EmailWidget extends StatefulWidget {
  final WidgetData widgetData;

  const EmailWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  State<EmailWidget> createState() => _EmailWidgetState();
}

class _EmailWidgetState extends State<EmailWidget> {
  late final TextEditingController textControl;
  late final String title;
  late final String description;

  @override
  void initState() {
    textControl = TextEditingController(text: widget.widgetData.value ?? '');
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
      child: TextFormField(
        validator: MultiValidator([
          if (widget.widgetData.required) RequiredValidator(
            errorText: "Required",
          ),
          EmailValidator(
            errorText: "Please enter a valid email address",
          ),
        ]),
        controller: textControl,
        decoration: const InputDecoration(
          hintText: 'Email',
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.5, color: Colors.black45)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2.0, color: Colors.white70)),
        ),
        keyboardType: TextInputType.emailAddress,
        onChanged: (val) => widget.widgetData.onChange(widget.widgetData.path, val),
        enabled: !widget.widgetData.disabled,
        autofocus: widget.widgetData.autofocus,
        readOnly: widget.widgetData.readonly,
        autofillHints: const [AutofillHints.email],
      ),
    );
  }
}
