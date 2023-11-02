import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/share/share_config.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/share/share_controller.dart';
import 'package:rt_10055_2D_configurator_suite/utils/show_toast.dart';
import 'package:share_plus/share_plus.dart';

String? getSharableLinkWithQueryParam(Map<String, int> configurations) {
  String sharableLink = 'https://rt10055-2d-configurator-suite.web.app/?';
  Map<String, int>? shortConfigurations_ = shortConfigurations(configurations);
  (shortConfigurations_ ?? configurations).forEach((key, value) {
    sharableLink = sharableLink + '$key=$value:';
  });
  debugPrint(sharableLink);
  return sharableLink;
}

Map<String, int>? shortConfigurations(Map<String, int> configurations,
    {int? startLenght = 3}) {
  Map<String, int> shortConfigurationsMap = {};
  configurations.forEach((key, value) {
    String shortKey = key.substring(0, startLenght);
    shortConfigurationsMap[shortKey.toLowerCase()] = value;
  });

  int configurationLength = shortConfigurationsMap.length;
  int setOfConfigurations = shortConfigurationsMap.keys.toSet().length;
  if (configurations.length != setOfConfigurations) {
    print("There are some configurations with the same key");
    return shortConfigurations(configurations, startLenght: startLenght! + 1);
  } else {
    print("There are no configurations with the same key" +
        shortConfigurationsMap.toString());
    return shortConfigurationsMap;
  }
}

bool isConfigsIdentical(
    {required Map<String, int>? oldConfig,
    required Map<String, int>? newConfig}) {
  if (newConfig == null) {
    return false;
  } else if (oldConfig == null) {
    return true;
  }
  if (oldConfig.length != newConfig.length) {
    return false;
  }
  for (var key in oldConfig.keys) {
    if (oldConfig[key] != newConfig[key]) {
      return false;
    }
  }
  return true;
}

void copyToClipboard(BuildContext context, String link) {
  Clipboard.setData(ClipboardData(text: link!));
  showToast(context, 'Link is copied');
  // copied successfully
}

void onPressShareLink(Map<String, int> configurations, BuildContext context) {
  String? link = getSharableLinkWithQueryParam(configurations);

  if (kIsWeb) {
    ShareController shareController = ShareController(
      title: 'Share on:',
      networks: [
        SocialConfig(type: 'facebook', appId: 'your-facebook-app-id'),
        SocialConfig(type: 'twitter'),
        SocialConfig(type: 'linkedin'),
      ],
    );

    List<IconButton> buttons = [];

    for (var network in shareController.networks) {
      buttons.add(network.button(link));
    }
    buttons.add(IconButton(
        onPressed: () {
          copyToClipboard(context, link!);
          Navigator.pop(context, true);
        },
        icon: const Icon(Icons.copy)));

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: shareController.title != null
                ? Text(
                    shareController.title ?? '',
                    textAlign: TextAlign.center,
                  )
                : null,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buttons,
              ),
            ],
          );
        });
  } else {
    Share.share(link!);
  }
}
