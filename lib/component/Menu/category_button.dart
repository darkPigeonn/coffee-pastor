import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:nb_utils/nb_utils.dart';

class ButtonCategory extends StatelessWidget {
  final bool tap;
  final int index;
  final GestureTapCallback onPressed;
  final String title;

  const ButtonCategory({
    Key? key, // Corrected key parameter
    required this.tap,
    required this.index,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: tap ? primaryLight : white,
          border: Border.all(width: 1, color: tap ? primaryDark : grey1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              title,
              style: TextStyle(
                color: tap ? black : black,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
