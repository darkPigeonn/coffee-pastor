// import 'package:flutter_coffee_application/resource/model/order_model.dart';
// import 'package:flutter_coffee_application/resource/services/api/order_services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final orderServices = Provider<OrderServices>((ref) => OrderServices());
// final todayOrderProvider = FutureProvider<List<ModelOrder>>((ref) async {
//   return ref.read(orderServices).getTodayOrder();
// });
// final allOrderProvider = FutureProvider<List<ModelOrder>>((ref) async {
//   return ref.read(orderServices).getAllOrder();
// });
// final userOrderProvider = FutureProvider<List<ModelOrder>>((ref) async{
//   return ref.read(orderServices).getUserOrder();
// });