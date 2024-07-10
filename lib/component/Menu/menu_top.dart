// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

class MenuTop extends ConsumerWidget {
  final String type;
  const MenuTop({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: type == "deliv" ? 200 : 100,
      child: Stack(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.1,
                  0.6,
                  0.9,
                ],
                colors: type == "deliv"
                    ? [
                        white,
                        secondaryLight,
                        secondary,
                      ]
                    : [
                        white,
                        primaryPastel,
                        primaryLight,
                      ],
              ),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: type == "deliv" ? secondaryPastel : primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: type == "deliv"
                            ? Icon(
                                Icons.motorcycle,
                                color: secondary,
                                size: 50,
                              )
                            : Icon(
                                Icons.shopping_bag_rounded,
                                color: primaryDark,
                                size: 50,
                              )),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        type == "deliv" ? "Delivery" : "Pick Up",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        type == "deliv"
                            ? "Segera diantar ke lokasimu"
                            : "Ambil ke store tanpa antri",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: type == "deliv"
          //       ? Container(
          //           margin: EdgeInsets.symmetric(horizontal: 16),
          //           width: MediaQuery.of(context).size.width,
          //           height: 160,
          //           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.all(
          //               Radius.circular(10),
          //             ),
          //             color: white,
          //             boxShadow: [
          //               BoxShadow(
          //                 color: Colors.grey.withOpacity(0.5),
          //                 spreadRadius: 2,
          //                 blurRadius: 5,
          //                 offset: Offset(0, 3), // changes position of shadow
          //               ),
          //             ],
          //           ),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Column(
          //                 children: [
          //                   Container(
          //                     width: 40,
          //                     height: 40,
          //                     decoration: BoxDecoration(
          //                       color: secondaryPastel,
          //                       shape: BoxShape.circle,
          //                     ),
          //                     child: Center(
          //                       child: Icon(
          //                         Icons.house_rounded,
          //                         color: secondary,
          //                         size: 40,
          //                       ),
          //                     ),
          //                   ),
          //                   Dash(
          //                     direction: Axis.vertical,
          //                     length: 40,
          //                     dashLength: 3,
          //                   ),
          //                   Container(
          //                     width: 40,
          //                     height: 40,
          //                     decoration: BoxDecoration(
          //                       color: primaryPastel,
          //                       shape: BoxShape.circle,
          //                     ),
          //                     child: Center(
          //                       child: Icon(
          //                         Icons.location_on,
          //                         color: primary,
          //                         size: 30,
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               SizedBox(
          //                 width: 20,
          //               ),
          //               Expanded(
          //                 child: Column(
          //                   children: [
          //                     Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Column(
          //                           mainAxisAlignment: MainAxisAlignment.start,
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.start,
          //                           children: [
          //                             Text(
          //                               "Pakuwon City Mall, Surabaya",
          //                               style: TextStyle(
          //                                 fontSize: 17,
          //                                 fontWeight: FontWeight.w500,
          //                               ),
          //                             ),
          //                             Row(
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment.spaceAround,
          //                               children: [
          //                                 Text(
          //                                   "1,17 km",
          //                                   maxLines: 2,
          //                                   overflow: TextOverflow.ellipsis,
          //                                 ),
          //                                 SizedBox(
          //                                   width: 5,
          //                                 ),
          //                                 CircleAvatar(
          //                                   radius: 5,
          //                                   backgroundColor: primary,
          //                                 ),
          //                                 SizedBox(
          //                                   width: 5,
          //                                 ),
          //                                 Text(
          //                                   "Terdekat",
          //                                   style: TextStyle(
          //                                       fontWeight: FontWeight.w500,
          //                                       color: primaryLight),
          //                                 ),
          //                               ],
          //                             ),
          //                           ],
          //                         ),
          //                         SizedBox(
          //                           width: 10,
          //                         ),
          //                         Icon(Icons.arrow_forward_ios_rounded)
          //                       ],
          //                     ),
          //                     Divider(),
          //                     Expanded(
          //                       child: Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Flexible(
          //                             child: Column(
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment.start,
          //                               crossAxisAlignment:
          //                                   CrossAxisAlignment.start,
          //                               children: [
          //                                 Text(
          //                                   "Rumah",
          //                                   style: TextStyle(
          //                                     fontSize: 17,
          //                                     fontWeight: FontWeight.w500,
          //                                   ),
          //                                 ),
          //                                 Flexible(
          //                                   child: Text(
          //                                     "Surabaya, Lidah Wetan, Lakarsantri, Surabaya, East Java 60213",
          //                                     maxLines: 1,
          //                                     overflow: TextOverflow.ellipsis,
          //                                   ),
          //                                 ),
          //                                 Flexible(
          //                                   child: Text(
          //                                     "wisata bukit mas 2 I9 no 12",
          //                                     maxLines: 1,
          //                                     overflow: TextOverflow.ellipsis,
          //                                     style: TextStyle(
          //                                         color: Colors.grey[500],
          //                                         fontSize: 13),
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                           SizedBox(
          //                             width: 10,
          //                           ),
          //                           Icon(Icons.arrow_forward_ios_rounded)
          //                         ],
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         )
          //       : Container(
          //           margin: EdgeInsets.symmetric(horizontal: 16),
          //           width: MediaQuery.of(context).size.width,
          //           padding: EdgeInsets.all(16),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.all(
          //               Radius.circular(10),
          //             ),
          //             color: white,
          //             boxShadow: [
          //               BoxShadow(
          //                 color: Colors.grey.withOpacity(0.5),
          //                 spreadRadius: 2,
          //                 blurRadius: 5,
          //                 offset: Offset(0, 3), // changes position of shadow
          //               ),
          //             ],
          //           ),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Container(
          //                 width: 36,
          //                 height: 36,
          //                 decoration: BoxDecoration(
          //                   color: primaryLight,
          //                   shape: BoxShape.circle,
          //                 ),
          //                 child: Center(
          //                   child: Icon(
          //                     Icons.house_rounded,
          //                     color: primaryDark,
          //                     size: 28,
          //                   ),
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.only(right: 4),
          //                 child: Dash(
          //                   direction: Axis.vertical,
          //                   length: 40,
          //                   dashLength: 3,
          //                 ),
          //               ),
          //               Column(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     "Cafe Pastor, Surabaya",
          //                     style: h3(),
          //                     maxLines: 2,
          //                     overflow: TextOverflow.ellipsis,
          //                   ),
          //                   // Row(
          //                   //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                   //   children: [
          //                   //     Text(
          //                   //       "1,17 km",
          //                   //       maxLines: 2,
          //                   //       overflow: TextOverflow.ellipsis,
          //                   //     ),
          //                   //     SizedBox(
          //                   //       width: 5,
          //                   //     ),
          //                   //     CircleAvatar(
          //                   //       radius: 5,
          //                   //       backgroundColor: primary,
          //                   //     ),
          //                   //     SizedBox(
          //                   //       width: 5,
          //                   //     ),
          //                   //     Text(
          //                   //       "Terdekat",
          //                   //       style: TextStyle(
          //                   //           fontWeight: FontWeight.w500,
          //                   //           color: primaryLight),
          //                   //     ),
          //                   //   ],
          //                   // ),
          //                 ],
          //               ),
          //               40.width,
          //               Icon(
          //                 Icons.arrow_forward_ios_rounded,
          //               )
          //             ],
          //           ),
          //         ),
          // ),
        ],
      ),
    );
  }
}
