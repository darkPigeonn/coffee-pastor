import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/booking/add_edit_booking.dart';
import 'package:flutter_coffee_application/component/Button.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/resource/model/booking_model.dart';
import 'package:flutter_coffee_application/resource/provider/data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../style/color.dart';
import '../style/typhography.dart';

class MetodeModalBottom extends ConsumerStatefulWidget {
  const MetodeModalBottom({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MetodeModalBottomState();
}

class _MetodeModalBottomState extends ConsumerState<MetodeModalBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        color: white,
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                color: grey3,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Pilih Metode Pemesanan",
                  style: h1(color: primary),
                ),
              ),
            ),
            RadioButtonIcon(
              title: "Pick Up",
              subtitle: "Ambil ke store tanpa antri",
              groupValue: ref.watch(isDelivProvider),
              icon: Icons.shopping_bag,
              onChanged: (bool? value) {
                setState(() {
                  ref
                      .read(isDelivProvider.notifier)
                      .update((state) => value ?? false);
                });
                Navigator.pop(context);
              },
              value: false,
            ),
            RadioButtonIcon(
              title: "Delivery",
              subtitle: "Segera diantar ke lokasimu",
              groupValue: ref.watch(isDelivProvider),
              icon: Icons.motorcycle,
              onChanged: (bool? value) {
                setState(() {
                  ref
                      .read(isDelivProvider.notifier)
                      .update((state) => value ?? false);
                });
                Navigator.pop(context);
              },
              value: true,
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: primary,
              child: TextButton(
                style: TextButton.styleFrom(foregroundColor: white),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "PILIH",
                  style: h3(
                    color: white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeModalBottom extends ConsumerStatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final List<ModelBooking>? bookings;

  const TimeModalBottom({
    Key? key,
    this.startDate,
    this.endDate,
    this.bookings,
  }) : super(key: key);

  @override
  _TimeModalBottomState createState() => _TimeModalBottomState();
}

class _TimeModalBottomState extends ConsumerState<TimeModalBottom> {
  List<DateTime> startTimes = [];
  List<DateTime> endTimes = [];
  List<bool> isSlotAvailable = [];

  @override
  void initState() {
    super.initState();
    if (widget.startDate != null && widget.endDate != null) {
      generateTimeSlots(widget.startDate!, widget.endDate!);
    }
  }

  void generateTimeSlots(DateTime start, DateTime end) {
    DateTime current = start;

    while (current.isBefore(end)) {
      DateTime next = current.add(Duration(hours: 1));
      if (next.isAfter(end)) {
        next = end;
      }
      startTimes.add(current);
      endTimes.add(next);
      current = next;
    }

    // Initialize availability status for each slot
    for (int i = 0; i < startTimes.length; i++) {
      isSlotAvailable.add(true); // Assume all slots are initially available
    }

    // Check availability against bookings
    if (widget.bookings != null) {
      for (int i = 0; i < startTimes.length; i++) {
        DateTime slotStartTime = startTimes[i];
        DateTime slotEndTime = endTimes[i];

        for (var booking in widget.bookings!) {
          if (isSlotWithinBookingInterval(slotStartTime, slotEndTime, booking) &&
              booking.isMax) {
            isSlotAvailable[i] =
                false; // Mark slot as unavailable if it overlaps with a booking and isMax is true
            break; // No need to check further if already marked as unavailable
          }
        }
      }
    }
  }

  bool isSlotWithinBookingInterval(
      DateTime slotStartTime, DateTime slotEndTime, ModelBooking booking) {
    return (slotStartTime.isAfter(booking.startTime) &&
            slotStartTime.isBefore(booking.endTime)) ||
        (slotEndTime.isAfter(booking.startTime) &&
            slotEndTime.isBefore(booking.endTime));
  }

  String formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
              color: Colors.grey[300],
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Daftar Reservasi",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              formatDate2(widget.startDate!),
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: List.generate(startTimes.length, (index) {
                  String slot =
                      "${formatTime(startTimes[index])} - ${formatTime(endTimes[index])}";

                  return InkWell(
                    onTap: isSlotAvailable[index]
                        ? () {
                            AddOrEditBookingPage(
                              startDate: startTimes[index],
                              endDate: endTimes[index],
                            ).launch(context);
                          }
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            slot,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            isSlotAvailable[index] ? "Tersedia" : "Unavailable",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
