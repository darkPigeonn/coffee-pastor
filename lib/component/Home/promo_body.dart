// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/resource/model/promo_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:nb_utils/nb_utils.dart';

class PromoBody extends StatelessWidget {
  final List<ModelPromo> list;

  const PromoBody({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: AlignedGridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 1,
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              left: 16, right: index == list.length - 1 ? 16 : 0
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[350]!,
                width: 2
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            width: 300,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 8,
                ),
                Image.asset(
                  list[index].image,
                  width: MediaQuery.of(context).size.width / 4,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Dash(
                    direction: Axis.vertical,
                    length: 80,
                    dashLength: 3,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        list[index].title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        list[index].description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
