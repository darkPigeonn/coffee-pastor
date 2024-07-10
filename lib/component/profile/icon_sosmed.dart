// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class IconSosMed extends StatefulWidget {
  final Function()? onTap;
  final String imagePath;
  const IconSosMed({super.key, required this.imagePath, required this.onTap});

  @override
  State<IconSosMed> createState() => _IconSosMedState();
}

class _IconSosMedState extends State<IconSosMed> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              widget.imagePath,
            ),
          ),
        ),
      ),
    );
  }
}
