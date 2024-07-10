import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/Button.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future showDialogLoading(
  var context,
) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    },
  );
}

Future successDialog(
  var context,
  void Function()? btnOkOnPress,
  String title,
  String desc,
) {
  return Alert(
    context: context,
    type: AlertType.success,
    title: title,
    desc: desc,
    buttons: [
      // DialogButton(
      //   child: Text(
      //     "Cancel",
      //     style: TextStyle(color: Colors.white, fontSize: 18),
      //   ),
      //   onPressed: () => Navigator.pop(context),
      //   color: danger,
      // ),
      DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: btnOkOnPress,
        color: primary,
      ),
    ],
  ).show();
}

Future errorDialog(
  var context,
  void Function()? btnOkOnPress,
  String title,
  String desc,
) {
  return Alert(
    context: context,
    type: AlertType.error,
    title: title,
    desc: desc,
    buttons: [
      // DialogButton(
      //   child: Text(
      //     "Cancel",
      //     style: TextStyle(color: Colors.white, fontSize: 18),
      //   ),
      //   onPressed: () => Navigator.pop(context),
      //   color: danger,
      // ),
      DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: btnOkOnPress,
        color: primary,
      ),
    ],
  ).show();
}

Future warningDialog(
  var context,
  void Function()? btnOkOnPress,
  String title,
  String desc,
) {
  return Alert(
    context: context,
    type: AlertType.warning,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () => Navigator.pop(context),
        color: danger,
      ),
      DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: btnOkOnPress,
        color: primary,
      ),
    ],
  ).show();
}

Future showDialogConfirm(
  var context,
  String title,
  String subTitle,
  String confirmTitle,
  GestureTapCallback onTapConfirm,
  String cancelTitle,
  GestureTapCallback onTapCancel,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return Consumer(builder: (
          BuildContext context,
          WidgetRef ref,
          Widget? child,
        ) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: h4(color: primary),
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    subTitle,
                    style: body2(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Button(
                    onPressed: () => onTapConfirm(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: Text(
                        confirmTitle,
                        style: body1(
                          color: white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: cancelTitle != "",
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => onTapCancel(),
                          child: Container(
                            color: Colors.transparent,
                            child: Text(
                              cancelTitle,
                              style: body3(
                                color: grey1,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
      });
}