import 'package:flutter/material.dart';
import 'package:rt_10055_2D_configurator_suite/theme/typography.dart';

class PriceDeliveryInfo extends StatelessWidget {
  String title;
  String priceDesc;
  String price;
  String deliveryDate;

  PriceDeliveryInfo(
      {super.key,
      required this.title,
      required this.priceDesc,
      required this.price,
      required this.deliveryDate});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: headline4TextStyle.copyWith(
                      color: const Color(0xFF00C8B7)),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      priceDesc,
                      style: headline6BoldTextStyle,
                    ),
                    Text(
                      price,
                      style: headline6BoldTextStyle,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  deliveryDate,
                  style: headline6TextStyle,
                ),
              ],
            ));
  }
}
