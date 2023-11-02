import 'dart:convert';

import 'package:rt_10055_2D_configurator_suite/mockup_content/hotspots.dart';
import 'package:rt_10055_2D_configurator_suite/utils/general_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

dynamic fromStringToMapConfigs(String configs_) {
  // dynamic configs = {};

  String configs__ = configs_
      .replaceAll(': ', '": ')
      .replaceAll(', ', ', "')
      .replaceAll('{', '{"')
      .replaceAll(': ', ': "')
      .replaceAll('},', '"},')
      .replaceAll(', ', '", ')
      .replaceAll('"{"', '{"')
      .replaceAll('"}"', '"}')
      .replaceAll('}}}}', '"}}}}')
      .replaceAll('}}"}', '"}}}');

  Map<dynamic, dynamic> configs = json.decode(configs__);

  Map<String, dynamic> conf =
      configs.map((key, value) => MapEntry(key.toString(), castValue(value)));

  return conf;
}

dynamic castValue(dynamic value) {
  if (value != null) {
    if (value == 'true')
      return true;
    else if (value == 'false')
      return false;
    else if (value is String && isNumeric(value)) {
      return double.parse(value);
    } else if (value is String) {
      return value;
    } else if (value is Map) {
      Map<dynamic, dynamic> value_ = value.map((key, value) => MapEntry(
          isNumeric(key) ? int.parse(key) : key.toString(), castValue(value)));
      return value_;
    }
    // else {
    //   return 'blabla';
    // }
    // if (value is Map) {
    //   print(value);
    //   Map myMap = {};
    //   value.map((key_, value_) => myMap[key_.toString()] = castValue(value_));
    //   return myMap;
    // }
  }
}

Future<Map<String, dynamic>> getConfigFromMemory(String ref) async {
  Map<String, dynamic> configs = {};

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? configPref = prefs.getString(ref);
  if (configPref != null) {
    configs = fromStringToMapConfigs(configPref!);
  } else if (ref == 'saved_hotspots') {
    configs = fromStringToMapConfigs(saved_hotspots.toString());
  }

  return configs;
}

setConfigInMemory(String value, String ref) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(ref, value);
}

bool checkIfSavedConfigsMatch(
    Map<String, int> configs, Map<dynamic, dynamic> configsMapping) {
  bool savedConfigsMatch = true;
  configs.entries.forEach((e) {
    if (configsMapping[e.key] == null) {
      savedConfigsMatch = savedConfigsMatch && false;
    }
  });

  return savedConfigsMatch;
}
