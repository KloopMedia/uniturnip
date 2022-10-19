import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/json_schema_ui/models/file_model.dart';
import 'package:uniturnip/json_schema_ui/models/ui_model.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:video_player/video_player.dart';

import 'widget_ui.dart';

class FileWidget extends StatefulWidget {
  final WidgetData widgetData;

  const FileWidget({Key? key, required this.widgetData}) : super(key: key);

  @override
  State<FileWidget> createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget> {
  late String title;
  late String description;
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
      final ImagePicker picker = ImagePicker();
      XFile? file;
      switch (type) {
        case FileType.image:
          file = await picker.pickImage(source: ImageSource.gallery);
          break;
        case FileType.video:
          file = await picker.pickVideo(source: ImageSource.gallery);
          break;
        default:
          final result = await FilePicker.platform.pickFiles(type: type, withData: true);
          if (result != null && result.files.isNotEmpty) {
            final fileBytes = result.files.first.bytes;
            final name = result.files.first.name;
            if (fileBytes != null) {
              file = XFile.fromData(
                fileBytes,
                name: name,
              );
            }
          }
      }
      if (!mounted || file == null) return;

      // for (var file in files) {
      var uploadTask = await context.read<UIModel>().saveFile!(
        file,
        kIsWeb ? null : file.path,
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
      // }
    } on PlatformException catch (e) {
      print('File upload Platform Exception $e');
    } catch (e) {
      print('File upload other error $e');
    }
  }

  void openFile(String path) async {
    try {
      var file = context.read<UIModel>().getFile!(path);
      if (!mounted) return;
      Navigator.push(
        context,
        DialogRoute(
          context: context,
          builder: (_) {
            return Center(
              child: Dismissible(
                key: const Key("file-preview"),
                direction: DismissDirection.vertical,
                onDismissed: (_) {
                  Navigator.of(context).pop();
                },
                child: FutureBuilder(
                  future: file,
                  builder: (BuildContext context, AsyncSnapshot<FileModel> snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasData) {
                      final file = snapshot.data!;
                      final url = file.url;
                      if (url == null) {
                        return const Text('Error: Failed to load the file! No file url!');
                      }
                      if (file.type == FileType.image) {
                        return ImageViewerWidget(url: url);
                      } else if (file.type == FileType.video) {
                        return VideoPlayerWidget(url: url);
                      } else {
                        // AnchorElement(href: url)
                        //   ..setAttribute('download', file.name)
                        //   ..click();
                        return const Text(
                          'Error: Failed to load the file! File type not supported for preview!',
                        );
                      }
                    }
                    return const Text('Error: Failed to load the file!');
                  },
                ),
              ),
            );
          },
        ),
      );
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
    title = widget.widgetData.title;
    description = widget.widgetData.description;

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
      builder: (context, asyncSnapshot) {
        TaskSnapshot? snapshot = asyncSnapshot.data;

        if (asyncSnapshot.hasError) {
          if (asyncSnapshot.error is FirebaseException &&
              (asyncSnapshot.error as FirebaseException).code == 'canceled') {
            return const Text('Upload canceled.');
          } else {
            print(asyncSnapshot.error);
            return const Text('Something went wrong.');
          }
        } else if (snapshot != null) {
          final progress = snapshot.bytesTransferred / snapshot.totalBytes;
          if (progress < 1) {
            return Row(
              children: [
                Flexible(
                  child: Text(
                    snapshot.ref.name,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(child: LinearProgressIndicator(value: progress)),
                Text('${progress.toInt() * 100}'),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        }
        return const SizedBox.shrink();
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
        ElevatedButton.icon(
          onPressed: () {
            onSelect(FileType.image);
          },
          icon: const Icon(Icons.image),
          label: const Text('Image'),
        ),
        const SizedBox(
          width: 8,
        ),
        ElevatedButton.icon(
          onPressed: () {
            onSelect(FileType.video);
          },
          icon: const Icon(Icons.video_file),
          label: const Text('Video'),
        ),
        const SizedBox(
          width: 8,
        ),
        ElevatedButton.icon(
          onPressed: () {
            onSelect(FileType.any);
          },
          icon: const Icon(Icons.file_present),
          label: const Text('File'),
        ),
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

class ImageViewerWidget extends StatelessWidget {
  final String url;

  const ImageViewerWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: url,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  const VideoPlayerWidget({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          autoPlay: true,
        );
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController.value.isInitialized) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Chewie(controller: chewieController),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
  }
}
