import 'package:flutter/material.dart';
import 'package:rt_10055_2D_configurator_suite/components/organism/row_info_display/row_info_model.dart';
import 'package:rt_10055_2D_configurator_suite/theme/typography.dart';

class RowInfoDisplay extends StatelessWidget {
  List<RowInfoModel> titles;

  RowInfoDisplay({super.key, required this.titles});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: titles
          .map(
            (e) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.smallTitle,
                  style: paragraphTextStyle,
                ),
                Text(
                  e.bigTitle,
                  style: headline5TextStyle,
                )
              ],
            ),
          )
          .toList(),
    ));
  }
}
