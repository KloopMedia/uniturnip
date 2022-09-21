import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/json_schema_ui/models/ui_model.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/utilities/audio_recorder.dart';
import 'package:uniturnip/json_schema_ui/widgets/widget_ui.dart';

class AudioWidget extends StatefulWidget {
  final WidgetData widgetData;

  const AudioWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  late final String defaultValue;
  late final String? value;
  late final bool private;

  Future<String?> getAudio(BuildContext context) async {
    if (value != null) {
      if (value!.isEmpty) {
        return null;
      }
      final file = await context.read<UIModel>().getFile!(value!);
      return file.url;
    }
    return null;
  }

  @override
  void initState() {
    defaultValue = widget.widgetData.uiSchema['ui:options']['default'] ?? "";
    private = widget.widgetData.uiSchema['ui:options']?["private"] ?? false;
    value = widget.widgetData.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetUI(
      title: widget.widgetData.title,
      description: widget.widgetData.description,
      required: widget.widgetData.required,
      child: FutureBuilder(
        initialData: defaultValue,
        future: getAudio(context),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          }
          return AudioRecorder(
            disabled: widget.widgetData.disabled,
            isExternal: defaultValue.isNotEmpty,
            url: snapshot.data,
            onRecorderStop: (file) async {
              var storagePath = await context.read<UIModel>().saveAudioRecord!(file, private);
              widget.widgetData.onChange(widget.widgetData.path, storagePath);
            },
          );
        },
      ),
    );
  }
}
