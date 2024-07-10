class ModelCategory {
  ModelCategory({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory ModelCategory.fromJson(Map<String, dynamic> json) {
    return ModelCategory(
      id: json['_id'],
      name: json['name'],
    );
  }
}
