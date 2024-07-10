// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/Button.dart';
import 'package:flutter_coffee_application/component/ImageLoader.dart';
import 'package:flutter_coffee_application/component/Format/CurrencyFormat.dart';
import 'package:flutter_coffee_application/resource/provider/cart_provider.dart';
import 'package:flutter_coffee_application/sqlite_services/delete_data.dart';
import 'package:flutter_coffee_application/sqlite_services/fetch_data.dart';
import 'package:flutter_coffee_application/sqlite_services/update_data.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../style/color.dart';

class CartMenu extends ConsumerStatefulWidget {
  final String cartId;
  final String productId;
  final String nama;
  final String image;
  final String deskripsi;
  int jumlah;
  int harga;

  CartMenu({
    Key? key,
    required this.cartId,
    required this.productId,
    required this.nama,
    required this.image,
    required this.jumlah,
    required this.harga,
    required this.deskripsi,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartMenuState();
}

class _CartMenuState extends ConsumerState<CartMenu> {
  late int jumlah;
  late int subtotal;

  @override
  void initState() {
    super.initState();
    jumlah = widget.jumlah;
    subtotal = widget.harga * jumlah;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.nama, style: h3()),
                  Text(
                    widget.deskripsi,
                    style: body2(color: grey1),
                  ),
                ],
              ),
              Container(
                width: 90,
                height: 90,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LoadImage(imageLink: widget.image)
                ),
              ),
            ],
          ),
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                FormatCurrency.convertToIdr(subtotal, 0),
                style: h3(),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonCircle(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                      color: white,
                    ),
                    Dash(
                      direction: Axis.vertical,
                      length: 28,
                      dashLength: 8,
                      dashColor: grey,
                    ),
                    ButtonCircle(
                      icon: Icon(Icons.remove),
                      onPressed: () async {
                        final existingCart = await fetchCartById(widget.cartId);
                        final cartState = ref.read(cartStateProvider.notifier);
                        setState(() {
                          jumlah--;
                          widget.jumlah = jumlah;
                          subtotal = widget.harga * jumlah;
                        });
                        if (jumlah <= 0) {
                          await deleteData(widget.cartId, "carts");
                        }
                        existingCart!.quantities = jumlah;
                        await updateCart(existingCart);
                        final index = cartState.state.indexWhere(
                            (cart) => cart.cartId == existingCart.cartId);
                        if (index != -1) {
                          cartState.state[index] = existingCart;
                          cartState.state = List.from(cartState.state);
                        }
                      },
                      color: white,
                    ),
                    Text(
                      widget.jumlah.toString(),
                      style: h2(),
                    ),
                    ButtonCircle(
                      icon: Icon(
                        Icons.add,
                        color: white,
                      ),
                      onPressed: () async {
                        final existingCart = await fetchCartById(widget.cartId);
                        final cartState = ref.read(cartStateProvider.notifier);
                        setState(() {
                          jumlah++;
                          widget.jumlah = jumlah;
                          subtotal = widget.harga * jumlah;
                        });
                        existingCart!.quantities = jumlah;
                        await updateCart(existingCart);
                        final index = cartState.state.indexWhere(
                            (cart) => cart.cartId == existingCart.cartId);
                        if (index != -1) {
                          cartState.state[index] = existingCart;
                          cartState.state = List.from(cartState.state);
                        }
                      },
                      color: primary,
                    ),
                  ],
                ),
              )
            ],
          ),
          24.height,
          Divider(),
        ],
      ),
    );
  }
}
