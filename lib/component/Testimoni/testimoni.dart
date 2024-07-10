import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/ImageLoader.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/component/Format/NumberFormat.dart';
import 'package:flutter_coffee_application/resource/model/testimoni_model.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

class Testimoni extends ConsumerStatefulWidget {
  final ModelTestimoni testimoni;
  const Testimoni({super.key, required this.testimoni});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestimoniState();
}

class _TestimoniState extends ConsumerState<Testimoni> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            LoadImageCircle(
              imageLink: widget.testimoni.image,
              boxFit: BoxFit.fill,
              height: 50,
              width: 50,
            ),
            4.width,
            Text(
              widget.testimoni.createdByName.capitalizeEachWord(),
              style: custom(fontSize: 16, bold: FontWeight.normal),
            )
          ],
        ),
        8.height,
        Row(
          children: [
            Text(
              "${cleanDouble(widget.testimoni.rating)}/5  ",
              style: custom(fontSize: 16, bold: FontWeight.normal),
            ),
            Text(
              timeDifference(widget.testimoni.createdAt, DateTime.now()),
              style: body1(),
            )
          ],
        ),
        8.height,
        Text(
          widget.testimoni.isiTestimoni,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: custom(fontSize: 16, bold: FontWeight.normal),
        )
      ],
    );
  }
}


class DetailTestimoniIcon extends ConsumerStatefulWidget {
  final ModelTestimoni testimoni;
  const DetailTestimoniIcon({super.key, required this.testimoni});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailTestimoniState();
}

class _DetailTestimoniState extends ConsumerState<DetailTestimoniIcon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LoadImageCircle(
              imageLink: widget.testimoni.image,
              boxFit: BoxFit.fill,
              height: 50,
              width: 50,
            ),
            16.width,
            Text(
              widget.testimoni.createdByName.capitalizeEachWord(),
              style: custom(fontSize: 16, bold: FontWeight.normal),
            )
          ],
        ),
        8.height,
        Row(
          children: [
            Text(
              "${cleanDouble(widget.testimoni.rating)}/5  ",
              style: custom(fontSize: 16, bold: FontWeight.normal),
            ),
            Text(
              timeDifference(widget.testimoni.createdAt, DateTime.now()),
              style: body1(),
            )
          ],
        ),
        8.height,
        Text(
          widget.testimoni.isiTestimoni,
          style: custom(fontSize: 16, bold: FontWeight.normal),
        )
      ],
    );
  }
}