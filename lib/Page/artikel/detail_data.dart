// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/ImageLoader.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/component/other.dart';
import 'package:flutter_coffee_application/resource/provider/resources_provider.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_iframe/flutter_html_iframe.dart';
import 'package:flutter_share/flutter_share.dart';

class DetailData extends ConsumerStatefulWidget {
  final String id;
  final String type;
  const DetailData({
    super.key,
    required this.id,
    required this.type,
  });

  @override
  ConsumerState<DetailData> createState() => _DetailDataState();
}

class _DetailDataState extends ConsumerState<DetailData> {
  String title = "";
  String excerpt = "";
  String url = "";

  @override
  void initState() {
    if (widget.type == "artikel") {
      print("Masuk");
      ref.refresh(detailArtikelData(widget.id).future);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.type.capitalizeFirstLetter(),
            style: h1(),
          ),
          leading: BackButton(
            color: black,
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Visibility(
              visible: widget.type == "artikel",
              child: IconButton(
                onPressed: () async {
                  if (url != "") {
                    await FlutterShare.share(
                        title: title, text: excerpt, linkUrl: url);
                  }
                },
                icon: Icon(
                  Icons.share,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: ref.watch(detailArtikelData(widget.id)).when(
              skipLoadingOnRefresh: false,
              data: (data) {
                title = data!.title;
                excerpt = data.excerpt;
                url = data.originalUrl;
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  child: Column(
                    children: [
                      16.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Text(
                              data.title,
                              style: h4(),
                            ),
                            Divider(
                              color: Colors.grey,
                              height: 16,
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data.author,
                                  style: body2(color: grey),
                                ),
                                Text(
                                  formatDate2(DateTime.parse(data.publishDate)),
                                  style: body2(color: grey),
                                ),
                              ],
                            ),
                            // 16.height,
                          ],
                        ),
                      ),
                      16.height,
                      if (data.imageLink != "noImage")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadImage(
                              imageLink: data.imageLink,
                              // height: MediaQuery.of(context).size.width,
                              width: MediaQuery.of(context).size.width - 32,
                              boxFit: BoxFit.contain,
                            ),
                          ],
                        ),
                      if (data.content != "")
                        Html(
                          data: data.content,
                          style: {
                            "body": Style(
                              fontSize: FontSize(14),
                              fontWeight: FontWeight.normal,
                              padding: HtmlPaddings.symmetric(horizontal: 16),
                              margin: Margins.all(0),
                            ),
                            "link": Style(
                              fontSize: FontSize(14),
                              fontWeight: FontWeight.normal,
                              color: link,
                              padding: HtmlPaddings.symmetric(horizontal: 16),
                              margin: Margins.all(0),
                            ),
                          },
                          onLinkTap: (url, attributes, element) async {
                            launchUrl(Uri.parse(url!),
                                mode: LaunchMode.platformDefault);
                          },
                          extensions: [
                            IframeHtmlExtension(),
                          ],
                        ),
                    ],
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
                          bool result =
                              await checkInternetConnectivity(context);
                          if (result) {
                            await ref
                                .refresh(detailArtikelData(widget.id).future);
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
            ));
  }
}
