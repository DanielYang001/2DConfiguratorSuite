import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialConfig {
  SocialConfig({required this.type, this.appId, this.icon});

  var appId;
  String type;
  Image? icon;

  IconButton button(url) {
    if (type == 'facebook') {
      var url0 = Uri.parse(
          'https://www.facebook.com/dialog/share?app_id=$appId&display=page&href=$url');
      return IconButton(
        icon: icon ??
            Image.asset(
              'icons/facebook.png',
            ),
        onPressed: () => {_launchURL(url0)},
        iconSize: 32,
      );
    }
    if (type == 'twitter') {
      var url0 = Uri.parse('https://twitter.com/intent/tweet?text=$url');
      return IconButton(
        icon: icon ??
            Image.asset(
              'icons/twitter.png',
            ),
        onPressed: () => {_launchURL(url0)},
        iconSize: 32,
      );
    }
    if (type == 'linkedin') {
      var url0 =
          Uri.parse('https://www.linkedin.com/sharing/share-offsite/?url=$url');
      return IconButton(
        icon: icon ??
            Image.asset(
              'icons/linkedin.png',
            ),
        onPressed: () => {_launchURL(url0)},
        iconSize: 32,
      );
    }

    return IconButton(
      icon: const Icon(Icons.error),
      onPressed: () => {},
    );
  }

  void _launchURL(url) async => await canLaunchUrl(url)
      ? await launchUrl(
          url,
          webOnlyWindowName: '_blank',
        )
      : throw 'Could not launch $url';
}
