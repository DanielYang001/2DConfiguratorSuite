import 'package:flutter/material.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/side_menu_section/side_menu_item.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/side_menu_section/side_menu_item_widget.dart';

class SideMenuSection extends StatefulWidget {
  final List<SideMenuItem> sideMenuItems;
  final void Function(String) onClick;
  const SideMenuSection(
      {super.key, required this.sideMenuItems, required this.onClick});

  @override
  State<StatefulWidget> createState() {
    return _SideMenuSectionState();
  }
}

class _SideMenuSectionState extends State<SideMenuSection> {
  late List<ExpansionTileController> controllers = [];
  int expanded = 0;

  @override
  void initState() {
    setState(() {
      widget.sideMenuItems.forEach((e) {
        controllers.add(ExpansionTileController());
      });
    });
    super.initState();
  }

  List<Widget> sideMenuItemsReordered(List<Widget> sideMenuItems) {
    List<Widget> sideMenuItemsReordered = [];
    sideMenuItemsReordered.add(sideMenuItems[expanded]);
    sideMenuItems.forEach((element) {
      if (sideMenuItems.indexOf(element) != expanded) {
        sideMenuItemsReordered.add(element);
      }
    });
    return sideMenuItemsReordered;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            Column(children: [
              ...widget.sideMenuItems.map((e) {
                var index = widget.sideMenuItems.indexOf(e);
                return Column(
                  children: [
                    SideMenuItemWidget(
                      onExpansionChanged: (int index, bool change) {
                        // setState(() => expanded = index);
                        if (change) {
                          widget.onClick!(widget.sideMenuItems[index].title!);
                          controllers.forEach((element) {
                            var index_ = controllers.indexOf(element);
                            if (index != index_) {
                              setState(() {
                                expanded = index;
                                controllers![index_]!.collapse();
                              });
                            }
                          });
                        } else if (expanded == index) {
                          controllers![index]!.expand();
                        }
                      },
                      index: index,
                      controller:
                          controllers.isNotEmpty ? controllers[index] : null,
                      childrenHeight: MediaQuery.of(context).size.height -
                          (30 + 50 * widget.sideMenuItems!.length),
                      currentSideMenuItem: e,
                      initiallyExpanded: index == 0,
                    ),
                  ],
                );
              }
                  // .addDividerToEach(
                  //         isPaddedBottom: true,
                  //         isLast: sideMenuItems.length == sideMenuItems.indexOf(e) + 1,
                  //         context: context)
                  ).toList(),
            ]));
  }
}
