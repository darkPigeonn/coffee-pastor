// ignore_for_file: must_be_immutable, file_names, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadImage extends StatelessWidget {
  final String imageLink;
  BoxFit? boxFit;
  double? height;
  double? width;

  LoadImage({
    super.key,
    required this.imageLink,
    this.boxFit,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return imageLink == "noImage"
        ? SizedBox(
            height: height,
            width: width,
            child: const Icon(
              Icons.broken_image,
              color: Colors.grey,
            ),
          )
        : Image.network(
            imageLink,
            fit: boxFit,
            height: height,
            width: width,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.transparent,
                height: height,
                width: width,
                child: Icon(
                  Icons.broken_image_rounded,
                  color: Colors.grey,
                ),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: height,
                  width: width,
                  color: Colors.white,
                ),
              );
            },
          );
  }
}

class LoadImageCircle extends StatelessWidget {
  final String imageLink;
  BoxFit? boxFit;
  double? height;
  double? width;
  LoadImageCircle({
    super.key,
    required this.imageLink,
    this.boxFit,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return imageLink == "noImage"
        ? Container(
            height: height,
            width: width,
            child: Image.asset(
              "assets/image/no_image.jpg",
              fit: boxFit,
              height: height,
              width: width,
            ))

        // const Icon(
        //       Icons.broken_image,
        //       color: Colors.grey,
        //     ),
        : ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.network(
              imageLink,
              fit: boxFit,
              height: height,
              width: width,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                    color: Colors.transparent,
                    height: height,
                    width: width,
                    child: Image.asset(
                      "assets/image/no_image.jpg",
                      fit: boxFit,
                      height: height,
                      width: width,
                    ));
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: height,
                    width: width,
                    color: Colors.white,
                  ),
                );
              },
            ),
          );
  }
}
