// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/component/Format/CurrencyFormat.dart';
import 'package:flutter_coffee_application/resource/model/cart_model.dart';
import 'package:flutter_coffee_application/resource/model/order_model.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryOrder extends ConsumerWidget {
  final ModelOrder modelOrder;
  HistoryOrder({Key? key, required this.modelOrder}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int itemCount = getTotalItemCount(modelOrder.items);
    int itemTotal = calculateTotalSubtotal(modelOrder.items);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          modelOrder.orderId,
          style: h2(color: primary),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          formatDate(modelOrder.orderDate),
          style: body1(),
        ),
        SizedBox(
          height: 16,
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: modelOrder.items.productIds.length,
          itemBuilder: (context, index) {
            final item = modelOrder.items;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      item.quantities[index].toString(),
                      style: body1(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      item.productIds[index],
                      style: body1(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      FormatCurrency.convertToIdr(
                          item.subTotal[index],
                          0), // Adjusted index usage
                      style: body1(),
                    )
                  ],
                )
              ],
            );
          },
        ),
        SizedBox(
          height: 16,
        ),
        Divider(
          height: 2,
          color: grey2,
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Text(
              '$itemCount Item',
              style: h4(color: primary),
            ),
            SizedBox(width: 10),
            Text(
              FormatCurrency.convertToIdr(
                itemTotal,
                0,
              ),
              style: h4(color: primary),
            ),
          ],
        ),
      ],
    );
  }

  int getTotalItemCount(ModelCart items) {
    int totalCount = 0;
    for (var quantity in items.quantities) {
      totalCount += quantity;
    }
    return totalCount;
  }

  int calculateTotalSubtotal(ModelCart items) {
  int total = 0;
  for (int subtotal in items.subTotal) {
    total += subtotal;
    }
  return total;
  }
}
