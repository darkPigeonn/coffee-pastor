import 'package:flutter_coffee_application/resource/const_db.dart';
import 'package:flutter_coffee_application/resource/model/cart_model.dart';

Future<void> updateCart(Cart cart) async {
  final db = await userCartDB;
  final batch = db.batch();

  for (var i = 0; i < cart.productId.length; i++) {
    batch.update(
      'carts',
      cart.toMap(), 
      where: 'cartId = ? AND productId = ?', 
      whereArgs: [cart.cartId, cart.productId[i]],
    );
  }

  await batch.commit(); 
}