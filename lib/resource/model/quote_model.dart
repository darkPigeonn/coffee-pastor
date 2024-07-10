class ModelQuote {
    String id;
    String title;
    String slug;
    String description;
    List<String> images;
    String author;
    String createdBy;
    DateTime createdAt;

    ModelQuote({
        required this.id,
        required this.title,
        required this.slug,
        required this.description,
        required this.images,
        required this.author,
        required this.createdBy,
        required this.createdAt,
    });

    factory ModelQuote.fromJson(Map<String, dynamic> json) => ModelQuote(
        id: json["_id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        author: json["author"],
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "slug": slug,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x)),
        "author": author,
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
    };
}