import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/booking/detail_booking.dart';
import 'package:flutter_coffee_application/Page/notification/detail_notification.dart';
import 'package:flutter_coffee_application/component/notif_body.dart';
import 'package:flutter_coffee_application/resource/const_resource.dart';
import 'package:flutter_coffee_application/resource/provider/notification_provider.dart';
import 'package:flutter_coffee_application/resource/services/api/notification_services.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../checkinternet.dart';
import '../../component/show_dialog.dart';
import '../../style/typhography.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  @override
  void initState() {
    ref.refresh(notifProvider.future);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(notifProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
        ),
        centerTitle: true,
      ),
      body: list.when(
        skipLoadingOnRefresh: false,
        data: (_data) {
          if (_data.isEmpty) {
            return Center(
              child: Text(
                "Tidak ada notifikasi",
                style: body2(color: Colors.grey),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              bool res = await checkInternetConnectivity(context);
              if (res) {
                await ref.refresh(notifProvider.future);
              }
            },
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      try {
                        showDialogLoading(context);
                        Map<String, dynamic> response =
                            await NotificationServices()
                                .updateNotification(_data[index].id)
                                .timeout(
                                  Duration(seconds: apiWaitTime),
                                );

                        print(response);
                        finish(context);
                        if (response['statusCode'] == 200) {
                          ref.refresh(notifProvider.future);
                          _data[index].categoryName == "booking"
                              ? DetailBooking(
                                  id: _data[index].categoryId,
                                ).launch(context)
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailNotif(
                                      detailNotif: _data[index],
                                    ),
                                  ),
                                );
                        } else {
                          print("Error: >>>>");
                          _data[index].categoryName == "booking"
                              ? DetailBooking(
                                  id: _data[index].categoryId,
                                ).launch(context)
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailNotif(
                                      detailNotif: _data[index],
                                    ),
                                  ),
                                );
                        }
                      } on TimeoutException {
                        finish(context);

                        _data[index].categoryName == "booking"
                            ? DetailBooking(
                                id: _data[index].categoryId,
                              ).launch(context)
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailNotif(
                                    detailNotif: _data[index],
                                  ),
                                ),
                              );
                      } catch (e) {
                        finish(context);

                        _data[index].categoryName == "booking"
                            ? DetailBooking(
                                id: _data[index].categoryId,
                              ).launch(context)
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailNotif(
                                    detailNotif: _data[index],
                                  ),
                                ),
                              );
                      }
                    },
                    child: NotoficationBody(
                      notif: _data[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
        error: (error, stackTrace) {
          print(error);
          print(stackTrace);
          return Center(
            child: IconButton(
              onPressed: () async {
                bool res = await checkInternetConnectivity(context);
                if (res) {
                  await ref.refresh(notifProvider.future);
                }
              },
              icon: Icon(
                Icons.refresh,
                color: primary,
              ),
            ),
          );
        },
        loading: () => Center(
            child: CircularProgressIndicator(
          color: primary,
        )),
      ),
    );
  }
}
