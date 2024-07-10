// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/resource/model/notif_model.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../style/typhography.dart';

class NotoficationBody extends ConsumerWidget {
  final ModelNotif notif;
  const NotoficationBody({
    super.key,
    required this.notif,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: notif.read == ""
              ? Color(
                  int.parse("0xFFFF0000"),
                )
              : Color.fromARGB(255, 1, 147, 50),
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        leading: CircleAvatar(
          backgroundColor: primary,
          foregroundColor: white,
          child: Icon(Icons.menu_book_sharp)
          
        ),
        title: Text(
          notif.categoryName.capitalizeFirstLetter(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: body1(),
        ),
        subtitle: Text(
          notif.message,
          style: body3(color: Colors.grey),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text("${formatDate2(notif.createdAt)}"),
      ),
    );
  }
}