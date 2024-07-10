import 'package:sqflite/sqflite.dart';

import '../resource/const_db.dart';
import '../resource/model/cart_model.dart';

Future<void> insertCart(Cart cart) async {
  final db = await userCartDB;
  final batch = db.batch();

  batch.insert(
    'carts',
    cart.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  await batch.commit();
}
