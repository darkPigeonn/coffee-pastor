class ModelNotif {
    String id;
    DateTime timestamp;
    String senderId;
    String receiverId;
    String message;
    String categoryId;
    String categoryName;
    DateTime createdAt;
    String createdBy;
    String read;

    ModelNotif({
        required this.id,
        required this.timestamp,
        required this.senderId,
        required this.receiverId,
        required this.message,
        required this.categoryId,
        required this.categoryName,
        required this.createdAt,
        required this.createdBy,
        required this.read,
    });

    factory ModelNotif.fromJson(Map<String, dynamic> json) => ModelNotif(
        id: json["_id"] ?? "",
        timestamp: DateTime.parse(json["timestamp"]),
        senderId: json["senderId"] ?? "",
        receiverId: json["receiverId"] ?? "",
        message: json["message"] ?? "",
        categoryId: json["categoryId"] ?? "",
        categoryName: json["categoryName"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"] ?? "",
        read: json["read"] ?? "",
    );
}
