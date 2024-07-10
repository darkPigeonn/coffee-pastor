import '../const_db.dart';

class ModelCart {
  String id;
  List<String> productIds;
  List<int> quantities;
  List<int> subTotal;

  ModelCart({
    required this.id,
    required this.productIds,
    required this.quantities,
    required this.subTotal,
  });

  factory ModelCart.fromJson(Map<String, dynamic> json) {
    return ModelCart(
      id: json[Constant.cartId],
      productIds: List<String>.from(json[Constant.cartProductIds]),
      quantities: List<int>.from(json[Constant.cartQuantities]),
      subTotal: List<int>.from(json[Constant.cartSubTotal]),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[Constant.cartId] = this.id;
    data[Constant.cartProductIds] = this.productIds;
    data[Constant.cartQuantities] =
        this.quantities.map((value) => value.toString()).toList();
    data[Constant.cartSubTotal] =
        this.subTotal.map((value) => value.toString()).toList();
    return data;
  }
}

class Cart {
  final String cartId;
  final String productId;
  final String productName;
  final String productImages;
  int quantities;
  int subtotal;
  final String description;

  Cart({
    required this.cartId,
    required this.productId,
    required this.productName,
    required this.productImages,
    required this.quantities,
    required this.subtotal,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'cartId': cartId,
      'productId': productId,
      'productName': productName,
      'productImages': productImages,
      'quantities': quantities,
      'subtotal': subtotal,
      'description': description,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'cartId': cartId,
      'productId': productId,
      'productName': productName,
      'productImages': productImages,
      'quantities': quantities,
      'subtotal': subtotal,
      'description': description,
    };
  }
}
