import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/booking/add_edit_booking.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/component/Toast/show_toast.dart';
import 'package:flutter_coffee_application/component/modal_bottom.dart';
import 'package:flutter_coffee_application/component/other.dart';
import 'package:flutter_coffee_application/resource/provider/booking_provider.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../resource/const_resource.dart';

class BookingPage extends ConsumerStatefulWidget {
  const BookingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookingPageState();
}

class _BookingPageState extends ConsumerState<BookingPage> {
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    0,
    0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reservasi"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              AddOrEditBookingPage(
                startDate: selectedDate,
                endDate: selectedDate.add(Duration(hours: 1)),
              ).launch(context);
            },
            icon: Icon(
              Icons.add_box_outlined,
              color: white,
              size: 32,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            // decoration: BoxDecoration(border: Border.all(color: grey)),
            decoration: shadowBox(),
            child: SfCalendar(
              // dataSource: GoogleDataSource(Events: snapshot.data),
              view: CalendarView.month,
              todayHighlightColor: primary,
              monthViewSettings: MonthViewSettings(
                showAgenda: false,
                agendaViewHeight: MediaQuery.of(context).size.height / 3 - 32,
              ),
              selectionDecoration: BoxDecoration(
                border: Border.all(color: primary, width: 2),
              ),
              onSelectionChanged: (calendarSelectionDetails) {
                if (calendarSelectionDetails.date != null) {
                  setState(() {
                    selectedDate = DateTime(
                      calendarSelectionDetails.date!.year,
                      calendarSelectionDetails.date!.month,
                      calendarSelectionDetails.date!.day,
                      8,
                      0,
                      0,
                    );
                  });
                  if (selectedDate.isAfter(today) || selectedDate.isToday) {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Consumer(
                          builder: (context, ref, child) {
                            return ref
                                .watch(approveBookingProvider(
                                    formatDate3(selectedDate)))
                                .when(
                                  data: (data) {
                                    print(data);
                                    return TimeModalBottom(
                                      startDate: selectedDate,
                                      endDate: DateTime(
                                        calendarSelectionDetails.date!.year,
                                        calendarSelectionDetails.date!.month,
                                        calendarSelectionDetails.date!.day,
                                        22,
                                        0,
                                        0,
                                      ),
                                      bookings:
                                          data,
                                    );
                                  },
                                  error: (error, s) {
                                    return TimeModalBottom(
                                      startDate: selectedDate,
                                      endDate: DateTime(
                                        calendarSelectionDetails.date!.year,
                                        calendarSelectionDetails.date!.month,
                                        calendarSelectionDetails.date!.day,
                                        22,
                                        0,
                                        0,
                                      ),
                                    );
                                  },
                                  loading: () => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                          },
                        );
                      },
                    );
                  } else {
                    showToast("Tidak bisa memilih hari karena sudah lewat");
                  }
                }
              },
              onTap: (calendarTapDetails) {
                // print(calendarTapDetails.targetElement);
                if (calendarTapDetails.targetElement.toString() ==
                    "CalendarElement.appointment") {}
              },
              appointmentTimeTextFormat: 'HH:mm',
              headerDateFormat: 'MMMM yyyy',
              timeZone: "UTC",
              showDatePickerButton: true,
              firstDayOfWeek: 1,
              appointmentTextStyle: h1(),
            ),
          ),
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> bookings = [
  {
    "_id": "1",
    "store": "Store ABC",
    "isMax": true,
    "humanCount": 20,
    "Event": "Event XYZ",
    "PICName": "John Doe",
    "PICPhoneNumber": "08123456789",
    "duration": 2,
    "startTime": "2024-06-06T09:00:00.000Z",
    "endTime": "2024-06-06T11:00:00.000Z",
    "isApproved": true,
    "color": "FF5151" // Color in RGB format
  },
  {
    "_id": "2",
    "store": "Store DEF",
    "isMax": false,
    "humanCount": 15,
    "Event": "Event ABC",
    "PICName": "Jane Smith",
    "PICPhoneNumber": "08123456788",
    "duration": 1,
    "startTime": "2024-06-07T10:00:00.000Z",
    "endTime": "2024-06-07T11:00:00.000Z",
    "isApproved": true,
    "color": "FF5151" // Color in RGB format
  },
  {
    "_id": "3",
    "store": "Store GHI",
    "isMax": true,
    "humanCount": 30,
    "Event": "Event PQR",
    "PICName": "Alice Johnson",
    "PICPhoneNumber": "08123456787",
    "duration": 3,
    "startTime": "2024-06-08T13:00:00.000Z",
    "endTime": "2024-06-08T16:00:00.000Z",
    "isApproved": false,
    "color": "FF5151" // Color in RGB format
  },
  {
    "_id": "4",
    "store": "Store ABC",
    "isMax": true,
    "humanCount": 20,
    "Event": "Event XYZAA",
    "PICName": "John Doe A",
    "PICPhoneNumber": "08123456789",
    "duration": 2,
    "startTime": "2024-06-06T09:00:00.000Z",
    "endTime": "2024-06-06T11:00:00.000Z",
    "isApproved": true,
    "color": "FF5151"
  },
];
