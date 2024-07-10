// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/ImageLoader.dart';
import 'package:flutter_coffee_application/component/Format/CurrencyFormat.dart';
import 'package:flutter_coffee_application/resource/model/cart_model.dart';
import 'package:flutter_coffee_application/resource/model/product_model.dart';
import 'package:flutter_coffee_application/resource/provider/cart_provider.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../sqlite_services/fetch_data.dart';
import '../../sqlite_services/insert_data.dart';
import '../../sqlite_services/update_data.dart';

class DetailProduk extends ConsumerStatefulWidget {
  final ModelProduct list;
  const DetailProduk({super.key, required this.list});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailProdukState();
}

class _DetailProdukState extends ConsumerState<DetailProduk> {
  @override
  void initState() {
    ref.refresh(cartProvider.future);
    super.initState();
  }

  int jumlahProduk = 1;
  int _currentSlide = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: white,
          toolbarHeight: MediaQuery.of(context).size.width,
          automaticallyImplyLeading: false,
          flexibleSpace: Stack(
            children: [
              Stack(
                children: [
                  widget.list.images.length > 2
                      ? CarouselSlider.builder(
                          itemCount: widget.list.images.length,
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.width,
                            aspectRatio: 1,
                            initialPage: _currentSlide,
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                            enableInfiniteScroll: true,
                            scrollDirection: Axis.horizontal,
                            pauseAutoPlayOnTouch: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentSlide = index;
                              });
                            },
                          ),
                          itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) {
                            return LoadImage(
                              imageLink: widget.list.images[0],
                              boxFit: BoxFit.fill,
                            );
                          },
                        )
                      : Container(
                        height: MediaQuery.of(context).size.width,
                        child: LoadImage(
                            imageLink: widget.list.images[0],
                            boxFit: BoxFit.fill,
                          ),
                      ),
                  widget.list.images.length > 2
                      ? Positioned(
                          left: 0,
                          right: 0,
                          bottom: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              widget.list.images.length,
                              (index) => Container(
                                width: 8,
                                height: 8,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color: index == _currentSlide
                                      ? grey1
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              Positioned(
                top: 20,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: white,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: primary,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.list.name,
                            style: h1(),
                          ),
                          12.height,
                          Text(
                            widget.list.description,
                            style: body1(color: grey1),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          12.height,
                          Text(
                            FormatCurrency.convertToIdr(widget.list.price, 0),
                            style: h1(),
                          ),
                          12.height
                        ],
                      ),
                    ),
                    Container(height: 4, color: grey2),
                    290.height,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    color: primaryPastel,
                    child: Row(
                      children: [
                        Text(
                          " Kamu berpotensi mendapatkan ",
                          style: body1(),
                        ),
                        Text(
                          "${(widget.list.price * jumlahProduk / 10000).floor()} poin",
                          style: custom(
                            fontSize: 16,
                            color: primary,
                            bold: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    color: white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 17,
                          backgroundColor: primary,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: white,
                            child: IconButton(
                              iconSize: 16,
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  jumlahProduk--;
                                  if (jumlahProduk == 0) {
                                    Navigator.pop(context);
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        Text(
                          jumlahProduk.toString(),
                          style: h1(),
                        ),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: primary,
                          child: IconButton(
                            iconSize: 16,
                            icon: Icon(
                              Icons.add,
                              color: white,
                            ),
                            onPressed: () {
                              setState(() {
                                jumlahProduk++;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              final cartId = widget.list.id;
                              final existingCart = await fetchCartById(cartId);
                              final cartState =
                                  ref.read(cartStateProvider.notifier);
                              if (existingCart != null) {
                                existingCart.quantities += jumlahProduk;
                                existingCart.subtotal = widget.list.price;
                                await updateCart(existingCart);
                                final index = cartState.state.indexWhere(
                                    (cart) =>
                                        cart.cartId == existingCart.cartId);
                                if (index != -1) {
                                  cartState.state[index] = existingCart;
                                  cartState.state = List.from(cartState.state);
                                }
                              } else {
                                Cart newCart = Cart(
                                  cartId: cartId,
                                  productId: widget.list.id,
                                  productName: widget.list.name,
                                  productImages:
                                      widget.list.images.isNotEmpty &&
                                              widget.list.images[0] != null
                                          ? widget.list.images[0]
                                          : "",
                                  quantities: jumlahProduk,
                                  subtotal: widget.list.price,
                                  description: widget.list.description,
                                );
                                await insertCart(newCart);
                                // Update cartState with the new product
                                cartState.state.add(newCart);
                                cartState.state = List.from(cartState.state);
                              }
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Tambah",
                                  style: h4(
                                    color: white,
                                  ),
                                ),
                                5.width,
                                CircleAvatar(
                                  radius: 3,
                                  backgroundColor: white,
                                ),
                                5.width,
                                Text(
                                  FormatCurrency.convertToIdr(
                                      widget.list.price * jumlahProduk, 0),
                                  style: h4(
                                    color: white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
