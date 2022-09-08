import 'package:file_picker/file_picker.dart';

class FileModel {
  final String name;
  final String path;
  final String? url;
  final FileType? type;

  const FileModel({
    required this.name,
    required this.path,
    this.type,
    this.url,
  });
}