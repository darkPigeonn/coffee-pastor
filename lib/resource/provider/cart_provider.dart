import 'package:flutter_coffee_application/sqlite_services/fetch_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cart_model.dart';

final cartProvider = FutureProvider<List<Cart>>((ref) async {
  final List<Cart> cartData = await fetchAllCarts();
  final cartState = ref.read(cartStateProvider);
  cartState.clear();
  if (cartState.isEmpty) {
    for (var cart in cartData) {
      cartState.add(cart);
    }
  }
  ref.watch(cartStateProvider.notifier).update((state) => cartState);
  return cartState;
});

final paymentProvider = FutureProvider<String>((ref) async {
  final data = ref.read(paymentMethod.notifier).state;
  return data;
});

final cartStateProvider = StateProvider<List<Cart>>((ref) => []);

final paymentMethod = StateProvider<String>((ref) => "cash");
