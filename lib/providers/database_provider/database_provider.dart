import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rt_10055_2D_configurator_suite/data_services/database_repository.dart';
import 'package:rt_10055_2D_configurator_suite/models/packages.dart';

class DatabaseProvider extends StateNotifier<void> {
  DatabaseProvider() : super(null);

  String? _sessionID;

  DatabaseRepository _databaseRepository = DatabaseRepository();

  bool isSaving = false;

  Map<String, int>? latestSavedConfig;
  Package? latestSavedPackage;

  bool isConfigsSame(Map<String, int> config, Package? package) {
    if (latestSavedConfig == null ||
        (latestSavedPackage == null && package != null)) {
      return false;
    }
    if (package?.id != latestSavedPackage?.id) {
      return false;
    }
    bool isMapsSame = latestSavedConfig!.entries
        .every((element) => element.value == config[element.key]);

    return isMapsSame;
  }

  shallowMapCopy(Map<String, int> map) {
    Map<String, int> copy = {};
    map.forEach((key, value) {
      copy[key] = value;
    });
    return copy;
  }

  Future<void> saveChanges(
      {required Map<String, int> config,
      Package? package,
      required double totalCost,
      required Map<String, double> cost}) async {
    if (!isSaving && !isConfigsSame(config, package)) {
      isSaving = true;
      String? sessionID = await _databaseRepository.saveChanges(
          sessionID: _sessionID,
          configMapping: config,
          package: package,
          totalCost: totalCost,
          cost: cost);
      latestSavedConfig = shallowMapCopy(config);
      if (package != null) {
        latestSavedPackage = Package.fromMap(package.toMap());
      }
      isSaving = false;
      if (sessionID != null) {
        _sessionID ??= sessionID;
      }
    } else {}
  }

  Future<bool> saveCurrentConfigImages(
      Map<dynamic, dynamic> screenShotted) async {
    try {
      await _databaseRepository.saveCurrentConfigImages(
          _sessionID!, screenShotted);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}

final databaseProvider = StateNotifierProvider<DatabaseProvider, void>((ref) {
  return DatabaseProvider();
});
