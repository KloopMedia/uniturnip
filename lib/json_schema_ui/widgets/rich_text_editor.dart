import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:flutter_html/flutter_html.dart';
import '../models/widget_data.dart';

/// чтобы запустить web версию:
/// flutter build web --web-renderer html
/// flutter run --web-renderer html

class RichTextEditor extends StatefulWidget {
  const RichTextEditor({Key? key, required this.widgetData}) : super(key: key);

  final WidgetData widgetData;

  @override
  State<RichTextEditor> createState() => RichTextEditorState();
}

class RichTextEditorState extends State<RichTextEditor> {
  final HtmlEditorController controller = HtmlEditorController();
  bool isPreview = false;
  var htmlText;
  var modifiedHtmlText;
  var defaultHtmlText;
  bool readonly = true;
  bool disabled = true;

  @override
  void initState() {
    readonly = widget.widgetData.readonly;
    disabled = widget.widgetData.disabled;
    defaultHtmlText = widget.widgetData.schema['default'];
    isPreview = readonly == true && disabled == true ? true : false;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    if (htmlText.toString().length > 6 &&
        htmlText.toString().startsWith('<br>', 3)) {
      modifiedHtmlText = htmlText.toString().substring(11);
    } else {
      modifiedHtmlText = htmlText;
    }

    if (readonly == true && disabled == true) widget.widgetData.onChange(context, widget.widgetData.path, defaultHtmlText);

    return isPreview == true
        ? Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                      child: Html(data: modifiedHtmlText ?? defaultHtmlText ?? ''))
              ),
              readonly == false && disabled == false
                  ? TextButton(
                      style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
                      onPressed: () {
                        setState(() => isPreview = false);
                      },
                      child: const Text('Edit rich text', style: TextStyle(color: Colors.white)),
                  )
                  : Container()
            ]
          )
        : GestureDetector(
            onTap: () {
              if (!kIsWeb) {
                controller.clearFocus();
              }
            },
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SingleChildScrollView(
                      // child: Text("DDDD")
                      child: HtmlEditor(
                        controller: controller,
                        htmlEditorOptions: const HtmlEditorOptions(
                          autoAdjustHeight: false,
                          hint: 'Your text here...',
                          shouldEnsureVisible: true,
                        ),
                        htmlToolbarOptions: HtmlToolbarOptions(
                          toolbarPosition: ToolbarPosition.aboveEditor,
                          toolbarType: ToolbarType.nativeScrollable,
                          toolbarItemHeight: 50.0,
                          gridViewVerticalSpacing: 3,
                          gridViewHorizontalSpacing: 3,
                          renderBorder: true,
                          renderSeparatorWidget: false,
                          dropdownMenuMaxHeight: 600.0,
                          defaultToolbarButtons: const [
                            StyleButtons(),
                            FontSettingButtons(fontSizeUnit: false),
                            FontButtons(),
                            ColorButtons(),
                            ParagraphButtons(
                              caseConverter: false,
                              textDirection: false,
                              increaseIndent: false,
                              decreaseIndent: false,
                            ),
                            ListButtons(),
                          ],
                          customToolbarButtons: [
                            UndoRedoButtons(controller: controller)
                          ],
                          onButtonPressed: (ButtonType type, bool? status,
                              Function? updateStatus) {
                            return true;
                          },
                          onDropdownChanged: (DropdownType type,
                              dynamic changed,
                              Function(dynamic)? updateSelectedItem) {
                            return true;
                          },
                        ),
                        callbacks: Callbacks(onInit: () {
                          if (modifiedHtmlText.toString().length > 6) {
                            controller.insertHtml(modifiedHtmlText);
                          } else {
                            controller.insertHtml(defaultHtmlText);
                          }
                        }, onChangeContent: (String? changed) {
                          setState(() => htmlText = changed);
                        }),
                        otherOptions: const OtherOptions(height: 550),
                      ),
                    ),
                    Center(
                        child: TextButton(
                            style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
                            onPressed: () {
                              setState(() => isPreview = true);
                              widget.widgetData.onChange(context, widget.widgetData.path, modifiedHtmlText);
                            },
                            child: const Text('Preview rich text', style: TextStyle(color: Colors.white)))
                    ),
                  ]
              ),
            ),
          );
  }
}

class UndoRedoButtons extends StatelessWidget {
  const UndoRedoButtons({Key? key, required this.controller}) : super(key: key);

  final HtmlEditorController controller;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          width: 50.0,
          height: 50.0,
          decoration: const BoxDecoration(
              border: Border.fromBorderSide(
                  BorderSide(color: Color(0xffd0d0d0), width: 1))),
          child: IconButton(
            icon: const Icon(Icons.undo),
            onPressed: () {
              controller.undo();
            },
          )),
      Container(
          width: 50.0,
          height: 50.0,
          decoration: const BoxDecoration(
              border: Border.fromBorderSide(
                  BorderSide(color: Color(0xffd0d0d0), width: 1))),
          child: IconButton(
            icon: const Icon(Icons.redo),
            onPressed: () {
              controller.redo();
            },
          ))
    ]);
  }
}
