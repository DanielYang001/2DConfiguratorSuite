import 'package:flutter/cupertino.dart';

const EdgeInsets sideMenuPadding = EdgeInsets.symmetric(horizontal: 20);

class MainTemplate extends StatelessWidget {
  const MainTemplate({
    super.key,
    required this.mainViewWidget,
    required this.sideMenuWidget,
    this.headerWidget,
    this.bottomBarWidget,
    this.fullScreen = false,
  });

  final Widget? mainViewWidget;
  final Widget? sideMenuWidget;
  final Widget? bottomBarWidget;
  final Widget? headerWidget;
  final bool fullScreen;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double mainViewWidth = constraints.maxWidth * 0.725;
      double sideMenuWidth = constraints.maxWidth - mainViewWidth;
      double headerHeight = 30;
      double mainHeight = constraints.maxHeight;
      // - headerHeight;
      return SizedBox(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: Column(children: [
          if (!fullScreen)
            SizedBox(
              height: headerHeight,
              width: constraints.maxWidth,
              child: headerWidget,
            ),
          Row(children: [
            SizedBox(
                width: fullScreen ? constraints.maxWidth : mainViewWidth,
                height: fullScreen
                    ? constraints.maxHeight
                    : (mainHeight - headerHeight),
                child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      mainViewWidget!,
                      if (!fullScreen)
                        SizedBox(
                          height: 100,
                          width: constraints.maxWidth - sideMenuWidth,
                          child: bottomBarWidget,
                        )
                    ])),
            if (!fullScreen)
              SizedBox(
                width: sideMenuWidth,
                height: mainHeight - headerHeight,
                child: sideMenuWidget,
              )
          ]),
        ]),
      );
    });
  }
}
