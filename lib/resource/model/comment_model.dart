class ModelComment {
  ModelComment({
    required this.id,
    required this.name,
    required this.image,
    required this.comment,
  });

  String id;
  String name;
  String image;
  String comment;

  factory ModelComment.fromJson(Map<String, dynamic> json) {
    return ModelComment(
      id: json['_id'],
      name: json['profileName'],
      image: json['profileImage'],
      comment: json['comment'],
    );
  }
}