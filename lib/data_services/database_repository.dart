import 'dart:typed_data';

import 'package:rt_10055_2D_configurator_suite/data_services/database_api_client.dart';
import 'package:rt_10055_2D_configurator_suite/models/packages.dart';

class DatabaseRepository {
  final DatabaseApiClient _databaseApi = DatabaseApiClient();

  Future<String?> saveChanges(
      {required String? sessionID,
      required Map<String, int> configMapping,
      required double totalCost,
      required Map<String, double> cost,
      Package? package}) async {
    return await _databaseApi.saveChanges(
        sessionID: sessionID,
        configMapping: configMapping,
        package: package,
        totalCost: totalCost,
        cost: cost);
  }

  saveCurrentConfigImages(
      String sessionID, Map<dynamic, dynamic> screenShotted) async {
    await _databaseApi.saveCurrentConfigImages(sessionID, screenShotted);
  }
}
