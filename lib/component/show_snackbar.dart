import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

SnackBar successSnackbar() {
  return SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Berhasil',
      message:
          'Anda berhasil memperbarui profile!',
      contentType: ContentType.success,
    ),
  );
}

SnackBar failSnackbar() {
  return SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Gagal',
      message:
          'Anda gagal memperbarui profile!',
      contentType: ContentType.failure,
    ),
  );
}