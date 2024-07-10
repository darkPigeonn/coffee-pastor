import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/other.dart';
import 'package:flutter_coffee_application/resource/provider/data_provider.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class KontakPage extends ConsumerStatefulWidget {
  final String id;
  KontakPage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KontakPageState();
}

class _KontakPageState extends ConsumerState<KontakPage> {
  Widget socialLinkIcon(String type) {
    if (type == "Ig") {
      return Container(
          padding: EdgeInsets.all(6),
          child: Image.asset(
            'assets/logo/Instagram.png',
            height: 28,
            width: 28,
          ));
    } else if (type == "Fb") {
      return Container(
        padding: EdgeInsets.all(6),
        child: FaIcon(
          FontAwesomeIcons.facebook,
          color: Color.fromARGB(255, 66, 103, 178),
          size: 28,
        ),
      );
    } else if (type == "Youtube") {
      return Container(
        padding: EdgeInsets.all(6),
        child: FaIcon(
          FontAwesomeIcons.youtube,
          color: Color.fromARGB(255, 255, 0, 0),
          size: 28,
        ),
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.refresh(detailParokiData(widget.id)).when(
          data: (data) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kontak Gereja",
                      style: h3(),
                    ),
                    data.secretariatTelephone == null || data.secretariatTelephone == ""
                        ? Column(
                            children: [
                              8.height,
                              Text(
                                "Kontak sekretariat gereja belum tersedia",
                                style: body3(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        : Visibility(
                            visible: data.secretariatTelephone != null || data.secretariatTelephone != "",
                            child: Column(
                              children: [
                                16.height,
                                Ink(
                                  padding: EdgeInsets.all(8),
                                  decoration: shadowBox(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          data.secretariatTelephone.toString(),
                                          style: body1(),
                                        ),
                                      ),
                                      16.width,
                                      InkWell(
                                        onTap: () {
                                          launchUrl(Uri.parse("tel://${data.secretariatTelephone}"));
                                        },
                                        radius: 52,
                                        borderRadius: BorderRadius.circular(24),
                                        child: Container(
                                          padding: EdgeInsets.all(6),
                                          child: FaIcon(
                                            FontAwesomeIcons.phoneFlip,
                                            color: Color.fromARGB(255, 66, 103, 178),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                    data.whatsapp == null || data.whatsapp == ""
                        ? Column(
                            children: [
                              16.height,
                              Text(
                                "Kontak whatsapp gereja belum tersedia",
                                style: body3(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        : Visibility(
                            visible: data.whatsapp != null || data.whatsapp != "",
                            child: Column(
                              children: [
                                16.height,
                                Ink(
                                  padding: EdgeInsets.all(8),
                                  decoration: shadowBox(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          data.whatsapp.toString(),
                                          style: body1(),
                                        ),
                                      ),
                                      16.width,
                                      InkWell(
                                        onTap: () async {
                                          var contact = data.whatsapp;
                                          var androidUrl = "https://wa.me/$contact?text=Halo, saya mau bertanya";
                                          var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Halo, saya mau bertanya')}";

                                          if (Platform.isIOS) {
                                            await launchUrl(Uri.parse(iosUrl));
                                          } else {
                                            await launchUrl(Uri.parse(androidUrl));
                                          }
                                        },
                                        radius: 52,
                                        borderRadius: BorderRadius.circular(24),
                                        child: Container(
                                          padding: EdgeInsets.all(6),
                                          child: FaIcon(
                                            FontAwesomeIcons.whatsapp,
                                            color: Color.fromARGB(255, 37, 211, 102),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                    data.email == null || data.email == ""
                        ? Column(
                            children: [
                              16.height,
                              Text(
                                "Kontak email gereja belum tersedia",
                                style: body3(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        : Visibility(
                            visible: data.email != null || data.email != "",
                            child: Column(
                              children: [
                                16.height,
                                Ink(
                                  padding: EdgeInsets.all(8),
                                  decoration: shadowBox(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          data.email.toString(),
                                          style: body1(),
                                        ),
                                      ),
                                      16.width,
                                      InkWell(
                                        onTap: () {
                                          launchUrl(
                                              Uri.parse("mailto:${data.email!}?subject=Pertanyaan&body=Halo, saya mau bertanya"));
                                        },
                                        radius: 52,
                                        borderRadius: BorderRadius.circular(24),
                                        child: Container(
                                          padding: EdgeInsets.all(6),
                                          child: Icon(
                                            Icons.mail,
                                            color: primary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Visibility(
                      visible: data.socialLinks!.isNotEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          16.height,
                          Divider(thickness: 1, color: Colors.grey, height: 0),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Sosial media", style: body1()),
                                Wrap(
                                  spacing: 16,
                                  children: [
                                    for (int i = 0; i < data.socialLinks!.length; i++)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(4),
                                          onTap: () {
                                            launchUrl(Uri.parse("${data.socialLinks![i].url}"));
                                          },
                                          child: socialLinkIcon(data.socialLinks![i].type),
                                        ),
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          error: (error, stackTrace) {
            print(error);
            print(stackTrace);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Tidak dapat menemukan data",
                    style: body3(color: grey),
                  ),
                  16.height,
                  IconButton(
                    onPressed: () async {
                      final res = await checkInternetConnectivity(context);
                      if (res) {
                        await ref.refresh(detailParokiData(widget.id).future);
                      }
                    },
                    icon: Icon(Icons.refresh),
                  )
                ],
              ),
            );
          },
          loading: () => CircularProgressIndicator(),
        );
  }
}
