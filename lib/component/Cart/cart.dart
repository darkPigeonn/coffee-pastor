// ignore_for_file: unused_result, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/order/checkout.dart';
import 'package:flutter_coffee_application/component/Format/CurrencyFormat.dart';
import 'package:flutter_coffee_application/resource/provider/cart_provider.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../resource/model/cart_model.dart';
import '../../style/typhography.dart';

class CartBody extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartBodyState();
}

class _CartBodyState extends ConsumerState<CartBody> {
  @override
  void initState() {
    super.initState();
    ref.refresh(cartProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    final cartList = ref.watch(cartStateProvider);
    int totalQuantity = _getTotalQuantity(cartList);
    int totalSubtotal = _getTotalSubtotal(cartList);

    return Visibility(
      visible: totalQuantity > 0,
      child: Positioned(
        bottom: 0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          color: Colors.white,
          padding: EdgeInsets.all(12),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckOutPage(),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: primary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Cek Keranjang ($totalQuantity produk)",
                    style: body1(color: Colors.white),
                  ),
                  Text(
                    "Rp ${FormatCurrency.convertToIdr(totalSubtotal, 0)}",
                    style: h3(color: Colors.white),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 14,
                    child: Icon(
                      Icons.navigate_next,
                      color: primary,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  int _getTotalQuantity(List<Cart> carts) {
    int totalQuantity = 0;
    for (var cart in carts) {
      totalQuantity += cart.quantities;
    }
    return totalQuantity;
  }

  int _getTotalSubtotal(List<Cart> carts) {
    int totalAmount = 0;
    for (var cart in carts) {
      totalAmount += cart.subtotal * cart.quantities;
    }
    return totalAmount;
  }
}
