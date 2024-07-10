import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/Button.dart';
import 'package:flutter_coffee_application/component/TextField.dart';
import 'package:flutter_coffee_application/component/Toast/show_toast.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/component/show_dialog.dart';
import 'package:flutter_coffee_application/main.dart';
import 'package:flutter_coffee_application/resource/const_resource.dart';
import 'package:flutter_coffee_application/resource/provider/auth/auth_provider.dart';
import 'package:flutter_coffee_application/resource/services/api/booking_services.dart';
import 'package:flutter_coffee_application/resource/services/api/notification_services.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quickalert/quickalert.dart';

import '../../style/Color.dart';

class AddOrEditBookingPage extends ConsumerStatefulWidget {
  final bool? isEdit;
  final String? id;
  final String? title;
  final String? notes;
  final bool? isMax;
  final DateTime startDate;
  final DateTime endDate;
  final int? phone;

  const AddOrEditBookingPage({
    super.key,
    this.isEdit,
    this.id,
    this.title,
    this.notes,
    this.isMax,
    required this.startDate,
    required this.endDate,
    this.phone,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddOrEditBookingPageState();
}

class _AddOrEditBookingPageState extends ConsumerState<AddOrEditBookingPage> {
  TextEditingController eventCont = TextEditingController();
  TextEditingController nameCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController peopleCont = TextEditingController();
  bool isMax = false;
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    if (widget.isEdit != null) {
      eventCont.text = widget.title!;
      nameCont.text = widget.notes!;
      phoneCont.text = widget.phone!.toString();
      isMax = widget.isMax!;
    }
    startDate = widget.startDate;
    endDate = widget.endDate;
    super.initState();
  }

  Future<DateTime?> getDate(DateTime value) async {
    return await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2500, 12, 31),
      initialDate: value,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: primary,
              onPrimary: white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  Future<TimeOfDay?> getTime(
      BuildContext context, TimeOfDay initialTime) async {
    TimeOfDay? pickedTime = await showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return _CustomTimePickerDialog(initialTime: initialTime);
      },
    );

    if (pickedTime != null) {
      return TimeOfDay(hour: pickedTime.hour, minute: 0);
    }

