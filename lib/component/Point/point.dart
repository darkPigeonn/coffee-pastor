// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/resource/model/user_model.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

class PointBody extends ConsumerStatefulWidget {
  final ListPoint listPoint;
  const PointBody({super.key, required this.listPoint});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PointBodyState();
}

class _PointBodyState extends ConsumerState<PointBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        children: [
          8.height,
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Point Didapat",
                      style: h4(color: grey),
                    ),
                    Text(
                      widget.listPoint.outlet == "garum-cafe"
                          ? "Cafe Pastor"
                          : "Cafe Pastor",
                      style: h2(),
                    ),
                    // Text(
                    //   "4 Item 123000",
                    //   style: body1(),
                    // ),
                    Text(
                      formatDate(
                        widget.listPoint.createdAt,
                      ),
                      style: body1(color: grey1),
                    ),
                  ],
                ),
                Text(
                  "+${widget.listPoint.point} Poin",
                  style: h4(color: safeAlt),
                )
              ],
            ),
          ),
          12.height,
          Divider(),
        ],
      ),
    );
  }
}
