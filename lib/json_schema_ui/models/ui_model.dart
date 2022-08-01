import 'dart:collection';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/fields/json_schema_field.dart';
import '../fields/json_schema_leaf.dart';
import 'mapPath.dart';
import '../utils.dart';
import 'widget_data.dart';

class UIModel extends ChangeNotifier {
  UIModel({Map<String, dynamic> data = const {}, this.onUpdate}) : _data = data;

  Map<String, dynamic> _data;
  bool _isExternal = false;

  bool get isExternal => _isExternal;

  // late WidgetData widgetData;

  set data(Map<String, dynamic> value) {
    _data = value;
    _isExternal = true;
    notifyListeners();
    // onUpdate!(path: MapPath(), data: _data);
  }



  void Function({required MapPath path, required Map<String, dynamic> data})?
      onUpdate;

  UnmodifiableMapView<String, dynamic> get data =>
      UnmodifiableMapView<String, dynamic>(_data);

  void modifyData(MapPath path, dynamic value) {
    _data = Utils.modifyMapByPath(path, _data, value);
    _isExternal = false;
    notifyListeners();
    onUpdate!(path: path, data: data);
  }

  void addArrayElement(MapPath path) {
    List<dynamic>? array = Utils.getDataBypath(path, _data);
    if (array == null) {
      _data = Utils.modifyMapByPath(path, _data, [null, null]);
    } else {
      int arrayLength = array.length;
      MapPath newPath = path.add('leaf', arrayLength);
      _data = Utils.modifyMapByPath(newPath, _data, null);
    }
    _isExternal = false;
    notifyListeners();
    onUpdate!(path: path, data: data);
  }

  void removeArrayElement(MapPath path) {
    List<dynamic>? array = Utils.getDataBypath(path, _data);
    if (array != null && array.length > 1) {
      array.removeLast();
      _data = Utils.modifyMapByPath(path, _data, array);
      _isExternal = false;
      notifyListeners();
      onUpdate!(path: path, data: data);
    }
  }

  getDataByPath(MapPath path) {
    return Utils.getDataBypath(path, _data);
  }

  /// -------------- for ReaderWidget --------------

  TextSpan _sentenceAsTextSpan = const TextSpan();
  TextSpan get sentenceAsTextSpan => _sentenceAsTextSpan;

  String _clickedWord = '';
  String get clickedWord => _clickedWord;

  String _translation = '';
  String get translation => _translation;

  final List<String> _sentenceAsList = [];
  List<String> get sentenceAsList => _sentenceAsList;

  List<Map<String, dynamic>> _dataValue = [];
  List<Map<String, dynamic>> get dataValue => _dataValue;

  int _index = 0;
  int get index => _index;

  List<String> _clickedWordList = [];
  List<String> get clickedWordList => _clickedWordList;

  List<String> _translationList = [];
  List<String> get translationList => _translationList;

  void setData(WidgetData widgetData, List<Map<String, dynamic>> value) {
    if (widgetData.disabled == true) {

    } else {
      _dataValue = value;
    }

  }

  void getSentenceAsList() {
    sentenceAsList.clear();
    for (var map in dataValue) {
      _sentenceAsList.add(map['word']);
    }
  }

  void getTextSpan(WidgetData widgetData, BuildContext context) {
    final List<TextSpan> arrayOfTextSpan = [];

    for (int index = 0; index < sentenceAsList.length; index++) {
      arrayOfTextSpan.add(TextSpan(text: sentenceAsList[index] + ' '));
    }

    _sentenceAsTextSpan = TextSpan(
        children: arrayOfTextSpan
            .map((e) => TextSpan(
            text: e.text,
            style: TextStyle(
              fontSize: 20.0,
              color: (_clickedWord == e.text) ? Colors.greenAccent : Colors.black,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _clickedWord = e.text!;
                getTextSpan(widgetData, context);
                getTranslate();
                changeCount(widgetData, context);
                addToWordsList();
                notifyListeners();
              }))
            .toList());
  }

  void hideClickedWord() {
    _clickedWord = '';
    notifyListeners();
  }

  void getTranslate() {
    var wordWithoutSpace = clickedWord.substring(0, clickedWord.length - 1);
    _index = sentenceAsList.indexOf(wordWithoutSpace);
    _translation = dataValue[index]['translation'];
  }

  void changeCount(WidgetData widgetData, BuildContext context) {
    List<Map<String, dynamic>> copyDataList = List.from(dataValue);
    Map<String, dynamic> copyDataMap = {...dataValue[index]};
    copyDataMap['count'] = copyDataMap['count'] + 1;
    if (copyDataMap['count'] == 1) {
      if (copyDataMap['active'] == true)  copyDataMap['active'] = false;
    }
    copyDataList.removeAt(index);
    copyDataList.insert(index, copyDataMap);
    widgetData.onChange(context, widgetData.path, copyDataList);
  }

  void addToWordsList() {
    if (clickedWordList.contains(clickedWord) && translationList.contains(translation)) {
      var i = _clickedWordList.indexOf(clickedWord);
      _clickedWordList.insert(i, clickedWord);
      _clickedWordList.remove(clickedWord);
      _translationList.insert(i, translation);
      _translationList.remove(translation);
    } else {
      _clickedWordList.add(clickedWord);
      _translationList.add(translation);
    }
    notifyListeners();
  }


  /// -------------- for LearnerWidget --------------


  int _counter = 0;
  int get counter => _counter;

  int _length = 0;
  int get length => _length;

  void initValues(Map schema) {
    List fields = schema['properties'].keys.toList();
    _length = fields.length;
  }

  getField() {
    _counter ++;
    if (counter == length) _counter = 0;
    notifyListeners();
  }


}