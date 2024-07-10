// import 'package:flutter/material.dart';
// import 'package:flutter_coffee_application/component/formatter/DateFormatter.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nb_utils/nb_utils.dart';

// import '../../style/color.dart';
// import '../../style/typhography.dart';

// class DataArtikel extends ConsumerWidget {
//   const DataArtikel({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ref.watch(featuredArtikelList).when(
//           skipLoadingOnRefresh: false,
//           data: (data) => Container(
//             // height: MediaQuery.of(context).size.height / 4,
//             // margin: EdgeInsets.symmetric(horizontal: 16),
//             // padding: EdgeInsets.all(8),
//             // decoration: shadowBox(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Artikel", style: h4()),
//                       InkWell(
//                           borderRadius: BorderRadius.circular(8),
//                           onTap: () {
//                             // Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //     builder: (context) => ArtikelPage(),
//                             //   ),
//                             // );
//                           },
//                           child: Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                               child: Text("Lihat Semua", style: body2(color: grey)))),
//                     ],
//                   ),
//                 ),
//                 8.height,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Divider(
//                     thickness: 1,
//                     color: grey2,
//                     height: 0,
//                   ),
//                 ),
//                 4.height,
//                 if (data.isEmpty)
//                   Center(
//                     child: Text(
//                       "Tidak ada artikel",
//                       style: body2(color: grey1),
//                     ),
//                   ),
//                 if (data.isNotEmpty)
//                   HorizontalList(
//                     padding: EdgeInsets.fromLTRB(16, 4, 16, 8),
//                     itemCount: data.length,
//                     physics: BouncingScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         // onTap: () => DetailData(
//                         //   id: data[index].slug,
//                         //   type: "artikel",
//                         // ).launch(context),
//                         child: Container(
//                           width: 240,
//                           // margin: EdgeInsets.only(top: index == 0 ? 4 : 8),
//                           // padding: const EdgeInsets.all(8),
//                           // decoration: shadowBox(),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 height: 160,
//                                 width: 240,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(8),
//                                     topRight: Radius.circular(8),
//                                   ),
//                                   child: LoadImage(
//                                     imageLink: data[index].imageLink,
//                                     boxFit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Flexible(
//                                       child: Text(
//                                         data[index].title,
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: body1(),
//                                       ),
//                                     ),
//                                     16.width,
//                                     Text(
//                                       formatDate(DateTime.parse(data[index].publishDate)),
//                                       textAlign: TextAlign.end,
//                                       style: body2(color: grey),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               // 6.height,
//                               // Text(
//                               //   data[index].author,
//                               //   style: body2(color: grey),
//                               // ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 // ListView.builder(
//                 //   padding: EdgeInsets.fromLTRB(16, 4, 16, 16),
//                 //   shrinkWrap: true,
//                 //   itemCount: data.length > 5 ? 5 : data.length,
//                 //   physics: NeverScrollableScrollPhysics(),
//                 //   itemBuilder: (context, index) {
//                 //     return GestureDetector(
//                 //       onTap: () => DetailData(
//                 //         id: data[index].slug,
//                 //         type: "artikel",
//                 //       ).launch(context),
//                 //       child: Container(
//                 //         margin: EdgeInsets.only(top: index == 0 ? 4 : 8),
//                 //         padding: const EdgeInsets.all(8),
//                 //         decoration: shadowBox(),
//                 //         child: Column(
//                 //           crossAxisAlignment: CrossAxisAlignment.start,
//                 //           children: [
//                 //             Row(
//                 //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //               crossAxisAlignment: CrossAxisAlignment.start,
//                 //               children: [
//                 //                 Flexible(
//                 //                   child: Text(
//                 //                     data[index].title,
//                 //                     maxLines: 2,
//                 //                     overflow: TextOverflow.ellipsis,
//                 //                     style: body1(),
//                 //                   ),
//                 //                 ),
//                 //                 16.width,
//                 //                 Text(
//                 //                   indSimpleDateFormatter(DateTime.parse(data[index].publishDate)),
//                 //                   textAlign: TextAlign.end,
//                 //                   style: body2(color: grey),
//                 //                 ),
//                 //               ],
//                 //             ),
//                 //             6.height,
//                 //             Text(
//                 //               data[index].author,
//                 //               style: body2(color: grey),
//                 //             ),
//                 //           ],
//                 //         ),
//                 //       ),
//                 //     );
//                 //   },
//                 // )
//               ],
//             ),
//           ),
//           error: (error, stackTrace) {
//             print(error);
//             print(stackTrace);
//             if (error.toString() == "204") {
//               return Container(
//                 margin: EdgeInsets.symmetric(horizontal: 16),
//                 height: MediaQuery.of(context).size.height / 4,
//                 decoration: shadowBox(),
//                 child: Center(
//                     child: Container(
//                         decoration: shadowBox(),
//                         child: Text(
//                           "Belum ada artikel terkini saat ini",
//                           style: body3(color: Colors.grey),
//                         ))),
//               );
//             }
//             return Container(
//               margin: EdgeInsets.symmetric(horizontal: 16),
//               height: MediaQuery.of(context).size.height / 4,
//               decoration: shadowBox(),
//               child: Center(
//                   child: Container(
//                 decoration: shadowBox(),
//                 child: IconButton(
//                   onPressed: () async {
//                     bool result = await checkInternetConnectivity(context);
//                     if (result) {
//                       await ref.refresh(featuredBeritaList.future);
//                     }
//                   },
//                   icon: Icon(
//                     Icons.refresh,
//                     color: ref.watch(styleApp).color.primary,
//                   ),
//                 ),
//               )),
//             );
//           },
//           loading: () => Container(
//             margin: EdgeInsets.symmetric(horizontal: 16),
//             height: MediaQuery.of(context).size.height / 4,
//             decoration: shadowBox(),
//             child: Center(child: CircularProgressIndicator()),
//           ),
//         );
//   }
// }