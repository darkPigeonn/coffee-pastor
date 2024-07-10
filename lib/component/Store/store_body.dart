// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/resource/model/store_model.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

class StoreBody extends ConsumerStatefulWidget {
  final ModelStore store;
  const StoreBody({super.key, required this.store});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoreBodyState();
}

class _StoreBodyState extends ConsumerState<StoreBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.store.nama.toUpperCase(),
                style: custom(
                  fontSize: 20,
                  bold: FontWeight.w400,
                ),
              ),
              8.height,
              Text(
                widget.store.lokasi.alamat,
                style: custom(
                  fontSize: 16,
                  bold: FontWeight.w400,
                ),
              ),
              8.height,
              Text(
                "Jam Buka",
                style: custom(
                  fontSize: 16,
                  bold: FontWeight.w400,
                ),
              ),
              Text(
                "${widget.store.startTime} - ${widget.store.endTime}",
                style: custom(
                  fontSize: 16,
                  bold: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: black,
        )
      ],
    );
  }
}
