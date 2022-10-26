import 'package:flutter/material.dart';
import 'dart:async';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/utilities/date_time.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  late final TextEditingController textControl;

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
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
      );
      // TODO: Check if onChange below is necessary.
      if (pickedDate != null) {
        final date = parseDate(pickedDate);
        widget.widgetData.onChange(widget.widgetData.path, date);
        textControl.text = date;
      }
    }

    return WidgetUI(
      title: widget.widgetData.title,
      description: widget.widgetData.description,
      required: widget.widgetData.required,
      child: TextFormField(
        style: Theme.of(context).textTheme.headlineSmall,
        validator: (val) {
          if ((val == null || val.isEmpty) && widget.widgetData.required) return 'Required';
          return null;
        },
        controller: textControl,
        onChanged: (val) => widget.widgetData.onChange(widget.widgetData.path, val),
        enabled: !widget.widgetData.disabled,
        keyboardType: TextInputType.datetime,
        autofocus: widget.widgetData.autofocus,
        readOnly: true,
        onTap: () => _selectDate(context),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1.5, color: Colors.black45)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2.0, color: Colors.white70)),
          suffixIcon: IconButton(
            onPressed: () => _selectDate(context),
            icon: const Icon(Icons.calendar_today),
          ),
        ),
      ),
    );
  }
}
