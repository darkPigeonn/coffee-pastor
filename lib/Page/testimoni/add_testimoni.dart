import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/show_dialog.dart';
import 'package:flutter_coffee_application/main.dart';
import 'package:flutter_coffee_application/resource/const_resource.dart';
import 'package:flutter_coffee_application/resource/provider/auth/auth_provider.dart';
import 'package:flutter_coffee_application/resource/services/api/testimoni_services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../component/TextField.dart';
import '../../../resource/helpers.dart';
import '../../../style/color.dart';
import '../../../style/typhography.dart';

class AddTestimoni extends ConsumerStatefulWidget {
  const AddTestimoni({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTestimoniState();
}

class _AddTestimoniState extends ConsumerState<AddTestimoni> {
  double rating = 5.0;
  final List<XFile> _imageFiles = [];
  List<String> _imagePaths = [];

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();

    if (pickedImages != null) {
      if (_imageFiles.length + pickedImages.length > 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Maximum of 1 image allowed'),
          ),
        );
        return;
      }

      setState(() {
        _imageFiles.addAll(pickedImages);
        print(_imageFiles);

        _imagePaths = _imageFiles.map((xfile) => xfile.path).toList();
      });
    }
  }

  Future<List<String>> uploadImages(List<String> imagePaths) async {
    List<String> uploadedImageLinks = [];
    int number = 0;
    for (var imagePath in imagePaths) {
      String imageLink = await uploadImage()
          .uploadProfilePicture(XFile(imagePath),
              "${sp.getString('token') != "" ? sp.getString('token') : "Guest-${name.text}"}-${number.toString()}")
          .timeout(Duration(seconds: apiWaitTime));
      uploadedImageLinks.add(imageLink);
      number++;
    }
    return uploadedImageLinks;
  }

  final name = TextEditingController();
  final desc = TextEditingController();
  final descNode = FocusNode();
  final nameNode = FocusNode();
  bool validate = false;
  bool waValidate = false;
  bool refValidate = false;
  bool enable = false;
  int textLength = 0;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    name.addListener(validateInputs);
    desc.addListener(validateInputs);
    descNode.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    desc.dispose();
    nameNode.removeListener(_onFocusChange);
    descNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void validateInputs() {
    if (name.text.isEmpty || desc.text.isEmpty) {
      setState(() {
        enable = false;
      });
    } else {
      setState(() {
        enable = true;
      });
    }
  }

  void _onFocusChange() {
    debugPrint("Name Focus: ${nameNode.hasFocus.toString()}");
    debugPrint("desc Focus: ${descNode.hasFocus.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Testimoni Baru',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: !ref.watch(isLogin),
                  child: Text(
                    "Tambahkan Gambar",
                    style: h2(color: primary),
                  ),
                ),
                Visibility(
                  visible: !ref.watch(isLogin),
                  child: _imageFiles.isEmpty
                      ? Row(
                          children: List.generate(
                            1,
                            (index) => Expanded(
                              child: Container(
                                height: 200,
                                margin: const EdgeInsets.all(4.0),
                                color: Colors.grey[300],
                                child: Center(
                                  child: Text(
                                    'Add Image',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 200, // Set a fixed height for the GridView
                          child: GridView.builder(
                            itemCount: _imageFiles.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: _pickImages,
                                child: Container(
                                  height: 200,
                                  margin: const EdgeInsets.all(4.0),
                                  color: Colors.grey[300],
                                  child: Center(
                                    child: _imageFiles.isEmpty
                                        ? Text(
                                            'Add Image',
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          )
                                        : Stack(
                                            children: [
                                              Center(
                                                child: Image.file(
                                                  File(_imageFiles[index].path),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Center(
                                                child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _imageFiles
                                                          .removeAt(index);
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
                Visibility(
                  visible: !ref.watch(isLogin),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: _pickImages,
                      child: const Text("Tambah Gambar"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                !ref.watch(isLogin)
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama",
                              style: h2(color: primary),
                            ),
                            DescTextField(
                              controller: name,
                              textInputType: TextInputType.name,
                              error: validate ? "belum diisi" : null,
                              hint: "Nama",
                              focus: nameNode,
                              onPressed: null,
                              // isShown: false,
                            )
                          ],
                        ),
                      )
                    : SizedBox(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Isi Testimoni",
                        style: h2(color: primary),
                      ),
                      DescTextField(
                        isAutoFocus: true,
                        controller: desc,
                        textInputType: TextInputType.multiline,
                        error: validate ? "belum diisi" : null,
                        hint: "Testimoni",
                        focus: descNode,
                        onPressed: null,
                      )
                    ],
                  ),
                ),
                16.height,
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rating",
                        style: h2(color: primary),
                      ),
                      RatingBar.builder(
                        initialRating: rating,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Check internet connectivity
                      bool result = await checkInternetConnectivity(context);
                      if (result) {
                        try {
                          List<String> uploadedImageLinks =
                              await uploadImages(_imagePaths);
                          if (ref.watch(isLogin)) {
                            if (desc.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Isi yang masih kosong'),
                                ),
                              );
                              return;
                            }
                            showDialogLoading(context);
                            Map<String, dynamic> response =
                                await TestimoniServices()
                                    .createTestimoniUser(desc.text, rating)
                                    .timeout(Duration(seconds: apiWaitTime));

                            Navigator.pop(context);
                            if (response['statusCode'] == 200) {
                              desc.clear();
                              successDialog(
                                context,
                                () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                "Sukses",
                                "Berhasil menambahkan testimoni",
                              );
                            } else if (response['statusCode'] == 412) {
                              errorDialog(
                                context,
                                () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                "Gagal Menambah Testimoni",
                                response['message'],
                              );
                            }
                          } else {
                            if (name.text.isEmpty || desc.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Isi yang masih kosong'),
                                ),
                              );
                              return;
                            }
                            name.clear();
                            desc.clear();
                            showDialogLoading(context);
                            Map<String, dynamic> response =
                                await TestimoniServices()
                                    .createTestimoniGuest(desc.text, rating)
                                    .timeout(Duration(seconds: apiWaitTime));

                            Navigator.pop(context);
                            if (response['statusCode'] == 200) {
                              successDialog(
                                context,
                                () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                "Sukses",
                                "Berhasil menambahkan testimoni",
                              );
                            } else if (response['statusCode'] == 412) {
                              errorDialog(
                                context,
                                () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                "Gagal Menambah Testimoni",
                                response['message'],
                              );
                            }
                          }
                        } on TimeoutException {
                          Navigator.pop(context); // Close loading dialog
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Timeout while uploading image or adding promo.'),
                            ),
                          );
                        } catch (e) {
                          Navigator.pop(context); // Close loading dialog
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: $e'),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No internet connectivity.'),
                          ),
                        );
                      }
                    },
                    child: const Text("Tambah Testimoni"),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
