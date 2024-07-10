class ModelPromo {
    String id;
    String title;
    String slug;
    String description;
    String image;
    String createdBy;
    String createdByName;
    DateTime createdAt;

    ModelPromo({
        required this.id,
        required this.title,
        required this.slug,
        required this.description,
        required this.image,
        required this.createdBy,
        required this.createdByName,
        required this.createdAt,
    });

    factory ModelPromo.fromJson(Map<String, dynamic> json) => ModelPromo(
        id: json["_id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        image: json["image"],
        createdBy: json["createdBy"],
        createdByName: json["createdByName"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "slug": slug,
        "description": description,
        "image": image,
        "createdBy": createdBy,
        "createdByName": createdByName,
        "createdAt": createdAt.toIso8601String(),
    };
}