import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/product/detail_product.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/Menu/category_button.dart';
import 'package:flutter_coffee_application/component/Menu/menu_body.dart';
import 'package:flutter_coffee_application/component/Menu/menu_top.dart';
import 'package:flutter_coffee_application/component/Cart/cart.dart';
import 'package:flutter_coffee_application/resource/provider/cart_provider.dart';
import 'package:flutter_coffee_application/resource/provider/category_provider.dart';
import 'package:flutter_coffee_application/resource/provider/data_provider.dart';
import 'package:flutter_coffee_application/resource/provider/product_provider.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ListProduk extends ConsumerStatefulWidget {
  const ListProduk({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListProdukState();
}

class _ListProdukState extends ConsumerState<ListProduk> {
  int _selectedIndex = 0;
  final itemKey = GlobalKey();
  final itemController = ItemScrollController();
  final itemListener = ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  void _handleCategoryTap(int index) {
    // Update the selected index
    setState(() {
      _selectedIndex = index;
    });
    // Scroll to the selected category index
    scrollToItem(index);
  }

  Future scrollToItem(index) async {
    itemController.scrollTo(
      index: index,
      duration: Duration(seconds: 1),
    );
  }

  bool changeTop = false;

  @override
  void initState() {
    super.initState();
    ref.refresh(cartProvider.future);
    itemListener.itemPositions.addListener(() {
      final indices =
          itemListener.itemPositions.value.map((item) => item.index).toList();
      setState(() {
        changeTop = indices.isNotEmpty ? indices[0] != 0 : false;
        _selectedIndex = indices.isNotEmpty ? indices[0] : 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(categoryProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: changeTop ? Size.fromHeight(100) : Size.fromHeight(50),
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.arrow_back_ios_sharp),
                  ),
                ),
                Expanded(
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: changeTop ? 1000 : 100),
                    opacity: changeTop ? 1 : 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        8.height,
                        Text(
                          ref.watch(isDelivProvider)
                              ? "Delivery dari Store"
                              : "Pick up di store",
                          style: h1()
                        ),
                        // Text(
                        //   "Cafe Pastor, Surabaya",
                        //   style: TextStyle(
                        //       fontSize: 18, fontWeight: FontWeight.bold),
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       "1,17 km",
                        //       maxLines: 2,
                        //       overflow: TextOverflow.ellipsis,
                        //     ),
                        //     SizedBox(
                        //       width: 5,
                        //     ),
                        //     CircleAvatar(
                        //       radius: 5,
                        //       backgroundColor: primary,
                        //     ),
                        //     SizedBox(
                        //       width: 5,
                        //     ),
                        //     Text(
                        //       "Terdekat",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.w500,
                        //           color: primaryLight),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
                8.width
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedCrossFade(
                    duration: const Duration(seconds: 1),
                    crossFadeState: changeTop
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstCurve: Curves.easeOut,
                    secondCurve: Curves.easeIn,
                    sizeCurve: Curves.easeOut,
                    firstChild: MenuTop(
                      type: ref.watch(isDelivProvider) ? "deliv" : "other",
                    ),
                    secondChild: Center(
                      child: SizedBox(),
                    ),
                  ),
                  12.height,
                  category.when(
                    data: (catData) {
                      if (catData.isEmpty) {
                        return Center(child: Text('No categories available'));
                      }
                      return SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: catData.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  right: 10, left: index == 0 ? 16 : 0),
                              child: ButtonCategory(
                                  tap: _selectedIndex == index,
                                  index: index,
                                  onPressed: () => _handleCategoryTap(index),
                                  title: catData[index].name),
                            );
                          },
                        ),
                      );
                    },
                    error: (error, e) => Text(e.toString()),
                    loading: () => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                  ),
                  Expanded(
                    child: category.when(
                      data: (data) {
                        if (data.isEmpty) {
                          return Center(child: Text('No products available'));
                        }
                        return ScrollablePositionedList.builder(
                          itemScrollController: itemController,
                          itemPositionsListener: itemListener,
                          scrollDirection: Axis.vertical,
                          itemCount: data.length,
                          itemBuilder: (context, i) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data[i].name,
                                        style: h5(),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Divider(),
                                ),
                                ref.watch(productProvider(data[i].name)).when(
                                      data: (_data) {
                                        if (_data.isEmpty) {
                                          return Center(
                                              child: Text(
                                                  'No products available'));
                                        }
                                        return ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: _data.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                MenuBody(
                                                  list: _data[index],
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailProduk(
                                                          list: _data[index],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                index == _data.length - 1
                                                    ? SizedBox(
                                                        height: 16,
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 16,
                                                        ),
                                                        child: Divider(),
                                                      ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      error: (error, e) {
                                        if (error.toString() == "204") {
                                          return SizedBox(
                                            child: Center(
                                              child: Container(
                                                  padding: EdgeInsets.all(32),
                                                  child: Text(
                                                    "Belum ada produk yang tersedia",
                                                    style: body2(
                                                      color: Colors.grey,
                                                    ),
                                                  )),
                                            ),
                                          );
                                        }
                                        return Center(
                                          child: Column(
                                            children: [
                                              Container(
                                                child: IconButton(
                                                  onPressed: () async {
                                                    bool result =
                                                        await checkInternetConnectivity(
                                                            context);
                                                    if (result) {
                                                      await ref.refresh(
                                                          categoryProvider
                                                              .future);
                                                    }
                                                  },
                                                  icon: Icon(
                                                      Icons.refresh_rounded,
                                                      color: primary),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      loading: () => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                              ],
                            );
                          },
                        );
                      },
                      error: (error, e) => Text(e.toString()),
                      loading: () => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CartBody()
          ],
        ),
      ),
    );
  }
}
