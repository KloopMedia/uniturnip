import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/json_schema_ui/models/file_model.dart';
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
  late final String title = widget.widgetData.title;
  late final String description = widget.widgetData.description;
  late final bool required = widget.widgetData.required;
  late final bool _multiPick;
  late final bool _private;
  UploadTask? _uploadTask;
  late Map<String, dynamic> value;

  List<FileModel> _files = [];

  Map<String, dynamic> _parseValue(dynamic rawData) {
    if (rawData is String) {
      var parsedData = json.decode(rawData);
      return {...parsedData};
    } else if (rawData is Map) {
      return {...rawData};
    } else {
      return {};
    }
  }

  List<FileModel> _getDistinctFiles(files) {
    var seen = <String>{};
    return files.where((file) => seen.add(file.name)).toList();
  }

  void _encodeAndSave(Map<String, dynamic> value) {
    // Convert Map to JSON
    var encoded = json.encode(value);
    // Save new value in formData
    widget.widgetData.onChange(widget.widgetData.path, encoded);
  }

  void _showSnackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content, textAlign: TextAlign.center),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void initState() {
    value = _parseValue(widget.widgetData.value);
    if (value.keys.isNotEmpty) {
      for (var file in value.entries) {
        _files.add(FileModel(name: file.key, path: file.value));
      }
      setState(() {});
    }
    _multiPick = widget.widgetData.uiSchema['ui:options']?["multiple"] ?? false;
    _private = widget.widgetData.uiSchema['ui:options']?["private"] ?? false;
    super.initState();
  }

  void _pickFile(FileType type) async {
    try {
      final result = await FilePicker.platform.pickFiles(type: type);
      var paths = result?.paths;
      if (!mounted || paths == null || paths.isEmpty) return;

      for (var path in paths) {
        var uploadTask = await context.read<UIModel>().saveFile!(
          path!,
          type,
          private: _private,
        );

        setState(() {
          _uploadTask = uploadTask;
        });

        // When upload is finished get filename and firebase storage path
        final snapshot = await uploadTask!.whenComplete(() {});
        final name = snapshot.ref.name;
        final storagePath = snapshot.ref.fullPath;

        // Add file to preview list
        final files = [..._files, FileModel(name: name, path: storagePath, type: type)];
        final distinctFiles = _getDistinctFiles(files);
        setState(() {
          _files = distinctFiles;
        });

        // Make a copy of value and add new file entry
        var formData = {...value, name: storagePath};
        _encodeAndSave(formData);
      }
    } on PlatformException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  void openFile(String path) async {
    try {
      var file = await context.read<UIModel>().getFile!(path);
      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return Scaffold(
          body: GestureDetector(
            child: Center(
              child: Builder(builder: (context) {
                final url = file.url;
                if (url != null) {
                  if (file.type == FileType.image) {
                    return Hero(
                      tag: 'imageHero',
                      child: Image.network(url),
                    );
                  }
                }
                return const SizedBox.shrink();
              }),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        );
      }));
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void _removeFile(String name) {
    var files = [..._files];
    var val = {...value};
    files.removeWhere((element) => element.name == name);
    val.remove(name);
    _encodeAndSave(val);
    setState(() {
      _files = files;
      value = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WidgetUI(
      title: title,
      description: description,
      required: required,
      child: Column(
        children: [
          FileSelectorButtonGroup(onSelect: _pickFile),
          UploadProgress(task: _uploadTask),
          for (var file in _files)
            FileControlButtonGroup(
              name: file.name,
              onRemove: () {
                _removeFile(file.name);
              },
              onPreview: () {
                openFile(file.path);
              },
              onCopy: () {
                Clipboard.setData(ClipboardData(text: file.path)).then((_) {
                  _showSnackBar("Path copied!");
                });
              },
            )
        ],
      ),
    );
  }
}

class UploadProgress extends StatelessWidget {
  final UploadTask? task;

  const UploadProgress({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (task == null) return const SizedBox.shrink();

    return StreamBuilder<TaskSnapshot>(
      stream: task!.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          return Row(
            children: [
              Text(
                snap.ref.name,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              Expanded(child: LinearProgressIndicator(value: progress)),
              Text('${progress.toInt() * 100}'),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class FileSelectorButtonGroup extends StatelessWidget {
  final void Function(FileType type) onSelect;

  const FileSelectorButtonGroup({Key? key, required this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            onSelect(FileType.image);
          },
          icon: const Icon(Icons.image),
        ),
        IconButton(
          onPressed: () {
            onSelect(FileType.video);
          },
          icon: const Icon(Icons.video_file),
        ),
        IconButton(
          onPressed: () {
            onSelect(FileType.any);
          },
          icon: const Icon(Icons.insert_drive_file),
        )
      ],
    );
  }
}

class FileControlButtonGroup extends StatelessWidget {
  final String name;
  final void Function() onRemove;
  final void Function() onPreview;
  final void Function() onCopy;

  const FileControlButtonGroup({
    Key? key,
    required this.name,
    required this.onRemove,
    required this.onPreview,
    required this.onCopy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(name, overflow: TextOverflow.ellipsis)),
        IconButton(onPressed: onPreview, icon: const Icon(Icons.visibility)),
        IconButton(onPressed: onRemove, icon: const Icon(Icons.delete)),
        IconButton(onPressed: onCopy, icon: const Icon(Icons.copy)),
      ],
    );
  }
}
