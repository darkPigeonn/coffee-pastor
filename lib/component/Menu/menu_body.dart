// ignore_for_file: prefer_const_constructors, must_be_immutable, sized_box_for_whitespace, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/ImageLoader.dart';
import 'package:flutter_coffee_application/component/Format/CurrencyFormat.dart';
import 'package:flutter_coffee_application/resource/model/product_model.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:nb_utils/nb_utils.dart';

class MenuBody extends StatelessWidget {
  final ModelProduct list;
  void Function()? onTap;
  MenuBody({super.key, required this.list, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              height: 100,
              child: LoadImage(imageLink: list.images[0], boxFit: BoxFit.fill,)
            ),
            10.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    list.name,
                    style: h3(),
                  ),
                  Expanded(
                    child: Text(
                      list.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ),
                  Text(
                    FormatCurrency.convertToIdr(list.price, 0),
                    style: h3()
                  ),
                ],
              ),
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     InkWell(
            //       onTap: () {},
            //       child: Icon(
            //         Icons.favorite_border_rounded,
            //       ),
            //     ),
            //     CircleAvatar(
            //       radius: 12,
            //       backgroundColor: primary,
            //       child: Icon(
            //         Icons.add,
            //         size: 16,
            //         color: white,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}