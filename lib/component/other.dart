// ignore_for_file: unused_result, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/artikel/article_page.dart';
import 'package:flutter_coffee_application/Page/artikel/detail_data.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/ImageLoader.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/resource/provider/resources_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../style/color.dart';
import '../style/typhography.dart';

class DataArtikel extends ConsumerWidget {
  const DataArtikel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(featuredArtikelList).when(
          skipLoadingOnRefresh: false,
          data: (data) => Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Artikel", style: h3()),
                      InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArtikelPage(),
                              ),
                            );
                          },
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Text("Lihat Semua", style: body2(color: grey)))),
                    ],
                  ),
                ),
                8.height,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    thickness: 1,
                    color: grey2,
                    height: 0,
                  ),
                ),
                4.height,
                if (data.isEmpty)
                  Center(
                    child: Text(
                      "Tidak ada artikel",
                      style: body2(color: grey1),
                    ),
                  ),
                if (data.isNotEmpty)
                  HorizontalList(
                    padding: EdgeInsets.fromLTRB(16, 4, 16, 8),
                    itemCount: data.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => DetailData(
                          id: data[index].slug,
                          type: "artikel",
                        ).launch(context),
                        child: Container(
                          width: 240,
                          // margin: EdgeInsets.only(top: index == 0 ? 4 : 8),
                          // padding: const EdgeInsets.all(8),
                          decoration: shadowBox(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 160,
                                width: 240,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  child: LoadImage(
                                    imageLink: data[index].imageLink,
                                    boxFit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        data[index].title,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: body1(),
                                      ),
                                    ),
                                    16.width,
                                    Text(
                                      formatDate2(DateTime.parse(data[index].publishDate)),
                                      textAlign: TextAlign.end,
                                      style: body2(color: grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
          error: (error, stackTrace) {
            if (error.toString() == "204") {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: MediaQuery.of(context).size.height / 4,
                decoration: shadowBox(),
                child: Center(
                    child: Container(
                        decoration: shadowBox(),
                        child: Text(
                          "Belum ada artikel terkini saat ini",
                          style: body3(color: Colors.grey),
                        ))),
              );
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: MediaQuery.of(context).size.height / 4,
              decoration: shadowBox(),
              child: Center(
                  child: Container(
                decoration: shadowBox(),
                child: IconButton(
                  onPressed: () async {
                    bool result = await checkInternetConnectivity(context);
                    if (result) {
                      await ref.refresh(featuredArtikelList.future);
                    }
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: primary,
                  ),
                ),
              )),
            );
          },
          loading: () => Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: MediaQuery.of(context).size.height / 4,
            decoration: shadowBox(),
            child: Center(child: CircularProgressIndicator()),
          ),
        );
  }
}

BoxDecoration shadowBox({double borderRadius = 8, Color boxColor = Colors.white}) {
  return BoxDecoration(
    color: boxColor,
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: const [
      BoxShadow(
        blurRadius: 4,
        color: Color.fromARGB(64, 0, 0, 0),
      ),
    ],
  );
}

class ItemBody extends ConsumerWidget {
  const ItemBody({
    Key? key,
    required this.title,
    required this.desc,
    required this.author,
    required this.publishDate,
  }) : super(key: key);

  final String title;
  final String desc;
  final String author;
  final String publishDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: body1(),
                ),
              ),
              Text(
                publishDate,
                textAlign: TextAlign.end,
                style: body2(color: grey),
              ),
            ],
          ),
          6.height,
          Text(
            author == "" ? desc : author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: body2(color: grey),
          ),
        ],
      ),
    );
  }
}

class DetailParokiView extends ConsumerWidget {
  final String frontImage;
  final String logo;
  final String name;
  final String address;
  DetailParokiView({
    super.key,
    required this.frontImage,
    required this.logo,
    required this.name,
    required this.address,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1 / 3 + 44,
              ),
              LoadImage(
                imageLink: frontImage,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1 / 3,
                boxFit: BoxFit.cover,
              ),
              Positioned(
                left: 16,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  height: 88,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        offset: Offset(0, 0),
                        spreadRadius: 0.4,
                        color: Colors.black45,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LoadImage(imageLink: logo),
                  ),
                ),
              ),
            ],
          ),
          24.height,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: h1(),
                ),
                4.height,
                Text(
                  address,
                  style: body3(color: Colors.black87),
                ),
              ],
            ),
          ),
          Divider(thickness: 1, color: Colors.grey.shade300, height: 48),
        ],
      ),
    );
  }
}
