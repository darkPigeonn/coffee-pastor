class ModelResources1 {
  String title = "",
      content = "",
      excerpt = "",
      publishDate = "",
      author = "",
      slug = "",
      imageLink = "",
      originalUrl = "";

  ModelResources1(
      {required this.title,
      required this.content,
      required this.excerpt,
      required this.publishDate,
      required this.author,
      required this.slug,
      required this.imageLink,
      required this.originalUrl});

  factory ModelResources1.fromJson(Map<String, dynamic> json) {
    String imageUrl = 'kosong';
    final imageLinkApi = json['imageLink'];

    if (imageLinkApi != null) {
      imageUrl = json['imageLink'];
    }

    String originalUrl = 'kosong';
    if (json['originalUrl'] != '' && json['originalUrl'] != null) {
      originalUrl = json['originalUrl'];
    }

    return new ModelResources1(
      title: json['title'] ?? "",
      content: json['content'] ?? "",
      excerpt: json['excerpt'] ?? "",
      publishDate: json['publishDate'] ?? "",
      author: json['author'] ?? "",
      slug: json['slug'] ?? "",
      imageLink: imageUrl,
      originalUrl: originalUrl,
    );
  }
}

// To parse this JSON data, do
//
//     final agendaModel = agendaModelFromJson(jsonString);

class AgendaModel {
  String id;
  String masterLiturgicalCalendarId;
  Weeks weeks;
  DateTime date;
  DateTime dateCall;
  String liturgicalMemorial;
  String noteLiturgicalMemorial;
  String liturgicalColor;
  EucharisticReading eucharisticReading;
  String noteLiturgicalEucharistic;
  String ofisiReading;
  String noteOfisi;
  String fakultatifMemorial;
  // List<String> eventsTarekat;
  // List<String> eventsKeuskupan;
  String? shortDescription;

  AgendaModel({
    required this.id,
    required this.masterLiturgicalCalendarId,
    required this.weeks,
    required this.date,
    required this.dateCall,
    required this.liturgicalMemorial,
    required this.noteLiturgicalMemorial,
    required this.liturgicalColor,
    required this.eucharisticReading,
    required this.noteLiturgicalEucharistic,
    required this.ofisiReading,
    required this.noteOfisi,
    required this.fakultatifMemorial,
    // required this.eventsTarekat,
    // required this.eventsKeuskupan,
    required this.shortDescription,
  });

  factory AgendaModel.fromJson(Map<String, dynamic> json) => AgendaModel(
        id: json["_id"],
        masterLiturgicalCalendarId: json["masterLiturgicalCalendarId"],
        weeks: Weeks.fromJson(json["weeks"]),
        date: json['date'] == null
            ? DateTime.now()
            : DateTime.parse(json["date"]),
        dateCall: json['dateCall'] == null
            ? DateTime.now()
            : DateTime.parse(json["dateCall"]),
        liturgicalMemorial: json["liturgicalMemorial"] ?? "",
        noteLiturgicalMemorial: json["noteLiturgicalMemorial"] ?? "",
        liturgicalColor: json["liturgicalColor"] ?? "",
        eucharisticReading:
            EucharisticReading.fromJson(json["eucharisticReading"]),
        noteLiturgicalEucharistic: json["noteLiturgicalEucharistic"] ?? "",
        ofisiReading: json["ofisiReading"] ?? "",
        noteOfisi: json["noteOfisi"] ?? "",
        fakultatifMemorial: json["fakultatifMemorial"] ?? "",
        // eventsTarekat: List<String>.from(json["eventsTarekat"].map((x) => x)),
        // eventsKeuskupan: List<String>.from(json["eventsKeuskupan"].map((x) => x)),
        shortDescription: json["shortDescription"] ?? "",
      );

