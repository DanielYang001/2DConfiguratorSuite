import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/side_menu_section/side_menu_item.dart';
import 'package:rt_10055_2D_configurator_suite/components/templates/main_template.dart';
import 'package:rt_10055_2D_configurator_suite/theme/typography.dart';

class SideMenuItemWidget extends HookConsumerWidget {
  final SideMenuItem currentSideMenuItem;
  final bool initiallyExpanded;
  final double childrenHeight;
  final ExpansionTileController? controller;
  final int? index;
  final void Function(int, bool)? onExpansionChanged;
  const SideMenuItemWidget(
      {super.key,
      required this.index,
      required this.onExpansionChanged,
      required this.currentSideMenuItem,
      required this.initiallyExpanded,
      required this.controller,
      required this.childrenHeight});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return
        // Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ExpansionTile(
            maintainState: true,
            controller: controller,
            onExpansionChanged: (bool change) =>
                {onExpansionChanged!(index!, change)},
            // backgroundColor: const Color(0xFFE9E9E9),
            tilePadding: sideMenuPadding,
            childrenPadding: sideMenuPadding,
            expandedAlignment: Alignment.topLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            initiallyExpanded: initiallyExpanded,
            // title: Container(height: 19),
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // if (currentSideMenuItem.title != null) Container(height: 5),
              if (currentSideMenuItem.title != null)
                Text(
                  currentSideMenuItem.title!,
                  style: headline5TextStyle,
                ),
              if (currentSideMenuItem.subtitle != null)
                const SizedBox(height: 5),
              if (currentSideMenuItem.subtitle != null)
                Text(
                  currentSideMenuItem.subtitle!,
                  style: paragraphTextStyle,
                ),
              // Container(height: 5),
            ]),
            children: [
          SizedBox(
              height: childrenHeight,
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(height: 5),
                    for (var subsectionItem
                        in currentSideMenuItem.subsectionItems!)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (subsectionItem.title != null)
                            Text(
                              subsectionItem.title!,
                              style: headline6TextStyle,
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (subsectionItem.widget != null)
                            subsectionItem.widget!,
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                  ])))
        ]);
  }
}
