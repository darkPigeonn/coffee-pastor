// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/MidtransWebview.dart';
import 'package:flutter_coffee_application/Page/product/product_page.dart';
import 'package:flutter_coffee_application/component/Button.dart';
import 'package:flutter_coffee_application/component/Icon.dart';
import 'package:flutter_coffee_application/component/Cart/cart_menu.dart';
import 'package:flutter_coffee_application/component/Format/CurrencyFormat.dart';
import 'package:flutter_coffee_application/component/modal_bottom.dart';
import 'package:flutter_coffee_application/component/payment_method.dart';
import 'package:flutter_coffee_application/resource/provider/cart_provider.dart';
import 'package:flutter_coffee_application/resource/provider/data_provider.dart';
import 'package:flutter_coffee_application/resource/services/api/midtrans/midtrans_services.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sqflite/sqflite.dart';

import '../../resource/model/cart_model.dart';

class CheckOutPage extends ConsumerStatefulWidget {
  CheckOutPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends ConsumerState<CheckOutPage> {
  @override
  void initState() {
    super.initState();
    ref.refresh(paymentProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    final cartList = ref.watch(cartStateProvider);
    final payment = ref.watch(paymentMethod.notifier).state;
    int totalSubtotal = _getTotalSubtotal(cartList);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: h1(),
        ),
        centerTitle: true,
        leading: BackButton(
          color: primary,
        ),
        surfaceTintColor: white,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !ref.watch(isDelivProvider)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              color: primaryPastel.withOpacity(0.4),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: primaryPastel,
                                  radius: 24,
                                  child: Icon(
                                    Icons.shopping_bag,
                                    size: 32,
                                    color: primary,
                                  ),
                                ),
                                title: Text(
                                  "Pick Up",
                                  style: h3(),
                                ),
                                subtitle: Text(
                                  "Ambil ke store tanpa antri",
                                  style: body2(),
                                ),
                                trailing: ButtonOutlined(
                                  text: "Ubah",
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MetodeModalBottom();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return MetodeModalBottom();
                                },
                              );
                            },
                          ),
                          16.height,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Ambil pesananmu di",
                              style: h2(),
                            ),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: primaryPastel,
                              radius: 24,
                              child: Icon(
                                Icons.home,
                                size: 30,
                                color: primary,
                              ),
                            ),
                            title: Text(
                              "Wisata Bukit Mas",
                              style: custom(fontSize: 20, bold: FontWeight.normal),
                            ),
                            subtitle: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "3 km ",
                                  style: custom(
                                    fontSize: 18,
                                    color: primary,
                                  ),
                                ),
                                Text(
                                  "dari lokasimu",
                                  style: body1(color: grey1),
                                ),
                              ],
                            ),
                          ),
                          12.height,
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              color: secondaryPastel.withOpacity(0.4),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: secondaryPastel,
                                  radius: 30,
                                  child: Icon(
                                    Icons.shopping_bag,
                                    size: 36,
                                    color: secondary,
                                  ),
                                ),
                                title: Text(
                                  "Delivery",
                                  style: h3(),
                                ),
                                subtitle: Text(
                                  "Segera diantar ke lokasimu",
                                  style: body2(),
                                ),
                                trailing: ButtonOutlined(
                                  text: "Ubah",
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MetodeModalBottom();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return MetodeModalBottom();
                                },
                              );
                            },
                          ),
                          16.height,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Pesanan dikirim dari",
                              style: h2(),
                            ),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: secondaryPastel,
                              radius: 24,
                              child: Icon(
                                Icons.home,
                                size: 30,
                                color: secondary,
                              ),
                            ),
                            title: Text(
                              "Wisata Bukit Mas",
                              style: custom(fontSize: 20, bold: FontWeight.normal),
                            ),
                            subtitle: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "3 km ",
                                  style: custom(
                                    fontSize: 18,
                                    color: primary,
                                  ),
                                ),
                                Text(
                                  "dari lokasimu",
                                  style: body1(color: grey1),
                                ),
                              ],
                            ),
                          ),
                          12.height,
                        ],
                      ),
                Divider(
                  thickness: 10,
                  color: grey2,
                ),
                12.height,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Detail Pesanan",
                              style: h2(),
                            ),
                            ButtonOutlined(
                              text: "Tambah",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListProduk(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        20.height,
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cartList.length,
                          itemBuilder: (context, index) {
                            return CartMenu(
                              cartId: cartList[index].cartId,
                              productId: cartList[index].productId,
                              nama: cartList[index].productName,
                              image: cartList[index].productImages,
                              jumlah: cartList[index].quantities,
                              harga: cartList[index].subtotal,
                              deskripsi: cartList[index].description,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Diskon Belanja",
                    style: h2(),
                  ),
                ),
                ListTile(
                  leading: CircleIcon(
                    icon: Icons.file_copy,
                  ),
                  title: Text(
                    "Belanja hemat pakai voucher",
                    style: body1(
                      color: grey1,
                    ),
                  ),
                  trailing: Icon(Icons.navigate_next),
                ),
                Divider(
                  thickness: 10,
                  color: grey2,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Metode Pembelanjaan",
                    style: h2(),
                  ),
                ),
                PaymentMethod(),
                8.height,
                Divider(
                  thickness: 8,
                  color: grey2,
                ),
                12.height,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rincian Pembayaran",
                        style: h2(),
                      ),
                      16.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Harga",
                            style: body1(),
                          ),
                          Text(
                            FormatCurrency.convertToIdr(totalSubtotal, 0),
                            style: body1(),
                          )
                        ],
                      ),
                      16.height,
                      Dash(
                        direction: Axis.horizontal,
                        length: MediaQuery.of(context).size.width - 32,
                        dashLength: 10,
                        dashColor: grey,
                      ),
                      16.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Pembayaran",
                            style: h3(color: primary),
                          ),
                          Text(
                            FormatCurrency.convertToIdr(totalSubtotal, 0),
                            style: h3(color: primary),
                          )
                        ],
                      ),
                      16.height,
                      Divider(
                        indent: 10,
                        endIndent: 10,
                      )
                    ],
                  ),
                ),
                10.height,
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 26),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    color: primaryPastel.withOpacity(0.4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Kamu berpotensi mendapatkan ",
                        style: body1(),
                      ),
                      Text(
                        "${(totalSubtotal / 10000).floor()} poin",
                        style: h3(
                          color: primary,
                        ),
                      )
                    ],
                  ),
                ),
                12.height,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kebijakan Pembatalan",
                        style: h3(),
                      ),
                      10.height,
                      Text(
                        "Kamu tidak dapat melakukan pembatalan atau perubahan apapun pada pesanan setelah melakukan pembayaran",
                        style: body2(color: grey1),
                      ),
                    ],
                  ),
                ),
                100.height,
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              color: white,
              child: Button(
                height: 50,
                onPressed: () async {
                  final data = await MidtransServices().requestGopay();

                  if (data != null && data.actions != null) {
                    final deeplinkAction = data.actions.firstWhere(
                      (action) => action.name == 'deeplink-redirect',
                    );

                    if (deeplinkAction != null) {
                      print('Action found: ${deeplinkAction.url}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MidtransWebview(
                            url: deeplinkAction.url,
                          ),
                        ),
                      );
                    } else {
                      print('Action not found');
                    }
                  } else {
                    print('No actions found in the response');
                  }
                },
                child: Text(
                  "Lanjutkan",
                  style: body1(
                    color: white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _getTotalSubtotal(List<Cart> carts) {
    int totalAmount = 0;
    for (var cart in carts) {
      totalAmount += cart.subtotal * cart.quantities;
    }
    return totalAmount;
  }
}
