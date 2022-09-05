import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:just_audio/just_audio.dart';
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
        Html(
          data:  modifiedHtmlText ?? defaultHtmlText,
          customRender: {
            "audio": (context, child) {
              final attrs = context.tree.element?.attributes;
              if (attrs != null) {
                String? src = attrs['src'] ?? "";
                return AudioPlayerWidget(url: src);
              }
            },
          },
        ),
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


class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late final AudioPlayer _audioPlayer;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer
        .setUrl(widget.url)
        .catchError((error) {
      print("An error occured: $error");
    });
    _audioPlayer.durationStream.listen((newDuration) {
      if (newDuration != null) {
        setState(() {
          duration = newDuration;
        });
      } else {
        setState(() {
          duration = Duration.zero;
        });
      }
    });
    _audioPlayer.positionStream.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Widget _playerButton(PlayerState playerState) {
    final processingState = playerState.processingState;
    if (_audioPlayer.playing != true) {
      return CupertinoButton(
        minSize: double.minPositive,
        padding: const EdgeInsets.only(left: 6.0),
        child: const Icon(Icons.play_arrow, color: Colors.black, size: 24),
        onPressed: () => _audioPlayer.play(),
      );
    } else if (processingState != ProcessingState.completed) {
      return CupertinoButton(
        minSize: double.minPositive,
        padding: const EdgeInsets.only(left: 6.0),
        child: const Icon(Icons.pause, color: Colors.black, size: 24),
        onPressed: () => _audioPlayer.pause(),
      );
    } else if (processingState == ProcessingState.completed){
      return CupertinoButton(
          minSize: double.minPositive,
          padding: const EdgeInsets.only(left: 6.0),
          child: const Icon(Icons.replay, color: Colors.black, size: 24),
          onPressed: () async {
            _audioPlayer.stop();
            await _audioPlayer.seek(Duration.zero);
            _audioPlayer.play();
          }
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _rewindButton() {
    return  CupertinoButton(
      minSize: double.minPositive,
      // padding: EdgeInsets.zero,
      padding: const EdgeInsets.only(left: 4.0),
      child: const Icon(Icons.replay_5, color: Colors.black, size: 24),
      onPressed: () async {
        await _audioPlayer.seek(Duration(seconds: _audioPlayer.position.inSeconds - 5));
      },
    );
  }

  Widget _forwardButton() {
    return  CupertinoButton(
      minSize: double.minPositive,
      // padding: EdgeInsets.zero,
      padding: const EdgeInsets.only(left: 6.0),
      child: const Icon(Icons.forward_5, color: Colors.black, size: 24),
      onPressed: () async {
        await _audioPlayer.seek(Duration(seconds: _audioPlayer.position.inSeconds + 5));
      },
    );
  }

  Widget _stopButton() {
    return  CupertinoButton(
      minSize: double.minPositive,
      // padding: EdgeInsets.zero,
      padding: const EdgeInsets.only(left: 6.0),
      child: const Icon(Icons.stop, color: Colors.black, size: 24),
      onPressed: () async {
        _audioPlayer.stop();
        await _audioPlayer.seek(Duration.zero);
      },
    );
  }

  String? time(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if(duration.inHours > 0) hours,
      minutes,
      seconds
    ].join(":");
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 75,
      child: Card(
        color: Colors.white70,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).colorScheme.outline,),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _rewindButton(),
                      StreamBuilder<PlayerState>(
                        stream: _audioPlayer.playerStateStream,
                        builder: (context, snapshot) {
                          final playerState = snapshot.data;
                          if (playerState != null) {
                            return _playerButton(playerState);
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      _forwardButton(),
                      _stopButton(),
                    ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder<Duration?>(
                      stream: _audioPlayer.durationStream,
                      builder: (context, snapshot) {
                        final duration = snapshot.data ?? Duration.zero;
                        return StreamBuilder<Duration>(
                          stream: _audioPlayer.positionStream,
                          builder: (context, snapshot) {
                            var position = snapshot.data ?? Duration.zero;
                            if (position > duration) {
                              position = duration;
                            }
                            return SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.black,
                                inactiveTrackColor: Colors.grey,
                                trackShape: const RectangularSliderTrackShape(),
                                trackHeight: 3.0,
                                thumbColor: Colors.black,
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                                //overlayColor: Colors.red.withAlpha(32),
                                overlayShape: const RoundSliderOverlayShape(overlayRadius: 10.0),
                              ),
                              child: Expanded(
                                child: Slider(
                                  min: 0,
                                  max: duration.inSeconds.toDouble(),
                                  value: position.inSeconds.toDouble(),
                                  onChanged: (newPosition) async {
                                    final position = Duration(seconds: newPosition.toInt());
                                    await _audioPlayer.seek(position);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Text('${time(position) ?? ""} / ${time(duration) ?? ""}')
                    // Text('${time(position) ?? ""} / ${time(duration - position) ?? ""}')
                  ],
                )
              ]
          ),
        ),
      ),
    );
  }
}
