import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/ImageLoader.dart';
import 'package:flutter_coffee_application/resource/model/quote_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../style/color.dart';
import '../style/typhography.dart';

class Quotes extends ConsumerWidget {
  final ModelQuote quote;
  const Quotes({super.key, required this.quote});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          radiusCircular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(2, 3), // changes position of shadow
          ),
        ],
        color: primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quote.description,
            style: h3(color: white),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          12.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadImage(
                imageLink: quote.images[0],
                width: 120,
                height: 120,
                boxFit: BoxFit.fill,
              ),
              16.width,
              Text(
                quote.author,
                style: custom(
                  fontSize: 16,
                  bold: FontWeight.normal,
                  color: grey3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
