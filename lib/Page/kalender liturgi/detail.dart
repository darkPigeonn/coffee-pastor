import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/resource/const_resource.dart';
import 'package:flutter_coffee_application/resource/provider/resources_provider.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

class DetailKalenderLiturgi extends ConsumerStatefulWidget {
  // final Map dataDetails;

  const DetailKalenderLiturgi({
    // required this.dataDetails,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<DetailKalenderLiturgi> createState() => _DetailKalenderLiturgiState();
}

class _DetailKalenderLiturgiState extends ConsumerState<DetailKalenderLiturgi> {
  // late List ayats;

  DateTime dateNow = DateTime.now();
  Future<void> changeDate(bool isAdd) async {
    if (isAdd) {
      setState(() {
        dateNow = dateNow.add(Duration(days: 1));
      });
      // pageFlipKey.currentState?.foward();
    } else {
      setState(() {
        dateNow = dateNow.subtract(Duration(days: 1));
      });
      // pageFlipKey.currentState?.reverse();
    }
  }

  @override
  void initState() {
    // ayats = widget.dataDetails['eucharisticReading']['psalmDetail']['ayats'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kalender Liturgi',
          style: TextStyle(fontWeight: FontWeight.bold, color: white),
        ),
        centerTitle: true,
        backgroundColor: primary,
      ),
      bottomNavigationBar: SafeArea(
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                offset: Offset(0, 5),
                color: Colors.black54,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // InkWell(
              //   borderRadius: BorderRadius.circular(32),
              //   onTap: () async => changeDate(false),
              //   child: SizedBox(
              //     height: 32,
              //     width: 32,
              //     child: Icon(
              //       Icons.arrow_circle_left_outlined,
              //       color: Colors.black54,
              //     ),
              //   ),
              // ),
              // 16.width,
              Flexible(
                child: Text(
                  formatDate2(dateNow),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // 16.width,
              // InkWell(
              //   borderRadius: BorderRadius.circular(32),
              //   onTap: () async => changeDate(true),
              //   child: SizedBox(
              //     height: 32,
              //     width: 32,
              //     child: Icon(
              //       Icons.arrow_circle_right_outlined,
              //       color: Colors.black54,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: Dismissible(
        resizeDuration: null,
        onDismissed: (DismissDirection direction) {
          direction == DismissDirection.endToStart ? changeDate(true) : changeDate(false);
        },
        key: ValueKey(dateNow),
        child: ref.watch(todayAgendasProvider(agendaDateFormatter(dateNow))).when(
              skipLoadingOnRefresh: false,
              data: (data) => SizedBox.expand(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(16),
                          child: Material(
                            textStyle: liturgiTheme(data.liturgicalColor.toString()),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: liturgiColor(
                                  data.liturgicalColor.toString(),
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: grey1,
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Positioned(
                                          right: -60,
                                          bottom: -55,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(colors: [
                                                  Color.fromARGB(89, 187, 187, 187),
                                                  Color.fromARGB(43, 255, 255, 255),
                                                ]),
                                                shape: BoxShape.circle),
                                            width: 200,
                                            height: 300,
                                          )),
                                      Positioned(
                                        right: -40,
                                        top: -10,
                                        child: Image.asset(
                                          'assets/image/icon-kl.png',
                                          height: 200,
                                          width: 200,
                                        ),
                                      ),
                                      Positioned(
                                        right: -80,
                                        top: -50,
                                        child: Container(
                                          height: 180,
                                          width: 180,
                                          decoration: BoxDecoration(),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                        alignment: Alignment.center,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(data.liturgicalMemorial.toString().isNotEmpty
                                                ? data.liturgicalMemorial
                                                : "Hari Biasa"),
                                            Text('Warna Liturgi : ' + data.liturgicalColor.toString()),
                                            Text('Bacaan I : ' + data.eucharisticReading.firstReading.toString()),
                                            Text('Mazmur : ' + data.eucharisticReading.psalm.toString()),
                                            data.eucharisticReading.secondReading != ''
                                                ? Text('Bacaan II : ' + data.eucharisticReading.secondReading.toString())
                                                : Container(),
                                            Text('Injil : ' + data.eucharisticReading.gospel.toString()),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.weeks.liturgical,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              2.height,
                              data.liturgicalMemorial.contains("</p>")
                                  ? Html(
                                      data: data.liturgicalMemorial,
                                      // style: {
                                      //   "body": Style(
                                      //     color: Colors.black,
                                      //     textAlign: TextAlign.justify,
                                      //     fontSize: FontSize(16),
                                      //     height: Height(1.4),
                                      //   )
                                      // },
                                    )
                                  : Text(
                                      data.liturgicalMemorial,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                              Divider(
                                thickness: 1,
                                height: 16,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),

                        // Text(
                        //   'Warna Liturgi : ' + dataDetails['liturgicalColor'],
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //   ),
                        // ),
                        // Divider(
                        //   height: 20,
                        //   thickness: 5,
                        //   endIndent: 0,
                        //   color: liturgiColor(dataDetails['liturgicalColor']),
                        // ),
                        ExpansionTile(
                          tilePadding: EdgeInsets.symmetric(horizontal: 16),
                          backgroundColor: Colors.grey.shade100,
                          childrenPadding: EdgeInsets.symmetric(horizontal: 16),
                          title: Text(
                            'Bacaan 1 : ' + data.eucharisticReading.firstReading,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          subtitle: data.eucharisticReading.firstReadingDetail.excerpt.contains("</p>")
                              ? Html(
                                  data: data.eucharisticReading.firstReadingDetail.excerpt,
                                  // style: {
                                  //   "body": Style(
                                  //     color: Colors.black,
                                  //     textAlign: TextAlign.justify,
                                  //     fontSize: FontSize(16),
                                  //     height: Height(1.4),
                                  //   )
                                  // },
                                )
                              : Text(
                                  data.eucharisticReading.firstReadingDetail.excerpt,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                          children: [
                            data.eucharisticReading.firstReadingDetail.details.contains("</p>")
                                ? Html(
                                    data: data.eucharisticReading.firstReadingDetail.details,
                                    // style: {
                                    //   "body": Style(
                                    //     color: Colors.black,
                                    //     textAlign: TextAlign.justify,
                                    //     fontSize: FontSize(16),
                                    //     height: Height(1.4),
                                    //   )
                                    // },
                                  )
                                : Text(
                                    data.eucharisticReading.firstReadingDetail.details,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.4,
                                    ),
                                  ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                        ExpansionTile(
                          tilePadding: EdgeInsets.symmetric(horizontal: 16),
                          backgroundColor: Colors.grey.shade100,
                          childrenPadding: EdgeInsets.symmetric(horizontal: 16),
                          title: Text(
                            'Mazmur : ' + data.eucharisticReading.psalm,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          subtitle: data.eucharisticReading.psalmDetail.reffren.contains("</p>")
                              ? Html(
                                  data: data.eucharisticReading.psalmDetail.reffren,
                                  // style: {
                                  //   "body": Style(
                                  //     color: Colors.black,
                                  //     textAlign: TextAlign.justify,
                                  //     fontSize: FontSize(16),
                                  //     height: Height(1.4),
                                  //   )
                                  // },
                                )
                              : Text(
                                  'reffren : ' + data.eucharisticReading.psalmDetail.reffren,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                          children: [
                            Column(
                              children: [
                                for (int i = 0; i < data.eucharisticReading.psalmDetail.ayats.length; i++)
                                  Column(
                                    children: [
                                      data.eucharisticReading.psalmDetail.ayats[i].contains("</p>")
                                          ? Html(
                                              data: data.eucharisticReading.psalmDetail.ayats[i],
                                              // style: {
                                              //   "body": Style(
                                              //     color: Colors.black,
                                              //     textAlign: TextAlign.justify,
                                              //     fontSize: FontSize(16),
                                              //     height: Height(1.4),
                                              //   )
                                              // },
                                            )
                                          : Text(
                                              data.eucharisticReading.psalmDetail.ayats[i],
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                fontSize: 16,
                                                height: 1.4,
                                              ),
                                            ),
                                      8.height,
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                        data.eucharisticReading.secondReading != ''
                            ? ExpansionTile(
                                tilePadding: EdgeInsets.symmetric(horizontal: 16),
                                backgroundColor: Colors.grey.shade100,
                                childrenPadding: EdgeInsets.symmetric(horizontal: 16),
                                title: Text(
                                  'Bacaan 2 : ' + data.eucharisticReading.firstReading,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                  data.eucharisticReading.firstReadingDetail.excerpt,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                children: [
                                  data.eucharisticReading.firstReadingDetail.details.contains("</p>")
                                      ? Html(
                                          data: data.eucharisticReading.firstReadingDetail.details,
                                          // style: {
                                          //   "body": Style(
                                          //     color: Colors.black,
                                          //     textAlign: TextAlign.justify,
                                          //     fontSize: FontSize(16),
                                          //     height: Height(1.4),
                                          //   )
                                          // },
                                        )
                                      : Text(
                                          data.eucharisticReading.firstReadingDetail.details,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontSize: 16,
                                            height: 1.4,
                                          ),
                                        ),
                                ],
                              )
                            : Container(),
                        ExpansionTile(
                          tilePadding: EdgeInsets.symmetric(horizontal: 16),
                          backgroundColor: Colors.grey.shade100,
                          childrenPadding: EdgeInsets.symmetric(horizontal: 16),
                          title: Text(
                            'Bacaan Injil : ' + data.eucharisticReading.gospel,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          subtitle: data.eucharisticReading.gospelReadingDetail.excerpt.contains("</p>")
                              ? Html(
                                  data: data.eucharisticReading.gospelReadingDetail.excerpt,
                                  // style: {
                                  //   "body": Style(
                                  //     color: Colors.black,
                                  //     textAlign: TextAlign.justify,
                                  //     fontSize: FontSize(16),
                                  //     height: Height(1.4),
                                  //   )
                                  // },
                                )
                              : Text(
                                  data.eucharisticReading.gospelReadingDetail.excerpt,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                          children: [
                            data.eucharisticReading.gospelReadingDetail.details.contains("</p>")
                                ? Html(
                                    data: data.eucharisticReading.gospelReadingDetail.details,
                                    // style: {
                                    //   "body": Style(
                                    //     color: Colors.black,
                                    //     textAlign: TextAlign.justify,
                                    //     fontSize: FontSize(16),
                                    //     height: Height(1.4),
                                    //   )
                                    // },
                                  )
                                : Text(
                                    data.eucharisticReading.gospelReadingDetail.details,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.4,
                                    ),
                                  ),
                          ],
                        ),
                        16.height,
                      ],
                    ),
                  ),
                ),
              ),
              error: (error, stackTrace) {
                print(error);
                print(stackTrace);
                if (error.toString() == "204") {
                  return Column(
                    children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          bool res = await checkInternetConnectivity(context);
                          if (res) {
                            await ref.refresh(todayAgendasProvider(agendaDateFormatter(dateNow)).future);
                          }
                        },
                        child: SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(32),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(32),
                              child: Text(
                                "Tidak dapat menemukan kalender liturgi untuk hari ini",
                                textAlign: TextAlign.center,
                                style: body3(color: grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Tidak dapat memuat data",
                        style: body3(color: grey),
                      ),
                      16.height,
                      IconButton(
                        onPressed: () async {
                          final res = await checkInternetConnectivity(context);
                          if (res) {
                            await ref.refresh(todayAgendasProvider(agendaDateFormatter(dateNow)).future);
                          }
                        },
                        icon: Icon(Icons.refresh),
                      )
                    ],
                  ),
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
            ),
      ),
      // ref.watch(todayAgendasProvider(agendaDateFormatter(dateNow))).when(
      //       skipLoadingOnRefresh: false,
      //       data: (data) => SizedBox.expand(
      //         child: GestureDetector(
      //           onPanUpdate: (details) async {
      //             // Swiping in right direction.
      //             if (details.delta.dx > 0) {
      //               if (details.delta.distance >= 12) {
      //                 print(details.delta.distance);
      //                 // print("SWIPE RIGHT");
      //                 await changeDate(false);
      //               }
      //             }
      //             // Swiping in left direction.
      //             if (details.delta.dx < 0) {
      //               if (details.delta.distance >= 12) {
      //                 print(details.delta.distance);
      //                 await changeDate(true);
      //                 // print("SWIPE LEFT");
      //               }
      //             }
      //           },
      //           child: SingleChildScrollView(
      //             physics: const BouncingScrollPhysics(),
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Container(
      //                   margin: EdgeInsets.all(16),
      //                   child: Material(
      //                     textStyle: liturgiTheme(data.liturgicalColor.toString()),
      //                     child: Container(
      //                       width: MediaQuery.of(context).size.width,
      //                       decoration: BoxDecoration(
      //                         color: liturgiColor(
      //                           data.liturgicalColor.toString(),
      //                         ),
      //                         borderRadius: BorderRadius.circular(12),
      //                         boxShadow: [
      //                           BoxShadow(
      //                             color: ref.watch(parokiLib)[ref.watch(parokiLibIndex)].color.cGreyShadow,
      //                             spreadRadius: 1,
      //                             blurRadius: 4,
      //                             offset: Offset(0, 3), // changes position of shadow
      //                           ),
      //                         ],
      //                       ),
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Stack(
      //                             children: [
      //                               Positioned(
      //                                   right: -60,
      //                                   bottom: -55,
      //                                   child: Container(
      //                                     decoration: BoxDecoration(
      //                                         gradient: LinearGradient(colors: [
      //                                           Color.fromARGB(89, 187, 187, 187),
      //                                           Color.fromARGB(43, 255, 255, 255),
      //                                         ]),
      //                                         shape: BoxShape.circle),
      //                                     width: 200,
      //                                     height: 300,
      //                                   )),
      //                               Positioned(
      //                                 right: -40,
      //                                 top: -10,
      //                                 child: Image.asset(
      //                                   'assets/images/icon-kl.png',
      //                                   height: 200,
      //                                   width: 200,
      //                                 ),
      //                               ),
      //                               Positioned(
      //                                 right: -80,
      //                                 top: -50,
      //                                 child: Container(
      //                                   height: 180,
      //                                   width: 180,
      //                                   decoration: BoxDecoration(),
      //                                 ),
      //                               ),
      //                               Container(
      //                                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      //                                 alignment: Alignment.center,
      //                                 child: Column(
      //                                   crossAxisAlignment: CrossAxisAlignment.start,
      //                                   children: [
      //                                     Text(data.liturgicalMemorial.toString().isNotEmpty
      //                                         ? data.liturgicalMemorial
      //                                         : "Hari Biasa"),
      //                                     Text('Warna Liturgi : ' + data.liturgicalColor.toString()),
      //                                     Text('Bacaan I : ' + data.eucharisticReading.firstReading.toString()),
      //                                     Text('Mazmur : ' + data.eucharisticReading.psalm.toString()),
      //                                     data.eucharisticReading.secondReading != ''
      //                                         ? Text('Bacaan II : ' + data.eucharisticReading.secondReading.toString())
      //                                         : Container(),
      //                                     Text('Injil : ' + data.eucharisticReading.gospel.toString()),
      //                                   ],
      //                                 ),
      //                               )
      //                             ],
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.symmetric(horizontal: 16),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text(
      //                         data.weeks.liturgical,
      //                         style: TextStyle(
      //                           fontSize: 14,
      //                         ),
      //                       ),
      //                       2.height,
      //                       Text(
      //                         data.liturgicalMemorial,
      //                         style: TextStyle(
      //                           fontSize: 16,
      //                         ),
      //                       ),
      //                       Divider(
      //                         thickness: 1,
      //                         height: 16,
      //                         color: Colors.grey,
      //                       ),
      //                     ],
      //                   ),
      //                 ),

      //                 // Text(
      //                 //   'Warna Liturgi : ' + dataDetails['liturgicalColor'],
      //                 //   style: TextStyle(
      //                 //     fontSize: 16,
      //                 //   ),
      //                 // ),
      //                 // Divider(
      //                 //   height: 20,
      //                 //   thickness: 5,
      //                 //   endIndent: 0,
      //                 //   color: liturgiColor(dataDetails['liturgicalColor']),
      //                 // ),
      //                 ExpansionTile(
      //                   tilePadding: EdgeInsets.symmetric(horizontal: 16),
      //                   backgroundColor: Colors.grey.shade100,
      //                   childrenPadding: EdgeInsets.symmetric(horizontal: 16),
      //                   title: Text(
      //                     'Bacaan 1 : ' + data.eucharisticReading.firstReading,
      //                     style: TextStyle(
      //                       fontSize: 16,
      //                     ),
      //                   ),
      //                   subtitle: Text(
      //                     data.eucharisticReading.firstReadingDetail.excerpt,
      //                     style: TextStyle(
      //                       fontSize: 16,
      //                       fontStyle: FontStyle.italic,
      //                     ),
      //                   ),
      //                   children: [
      //                     Text(
      //                       data.eucharisticReading.firstReadingDetail.details,
      //                       textAlign: TextAlign.justify,
      //                       style: TextStyle(
      //                         fontSize: 16,
      //                         height: 1.4,
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: 30,
      //                     )
      //                   ],
      //                 ),
      //                 ExpansionTile(
      //                   tilePadding: EdgeInsets.symmetric(horizontal: 16),
      //                   backgroundColor: Colors.grey.shade100,
      //                   childrenPadding: EdgeInsets.symmetric(horizontal: 16),
      //                   title: Text(
      //                     'Mazmur : ' + data.eucharisticReading.psalm,
      //                     style: TextStyle(
      //                       fontSize: 16,
      //                     ),
      //                   ),
      //                   subtitle: Text(
      //                     'reffren : ' + data.eucharisticReading.psalmDetail.reffren,
      //                     style: TextStyle(
      //                       fontSize: 16,
      //                       fontStyle: FontStyle.italic,
      //                     ),
      //                   ),
      //                   children: [
      //                     Column(
      //                       children: [
      //                         for (int i = 0; i < data.eucharisticReading.psalmDetail.ayats.length; i++)
      //                           Column(
      //                             children: [
      //                               Text(
      //                                 data.eucharisticReading.psalmDetail.ayats[i],
      //                                 textAlign: TextAlign.justify,
      //                                 style: TextStyle(
      //                                   fontSize: 16,
      //                                   height: 1.4,
      //                                 ),
      //                               ),
      //                               8.height,
      //                             ],
      //                           ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //                 data.eucharisticReading.secondReading != ''
      //                     ? ExpansionTile(
      //                         tilePadding: EdgeInsets.symmetric(horizontal: 16),
      //                         backgroundColor: Colors.grey.shade100,
      //                         childrenPadding: EdgeInsets.symmetric(horizontal: 16),
      //                         title: Text(
      //                           'Bacaan 2 : ' + data.eucharisticReading.firstReading,
      //                           style: TextStyle(
      //                             fontSize: 16,
      //                           ),
      //                         ),
      //                         subtitle: Text(
      //                           data.eucharisticReading.firstReadingDetail.excerpt,
      //                           style: TextStyle(
      //                             fontSize: 16,
      //                             fontStyle: FontStyle.italic,
      //                           ),
      //                         ),
      //                         children: [
      //                           Text(
      //                             data.eucharisticReading.firstReadingDetail.details,
      //                             textAlign: TextAlign.justify,
      //                             style: TextStyle(
      //                               fontSize: 16,
      //                               height: 1.4,
      //                             ),
      //                           ),
      //                         ],
      //                       )
      //                     : Container(),
      //                 ExpansionTile(
      //                   tilePadding: EdgeInsets.symmetric(horizontal: 16),
      //                   backgroundColor: Colors.grey.shade100,
      //                   childrenPadding: EdgeInsets.symmetric(horizontal: 16),
      //                   title: Text(
      //                     'Bacaan Injil : ' + data.eucharisticReading.gospel,
      //                     style: TextStyle(
      //                       fontSize: 16,
      //                     ),
      //                   ),
      //                   subtitle: Text(
      //                     data.eucharisticReading.gospelReadingDetail.excerpt,
      //                     style: TextStyle(
      //                       fontSize: 16,
      //                       fontStyle: FontStyle.italic,
      //                     ),
      //                   ),
      //                   children: [
      //                     Text(
      //                       data.eucharisticReading.gospelReadingDetail.details,
      //                       textAlign: TextAlign.justify,
      //                       style: TextStyle(
      //                         fontSize: 16,
      //                         height: 1.4,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 16.height,
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //       error: (error, stackTrace) {
      //         print(error);
      //         print(stackTrace);
      //         return Center(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               Text(
      //                 "Tidak dapat memuat data",
      //                 style: body3(color: grey),
      //               ),
      //               16.height,
      //               IconButton(
      //                 onPressed: () async {
      //                   final res = await checkInternetConnectivity(context);
      //                   if (res) {
      //                     await ref.refresh(todayAgendasProvider(agendaDateFormatter(dateNow)).future);
      //                   }
      //                 },
      //                 icon: Icon(Icons.refresh),
      //               )
      //             ],
      //           ),
      //         );
      //       },
      //       loading: () => Center(child: CircularProgressIndicator()),
      // ),
    );
  }
}
