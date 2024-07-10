class ModelProduct {
  String id;
  String name;
  String description;
  String category;
  int price;
  int stock;
  List<String> images;
  DateTime createdAt;
  String createdBy;
  String createdByName;

  ModelProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.stock,
    required this.images,
    required this.createdAt,
    required this.createdBy,
    required this.createdByName,
  });

  factory ModelProduct.fromJson(Map<String, dynamic> json) => ModelProduct(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        category: json["category"],
        price: json["price"],
        stock: json["stock"],
        images: List<String>.from(json["images"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"],
        createdByName: json["createdByName"],
      );
}