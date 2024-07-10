import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/Toast/show_toast.dart';
import 'package:flutter_coffee_application/resource/provider/data_provider.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LokasiPage extends ConsumerStatefulWidget {
  final String id;
  LokasiPage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LokasiPageState();
}

class _LokasiPageState extends ConsumerState<LokasiPage> {
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
                      "Lokasi",
                      style: h3(),
                    ),
                    4.height,
                    data.coordinates == null
                        ? Text(
                            "Lokasi belum tersedia",
                            style: body3(
                              color: Colors.grey,
                            ),
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(primary),
                            ),
                            onPressed: () async {
                              String googleUrl =
                                  'https://www.google.com/maps/search/?api=1&query=${data.coordinates!.latitude},${data.coordinates!.longitude}';
                              if (await canLaunchUrlString(googleUrl)) {
                                await launchUrlString(googleUrl);
                              } else {
                                showToast("Tidak bisa membuka map");
                              }
                            },
                            child: Text(
                              "Buka di Google Maps",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
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
