import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/json_schema_ui/fields/object_field.dart';

import 'models/models.dart';

typedef ChangeCallback = void Function({
  required MapPath path,
  required Map<String, dynamic> data,
});

typedef SubmitCallback = void Function({
  required Map<String, dynamic> data,
});

typedef SaveAudioRecordCallback = Future<String> Function(XFile file, bool private);

typedef UploadFileCallback = Future<UploadTask?> Function(
  XFile file,
  String? path,
  FileType type, {
  bool private,
});

typedef GetFileCallback = Future<FileModel> Function(String path);

class JSONSchemaUI extends StatelessWidget {
  final Map<String, dynamic> schema;
  final Map<String, dynamic> ui;
  final Map<String, dynamic> data;
  final ChangeCallback? onUpdate;
  final SubmitCallback? onSubmit;
  final SaveAudioRecordCallback? saveAudioRecord;
  final UploadFileCallback? saveFile;
  final GetFileCallback? getFile;
  final UIModel _formController;
  final bool hideSubmitButton;

  JSONSchemaUI({
    Key? key,
    required this.schema,
    this.ui = const {},
    this.data = const {},
    this.onUpdate,
    this.onSubmit,
    this.saveAudioRecord,
    this.saveFile,
    this.hideSubmitButton = false,
    UIModel? formController,
    this.getFile,
  })  : _formController = formController ??
            UIModel(
              data: data,
              onUpdate: onUpdate,
              saveAudioRecord: saveAudioRecord,
              saveFile: saveFile,
              getFile: getFile,
            ),
        super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UIModel>.value(
      value: _formController,
      // create: (context) => UIModel(
      //   data: data,
      //   onUpdate: onUpdate,
      //   saveAudioRecord: saveAudioRecord,
      // ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              JSONSchemaUIField(
                schema: schema,
                ui: ui,
                disabled: false,
              ),

              // Button that submit the whole form using global key
              Builder(builder: (context) {
                if (hideSubmitButton) {
                  return const SizedBox.shrink();
                }
                return Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: context.read<UIModel>().disabled
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              onSubmit!(data: context.read<UIModel>().data);
                            } else {
                              print('validation failed');
                              _showFormSnackBar(context, 'Your form has empty fields. Please correct them and submit again.');
                            }
                          },
                    child: Text(
                      "Submit",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  void _showFormSnackBar(BuildContext context, String content) {
    final snackBar = SnackBar(
      duration: const Duration(minutes: 3),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(30.0),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Text(content, style: Theme.of(context).textTheme.headlineMedium),
      backgroundColor: (Colors.redAccent),
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
