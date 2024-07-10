// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:nb_utils/nb_utils.dart';

import '../style/color.dart';
import '../style/typhography.dart';

class ModalGenderWheelChooser extends StatefulWidget {
  dynamic Function(dynamic)? onValueChanged;
  List<Widget>? children;
  void Function()? onPressed;
  ModalGenderWheelChooser({
    super.key,
    required this.onValueChanged,
    required this.children,
    required this.onPressed,
  });
  @override
  State<ModalGenderWheelChooser> createState() =>
      _ModalGenderWheelChooserState();
}

class _ModalGenderWheelChooserState extends State<ModalGenderWheelChooser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        color: white,
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                color: grey3,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Pilih Jenis Kelamin",
                  style: h1(color: primary),
                ),
              ),
            ),
            WheelChooser.custom(
                listHeight: 300,
                itemSize: 80,
                onValueChanged: widget.onValueChanged,
                children: widget.children),
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              color: primary,
              child: TextButton(
                style: TextButton.styleFrom(foregroundColor: white),
                onPressed: widget.onPressed,
                child: Text(
                  "PILIH",
                  style: h3(
                    color: white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
