import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ImageLoader.dart';

// ignore: must_be_immutable
class UserPicture extends ConsumerWidget {
  final GestureTapCallback onTap;
  final String profilePicture;
  File? imageFile;
  UserPicture({
    super.key,
    required this.onTap,
    required this.profilePicture,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          profilePicture == "file"
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: kIsWeb
                      ? Image.network(
                          imageFile!.path,
                          fit: BoxFit.cover,
                          height: 140,
                          width: 140,
                        )
                      : Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                          height: 140,
                          width: 140,
                        ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: LoadImage(
                    imageLink: profilePicture,
                    boxFit: BoxFit.cover,
                    height: 140,
                    width: 140,
                  ),
                ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: grey2,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.edit_rounded,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }
}