// ignore_for_file: unused_result, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/artikel/detail_data.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/component/other.dart';
import 'package:flutter_coffee_application/resource/provider/resources_provider.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

class ArtikelPage extends ConsumerStatefulWidget {
  const ArtikelPage({super.key});

  @override
  ConsumerState<ArtikelPage> createState() => _ArtikelPageState();
}

class _ArtikelPageState extends ConsumerState<ArtikelPage> {
  @override
  void initState() {
    ref.refresh(artikelList.future);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Artikel Terkini",
          style: h1(),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
      ),
      body: ref.watch(artikelList).when(
            skipLoadingOnRefresh: false,
            data: (data) {
              return RefreshIndicator(
                onRefresh: () async => await ref.refresh(artikelList.future),
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  padding: EdgeInsets.all(16),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => DetailData(
                        id: data[index].slug,
                        type: "artikel",
                      ).launch(context),
                      child: Container(
                        margin: EdgeInsets.only(top: index != 0 ? 8 : 0),
                        padding: EdgeInsets.all(8),
                        decoration: shadowBox(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.all(0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          data[index].title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: body1(),
                                        ),
                                      ),
                                      Text(
                                        formatDate2(DateTime.parse(data[index].publishDate)),
                                        textAlign: TextAlign.end,
                                        style: body2(color: grey),
                                      ),
                                    ],
                                  ),
                                  6.height,
                                  Text(
                                    data[index].author,
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
              );
            },
            error: (error, stackTrace) {
              return Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Tidak dapat menemukan data artikel",
                    style: body2(color: grey),
                  ),
                  32.height,
                  Container(
                    decoration: shadowBox(),
                    child: IconButton(
                      onPressed: () async {
                        bool result = await checkInternetConnectivity(context);
                        if (result) {
                          await ref.refresh(artikelList.future);
                        }
                      },
                      icon: Icon(
                        Icons.refresh,
                        color: primary,
                      ),
                    ),
                  ),
                ],
              ));
            },
            loading: () => Center(child: CircularProgressIndicator()),
          ),
    );
  }
}