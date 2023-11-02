import 'package:rt_10055_2D_configurator_suite/components/organism/side_menu_section/subsection_item.dart';

class SideMenuItem {
  final String? title;
  final String? subtitle;
  final List<SubsectionItem>? subsectionItems;

  SideMenuItem(
      {required this.title,
      required this.subtitle,
      required this.subsectionItems});
}
