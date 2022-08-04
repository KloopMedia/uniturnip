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
  late bool isPreview;
  String? modifiedHtmlText;
  late final String defaultHtmlText;
  late final bool readonly;
  late final bool disabled;

  @override
  void initState() {
    readonly = widget.widgetData.readonly;
    disabled = widget.widgetData.disabled;
    defaultHtmlText = widget.widgetData.value ?? widget.widgetData.schema['default'] ?? '';
    isPreview = readonly || disabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (isPreview) {
      return Column(children: [
        Html(data: modifiedHtmlText ?? defaultHtmlText),
        !(readonly || disabled)
            ? TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary),
                onPressed: () {
                  setState(() => isPreview = false);
                },
                child: const Text('Edit rich text',
                    style: TextStyle(color: Colors.white)),
              )
            : const SizedBox.shrink()
      ]);
    } else {
      return GestureDetector(
        onTap: () {
          if (!kIsWeb) {
            controller.clearFocus();
          }
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HtmlEditor(
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
                ),
                callbacks: Callbacks(onInit: () {
                  if (modifiedHtmlText != null) {
                    if (modifiedHtmlText!.length > 6) {
                      controller.insertHtml(modifiedHtmlText!);
                    }
                  } else {
                    controller.insertHtml(defaultHtmlText);
                  }
                }, onChangeContent: (String? changed) {
                  setState(() {
                    if (changed != null) {
                      if (changed.length > 6 && changed.startsWith('<br>', 3)) {
                        modifiedHtmlText = changed.substring(11);
                      } else {
                        modifiedHtmlText = changed;
                      }
                    }
                  });
                }),
                otherOptions: const OtherOptions(height: 550),
              ),
              Center(
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary),
                      onPressed: () {
                        widget.widgetData.onChange(widget.widgetData.path, modifiedHtmlText);
                        setState(() => isPreview = true);
                      },
                      child: const Text('Preview rich text',
                          style: TextStyle(color: Colors.white)))),
            ]),
      );
    }
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
