import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  UploadTask? _uploadTask;

  bool _isLoading = false;
  List<PlatformFile>? _files;
  Set<FileModel> files = {};

  @override
  void initState() {
    print('FILE VALUE ${widget.widgetData.value}');
    // _files = widget.widgetData.value;
    _multiPick = widget.widgetData.uiSchema['ui:options']?["multiple"] ?? false;
    _private = widget.widgetData.uiSchema['ui:options']?["private"] ?? false;
    super.initState();
  }

  void _pickFile(FileType type) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: type,
      );
      _files = result?.files;
      var paths = result?.paths;
      if (!mounted || paths == null) return;
      print(paths);
      if (paths.isNotEmpty) {
        for (var path in paths) {
          var uploadTask = await context.read<UIModel>().saveFile!(
            path!,
            type,
            private: _private,
          );
          print('PATH: ${uploadTask?.snapshot.ref.fullPath}');
          setState(() {
            _uploadTask = uploadTask;
          });
          final snapshot = await uploadTask!.whenComplete(() {});
          final name = snapshot.ref.name;
          final storagePath = snapshot.ref.fullPath;
          setState(() {
            files.add(FileModel(name: name, path: storagePath));
          });
          Map<String, dynamic> data;
          var rawData = widget.widgetData.value;
          if (rawData is String) {
            var parsedData = json.decode(rawData);
            data = {...parsedData, name: storagePath};
          } else if (rawData is Map) {
            data = {...rawData, name: storagePath};
          } else {
            data = {name: storagePath};
          }
          print("DATA: ${json.encode(data)}");
          var encoded = json.encode(data);
          widget.widgetData.onChange(widget.widgetData.path, encoded);
        }
      }
    } on PlatformException catch (e) {
      _logException('Unsupported operation: $e');
    } catch (e) {
      _logException(e.toString());
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
              child: Hero(
                tag: 'imageHero',
                child: Image.file(file),
              ),
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
        children: [
          FileSelectorButtonGroup(onSelect: _pickFile),
          UploadProgress(task: _uploadTask),
          for (var file in files) Text(file.name)
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
          // return Text('$progress');
          return Row(
            children: [
              Text(snap.ref.name),
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

class FileModel {
  String name;
  String? path;
  String? url;

  FileModel({
    required this.name,
    this.path,
    this.url,
  });
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
            icon: const Icon(Icons.image)),
        IconButton(
            onPressed: () {
              onSelect(FileType.video);
            },
            icon: const Icon(Icons.video_file)),
        IconButton(
            onPressed: () {
              onSelect(FileType.any);
            },
            icon: const Icon(Icons.insert_drive_file))
      ],
    );
  }
}
