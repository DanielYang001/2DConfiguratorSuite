import 'package:rt_10055_2D_configurator_suite/components/atom/share/share_config.dart';

class ShareController {
  List<SocialConfig> networks = [];
  String? title;

  ShareController({this.title, required this.networks});
}
