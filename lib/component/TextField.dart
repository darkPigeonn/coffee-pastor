// ignore_for_file: must_be_immutable, file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginTextField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? error;
  final String hint;
  FocusNode? focus;
  void Function()? onTap;
  final bool readOnly;

  LoginTextField({
    super.key,
    required this.controller,
    required this.textInputType,
    required this.error,
    required this.hint,
    this.focus,
    this.onTap,
    required this.readOnly,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends ConsumerState<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: widget.readOnly,
      focusNode: widget.focus,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      maxLines: 1,
      decoration: InputDecoration(
        errorText: widget.error,
        hintText: widget.hint,
        suffixIcon: widget.focus?.hasFocus == true
            ? IconButton(
                onPressed: () => widget.controller.clear(),
                icon: Icon(
                  Icons.close,
                  color: primary,
                ),
              )
            : null,
      ),
      onTap: widget.onTap,
    );
  }
}

class ProfileTextField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? error;
  final String hint;
  final String labelText;
  FocusNode? focus;
  void Function()? onTap;
  final bool readOnly;

  ProfileTextField({
    super.key,
    required this.controller,
    required this.textInputType,
    required this.error,
    required this.hint,
    required this.labelText,
    this.focus,
    this.onTap,
    required this.readOnly,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileTextFieldState();
}

class _ProfileTextFieldState extends ConsumerState<ProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.textInputType,
      readOnly: widget.readOnly,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIconConstraints: BoxConstraints(
          minHeight: 24,
          minWidth: 24,
        ),
        suffixIcon: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: primary,
              width: 2.0,
            ),
          ),
          child: Icon(
            Icons.edit,
            color: primary,
            size: 14,
          ),
        ),
        labelText: widget.labelText,
      ),
      onTap: widget.onTap,
    );
  }
}

class DescTextField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? error;
  final String hint;
  final FocusNode focus;
  final void Function()? onPressed;
  bool? isShown;
  bool? isAutoFocus;

  DescTextField({
    Key? key,
    required this.controller,
    required this.textInputType,
    required this.error,
    required this.hint,
    required this.focus,
    required this.onPressed,
    this.isShown,
    this.isAutoFocus,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DescTextFieldState();
}

class _DescTextFieldState extends ConsumerState<DescTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: widget.isAutoFocus != null ? widget.isAutoFocus! : false,
      focusNode: widget.focus,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      maxLines: null,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        errorText: widget.error,
        hintText: widget.hint,
        suffixIcon: widget.isShown != null ? IconButton(
          onPressed: widget.onPressed,
          icon: Icon(
            Icons.send,
          ),
        ) : null
      ),
    );
  }
}

class OutlinedTextfield extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? error;
  final String hint;
  final FocusNode focus;
  final void Function()? onPressed;

  OutlinedTextfield({
    Key? key,
    required this.controller,
    required this.textInputType,
    required this.error,
    required this.hint,
    required this.focus,
    required this.onPressed,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OutlinedTextfieldState();
}

class _OutlinedTextfieldState extends ConsumerState<OutlinedTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focus,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      maxLines: null,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        errorText: widget.error,
        hintText: widget.hint,
      ),
    );
  }
}

class TextFieldNoTitle extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final int? minLines;
  final int? maxLines;
  Function(String)? onChanges;
  Function()? onSubmitted;
  final String hint;
  TextFieldNoTitle({
    super.key,
    this.onChanges,
    this.onSubmitted,
    this.minLines,
    this.maxLines,
    required this.controller,
    required this.textInputType,
    required this.hint,
  });

  @override
  ConsumerState<TextFieldNoTitle> createState() => _TextFieldNoTitleState();
}

class _TextFieldNoTitleState extends ConsumerState<TextFieldNoTitle> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      scrollPhysics: BouncingScrollPhysics(),
      controller: widget.controller,
      autocorrect: false,
      enableSuggestions: false,
      keyboardType: widget.textInputType,

      minLines: widget.minLines == null
          ? 1
          : widget.minLines == -1
              ? null
              : widget.minLines,
      maxLines: widget.maxLines == null
          ? 1
          : widget.maxLines == -1
              ? null
              : widget.maxLines,
      onChanged: widget.onChanges,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },

      onSubmitted: (value) async => widget.onSubmitted != null ? widget.onSubmitted!() : null,
      // maxLength: widget.pass ? 1024 : 18,
      style: body1(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        errorMaxLines: 1,
        counterText: "",
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        border: const OutlineInputBorder(),
        hintText: widget.hint,
        hintStyle: body1(color: grey1),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}