    return null;
  }

  bool isStartDateValid(DateTime dateA, DateTime dateB) {
    if (dateA.isAfter(dateB) && !dateA.isAtSameMomentAs(dateB)) {
      return false;
    }
    return true;
  }

  bool isEndDateValid(DateTime dateA, DateTime dateB) {
    // print(dateA.toString() + "  " + dateB.toString());

    if (dateA.isBefore(dateB) && !dateA.isAtSameMomentAs(dateB)) {
      return false;
    }
    return true;
  }

  bool isPhoneNumberValid(String phoneNumber) {
    final regex = RegExp(r'^0\d{9,12}$');
    return regex.hasMatch(phoneNumber);
  }

  Future<void> insertReservationUser(
    String outlet,
    String event,
    String name,
    String phone,
    int humanCount,
    bool isMax,
    DateTime startDate,
    DateTime endDate,
  ) async {
    if (!mounted) return; // Check if the widget is still mounted
    showDialogLoading(context);
    try {
      var body = {
        "outlet": outlet,
        "isMax": isMax,
        "humanCount": humanCount,
        "nameEvent": event,
        "picName": name,
        "picNumber": phone,
        "startTime": startDate.toString(),
        "endTime": endDate.toString()
      };

      Map<String, dynamic> response = await BookingServices()
          .insertReservationUser(body)
          .timeout(Duration(seconds: apiWaitTime));

      final String bookingId = response["idReservation"];
      if (response["code"] == 200) {
        if (!mounted) return; // Check if the widget is still mounted
        context.pop();
        context.pop();
        Map<String, dynamic> body2 = {
          "title": "Booking dari $name",
          "description": "Untuk $event",
          "senderId": sp.getString("_id"),
          "receiverId": sp.getString("_id"),
          "type": "booking",
          "typeId": bookingId,
          "partner": "garum",
          "context": "booking"
        };
        int notificationResponse = await NotificationServices()
            .sendNotification(body2)
            .timeout(Duration(seconds: apiWaitTime));
        if (!mounted) return; // Check if the widget is still mounted
        if (notificationResponse == 200) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: "Sukses",
            text: "Reservasi dan notifikasi berhasil dikirim",
          );
        } else {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: "Reservasi Berhasil",
            text: "Reservasi berhasil, tapi gagal mengirim notifikasi",
          );
        }
      } else {
        if (!mounted) return; // Check if the widget is still mounted
        context.pop();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Gagal Membuat Reservasi",
          text: "Silahkan coba beberapa saat lagi",
        );
      }
    } on TimeoutException {
      if (!mounted) return; // Check if the widget is still mounted
      context.pop();
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Waktu Habis",
        text: "Gagal menambah reservasi, silahkan coba sekali lagi",
      );
    } catch (e) {
      if (!mounted) return; // Check if the widget is still mounted
      context.pop();
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Server Error",
        text: "Gagal menambah reservasi, silahkan coba sekali lagi. Error: $e",
      );
    }
  }

  Future<void> insertReservationGuest(
    String outlet,
    String event,
    String name,
    String phone,
    int humanCount,
    bool isMax,
    DateTime startDate,
    DateTime endDate,
  ) async {
    showDialogLoading(context);
    try {
      var body = {
        "outlet": outlet,
        "isMax": isMax,
        "humanCount": humanCount,
        "nameEvent": event,
        "picName": name,
        "picNumber": phone,
        "startTime": startDate.toString(),
        "endTime": endDate.toString()
      };

      Map<String, dynamic> response = await BookingServices()
          .insertReservationGuest(body)
          .timeout(Duration(seconds: apiWaitTime));

      if (response["code"] == 200) {
        context.pop();
        context.pop();
        Map<String, dynamic> body2 = {
          "title": "Booking dari ${name}",
          "description": "Untuk ${event}",
          "senderId": "Guest",
          "receiverId": "Admin",
          "type": "booking",
          "typeId": "guest",
          "partner": "garum",
          "context": "booking"
        };
        int notificationResponse = await NotificationServices()
            .sendNotification(body2)
            .timeout(Duration(seconds: apiWaitTime));
        if (notificationResponse == 200) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: "Sukses",
            text: "Berhasil membuat reservasi",
          );
        } else {
          context.pop();
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: "Sukses",
            text: "Berhasil membuat reservasi",
          );
        }
      } else {
        context.pop();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Gagal Membuat Reservasi",
          text: "Silahkan coba beberapa saat lagi",
        );
      }
    } on TimeoutException {
      context.pop();
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Waktu Habis",
        text: "Gagal menambah reservasi, silahkan coba sekali lagi",
      );
    } catch (e) {
      if (!mounted) return; // Check if the widget is still mounted
      context.pop();
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Server Error",
        text: "Gagal menambah reservasi, silahkan coba sekali lagi. Error: $e",
      );
    }
  }

  @override
  void dispose() {
    eventCont.dispose();
    nameCont.dispose();
    phoneCont.dispose();
    peopleCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isEdit != null ? "Edit Reservasi" : "Buat Reservasi"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama Acara", style: body1()),
            8.height,
            TextFieldNoTitle(
              minLines: 1,
              maxLines: 2,
              controller: eventCont,
              textInputType: TextInputType.text,
              hint: "Isi nama acara",
            ),
            16.height,
            Text("Nama Penanggung Jawab", style: body1()),
            8.height,
            TextFieldNoTitle(
              minLines: 1,
              maxLines: 12,
              controller: nameCont,
              textInputType: TextInputType.text,
              hint: "Isi nama penanggung jawab",
            ),
            16.height,
            Text("Nomor Telepon Penanggung Jawab", style: body1()),
            8.height,
            TextFieldNoTitle(
              controller: phoneCont,
              textInputType: TextInputType.number,
              hint: "Isi nomor telepon penanggung jawab",
            ),
            16.height,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total pengunjung", style: body1()),
                8.height,
                TextFieldNoTitle(
                  controller: peopleCont,
                  textInputType: TextInputType.number,
                  hint: "Isi jumlah total pengunjung",
                ),
              ],
            ),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Reservasi 1 tempat", style: body1()),
                Switch.adaptive(
                  activeColor: safeAlt,
                  value: isMax,
                  onChanged: (value) {
                    setState(() {
                      isMax = value;
                    });
                  },
                ),
              ],
            ),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Waktu Mulai",
                  style: body1(),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        DateTime? temp = await getDate(widget.startDate);
                        if (temp != null) {
                          setState(() {
                            startDate = DateTime(temp.year, temp.month,
                                temp.day, startDate.hour, startDate.minute);
                          });
                        }
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Ink(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(70, 170, 170, 170),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          formatDate2(startDate),
                          style: body1(
                            decoration: isStartDateValid(startDate, endDate)
                                ? null
                                : TextDecoration.lineThrough,
                            color: isStartDateValid(startDate, endDate)
                                ? Colors.black
                                : danger,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      child: Row(
                        children: [
                          8.width,
                          InkWell(
                            onTap: () async {
                              TimeOfDay? temp = await getTime(
                                  context, TimeOfDay.fromDateTime(startDate));
                              if (temp != null) {
                                setState(() {
                                  startDate = DateTime(
                                      widget.startDate.year,
                                      startDate.month,
                                      startDate.day,
                                      temp.hour,
                                      temp.minute);
                                });
                              }
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Ink(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(70, 170, 170, 170),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                formatDateTime(startDate),
                                style: body1(
                                  decoration:
                                      isStartDateValid(startDate, endDate)
                                          ? null
                                          : TextDecoration.lineThrough,
                                  color: isStartDateValid(startDate, endDate)
                                      ? Colors.black
                                      : danger,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Visibility(
              visible: !isStartDateValid(startDate, endDate),
              child: Column(
                children: [
                  4.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          "Waktu mulai tidak boleh lebih awal dari waktu selesai",
                          style: body3(
                            color: danger,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Waktu Selesai",
                  style: body1(),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        DateTime? temp = await getDate(endDate);
                        if (temp != null) {
                          setState(() {
                            endDate = DateTime(temp.year, temp.month, temp.day,
                                endDate.hour, endDate.minute);
                          });
                        }
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Ink(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(70, 170, 170, 170),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          formatDate2(endDate),
                          style: body1(
                            decoration: isEndDateValid(endDate, startDate)
                                ? null
                                : TextDecoration.lineThrough,
                            color: isEndDateValid(endDate, startDate)
                                ? Colors.black
                                : danger,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      child: Row(
                        children: [
                          8.width,
                          InkWell(
                            onTap: () async {
                              TimeOfDay? temp = await getTime(
                                  context, TimeOfDay.fromDateTime(endDate));
                              if (temp != null) {
                                setState(() {
                                  endDate = DateTime(
                                      endDate.year,
                                      endDate.month,
                                      endDate.day,
                                      temp.hour,
                                      temp.minute);
                                });
                              }
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Ink(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(70, 170, 170, 170),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                formatDateTime(endDate),
                                style: body1(
                                  decoration: isEndDateValid(endDate, startDate)
                                      ? null
                                      : TextDecoration.lineThrough,
                                  color: isEndDateValid(endDate, startDate)
                                      ? Colors.black
                                      : danger,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Visibility(
              visible: !isEndDateValid(endDate, startDate),
              child: Column(
                children: [
                  4.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          "Waktu selesai tidak boleh lebih awal dari waktu mulai",
                          style: body3(
                            color: danger,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            24.height,
            ButtonAccept(
              width: MediaQuery.of(context).size.width - 16,
              enable: eventCont.text.isNotEmpty &&
                  nameCont.text.isNotEmpty &&
                  phoneCont.text.isNotEmpty &&
                  peopleCont.text.isNotEmpty &&
                  isEndDateValid(endDate, startDate),
              onPressed: () async {
                bool result = await checkInternetConnectivity(context);

                if (result) {
                  if (!isPhoneNumberValid(phoneCont.text)) {
                    showToast("Nomor ponsel tidak valid");
                    return;
                  }
                  if (eventCont.text.isNotEmpty ||
                      nameCont.text.isNotEmpty ||
                      phoneCont.text.isNotEmpty ||
                      peopleCont.text.isNotEmpty) {
                    print(ref.watch(isLogin));
                    if (!ref.watch(isLogin)) {
                      print(ref.watch(isLogin));
                      insertReservationGuest(
                        "Cafe Pastor",
                        eventCont.text,
                        nameCont.text,
                        phoneCont.text,
                        peopleCont.text.toInt(),
                        isMax,
                        startDate,
                        endDate,
                      );
                    } else {
                      insertReservationUser(
                        "Cafe Pastor",
                        eventCont.text,
                        nameCont.text,
                        phoneCont.text,
                        peopleCont.text.toInt(),
                        isMax,
                        startDate,
                        endDate,
                      );
                    }
                  } else {
                    showToast("Pastikan semua sudah terisi");
                  }
                }
              },
              child: Text(
                "Simpan Acara",
                style: body1(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CustomTimePickerDialog extends StatefulWidget {
  final TimeOfDay initialTime;

  const _CustomTimePickerDialog({Key? key, required this.initialTime})
      : super(key: key);

  @override
  _CustomTimePickerDialogState createState() => _CustomTimePickerDialogState();
}

class _CustomTimePickerDialogState extends State<_CustomTimePickerDialog> {
  late int selectedHour;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initialTime.hour;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Select Time'),
      ),
      backgroundColor: primaryPastel,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<int>(
            value: selectedHour,
            items: List.generate(24, (index) {
              return DropdownMenuItem<int>(
                value: index,
                child: Text(index.toString().padLeft(2, '0')),
              );
            }),
            onChanged: (value) {
              setState(() {
                selectedHour = value!;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: custom(fontSize: 16, bold: FontWeight.normal),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(
              context,
              TimeOfDay(hour: selectedHour, minute: 0),
            );
          },
          child: Text(
            'OK',
            style: custom(fontSize: 16, bold: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
