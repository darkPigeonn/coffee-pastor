import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/component/other.dart';
import 'package:flutter_coffee_application/resource/model/booking_model.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

class Booking extends ConsumerStatefulWidget {
  final ModelBooking booking;
  const Booking({super.key, required this.booking});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookingState();
}

class _BookingState extends ConsumerState<Booking> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: shadowBox(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(widget.booking.nameEvent.capitalizeEachWord(), style: h3()),
              Container(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.booking.isApproved != null
                            ? widget.booking.isApproved!
                                ? safeAlt
                                : dangerDark
                            : warningDark),
                    child: Text(
                        widget.booking.isApproved != null
                            ? widget.booking.isApproved!
                                ? "DISETUJUI"
                                : "DITOLAK"
                            : "PENDING",
                        style: TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
          8.height,
          Text(
            "${formatDate(widget.booking.startTime)} - ${formatDateTime(widget.booking.endTime)}",
            style: body1(),
          ),
          8.height,
          Text(
            "${widget.booking.picName.capitalizeEachWord()} - ${widget.booking.picNumber}",
            style: body1(),
          ),
          8.height,
        ],
      ),
    );
  }
}
