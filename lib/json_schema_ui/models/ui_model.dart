import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/json_schema_ui.dart';
import 'package:uniturnip/json_schema_ui/models/mapPath.dart';
import 'package:uniturnip/json_schema_ui/utils.dart';

class UIModel extends ChangeNotifier {
  Map<String, dynamic> _data;
  ChangeCallback? onUpdate;
  SaveAudioRecordCallback? saveAudioRecord;
  bool disabled;

  UIModel({
    Map<String, dynamic> data = const {},
    this.disabled = false,
    this.onUpdate,
    this.saveAudioRecord,
  }) : _data = data;

  set data(Map<String, dynamic> value) {
    _data = value;
    notifyListeners();
  }

  UnmodifiableMapView<String, dynamic> get data => UnmodifiableMapView<String, dynamic>(_data);

  void modifyData(MapPath path, dynamic value) {
    _data = Utils.modifyMapByPath(path, _data, value);
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
    notifyListeners();
    onUpdate!(path: path, data: data);
  }

  void removeArrayElement(MapPath path) {
    List<dynamic>? array = Utils.getDataBypath(path, _data);
    if (array != null && array.length > 1) {
      array.removeLast();
      _data = Utils.modifyMapByPath(path, _data, array);
      notifyListeners();
      onUpdate!(path: path, data: data);
    }
  }

  getDataByPath(MapPath path) {
    return Utils.getDataBypath(path, _data);
  }

  /// -------------- for CardWidget --------------

  int _counter = 0;

  int get counter => _counter;

  int _length = 0;

  int get length => _length;

  void initValues(Map schema) {
    List fields = schema['properties'].keys.toList();
    _length = fields.length;
  }

  getField() {
    _counter++;
    if (counter == length) _counter = 0;
    notifyListeners();
  }
}
