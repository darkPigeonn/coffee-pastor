import 'dart:ui';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class ModelBooking {
  String id;
  String outlet;
  bool isMax;
  int humanCount;
  String nameEvent;
  String picName;
  String picNumber;
  DateTime startTime;
  DateTime endTime;
  DateTime createdAt;
  String createdBy;
  String createdByName;
  bool? isApproved;
  DateTime? publishedAt;
  String publishedBy;
  String publishedByName;

  ModelBooking({
    required this.id,
    required this.outlet,
    required this.isMax,
    required this.humanCount,
    required this.nameEvent,
    required this.picName,
    required this.picNumber,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.createdBy,
    required this.createdByName,
    required this.isApproved,
    this.publishedAt,
    required this.publishedBy,
    required this.publishedByName,
  });

  factory ModelBooking.fromJson(Map<String, dynamic> json) {
    return ModelBooking(
      id: json["_id"] as String,
      outlet: json["outlet"] as String,
      isMax: json["isMax"] as bool,
      humanCount: json["humanCount"] as int,
      nameEvent: json["nameEvent"] as String,
      picName: json["picName"] as String,
      picNumber: json["picNumber"] as String,
      startTime: DateTime.parse(json["startTime"] as String),
      endTime: DateTime.parse(json["endTime"] as String),
      createdAt: DateTime.parse(json["createdAt"] as String),
      createdBy: json["createdBy"] as String,
      createdByName: json["createdByName"] as String,
      isApproved: json["isApproved"],
      publishedAt: json["publishedAt"] != null ? DateTime.parse(json["publishedAt"] as String) : null,
      publishedBy: json["publishedBy"] as String? ?? "",
      publishedByName: json["publishedByName"] as String? ?? "",
    );
  }
}
var body = [
  {
    "_id": "idCalendar",
    "Event": "Event 123",
    "PICName": "nama 123",
    "startTime": "2024-06-04T00:00:00.000Z",
    "endTime": "2024-06-04T00:00:00.000Z",
    "color": "EFEEEF"
  }
];

// class MeetingDataSource extends CalendarDataSource {
//   MeetingDataSource(List<BookingModel> source) {
//     appointments = source;
//   }

//   @override
//   String getId(int index) {
//     return appointments![index].id;
//   }

//   @override
//   String getSubject(int index) {
//     return appointments![index].event;
//   }

//   @override
//   String getNotes(int index) {
//     return appointments![index].PICName;
//   }

//   @override
//   DateTime getStartTime(int index) {
//     return appointments![index].startTime;
//   }

//   @override
//   DateTime getEndTime(int index) {
//     return appointments![index].endTime;
//   }

//   @override
//   Color getColor(int index) {
//     return appointments![index].color;
//   }
// }

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}


class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}


class TimeSlot {
  final DateTime startTime;
  final DateTime endTime;
  final int currentPeople;
  final int maxPeople;

  TimeSlot({
    required this.startTime,
    required this.endTime,
    required this.currentPeople,
    required this.maxPeople,
  });
}
