// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coffee_application/component/Icon.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../style/typhography.dart';

class Button extends StatelessWidget {
  GestureTapCallback onPressed;
  final Widget child;
  final double? height;
  final double? width;
  final Color? color;
  Button({
    super.key,
    required this.onPressed,
    this.height,
    this.width,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: RawMaterialButton(
        padding: EdgeInsets.all(12),
        fillColor: color ?? primary,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: child,
      ),
    );
  }
}

class ButtonOutline extends StatelessWidget {
  GestureTapCallback onPressed;
  final Widget child;
  final double? height;
  final double? width;
  ButtonOutline({
    super.key,
    required this.onPressed,
    this.height,
    this.width,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: primary,
            ),
            surfaceTintColor: primaryPastel,
            foregroundColor: primaryPastel),
        onPressed: () => onPressed(),
        child: child,
      ),
    );
  }
}

class ButtonOutlined extends StatelessWidget {
  String text;
  void Function() onPressed;
  ButtonOutlined({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: h3(
          color: primary,
        ),
      ),
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          BorderSide(
            color: primary,
            width: 2.0,
            style: BorderStyle.solid,
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey;
            }
            return white;
          },
        ),
      ),
    );
  }
}

class ButtonCircle extends StatelessWidget {
  final Widget icon;
  final void Function()? onPressed;
  final Color color;

  const ButtonCircle({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 17,
      backgroundColor: primary, // Replace Colors.grey with your desired color
      child: CircleAvatar(
        radius: 16,
        backgroundColor: color,
        child: IconButton(
          iconSize: 16,
          icon: icon,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class ButtonSubmit extends StatelessWidget {
  GestureTapCallback onPressed;
  bool? enable;
  final Widget child;
  final double? height;
  final double? width;
  final Color? color;
  final double? elevate;

  ButtonSubmit({
    super.key,
    required this.onPressed,
    this.enable,
    this.height,
    this.width,
    this.color,
    this.elevate,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: RawMaterialButton(
        elevation: elevate != null ? elevate! : 0,
        disabledElevation: elevate != null ? elevate! : 0,
        fillColor: enable != null
            ? enable!
                ? color ?? primary
                : Colors.grey[350]
            : color ?? primary,
        onPressed: enable != null
            ? enable!
                ? onPressed
                : null
            : onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: child,
      ),
    );
  }
}

class RadioButton extends StatefulWidget {
  String title;
  String subtitle;
  bool value;
  String image;
  bool? groupValue;
  void Function(bool?)? onChanged;
  RadioButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.groupValue,
    required this.image,
    required this.onChanged,
    required this.value,
  });

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return RadioListTile<bool>(
      title: Text(widget.title),
      subtitle: Text(widget.subtitle),
      value: widget.value,
      groupValue: widget.groupValue,
      onChanged: widget.onChanged,
      controlAffinity: ListTileControlAffinity.trailing,
      secondary: CircleLogo(image: widget.image),
    );
  }
}

class RadioButtonIcon extends StatefulWidget {
  String title;
  String subtitle;
  bool value;
  IconData icon;
  bool? groupValue;
  void Function(bool?)? onChanged;
  RadioButtonIcon({
    super.key,
    required this.title,
    required this.subtitle,
    required this.groupValue,
    required this.icon,
    required this.onChanged,
    required this.value,
  });

  @override
  State<RadioButtonIcon> createState() => _RadioButtonIconState();
}

class _RadioButtonIconState extends State<RadioButtonIcon> {
  @override
  Widget build(BuildContext context) {
    return RadioListTile<bool>(
      title: Text(widget.title),
      subtitle: Text(widget.subtitle),
      value: widget.value,
      groupValue: widget.groupValue,
      onChanged: widget.onChanged,
      controlAffinity: ListTileControlAffinity.trailing,
      secondary: CircleIcon(icon: widget.icon),
    );
  }
}

class ButtonAccept extends ConsumerWidget {
  GestureTapCallback onPressed;
  bool? enable;
  final Widget child;
  final double? height;
  final double? width;
  final Color? color;
  final Color? colorSplash;
  ButtonAccept({
    super.key,
    required this.onPressed,
    this.enable,
    this.height,
    this.width,
    this.color,
    this.colorSplash,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width,
      height: height,
      child: RawMaterialButton(
        fillColor: enable != null
            ? enable!
                ? color ?? primary
                : Colors.grey[350]
            : color ?? primary,
        splashColor: colorSplash ?? primaryLight,
        onPressed: enable != null
            ? enable!
                ? onPressed
                : null
            : onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: child,
      ),
    );
  }
}

class ButtonIcon extends ConsumerWidget {
  GestureTapCallback onPressed;
  bool? enable;
  final Widget iconLeading;
  final Widget text;
  final Widget iconTrailing;
  final double? height;
  final double? width;
  final Color? color;
  final Color? colorSplash;
  ButtonIcon({
    super.key,
    required this.onPressed,
    this.enable,
    this.height,
    this.width,
    this.color,
    this.colorSplash,
    required this.iconLeading,
    required this.text,
    required this.iconTrailing,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: width,
      height: height,
      child: RawMaterialButton(
        elevation: 4,
        padding: EdgeInsets.all(12),
        fillColor: enable != null
            ? enable!
                ? color ?? primary
                : Colors.grey[350]
            : color ?? primary,
        splashColor: colorSplash ?? primaryLight,
        onPressed: enable != null
            ? enable!
                ? onPressed
                : null
            : onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconLeading,
            8.width,
            text,
            8.width,
            iconTrailing,
          ],
        ),
      ),
    );
  }
}

class RectangleButtonIcon extends ConsumerWidget {
  GestureTapCallback onPressed;
  bool? enable;
  final Widget iconLeading;
  final Widget text;
  final double? height;
  final double? width;
  final Color? color;
  final Color? colorSplash;
  RectangleButtonIcon({
    super.key,
    required this.onPressed,
    this.enable,
    this.height,
    this.width,
    this.color,
    this.colorSplash,
    required this.iconLeading,
    required this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: width,
      height: height,
      child: RawMaterialButton(
        elevation: 4,
        padding: EdgeInsets.all(8),
        fillColor: enable != null
            ? enable!
                ? color ?? primary
                : Colors.grey[350]
            : color ?? primary,
        splashColor: colorSplash ?? primaryLight,
        onPressed: enable != null
            ? enable!
                ? onPressed
                : null
            : onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            4.height,
            iconLeading,
            text,
          ],
        ),
      ),
    );
  }
}