import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/booking/detail_booking.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/Booking/booking.dart';
import 'package:flutter_coffee_application/component/other.dart';
import 'package:flutter_coffee_application/resource/model/booking_model.dart';
import 'package:flutter_coffee_application/resource/provider/booking_provider.dart';
import 'package:flutter_coffee_application/resource/provider/testimoni_provider.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

class ListBookingPage extends ConsumerStatefulWidget {
  const ListBookingPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListBookingPageState();
}

class _ListBookingPageState extends ConsumerState<ListBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Booking"),
        actions: [
          IconButton(
            onPressed: () => HistoryBookingPage().launch(context),
            icon: Icon(Icons.history),
          ),
        ],
      ),
      body: ref.watch(bookingProvider).when(
            data: (data) {
              List<ModelBooking> filteredData =
                  data.where((item) => item.isApproved == null).toList();
              return ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  return filteredData.isEmpty
                      ? Center(
                          child: Text("Belum ada daftar booking"),
                        )
                      : Column(
                          children: [
                            16.height,
                            InkWell(
                              onTap: () =>
                                  DetailBooking(id: filteredData[index].id)
                                      .launch(context),
                              child: Booking(
                                booking: filteredData[index],
                              ),
                            ),
                            index == filteredData.length - 1
                                ? 16.height
                                : SizedBox()
                          ],
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
                          "Belum ada testimoni baru",
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
                              await checkInternetConnectivity(context);
                          if (result) {
                            await ref.refresh(testimoniProvider.future);
                          }
                        },
                        icon: Icon(
                          Icons.refresh_rounded,
                        ),
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
    );
  }
}

class HistoryBookingPage extends ConsumerStatefulWidget {
  const HistoryBookingPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HistoryBookingPageState();
}

class _HistoryBookingPageState extends ConsumerState<HistoryBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat Booking"),
      ),
      body: ref.watch(bookingProvider).when(
            data: (data) {
              List<ModelBooking> filteredData =
                  data.where((item) => item.isApproved != null).toList();
              return ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  return filteredData.isEmpty
                      ? Center(
                          child: Text(
                            "Tidak ada riwayat booking",
                            style: body2(color: grey1),
                          ),
                        )
                      : Column(
                          children: [
                            16.height,
                            InkWell(
                              onTap: () =>
                                  DetailBooking(id: filteredData[index].id)
                                      .launch(context),
                              child: Booking(
                                booking: filteredData[index],
                              ),
                            ),
                          ],
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
                          "Belum ada testimoni baru",
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
                              await checkInternetConnectivity(context);
                          if (result) {
                            await ref.refresh(testimoniProvider.future);
                          }
                        },
                        icon: Icon(
                          Icons.refresh_rounded,
                        ),
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
    );
  }
}
