
import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/resource/provider/data_provider.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

class DeskripsiPage extends ConsumerStatefulWidget {
  final String id;
  const DeskripsiPage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeskripsiPageState();
}

class _DeskripsiPageState extends ConsumerState<DeskripsiPage> {
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
                      "Tentang Gereja ${data.churchName}",
                      style: h3(),
                    ),
                    4.height,
                    data.description == null || data.description == ""
                        ? Text(
                            "Belum ada deskripsi",
                            style: body3(
                              color: Colors.grey,
                            ),
                          )
                        : Html(
                            data: data.description,
                            shrinkWrap: true,
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
