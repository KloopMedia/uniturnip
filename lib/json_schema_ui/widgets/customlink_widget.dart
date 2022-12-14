import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';
import '../models/widget_data.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkWidget extends StatelessWidget {
  const LinkWidget({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {
    final String title = widgetData.title;
    final String description = widgetData.description;
    final bool required = widgetData.required;
    String link = widgetData.schema['default'] ?? widgetData.value ?? '';

    return WidgetUI(
      title: title,
      description: description,
      required: required,
      child: InkWell(
        child: Text(
          link,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.blue),
        ),
        onTap: () => launchUrl(Uri.parse(link)),
      ),
    );
  }
}
