import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class TextareaWidget extends StatefulWidget {
  final WidgetData widgetData;

  const TextareaWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  State<TextareaWidget> createState() => _TextareaWidgetState();
}

class _TextareaWidgetState extends State<TextareaWidget> {
  late final TextEditingController textControl;

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
    return WidgetUI(
      title: widget.widgetData.title,
      description: widget.widgetData.description,
      required: widget.widgetData.required,
      child: TextFormField(
        validator: (val) {
          if (widget.widgetData.required && (val == null || val.isEmpty)) return 'Required';
          return null;
        },
        style: Theme.of(context).textTheme.headlineSmall,
        controller: textControl,
        onChanged: (val) => widget.widgetData.onChange(widget.widgetData.path, val),
        enabled: !widget.widgetData.disabled,
        autofocus: widget.widgetData.autofocus,
        readOnly: widget.widgetData.readonly,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.5, color: Colors.black45)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2.0, color: Colors.white70)),
        ),
        maxLines: null,
        minLines: 4,
      ),
    );
  }
}
