import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/resource/provider/booking_provider.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../style/color.dart';

class DetailBooking extends ConsumerStatefulWidget {
  final String id;
  const DetailBooking({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<DetailBooking> createState() => _DetaiBookingState();
}

class _DetaiBookingState extends ConsumerState<DetailBooking> {
  @override
  void initState() {
    ref.refresh(detailBookingProvider(widget.id).future);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Booking",
        ),
      ),
      body: ref.watch(detailBookingProvider(widget.id)).when(
            skipLoadingOnRefresh: false,
            data: (data) {
              return RefreshIndicator(
                onRefresh: () async {
                  bool res = await checkInternetConnectivity(context);
                  if (res) {
                    await ref.refresh(detailBookingProvider(widget.id).future);
                  }
                },
                child: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                data.isApproved != null
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Status", style: body1()),
                                          Container(
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: data.isApproved!
                                                        ? safeAlt
                                                        : dangerDark),
                                                child: Text(
                                                  data.isApproved!
                                                      ? "DISETUJUI"
                                                      : "DITOLAK",
                                                  style: body3(color: white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Status", style: body1()),
                                          Container(
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: warningDark),
                                                child: Text(
                                                  "PENDING",
                                                  style: body3(color: white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                Divider(
                                    thickness: 2,
                                    color: Colors.grey.shade300,
                                    height: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1 /
                                                  3 +
                                              8,
                                          child: Text("Nama Acara",
                                              style: body1()),
                                        ),
                                        Text(": ", style: body1()),
                                        Flexible(
                                            child: Text(data.nameEvent ?? "",
                                                style: body2())),
                                      ],
                                    ),
                                    Divider(
                                        thickness: 1,
                                        color: Colors.grey.shade300,
                                        height: 16),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1 /
                                                  3 +
                                              8,
                                          child: Text("Nama Penanggung Jawab",
                                              style: body1()),
                                        ),
                                        Text(": ", style: body1()),
                                        Flexible(
                                            child: Text(data.picName ?? "",
                                                style: body2())),
                                      ],
                                    ),
                                    Divider(
                                        thickness: 1,
                                        color: Colors.grey.shade300,
                                        height: 16),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1 /
                                                  3 +
                                              8,
                                          child: Text(
                                              "Nomor Telepon Penanggung Jawab",
                                              style: body1()),
                                        ),
                                        Text(": ", style: body1()),
                                        Flexible(
                                            child: Text(data.picNumber ?? "",
                                                style: body2())),
                                      ],
                                    ),
                                    Divider(
                                        thickness: 1,
                                        color: Colors.grey.shade300,
                                        height: 16),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1 /
                                                  3 +
                                              8,
                                          child: Text("Jumlah Peserta",
                                              style: body1()),
                                        ),
                                        Text(": ", style: body1()),
                                        Flexible(
                                            child: Text(
                                                data.humanCount.toString() ??
                                                    "",
                                                style: body2())),
                                      ],
                                    ),
                                    Divider(
                                        thickness: 1,
                                        color: Colors.grey.shade300,
                                        height: 16),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1 /
                                                  3 +
                                              8,
                                          child: Text("Waktu Mulai",
                                              style: body1()),
                                        ),
                                        Text(": ", style: body1()),
                                        Flexible(
                                            child: Text(
                                                formatDate(data.startTime) ??
                                                    "",
                                                style: body2())),
                                      ],
                                    ),
                                    Divider(
                                        thickness: 1,
                                        color: Colors.grey.shade300,
                                        height: 16),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1 /
                                                  3 +
                                              8,
                                          child: Text("Waktu Selesai",
                                              style: body1()),
                                        ),
                                        Text(": ", style: body1()),
                                        Flexible(
                                            child: Text(
                                                "${formatDate(data.endTime)}" ??
                                                    "",
                                                style: body2())),
                                      ],
                                    ),
                                    Divider(
                                        thickness: 1,
                                        color: Colors.grey.shade300,
                                        height: 16),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (err, s) {
              print(err);
              print(s);
              if (err.toString() == "204") {
                return Padding(
                  padding: const EdgeInsets.all(64),
                  child: Center(
                    child: Text(
                      "Tidak ditemukan data booking",
                      style: body2(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              return Center(
                child: IconButton(
                  onPressed: () async {
                    bool result = await checkInternetConnectivity(context);
                    if (result) {
                      await ref
                          .refresh(detailBookingProvider(widget.id).future);
                    }
                  },
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: primary,
                  ),
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