  // Map<String, dynamic> toJson() => {
  //       "_id": id,
  //       "masterLiturgicalCalendarId": masterLiturgicalCalendarId,
  //       "weeks":  weeks.toJson(),
  //       "date": date.toIso8601String(),
  //       "dateCall":
  //           "${dateCall.year.toString().padLeft(4, '0')}-${dateCall.month.toString().padLeft(2, '0')}-${dateCall.day.toString().padLeft(2, '0')}",
  //       "liturgicalMemorial": liturgicalMemorial,
  //       "noteLiturgicalMemorial": noteLiturgicalMemorial,
  //       "liturgicalColor": liturgicalColor,
  //       "eucharisticReading": eucharisticReading.toJson(),
  //       "noteLiturgicalEucharistic": noteLiturgicalEucharistic,
  //       "ofisiReading": ofisiReading,
  //       "noteOfisi": noteOfisi,
  //       "fakultatifMemorial": fakultatifMemorial,
  //       // "eventsTarekat": List<dynamic>.from(eventsTarekat.map((x) => x)),
  //       // "eventsKeuskupan": List<dynamic>.from(eventsKeuskupan.map((x) => x)),
  //       "shortDescription": shortDescription,
  //     };
}

class EucharisticReading {
  String firstReading;
  ReadingDetail firstReadingDetail;
  String psalm;
  PsalmDetail psalmDetail;
  String secondReading;
  SecondReadingDetail secondReadingDetail;
  String gospel;
  ReadingDetail gospelReadingDetail;

  EucharisticReading({
    required this.firstReading,
    required this.firstReadingDetail,
    required this.psalm,
    required this.psalmDetail,
    required this.secondReading,
    required this.secondReadingDetail,
    required this.gospel,
    required this.gospelReadingDetail,
  });

  factory EucharisticReading.fromJson(Map<String, dynamic> json) =>
      EucharisticReading(
        firstReading: json["firstReading"] ?? "",
        firstReadingDetail: ReadingDetail.fromJson(json["firstReadingDetail"]),
        psalm: json["psalm"] ?? "",
        psalmDetail: PsalmDetail.fromJson(json["psalmDetail"]),
        secondReading: json["secondReading"] ?? "",
        secondReadingDetail:
            SecondReadingDetail.fromJson(json["secondReadingDetail"]),
        gospel: json["gospel"] ?? "",
        gospelReadingDetail:
            ReadingDetail.fromJson(json["gospelReadingDetail"]),
      );

  Map<String, dynamic> toJson() => {
        "firstReading": firstReading,
        "firstReadingDetail": firstReadingDetail.toJson(),
        "psalm": psalm,
        "psalmDetail": psalmDetail.toJson(),
        "secondReading": secondReading,
        "secondReadingDetail": secondReadingDetail.toJson(),
        "gospel": gospel,
        "gospelReadingDetail": gospelReadingDetail.toJson(),
      };
}

class ReadingDetail {
  String excerpt;
  String introduction;
  String details;

  ReadingDetail({
    required this.excerpt,
    required this.introduction,
    required this.details,
  });

  factory ReadingDetail.fromJson(Map<String, dynamic> json) => ReadingDetail(
        excerpt: json["excerpt"] ?? "",
        introduction: json["introduction"] ?? "",
        details: json["details"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "excerpt": excerpt,
        "introduction": introduction,
        "details": details,
      };
}

class PsalmDetail {
  String reffren;
  List<String> ayats;

  PsalmDetail({
    required this.reffren,
    required this.ayats,
  });

  factory PsalmDetail.fromJson(Map<String, dynamic> json) => PsalmDetail(
        reffren: json["reffren"] ?? "",
        ayats: json['ayats'] == null
            ? <String>[]
            : List<String>.from(json["ayats"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "reffren": reffren,
        "ayats": List<dynamic>.from(ayats.map((x) => x)),
      };
}

class SecondReadingDetail {
  String excerpt;
  String details;

  SecondReadingDetail({
    required this.excerpt,
    required this.details,
  });

  factory SecondReadingDetail.fromJson(Map<String, dynamic> json) =>
      SecondReadingDetail(
        excerpt: json["excerpt"] ?? "",
        details: json["details"] == null ? "" : json["details"],
      );

  Map<String, dynamic> toJson() => {
        "excerpt": excerpt,
        "details": details,
      };
}

class Weeks {
  String liturgical;

  Weeks({
    required this.liturgical,
  });

  factory Weeks.fromJson(Map<String, dynamic> json) => Weeks(
        liturgical: json["liturgical"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "liturgical": liturgical,
      };
}
