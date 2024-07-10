class ModelTestimoni {
    String id;
    String isiTestimoni;
    double rating;
    String image;
    DateTime createdAt;
    String createdBy;
    String createdByName;
    bool isPublish;

    ModelTestimoni({
        required this.id,
        required this.isiTestimoni,
        required this.rating,
        required this.image,
        required this.createdAt,
        required this.createdBy,
        required this.createdByName,
        required this.isPublish,
    });

    factory ModelTestimoni.fromJson(Map<String, dynamic> json) => ModelTestimoni(
        id: json["_id"],
        isiTestimoni: json["isiTestimoni"],
        rating: double.parse(json["rating"].toString()),
        image: json["image"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"],
        createdByName: json["createdByName"],
        isPublish: json["isPublish"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "isiTestimoni": isiTestimoni,
        "rating": rating,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "createdBy": createdBy,
        "createdByName": createdByName,
        "isPublish": isPublish,
    };
}
