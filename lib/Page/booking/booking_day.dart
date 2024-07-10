import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/other.dart';
import 'package:flutter_coffee_application/resource/model/booking_model.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingListPage extends ConsumerStatefulWidget {
  final List<Map<String, dynamic>> bookings;
  final DateTime selectedDate;

  BookingListPage({required this.bookings, required this.selectedDate});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BookingListPageState();
}

class _BookingListPageState extends ConsumerState<BookingListPage> {
  @override
  Widget build(BuildContext context) {
    final filteredBookings = widget.bookings.where((booking) {
      final startTime = DateTime.parse(booking['startTime']);
      final endTime = DateTime.parse(booking['endTime']);
      return startTime.year == widget.selectedDate.year &&
          startTime.month == widget.selectedDate.month &&
          startTime.day == widget.selectedDate.day &&
          endTime.year == widget.selectedDate.year &&
          endTime.month == widget.selectedDate.month &&
          endTime.day == widget.selectedDate.day;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking List'),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: filteredBookings.length,
        itemBuilder: (context, index) {
          final booking = filteredBookings[index];
          return BookingListItem(booking: ModelBooking.fromJson(booking));
        },
      ),
    );
  }
}

class BookingListItem extends StatelessWidget {
  final ModelBooking booking;

  BookingListItem({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${booking.startTime!.hour.toString().padLeft(2, '0')}:00 - ${booking.endTime!.hour.toString().padLeft(2, '0')}:00',
                style: h3(),
              ),
              Text(
                '${booking.humanCount}/${booking.isMax ? 'Max' : 'Unlimited'}',
                style: body1(),
              ),
            ],
          ),
          12.height,
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(12),
            decoration: shadowBox(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event: ${booking.nameEvent}',
                  style: body1(),
                ),
                4.height,
                Text(
                  'PIC Name: ${booking.picName}',
                  style: body1(),
                ),
                4.height,
                Text(
                  'PIC Phone: ${booking.picNumber}',
                  style: body1(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
