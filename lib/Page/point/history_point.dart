import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/Point/point.dart';
import 'package:flutter_coffee_application/resource/model/user_model.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryPoint extends ConsumerStatefulWidget {
  final List<ListPoint> listPoint;
  const HistoryPoint({super.key, required this.listPoint});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryPointState();
}

class _HistoryPointState extends ConsumerState<HistoryPoint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Point"),
        centerTitle: true,
      ),
      body: widget.listPoint.isEmpty
          ? Center(
              child: Text(
                "Belum ada riwayat penambahan atau pengurangan poin",
                style: body1(color: grey1),
              ),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: widget.listPoint.length,
              itemBuilder: (context, index) {
                return PointBody(
                  listPoint: widget.listPoint[index],
                );
              },
            ),
    );
  }
}
