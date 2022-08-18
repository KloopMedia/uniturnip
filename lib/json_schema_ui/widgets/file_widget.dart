import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/json_schema_ui/models/ui_model.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';

import 'widget_ui.dart';

class FileWidget extends StatefulWidget {
  final WidgetData widgetData;

  const FileWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  State<FileWidget> createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  late final String title = widget.widgetData.title;
  late final String description = widget.widgetData.description;
  late final bool required = widget.widgetData.required;
  late final bool _multiPick;
  late final bool _private;
  // final FileType _pickingType = FileType.any;
  bool _isLoading = false;
  List<PlatformFile>? _files;

  @override
  void initState() {
    _multiPick = widget.widgetData.uiSchema['ui:options']?["multiple"] ?? false;
    _private = widget.widgetData.uiSchema['ui:options']?["private"] ?? false;
    super.initState();
  }

  // void _pickFiles() async {
  //   try {
  //     var result = await FilePicker.platform.pickFiles(
  //       type: _pickingType,
  //       allowMultiple: _multiPick,
  //     );
  //     _files = result?.files;
  //     var paths = result?.paths;
  //     if (!mounted || paths == null) return;
  //     var storagePath = await context.read<UIModel>().saveFile!(
  //       paths,
  //       private: _private,
  //     );
  //     widget.widgetData.onChange(widget.widgetData.path, storagePath);
  //   } on PlatformException catch (e) {
  //     _logException('Unsupported operation: $e');
  //   } catch (e) {
  //     _logException(e.toString());
  //   }
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  void _pickImage() async {
    try {
      var result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: _multiPick,
      );
      _files = result?.files;
      var paths = result?.paths;
      if (!mounted || paths == null) return;
      var storagePath = await context.read<UIModel>().saveFile!(
        paths,
        FileType.image,
        private: _private,
      );
      widget.widgetData.onChange(widget.widgetData.path, storagePath);
    } on PlatformException catch (e) {
      _logException('Unsupported operation: $e');
    } catch (e) {
      _logException(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _pickVideo() async {
    try {
      var result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: _multiPick,
      );
      _files = result?.files;
      var paths = result?.paths;
      if (!mounted || paths == null) return;
      var storagePath = await context.read<UIModel>().saveFile!(
        paths,
        FileType.video,
        private: _private,
      );
      widget.widgetData.onChange(widget.widgetData.path, storagePath);
    } on PlatformException catch (e) {
      _logException('Unsupported operation: $e');
    } catch (e) {
      _logException(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _pickDocument() async {
    try {
      var result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: _multiPick,
      );
      _files = result?.files;
      var paths = result?.paths;
      if (!mounted || paths == null) return;
      var storagePath = await context.read<UIModel>().saveFile!(
        paths,
        FileType.video,
        private: _private,
      );
      widget.widgetData.onChange(widget.widgetData.path, storagePath);
    } on PlatformException catch (e) {
      _logException('Unsupported operation: $e');
    } catch (e) {
      _logException(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _clearCachedFiles() async {
    _resetState();
    try {
      bool? result = await FilePicker.platform.clearTemporaryFiles();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: result! ? Colors.green : Colors.red,
          content: Text((result
              ? 'Temporary files removed with success.'
              : 'Failed to clean temporary files')),
        ),
      );
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _removeFile(int index) {
    if (_files != null) {
      var paths = _files!.toList();
      var removedFile = paths.removeAt(index);
      setState(() {
        _files = paths;
      });
      _logException('Removed file: ${removedFile.name}');
    }
  }

  void _logException(String message) {
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _files = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WidgetUI(
      title: title,
      description: description,
      required: required,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(onPressed: () {
                _pickImage();
              }, icon: const Icon(Icons.image)),
              IconButton(onPressed: () {
                _pickVideo();
              }, icon: const Icon(Icons.video_file)),
              IconButton(onPressed: () {
                _pickDocument();
              }, icon: const Icon(Icons.insert_drive_file))
            ],
          ),
          // ElevatedButton.icon(
          //   onPressed: () => _pickFiles(),
          //   icon: const Icon(Icons.upload),
          //   label: const Text('Load file'),
          // ),
          Builder(
            builder: (BuildContext context) {
              if (_isLoading) {
                return const CircularProgressIndicator();
              } else if (_files != null) {
                return Column(
                  children: [
                    ListTile(
                      title: const Text('Files'),
                      trailing: TextButton.icon(
                        onPressed: () => _clearCachedFiles(),
                        icon: const Icon(Icons.clear_all),
                        label: const Text('Clear all'),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) => ListTile(
                        title: Text('File $index: ${_files![index].name}'),
                        trailing: IconButton(
                          onPressed: () => _removeFile(index),
                          icon: const Icon(Icons.clear),
                        ),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                      itemCount: _files!.length,
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          )
        ],
      ),
    );
  }
}