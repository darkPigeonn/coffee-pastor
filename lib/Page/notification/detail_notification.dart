import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/resource/model/notif_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';


import '../../style/typhography.dart';

class DetailNotif extends ConsumerWidget {
  final ModelNotif detailNotif;
  const DetailNotif({
    Key? key,
    required this.detailNotif,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              detailNotif.categoryName,
              style: h1(),
            ),
            4.height,
            Text(
              formatDate2(detailNotif.createdAt),
              style: body1(color: Colors.grey, bold: false),
            ),
            Divider(thickness: 1, height: 32, color: Colors.grey.shade400),
            Text(
              detailNotif.message,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}