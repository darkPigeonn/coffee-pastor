// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers, unused_result

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/auth/auth_page.dart';
import 'package:flutter_coffee_application/Page/booking/booking_history.dart';
import 'package:flutter_coffee_application/Page/booking/detail_booking.dart';
import 'package:flutter_coffee_application/Page/kalender%20liturgi/detail.dart';
import 'package:flutter_coffee_application/Page/notification/notification_page.dart';
import 'package:flutter_coffee_application/Page/paroki/paroki.dart';
import 'package:flutter_coffee_application/Page/point/history_point.dart';
import 'package:flutter_coffee_application/Page/product/product_page.dart';
import 'package:flutter_coffee_application/Page/promo/detail_promo.dart';
import 'package:flutter_coffee_application/Page/quote/detail_quote.dart';
import 'package:flutter_coffee_application/Page/testimoni/add_testimoni.dart';
import 'package:flutter_coffee_application/Page/testimoni/detail_testimoni.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/Booking/booking.dart';
import 'package:flutter_coffee_application/component/Button.dart';
import 'package:flutter_coffee_application/component/ImageLoader.dart';
import 'package:flutter_coffee_application/component/Testimoni/testimoni.dart';
import 'package:flutter_coffee_application/component/other.dart';
import 'package:flutter_coffee_application/component/quotes.dart';
import 'package:flutter_coffee_application/component/show_dialog.dart';
import 'package:flutter_coffee_application/resource/model/tentang_model.dart';
import 'package:flutter_coffee_application/resource/provider/auth/auth_provider.dart';
import 'package:flutter_coffee_application/resource/provider/booking_provider.dart';
import 'package:flutter_coffee_application/resource/provider/cart_provider.dart';
import 'package:flutter_coffee_application/resource/provider/data_provider.dart';
import 'package:flutter_coffee_application/resource/provider/notification_provider.dart';
import 'package:flutter_coffee_application/resource/provider/profile_provider.dart';
import 'package:flutter_coffee_application/resource/provider/promo_provider.dart';
import 'package:flutter_coffee_application/resource/provider/quote_provider.dart';
import 'package:flutter_coffee_application/resource/provider/resources_provider.dart';
import 'package:flutter_coffee_application/resource/provider/testimoni_provider.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Map? dataKalenderLiturgi = null;

  Future<void> _firebaseMessagingForegroundHandler(context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        // print('Message also contained a notification: ${message.notification}');
        ref.refresh(notifProvider.future);
        // await
        await showNotification(
            message.notification.hashCode,
            message.notification!.title!,
            message.notification!.body!,
            message.data);
      }
    });
  }

  Future<void> askNotificationPermission() async {
    bool isNotificationDenied = await Permission.notification.isDenied;
    bool isNotificationRestrictedOn = await Permission.notification.isLimited;
    bool isNotificationPermanentlyOff =
        await Permission.notification.isPermanentlyDenied;
    print(isNotificationDenied);
    print(isNotificationRestrictedOn);
    print(isNotificationPermanentlyOff);
    if (isNotificationDenied ||
        isNotificationRestrictedOn ||
        isNotificationPermanentlyOff) {
      await Permission.notification.onDeniedCallback(() async {
        await showDialogConfirm(
          context,
          "Akses Notifikasi",
          "Aktifkan akses notifikasi untuk mendapatkan kabar terbaru lewat aplikasi",
          "Aktifkan",
          () {
            askNotificationPermission();
            // Permission.notification.request();
            context.pop();
          },
          "Lain Kali",
          () {
            context.pop();
          },
        );
      }).onGrantedCallback(() {
        // Your code
      }).onPermanentlyDeniedCallback(() async {
        await showDialogConfirm(
          context,
          "Tidak Dapat Mengakses Notifikasi",
          "Aktifkan akses notifikasi pada pengaturan perangkat anda untuk menerima notifikasi terbaru",
          "Saya mengerti",
          () {
            context.pop();
          },
          "",
          () {
            context.pop();
          },
        );
        // Your code
      }).onRestrictedCallback(() async {
        // Your code
        // await showDialogConfirm(
        //   context,
        //   "Akses Notifikasi Terbatas",
        //   "Aktifkan akses notifikasi secara penuh untuk mendapatkan kabar terbaru lewat aplikasi",
        //   "Aktifkan",
        //   () {
        //     askPermission();
        //     context.pop();
        //   },
        //   "Lain Kali",
        //   () {
        //     context.pop();
        //   },
        // );
      }).onLimitedCallback(() async {
        // Your code
        // await showDialogConfirm(
        //   context,
        //   "Akses Notifikasi Terbatas",
        //   "Aktifkan akses notifikasi secara penuh untuk mendapatkan kabar terbaru lewat aplikasi",
        //   "Aktifkan",
        //   () {
        //     askPermission();
        //     context.pop();
        //   },
        //   "Lain Kali",
        //   () {
        //     context.pop();
        //   },
        // );
      }).onProvisionalCallback(() {
        // Your code
      }).request();
    }
  }

  Future<void> showNotification(int hashCode, String title, String body,
      Map<String, dynamic> data) async {
    //Create Notification Channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel', // id
      'High Importance Notifications', // title
      // 'This channel is used for important notifications.', // description
      importance: Importance.max,
      playSound: true,
    );

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) async {
      onDidReceiveNotificationResponse(data["type"], data["typeId"]);
    });

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'channel',
      'Notifikasi',
      // 'Notifikasi Kepegawaian',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      hashCode,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  Future<void> onDidReceiveNotificationResponse(
    String type,
    var typeId,
  ) async {
    if (type == '') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    } else if (type == 'booking' || type == "booking") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    }
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'booking') {
      DetailBooking(id: message.data['typeId']).launch(context);
    } else {
      NotificationPage().launch(context);
    }
  }

  whatsapp() async {
    var contact = "08123456789";
    var androidUrl =
        "whatsapp://send?phone=$contact&text=Hi, Saya ingin bertanya mengenai booking tempat di Cafe Pastor";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse("""
Hi, Saya ingin bertanya mengenai booking tempat di Cafe Pastor
""")}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("WhatsApp is not installed on the device"),
      ));
    }
  }

  bool _enabled = true;

  var now = DateTime.now();
  int _currentSlide = 0;
  @override
  void initState() {
    super.initState();
    ref.refresh(profileDataProvider.future);
    ref.refresh(promoProvider.future);
    ref.refresh(notifProvider.future);
    ref.refresh(cartProvider.future);
    ref.refresh(bookingProvider.future);
    ref.refresh(tentangProvider.future);
    askNotificationPermission();
    setupInteractedMessage();
    _firebaseMessagingForegroundHandler(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(profileDataProvider);
    final countBagde = ref.watch(updateBadgeProvider);
    final dataAgendas = ref.watch(agendasProvider);

    final isLoading = user is AsyncLoading;
    _enabled = isLoading;
    return PopScope(
      canPop: false,
      child: Skeletonizer(
        enabled: _enabled,
        child: Scaffold(
          body: RefreshIndicator(
            color: primary,
            onRefresh: () async {
              bool result = await checkInternetConnectivity(context);
              setState(() {
                _enabled = false;
              });
              if (result) {
                ref.refresh(profileDataProvider.future);
                ref.refresh(notifProvider.future);
                ref.refresh(cartProvider.future);
                ref.refresh(todayQuoteProvider.future);
                ref.refresh(tentangProvider.future);
              }
            },
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: ref.watch(isLogin) ? 320 : 350,
                        child: Stack(
                          children: [
                            Container(
                              height: 260,
                              color: primary,
                              child: ref.watch(isLogin)
                                  ? user.when(
                                      skipLoadingOnRefresh: false,
                                      data: (data) {
                                        return SafeArea(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 16, right: 16, top: 24),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      child: Image.asset(
                                                        'assets/logo/logo.png',
                                                        scale: 3.5,
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          now.hour >= 5 &&
                                                                  now.hour < 11
                                                              ? 'Selamat Pagi,'
                                                              : now.hour >=
                                                                          11 &&
                                                                      now.hour <
                                                                          15
                                                                  ? 'Selamat Siang,'
                                                                  : now.hour >=
                                                                              15 &&
                                                                          now.hour <
                                                                              19
                                                                      ? 'Selamat Sore,'
                                                                      : 'Selamat Malam,',
                                                          style: custom(
                                                              fontSize: 16,
                                                              bold: FontWeight
                                                                  .normal,
                                                              color: white),
                                                        ),
                                                        Container(
                                                          width: 180,
                                                          child: Text(
                                                            data.fullName
                                                                .capitalizeEachWord(),
                                                            style: h2(
                                                                color: white),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: primaryDark),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                NotificationPage()),
                                                      );
                                                    },
                                                    child: Center(
                                                      child: Badge.count(
                                                        isLabelVisible:
                                                            countBagde != 0,
                                                        count: countBagde,
                                                        child: Icon(
                                                          Icons
                                                              .notifications_rounded,
                                                          color: white,
                                                          size: 32,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      error: (error, e) {
                                        if (error.toString() == "204") {
                                          return SizedBox(
                                            child: Center(
                                              child: Container(
                                                  padding: EdgeInsets.all(32),
                                                  child: Text(
                                                    "??",
                                                    style: body2(
                                                      color: Colors.grey,
                                                    ),
                                                  )),
                                            ),
                                          );
                                        }
                                        return Center(
                                          child: Column(
                                            children: [
                                              Container(
                                                child: IconButton(
                                                  onPressed: () async {
                                                    bool result =
                                                        await checkInternetConnectivity(
                                                            context);
                                                    if (result) {
                                                      await ref.refresh(
                                                          profileDataProvider
                                                              .future);
                                                    }
                                                  },
                                                  icon: Icon(
                                                      Icons.refresh_rounded,
                                                      color: primary),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      loading: () => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : SafeArea(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 12, 16, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Selamat Datang di Cafe Pastor",
                                              style: body1(
                                                color: white,
                                              ),
                                            ),
                                            12.height,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    "Nikmati penawaran terbaik melalui akunmu !",
                                                    style: h3(color: white),
                                                    maxLines: 2,
                                                  ),
                                                ),
                                                Button(
                                                  onPressed: () {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AuthPage(),
                                                      ),
                                                    );
                                                  },
                                                  color: white,
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Login Sekarang",
                                                          style: h5(
                                                              color: primary),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios_sharp,
                                                          size: 12,
                                                          color: primary,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ref.watch(isLogin)
                                              ? user.when(
                                                  skipLoadingOnRefresh: false,
                                                  data: (data) {
                                                    return Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () =>
                                                                HistoryPoint(
                                                              listPoint: data
                                                                  .listPoints,
                                                            ).launch(context),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "${data.point} poin",
                                                                  style: h1(),
                                                                ),
                                                                8.width,
                                                                Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down,
                                                                  size: 32,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          dataAgendas.when(
                                                            skipLoadingOnRefresh:
                                                                false,
                                                            data: (_data) {
                                                              Map dataCek = _data[
                                                                  'liturgicalCalendars'];
                                                              dataKalenderLiturgi =
                                                                  _data[
                                                                      'liturgicalCalendars'];
                                                              return dataCek
                                                                      .isNotEmpty
                                                                  ? RectangleButtonIcon(
                                                                      color:
                                                                          white,
                                                                      onPressed:
                                                                          () =>
                                                                              DetailKalenderLiturgi().launch(context),
                                                                      iconLeading:
                                                                          Icon(
                                                                        Icons
                                                                            .calendar_month_outlined,
                                                                        size:
                                                                            36,
                                                                        color:
                                                                            primary,
                                                                      ),
                                                                      text:
                                                                          Text(
                                                                        "Kalender Liturgi",
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            body2(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                    )
                                                                  : Container();
                                                            },
                                                            error: (err, s) {
                                                              if (err.toString() ==
                                                                  "204") {
                                                                return SizedBox(
                                                                  child: Center(
                                                                    child: Container(
                                                                        padding: EdgeInsets.all(32),
                                                                        child: Text(
                                                                          "Belum ada kalender liturgi untuk hari ini",
                                                                          style:
                                                                              body3(
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        )),
                                                                  ),
                                                                );
                                                              }
                                                              return Center(
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      child:
                                                                          IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          bool
                                                                              result =
                                                                              await checkInternetConnectivity(context);
                                                                          if (result) {
                                                                            await ref.refresh(agendasProvider.future);
                                                                          }
                                                                        },
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .refresh_rounded,
                                                                          color:
                                                                              primary,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                            loading: () => Center(
                                                                child:
                                                                    SizedBox()),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  error: (err, s) {
                                                    if (err.toString() ==
                                                        "204") {
                                                      return SizedBox(
                                                        child: Center(
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(32),
                                                              child: Text(
                                                                "Belum ada kalender liturgi untuk hari ini",
                                                                style: body3(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              )),
                                                        ),
                                                      );
                                                    }
                                                    return Center(
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            child: IconButton(
                                                              onPressed:
                                                                  () async {
                                                                bool result =
                                                                    await checkInternetConnectivity(
                                                                        context);
                                                                if (result) {
                                                                  await ref.refresh(
                                                                      agendasProvider
                                                                          .future);
                                                                }
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .refresh_rounded,
                                                                color: primary,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  loading: () => Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: primary,
                                                    ),
                                                  ),
                                                )
                                              : dataAgendas.when(
                                                  skipLoadingOnRefresh: false,
                                                  data: (_data) {
                                                    Map dataCek = _data[
                                                        'liturgicalCalendars'];
                                                    dataKalenderLiturgi = _data[
                                                        'liturgicalCalendars'];
                                                    return dataCek.isNotEmpty
                                                        ? RectangleButtonIcon(
                                                            color: white,
                                                            onPressed: () =>
                                                                DetailKalenderLiturgi()
                                                                    .launch(
                                                                        context),
                                                            iconLeading: Icon(
                                                              Icons
                                                                  .calendar_month_outlined,
                                                              size: 36,
                                                              color: primary,
                                                            ),
                                                            text: Text(
                                                              "Kalender Liturgi",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: body2(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          )
                                                        : Container();
                                                  },
                                                  error: (err, s) {
                                                    if (err.toString() ==
                                                        "204") {
                                                      return SizedBox(
                                                        child: Center(
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(32),
                                                              child: Text(
                                                                "Belum ada kalender liturgi untuk hari ini",
                                                                style: body3(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              )),
                                                        ),
                                                      );
                                                    }
                                                    return Center(
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            child: IconButton(
                                                              onPressed:
                                                                  () async {
                                                                bool result =
                                                                    await checkInternetConnectivity(
                                                                        context);
                                                                if (result) {
                                                                  await ref.refresh(
                                                                      agendasProvider
                                                                          .future);
                                                                }
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .refresh_rounded,
                                                                color: primary,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  loading: () => Center(
                                                    child: SizedBox(
                                                      height: 116,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          CircularProgressIndicator(
                                                            color: primary,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          12.height,
                                          ButtonIcon(
                                            color: white,
                                            onPressed: () =>
                                                AddTestimoni().launch(context),
                                            iconLeading: Icon(
                                              Icons.comment_outlined,
                                              color: primary,
                                            ),
                                            text: Flexible(
                                              child: Text(
                                                "Tuliskan testimoni berkunjung ke cafe pastor",
                                                style: h5(color: black),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            iconTrailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: primary,
                                              size: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.height,
                      ref.watch(tentangProvider).when(
                            skipLoadingOnRefresh: false,
                            data: (data) {
                              List<dynamic> combinedData = [];
                              combinedData.addAll(data.promos.map((promo) => {
                                    'type': 'promo',
                                    'data': promo,
                                  }));
                              combinedData.add({
                                'type': 'paroki',
                                'data': data.paroki,
                              });

                              return Column(
                                children: [
                                  CarouselSlider.builder(
                                    itemCount: combinedData.length,
                                    itemBuilder: (BuildContext context,
                                        int itemIndex, int pageViewIndex) {
                                      ref
                                          .watch(likePromo.notifier)
                                          .state
                                          .add(false);
                                      var item = combinedData[itemIndex];
                                      if (item['type'] == 'promo') {
                                        Promo promo = item['data'];
                                        return GestureDetector(
                                          onTap: () {
                                            DetailPromo(
                                              onPressedLikeIcon: () {
                                                List<bool> tempList =
                                                    ref.read(likePromo);
                                                tempList[itemIndex] =
                                                    !tempList[itemIndex];
                                                ref
                                                    .watch(likePromo.notifier)
                                                    .update((state) =>
                                                        tempList.toList());
                                              },
                                              promoId: promo.id,
                                              index: itemIndex,
                                            ).launch(context);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 12),
                                            decoration: shadowBox(),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: LoadImage(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (16 / 9),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      (9 / 16),
                                                  imageLink: promo.image,
                                                  boxFit: BoxFit.fill,
                                                )),
                                          ),
                                        );
                                      } else if (item['type'] == 'paroki') {
                                        Paroki paroki = item['data'];
                                        return GestureDetector(
                                          onTap: () {
                                            DetailParoki(id: paroki.parokiId)
                                                .launch(context);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            decoration: shadowBox(),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: LoadImage(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      (16 / 9),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      (9 / 16),
                                                  imageLink: paroki.images[0],
                                                  boxFit: BoxFit.fill,
                                                )),
                                          ),
                                        );
                                      } else {
                                        return SizedBox(); // Handle other types if necessary
                                      }
                                    },
                                    options: CarouselOptions(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              (9 / 16),
                                      aspectRatio: 16 / 9,
                                      autoPlay: true,
                                      autoPlayInterval: Duration(seconds: 20),
                                      enableInfiniteScroll: true,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _currentSlide = index;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      combinedData.length,
                                      (index) => Container(
                                        width: index == _currentSlide ? 10 : 4,
                                        height: 4,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        decoration: BoxDecoration(
                                          color: index == _currentSlide
                                              ? Colors.black
                                              : Colors.grey,
                                          borderRadius: index == _currentSlide
                                              ? BorderRadius.circular(2)
                                              : BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            error: (error, e) {
                              if (error.toString() == "204") {
                                return SizedBox(
                                  child: Center(
                                    child: Container(
                                        padding: EdgeInsets.all(32),
                                        child: Text(
                                          "Belum ada promo yang tersedia",
                                          style: body2(
                                            color: Colors.grey,
                                          ),
                                        )),
                                  ),
                                );
                              }
                              return Center(
                                child: Column(
                                  children: [
                                    Container(
                                      child: IconButton(
                                        onPressed: () async {
                                          bool result =
                                              await checkInternetConnectivity(
                                                  context);
                                          if (result) {
                                            await ref.refresh(
                                                tentangProvider.future);
                                          }
                                        },
                                        icon: Icon(Icons.refresh_rounded,
                                            color: primary),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            loading: () => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ref.watch(isLogin)
                          ? ref.watch(bookingProvider).when(
                                data: (data) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Reservasi',
                                              style: h3(),
                                            ),
                                            GestureDetector(
                                              onTap: () => ListBookingPage()
                                                  .launch(context),
                                              child: Text(
                                                "Lihat Semua",
                                                style: body2(color: grey1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      16.height,
                                      InkWell(
                                        onTap: () => DetailBooking(
                                                id: data[data.length - 1].id)
                                            .launch(context),
                                        child: Booking(
                                            booking: data[data.length - 1]),
                                      ),
                                      16.height,
                                    ],
                                  );
                                },
                                error: (error, e) {
                                  if (error.toString() == "204") {
                                    return SizedBox();
                                  }
                                  return Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: IconButton(
                                            onPressed: () async {
                                              bool result =
                                                  await checkInternetConnectivity(
                                                      context);
                                              if (result) {
                                                await ref.refresh(
                                                    promoProvider.future);
                                              }
                                            },
                                            icon: Icon(Icons.refresh_rounded,
                                                color: primary),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                loading: () => Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                          : SizedBox(),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Text('Quote', style: h3()),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ref.watch(todayQuoteProvider).when(
                            skipLoadingOnRefresh: false,
                            data: (data) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailQuote(
                                        quote: data,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Quotes(quote: data),
                                ),
                              );
                            },
                            error: (error, e) {
                              if (error.toString() == "204") {
                                return SizedBox(
                                  child: Center(
                                    child: Container(
                                        padding: EdgeInsets.all(32),
                                        child: Text(
                                          "Belum ada quote untuk hari ini",
                                          style: body2(
                                            color: Colors.grey,
                                          ),
                                        )),
                                  ),
                                );
                              }
                              return Center(
                                child: Column(
                                  children: [
                                    Container(
                                      child: IconButton(
                                        onPressed: () async {
                                          bool result =
                                              await checkInternetConnectivity(
                                                  context);
                                          if (result) {
                                            await ref
                                                .refresh(promoProvider.future);
                                          }
                                        },
                                        icon: Icon(Icons.refresh_rounded,
                                            color: primary),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            loading: () => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      SizedBox(
                        height: 16,
                      ),
                      DataArtikel(),
                      16.height,
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Text('Pesan Sekarang', style: h3()),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: primary,
                                  ),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () {
                                    ref
                                        .watch(isDelivProvider.notifier)
                                        .update((state) => false);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ListProduk()),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Daftar Produk",
                                            style: h2(color: primary)),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  "Lihat produk produk yang terjual di cafe ini",
                                                  style: body1(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              8.width,
                                              CircleAvatar(
                                                backgroundColor: primaryLight,
                                                radius: 20,
                                                child: Icon(
                                                  Icons.shopping_bag,
                                                  size: 28,
                                                  color: primaryDark,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Expanded(
                            //   child: Card(
                            //     elevation: 0,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(12),
                            //       side: BorderSide(
                            //         color: secondary,
                            //       ),
                            //     ),
                            //     clipBehavior: Clip.antiAlias,
                            //     child: InkWell(
                            //       onTap: () {
                            //         ref
                            //             .watch(isDelivProvider.notifier)
                            //             .update((state) => true);
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //             builder: (context) =>
                            //                 const ListProduk(),
                            //           ),
                            //         );
                            //       },
                            //       child: Padding(
                            //         padding: const EdgeInsets.symmetric(
                            //             horizontal: 16, vertical: 10),
                            //         child: Column(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             Text(
                            //               "Delivery",
                            //               style: TextStyle(
                            //                 fontSize: 24,
                            //                 fontWeight: FontWeight.bold,
                            //                 color: secondary,
                            //               ),
                            //             ),
                            //             Expanded(
                            //               child: Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment
                            //                         .spaceBetween,
                            //                 children: [
                            //                   Flexible(
                            //                     child: Text(
                            //                       "Pesanan diantar ke lokasimu",
                            //                       maxLines: 3,
                            //                       overflow:
                            //                           TextOverflow.ellipsis,
                            //                     ),
                            //                   ),
                            //                   CircleAvatar(
                            //                     radius: 20,
                            //                     backgroundColor:
                            //                         secondaryPastel,
                            //                     child: Icon(
                            //                       Icons.motorcycle,
                            //                       size: 28,
                            //                       color: secondary,
                            //                     ),
                            //                   )
                            //                 ],
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        thickness: 10,
                        color: Colors.grey[200],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Text(
                          'Booking Tempat?',
                          style: h3(),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            whatsapp();
                          },
                          child: Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Image.asset("assets/logo/whatsapp.png"),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                flex: 15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Cafe Pastor Booking Service",
                                      style: body2(),
                                    ),
                                    Text(
                                      "0812-0000-0000",
                                      style: h5(color: greenColor),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      24.height,
                      Divider(
                        thickness: 2,
                        color: grey2,
                      ),
                      12.height,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Text(
                          'Testimoni',
                          style: h3(),
                        ),
                      ),
                      12.height,
                      ref.watch(testimoniProvider).when(
                            skipLoadingOnRefresh: false,
                            data: (data) {
                              return HorizontalList(
                                padding: EdgeInsets.fromLTRB(16, 4, 16, 8),
                                itemCount: data.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 300,
                                    margin: EdgeInsets.only(
                                        right:
                                            index == data.length - 1 ? 4 : 16),
                                    padding: const EdgeInsets.all(16),
                                    decoration: shadowBox(),
                                    child: InkWell(
                                        onTap: () => DetailTestimoni(
                                              tetimoniId: data[index].id,
                                            ).launch(context),
                                        child:
                                            Testimoni(testimoni: data[index])),
                                  );
                                },
                              );
                            },
                            error: (error, e) {
                              if (error.toString() == "204") {
                                return SizedBox(
                                  child: Center(
                                    child: Container(
                                        padding: EdgeInsets.all(32),
                                        child: Text(
                                          "Belum ada testimoni",
                                          style: body2(
                                            color: Colors.grey,
                                          ),
                                        )),
                                  ),
                                );
                              }
                              return Center(
                                child: Column(
                                  children: [
                                    Container(
                                      child: IconButton(
                                        onPressed: () async {
                                          bool result =
                                              await checkInternetConnectivity(
                                                  context);
                                          if (result) {
                                            await ref.refresh(
                                                testimoniProvider.future);
                                          }
                                        },
                                        icon: Icon(Icons.refresh_rounded,
                                            color: primary),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            loading: () => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
