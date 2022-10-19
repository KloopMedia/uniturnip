import 'package:flutter/material.dart';
import 'dart:async';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/utilities/date_time.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class DateTimeWidget extends StatefulWidget {
  final WidgetData widgetData;

  const DateTimeWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
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
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedDate != null && pickedTime != null) {
        final pickedDateTime = parseDateTime(pickedDate, pickedTime);
        widget.widgetData.onChange(widget.widgetData.path, pickedDateTime);
        textControl.text = pickedDateTime;
      }
    }

    return WidgetUI(
      title: widget.widgetData.title,
      description: widget.widgetData.description,
      required: widget.widgetData.required,
      child: TextFormField(
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
