import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/ImageLoader.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:nb_utils/nb_utils.dart';

import '../style/color.dart';

class CircleIcon extends StatelessWidget {
  final IconData icon;
  CircleIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: primaryPastel,
      radius: 20,
      child: Icon(
        icon,
        size: 24,
        color: primary,
      ),
    );
  }
}

class CircleLogo extends StatelessWidget {
  final String image;
  const CircleLogo({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: white,
      ),
      child: Image.asset(image),
    );
  }
}


class TestimoniIcon extends StatelessWidget {
  final String name;
  final String content;
  final String imageUser;
  const TestimoniIcon({
    super.key,
    required this.name,
    required this.content,
    required this.imageUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: LoadImage(
              imageLink: imageUser,
              width: 36,
              height: 36,
              boxFit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: h3()),
                const SizedBox(height: 4),
                Text(content, style: body3()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}