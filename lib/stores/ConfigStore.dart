import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rt_10055_2D_configurator_suite/models/packages.dart';
import 'package:rt_10055_2D_configurator_suite/utils/save_load_configurations.dart';

class ConfigStore extends ChangeNotifier {
  Map<String, int> _configurations = {};
  Map<String, int> _savedConfigurations = {};
  Map<String, double> _cost = {};
  Map<String, String> _variablesImages = {};
  Map<dynamic, dynamic> _imagesMapping = {};
  double _totalCost = 0;
  String _interiorImage = '';
  Package? selectedPackage;

  Map<dynamic, dynamic> getImageVariable() => _variablesImages;

  void changeSelectedPackage(Package? package) {
    if (selectedPackage?.id == package?.id) {
      _totalCost -= selectedPackage!.price!;
      selectedPackage = null;
    } else {
      if (selectedPackage != null) {
        _totalCost -= selectedPackage!.price!;
      }
      _totalCost += package!.price!;
      selectedPackage = package;
    }
    notifyListeners();
  }

  ConfigStore(Map<dynamic, dynamic> imagesMapping_) {
    inititeImagesMapping(imagesMapping_);
    initiateConfigurations();
    Future.delayed(const Duration(milliseconds: 1000), () {
      calculateImages();
      initiateCost();
    });
  }
  void initializeStore(Map<dynamic, dynamic> imagesMapping_,
      Map<String, int> queryConfigurations) {
    Future.delayed(Duration.zero, () {
      bool queryConfigIsDefined =
          queryConfigurations != null && queryConfigurations!.isNotEmpty;

      ////
      inititeImagesMapping(imagesMapping_);
      queryConfigIsDefined
          ? setConfigurationsFromQueryParam(queryConfigurations)
          : initiateConfigurations();

      Future.delayed(Duration(seconds: queryConfigIsDefined && !kIsWeb ? 6 : 1),
          () {
        calculateImages();
        initiateCost();
      });
    });
  }

  Map<String, int> get configurations => _configurations;
  Map<String, int> get savedConfigurations => _savedConfigurations;
  Map<String, String> get variablesImages => _variablesImages;
  Map<String, double> get cost => _cost;
  double get totalCost => _totalCost;
  String get interiorImage => _interiorImage;

  setConfigurations(Map<String, int> configurations_) {
    _configurations = configurations_;
    notifyListeners();
  }

  setConfigurationsFromQueryParam(Map<String, int> queryConfigurations) {
    Map<String, int> fullConfigurations_ = {};
    queryConfigurations.forEach((shortKey, shortValue) {
      String fullKey;
      int shortKeyLength = shortKey.length;
      _configurations.forEach((key, value) {
        if (key.substring(0, shortKeyLength).toLowerCase() ==
            shortKey.toLowerCase()) {
          fullKey = key;
          fullConfigurations_[fullKey] = shortValue;
        }
      });
    });
    _configurations = fullConfigurations_;
    notifyListeners();
  }

  setCost(Map<String, double> cost_) {
    _totalCost = 0;
    _cost = cost_;
    _cost.forEach((key, value) {
      _totalCost = _totalCost + value;
    });
    notifyListeners();
  }

  inititeImagesMapping(Map<dynamic, dynamic> imagesMapping_) {
    _imagesMapping = imagesMapping_;
  }

  initiateConfigurations() async {
    Map<String, int> configurations_ = {};
    _imagesMapping.forEach((key, value) {
      configurations_[key] = 1;
    });
    _configurations = configurations_;
    notifyListeners();
    ////
    // await getConfigFromMemory('config_pref').then((value) {
    //   if (value.entries.isNotEmpty &&
    //       checkIfSavedConfigsMatch(value, _imagesMapping)) {
    //     _savedConfigurations = value;
    //     notifyListeners();
    //   }
    // });
  }

  loadSavedConfigs() {
    setConfigurations(_savedConfigurations);
    calculateImages();
    initiateCost();
  }

  initiateCost() {
    _totalCost = 0;
    _imagesMapping.forEach((key, value) {
      int savedIndex = _configurations[key] ?? 1;
      double optionCost = double.parse(
          (value['values'].entries!.toList()![savedIndex - 1].value!['cost'] ??
                  '0')
              .toString());
      _cost[key] = optionCost;
      _totalCost = _totalCost + optionCost;
    });

    notifyListeners();
  }

  String generateInitImg() {
    return List.generate(_imagesMapping.length, (index) => '00')
        .toString()
        .replaceAll(', ', '.')
        .replaceAll('[', '')
        .replaceAll(']', '');
  }

  void calculateImages() {
    Map<String, String> variablesImages_ = {};
    String interiorImage_ = generateInitImg();
    int noOfInv =
        _imagesMapping['Environment']['values'].entries.toList().length;
    int interiorInv = _configurations['Environment']! + noOfInv;

    _imagesMapping.forEach((index1, value1) {
      String initImgName = generateInitImg();

      initImgName = initImgName.replaceRange(value1['order'] * 3 + 1,
          value1['order'] * 3 + 2, _configurations[index1].toString());

      if (value1['render_interior'] == 1) {
        interiorImage_ = interiorImage_.replaceRange(
            value1['order'] * 3 + 1,
            value1['order'] * 3 + 2,
            index1 == 'Environment'
                ? '$interiorInv'
                : _configurations[index1].toString());
      }

      value1['rendered_with'].toList().forEach((value2) {
        initImgName = initImgName.replaceRange(
            _imagesMapping[value2]['order'] * 3 + 1,
            _imagesMapping[value2]['order'] * 3 + 2,
            _configurations[value2].toString());
      });

      value1['values'].forEach((index3, value3) {
        if (value3['rendered_with'] != null) {
          value3['rendered_with'].toList().forEach((value4) {
            if (_configurations[index1] == value3['value']) {
              initImgName = initImgName.replaceRange(
                  _imagesMapping[value4]['order'] * 3 + 1,
                  _imagesMapping[value4]['order'] * 3 + 2,
                  _configurations[value4].toString());
            }
          });
        }
      });
      if (value1['has_a_layer'] != 0) initImgName = '$initImgName.00.png';
      variablesImages_[index1] = initImgName;
    });

    _interiorImage = '${interiorImage_}.00.jpeg';
    _variablesImages = variablesImages_;
    notifyListeners();
  }

  void onPressConfig(index_, value_) {
    Map<String, int> configurations_ = _configurations;
    Map<String, double> cost_ = _cost;
    configurations_[index_] = value_['value'];
    setConfigurations(configurations_);
    calculateImages();
    setConfigInMemory(configurations_.toString(), 'config_pref');
    if (value_['cost'] != null) {
      cost_[index_] = value_['cost'];
      setCost(cost_);
    }
  }
}
