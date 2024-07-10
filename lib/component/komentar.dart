import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/ImageLoader.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:nb_utils/nb_utils.dart';

class KomentarIcon extends StatelessWidget {
  final String name;
  final String content;
  final String imageUser;
  const KomentarIcon({
    super.key,
    required this.name,
    required this.content,
    required this.imageUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
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
          16.width,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: body3(bold: true),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: body3(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
