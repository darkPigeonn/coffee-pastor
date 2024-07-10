import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/promo/detail_promo.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/component/other.dart';
import 'package:flutter_coffee_application/resource/provider/promo_provider.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../style/typhography.dart';

class PromoListPage extends ConsumerStatefulWidget {
  const PromoListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PromoListPageState();
}

class _PromoListPageState extends ConsumerState<PromoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Promo"),
      ),
      body: Stack(
        children: [
          ref.watch(promoProvider).when(
                data: (data) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: index == 0 ? 4 : 0),
                        color: white,
                        child: Card(
                          color: white,
                          elevation: 2,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPromo(
                                    onPressedLikeIcon: () {
                                      List<bool> tempList = ref.read(likePromo);
                                      tempList[index] = !tempList[index];
                                      ref
                                          .watch(likePromo.notifier)
                                          .update((state) => tempList.toList());
                                      print(tempList);
                                    },
                                    promoId: data[index].id,
                                    index: index,
                                  ),
                                ),
                              );
                            },
                            child: ItemBody(
                              title: data[index].title,
                              desc: data[index].description,
                              author: "",
                              publishDate: formatDate2(data[index].createdAt),
                            ),
                          ),
                        ),
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
                              "Belum ada promo yang tersedia",
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
                                  await checkInternetConnectivity(context);
                              if (result) {
                                await ref.refresh(promoProvider.future);
                              }
                            },
                            icon: Icon(
                              Icons.refresh_rounded,
                              color: primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
        ],
      ),
    );
  }
}
