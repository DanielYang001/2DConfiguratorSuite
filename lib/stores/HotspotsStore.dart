import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rt_10055_2D_configurator_suite/utils/save_load_configurations.dart';

class HotspotsStore extends ChangeNotifier {
  Map<String, dynamic> _hotspots = {};
  List<dynamic> _hotspotsHistory = [];
  String _activeHotspotId = '';
  int _noOfFrames = 0;
  ////
  Map<String, dynamic> hotspots() => _hotspots;
  List<dynamic> hotspotsHistory() => _hotspotsHistory;
  String activeHotspotId() => _activeHotspotId;

  HotspotsStore(int noOfFrames) {
    _noOfFrames = noOfFrames;
    initiateHotspots();
    notifyListeners();
  }

  void initializeStore() {}

  initiateHotspots() async {
    await getConfigFromMemory('saved_hotspots').then((value) {
      if (value.entries.isNotEmpty) {
        _hotspots = value;
        notifyListeners();
      }
    });
  }

  void updateHotspots(Map<String, dynamic> newHotspots) {
    _hotspots = newHotspots;
    setConfigInMemory(_hotspots.toString(), 'saved_hotspots');
    notifyListeners();
  }

  void addHotspot(String hotspotName, int frame) {
    Map<String, dynamic> hotspots_ = _hotspots;
    String uniqId = generateUniqId(generateId());
    hotspots_[uniqId] = {
      'name': hotspotName,
      'active': true,
      'offsetsOnFrames': initiateOffsetsOnFrames(),
    };
    updateHotspots(hotspots_);
    setActive(uniqId);
  }

  Map<int, dynamic> initiateOffsetsOnFrames() {
    Map<int, dynamic> offsetsOnFrames_ = {};
    for (int i = 0; i < _noOfFrames; i++) {
      offsetsOnFrames_[i] = {
        'offset': {'x': 50, 'y': 50},
        'manual': false,
        'visible': true
      };
    }
    return offsetsOnFrames_;
  }

  void setActive(String hotspotId_) {
    Map<String, dynamic> hotspots_ = _hotspots;
    hotspots_.forEach((key, value) {
      if (key != hotspotId_) {
        hotspots_[key]['active'] = false;
      } else {
        hotspots_[key]['active'] = true;
        _activeHotspotId = hotspotId_;
      }
    });
    updateHotspots(hotspots_);
  }

  void editHotspot(String hotspotId_, String newHotspotName_) {
    Map<String, dynamic> hotspots_ = _hotspots;
    hotspots_[hotspotId_]['name'] = newHotspotName_;
    updateHotspots(hotspots_);
  }

  void toggleVisibility(String hotspotId_, int frame_) {
    Map<String, dynamic> hotspots_ = _hotspots;
    hotspots_[hotspotId_]['offsetsOnFrames'][frame_]['visible'] =
        !hotspots_[hotspotId_]['offsetsOnFrames'][frame_]['visible'];
    updateHotspots(hotspots_);
  }

  void updateHotspotPosition(
      String hotspotId_, int frame_, Offset newHotspotPosition_) {
    if (newHotspotPosition_ != null && _hotspots.isNotEmpty) {
      Map<String, dynamic> hotspots_ = _hotspots;
      hotspots_[hotspotId_]['offsetsOnFrames'][frame_]['offset'] = {
        'x': newHotspotPosition_.dx,
        'y': newHotspotPosition_.dy
      };
      hotspots_[hotspotId_]['offsetsOnFrames'][frame_]['manual'] = true;
      //
      updateHotspots(hotspots_);
      syncHotspotPositions(hotspotId_, frame_, newHotspotPosition_);
    }
  }

  void syncHotspotPositions(
      String hotspotId_, int frame_, Offset newHotspotPosition_) {
    var i = frame_ + 1 > _noOfFrames - 1 ? 0 : frame_ + 1;

    if (!_hotspots[hotspotId_]['offsetsOnFrames'][i]['manual']) {
      _hotspots[hotspotId_]['offsetsOnFrames'][i]['offset'] = {
        'x': newHotspotPosition_.dx,
        'y': newHotspotPosition_.dy
      };
      _hotspots[hotspotId_]['offsetsOnFrames'][i]['manual'] = false;
    }
    //
    var n = frame_ - 1 < 0 ? _noOfFrames - 1 : frame_ - 1;

    if (!_hotspots[hotspotId_]['offsetsOnFrames'][n]['manual']) {
      _hotspots[hotspotId_]['offsetsOnFrames'][n]['offset'] = {
        'x': newHotspotPosition_.dx,
        'y': newHotspotPosition_.dy
      };
      _hotspots[hotspotId_]['offsetsOnFrames'][n]['manual'] = false;
    }
  }

  void deleteHotspot(String hotspotId_) {
    Map<String, dynamic> hotspots_ = _hotspots;
    hotspots_.remove(hotspotId_);
    updateHotspots(hotspots_);
  }

  String generateUniqId(String id) {
    if (_hotspots.containsKey(id)) {
      return generateUniqId(generateId());
    } else {
      return id;
    }
  }

  String generateId() {
    var rng = new Random();
    var code = rng.nextInt(900000) + 100000;
    return code.toString();
  }
}
