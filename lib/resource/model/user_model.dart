import 'package:flutter_coffee_application/component/Format/DateFormat.dart';

class ModelUser {
  String id;
  String fullName;
  String email;
  String gender;
  String phoneNumber;
  String image;
  String dob;
  DateTime createdAt;
  int point;
  String partnerCode;
  String address;
  List<ListPoint> listPoints;

  ModelUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.gender,
    required this.phoneNumber,
    required this.image,
    required this.dob,
    required this.createdAt,
    required this.point,
    required this.partnerCode,
    required this.address,
    required this.listPoints,
  });

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
        id: json["_id"] ?? "",
        fullName: json["fullName"] ?? "",
        email: json["email"]  ?? "",
        gender: json["gender"]  ?? "",
        phoneNumber: json["phoneNumber"]  ?? "",
        image: json["image"],
        dob: json["dob"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        point: json["point"],
        partnerCode: json["partnerCode"] ?? "",
        address: json["address"] ?? "",
        listPoints: List<ListPoint>.from(
            json["listPoints"].map((x) => ListPoint.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "email": email,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "image": image,
        "dob": dob,
        "createdAt": createdAt.toIso8601String(),
        "point": point,
        "partnerCode": partnerCode,
        "address": address,
        "listPoints": List<dynamic>.from(listPoints.map((x) => x.toJson())),
      };
}

class ListPoint {
  String id;
  String purchaseId;
  String outlet;
  int point;
  String userId;
  DateTime createdAt;
  String createdBy;

  ListPoint({
    required this.id,
    required this.purchaseId,
    required this.outlet,
    required this.point,
    required this.userId,
    required this.createdAt,
    required this.createdBy,
  });

  factory ListPoint.fromJson(Map<String, dynamic> json) => ListPoint(
        id: json["_id"],
        purchaseId: json["purchaseId"],
        outlet: json["outlet"],
        point: json["point"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]).add(Duration(hours: 7)),
        createdBy: json["createdBy"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "purchaseId": purchaseId,
        "outlet": outlet,
        "point": point,
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "createdBy": createdBy,
      };
}
