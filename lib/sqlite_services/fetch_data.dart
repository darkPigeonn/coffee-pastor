import 'package:flutter_coffee_application/resource/const_db.dart';

import '../resource/model/cart_model.dart';

Future<List<Cart>> fetchAllCarts() async {
  final db = await userCartDB;
  final List<Map<String, dynamic>> cartMaps = await db.query('carts');

  List<Cart> carts = [];

  for (final cartMap in cartMaps) {
    String productIds = cartMap['productId'] as String;
    String productName = cartMap['productName'] as String;
    String productImages = cartMap['productImages'] as String;
    int quantities = cartMap['quantities'] as int;
    int subtotals = cartMap['subtotal'] as int;
    String description = cartMap['description'] as String;

    carts.add(
      Cart(
        cartId: cartMap['cartId'],
        productId: productIds,
        productName: productName,
        productImages: productImages,
        quantities: quantities,
        subtotal: subtotals,
        description: description,
      ),
    );
  }

  return carts;
}

Future<Cart?> fetchCartById(String cartId) async {
  final db = await userCartDB;
  final List<Map<String, dynamic>> cartMaps = await db.query(
    'carts',
    where: 'cartId = ?',
    whereArgs: [cartId],
  );

  if (cartMaps.isEmpty) return null;

  final cartMap = cartMaps.first;

  String productIds = cartMap['productId'] as String;
  String productName = cartMap['productName'] as String;
  String productImages = cartMap['productImages'] as String;
  int quantities = cartMap['quantities'] as int;
  int subtotals = cartMap['subtotal'] as int;
  String description = cartMap['description'] as String;

  return Cart(
    cartId: cartMap['cartId'],
    productId: productIds,
    productName: productName,
    productImages: productImages,
    quantities: quantities,
    subtotal: subtotals,
    description: description,
  );
}
