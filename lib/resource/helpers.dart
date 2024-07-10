import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:image_picker/image_picker.dart';

import 'package:dospace/dospace.dart' as dospace;
import 'package:intl/intl.dart';

import 'const_resource.dart';

class uploadImage {
  Future<String> uploadProfilePicture(XFile file, String id) async {
    dospace.Spaces spaces = new dospace.Spaces(
      region: "sgp1",
      accessKey: "DO00PP2ZVBNWVGD4Y7V8",
      secretKey: "PNnmfACeClcZCDM8pUk+cBjJCiFYsW3sKX8C1TcM5Go",
    );

    String basePathDigitalOcean = 'https://sgp1.digitaloceanspaces.com';
    var date = DateTime.now();
    String formattedDate = DateFormat('dd-mm-yyyy').format(date);

    var _fileName = 'profilePhoto' + formattedDate + '-' + file.name + '-' + id;
    var _extension = '.jpg';
    var _filePathDigitalOcean = "https://cdn.imavi.org" +
        '/coffeeProfilePhoto/' +
        _fileName +
        _extension;

    print("masuk bucket");
    dospace.Bucket bucket = spaces.bucket('imavistatic');

    try {
      if (kIsWeb) {
        print("masuk web");
        await bucket
            .uploadFile(
              "coffeeProfilePhoto/" + (_fileName + _extension),
              file,
              _extension,
              dospace.Permissions.public,
            )
            .timeout(Duration(seconds: apiWaitTime));
      } else {
        print("masuk android/ios");
        await bucket
            .uploadFile(
              "coffeeProfilePhoto/" + (_fileName + _extension),
              file,
              _extension,
              dospace.Permissions.public,
            )
            .timeout(Duration(seconds: apiWaitTime));
      }

      print("keluar upload gambar");
      return _filePathDigitalOcean;
    } on TimeoutException {
      rethrow;
    } catch (e) {
      print("Error dospace: $e");
      throw (e);
    }
  }

  Future<String> uploadTestimoniPicture(XFile file, String id) async {
    dospace.Spaces spaces = new dospace.Spaces(
      region: "sgp1",
      accessKey: "DO00PP2ZVBNWVGD4Y7V8",
      secretKey: "PNnmfACeClcZCDM8pUk+cBjJCiFYsW3sKX8C1TcM5Go",
    );

    String basePathDigitalOcean = 'https://sgp1.digitaloceanspaces.com';
    var date = DateTime.now();
    String formattedDate = DateFormat('dd-mm-yyyy').format(date);

    var _fileName = 'profilePhoto' + formattedDate + '-' + file.name + '-' + id;
    var _extension = '.jpg';
    var _filePathDigitalOcean = "https://cdn.imavi.org" +
        '/TestimoniPhoto/' +
        _fileName +
        _extension +
        formatDate2(DateTime.now());

    print("masuk bucket");
    dospace.Bucket bucket = spaces.bucket('imavistatic');

    try {
      if (kIsWeb) {
        print("masuk web");
        await bucket
            .uploadFile(
              "TestimoniPhoto/" +
                  (_fileName + _extension + formatDate2(DateTime.now())),
              file,
              _extension,
              dospace.Permissions.public,
            )
            .timeout(Duration(seconds: apiWaitTime));
      } else {
        print("masuk android/ios");
        await bucket
            .uploadFile(
              "TestimoniPhoto/" +
                  (_fileName + _extension + formatDate2(DateTime.now())),
              file,
              _extension,
              dospace.Permissions.public,
            )
            .timeout(Duration(seconds: apiWaitTime));
      }

      print("keluar upload gambar");
      return _filePathDigitalOcean;
    } on TimeoutException {
      rethrow;
    } catch (e) {
      print("Error dospace: $e");
      throw (e);
    }
  }
}
