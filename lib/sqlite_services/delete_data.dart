import 'package:flutter_coffee_application/resource/const_db.dart';

Future<void> clearTable(String tableName) async {
  // Get a reference to the database.
  final db = await userCartDB;

  // Delete all rows from the table.
  await db.delete(
    tableName,
  );
}

Future<void> deleteData(String id, String tableName) async {
  final db = await userCartDB;
  await db.delete(
    tableName,
    where: 'cartId = ?',
    whereArgs: [id],
  );
}
