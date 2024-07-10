// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/Button.dart';
import 'package:flutter_coffee_application/component/TextField.dart';
import 'package:flutter_coffee_application/component/Toast/show_toast.dart';
import 'package:flutter_coffee_application/component/profile/user_picture.dart';
import 'package:flutter_coffee_application/component/show_dialog.dart';
import 'package:flutter_coffee_application/resource/model/user_model.dart';
import 'package:flutter_coffee_application/resource/provider/profile_provider.dart';
import 'package:flutter_coffee_application/resource/services/api/profile_services.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';

import '../../component/Format/DateFormat.dart';
import '../../component/show_snackbar.dart';
import '../../resource/const_resource.dart';
import '../../resource/helpers.dart';
import '../../style/typhography.dart';

class DetailPage extends ConsumerStatefulWidget {
  final ModelUser user;
  DetailPage({super.key, required this.user});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  bool isPick = false;
  final name = TextEditingController();
  final address = TextEditingController();
  final dob = TextEditingController();
  final gender = TextEditingController();
  final phoneNumber = TextEditingController();
  final nameNode = FocusNode();
  final addressNode = FocusNode();
  final dobNode = FocusNode();
  final genderNode = FocusNode();
  final phoneNumberNode = TextEditingController();
  bool validate = false;
  final FocusNode _focus = FocusNode();
  DateTime selectedDate = DateTime.now();
  String? _selectedGender;

  static Future<XFile?> pickImageFromGalery() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 30);
      if (image == null) {
        print("Image is Empty");
        return null;
      } else {
        return XFile(image.path);
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      name.text = widget.user.fullName ?? '';
      address.text = widget.user.address ?? '';
      dob.text = widget.user.dob ?? '';
      gender.text = widget.user.gender ?? '';
      phoneNumber.text = widget.user.phoneNumber ?? '';
      _selectedGender = widget.user.gender;
    }
    _focus.addListener(_onFocusChange);
  }

  bool isPhoneNumberValid(String phoneNumber) {
    final regex = RegExp(r'^0\d{9,12}$');
    return regex.hasMatch(phoneNumber);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ref.watch(profileDataProvider).when(
            skipLoadingOnRefresh: false,
            data: (data) {
              return RefreshIndicator(
                onRefresh: () async {
                  bool result = await checkInternetConnectivity(context);
                  if (result) {
                    await ref.refresh(profileDataProvider.future);
                  }
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Container(
                          height: 300,
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 230,
                                color: primaryPastel,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 70,
                                    ),
                                    Text(
                                      "Akun Saya",
                                      style: TextStyle(
                                          color: primary, fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        color: Colors.blue[50],
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 0.2,
                                            spreadRadius: 0.0,
                                            offset: Offset(0, 0),
                                          )
                                        ],
                                      ),
                                      child: Text(
                                        "Member sejak: ${formatDate2(widget.user.createdAt)}",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 70,
                                left: 16,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: primary,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: primary,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left:
                                    MediaQuery.of(context).size.width / 2 - 72,
                                child: UserPicture(
                                  onTap: () async {
                                    bool result =
                                        await checkInternetConnectivity(
                                            context);
                                    if (result) {
                                      final pickImage =
                                          await pickImageFromGalery();
                                      if (pickImage == null) {
                                        showToast("Gambar tidak ditemukan");
                                      } else {
                                        showDialogLoading(context);

                                        try {
                                          late String imageLink;

                                          if (pickImage?.path != null) {
                                            print("Masuk Cropped");
                                            imageLink = await uploadImage()
                                                .uploadProfilePicture(
                                                    XFile(pickImage!.path),
                                                    data.id)
                                                .timeout(Duration(
                                                    seconds: apiWaitTime));
                                          }

                                          try {
                                            if (pickImage?.path != null) {
                                              var body = {
                                                "profilePicture": imageLink,
                                              };

                                              print(body);

                                              Map<String, dynamic> response =
                                                  await profileServices()
                                                      .updateProfileProfile(
                                                          body)
                                                      .timeout(Duration(
                                                          seconds:
                                                              apiWaitTime));

                                              if (pickImage?.path != null) {
                                                ref
                                                    .watch(imagePicked.notifier)
                                                    .update((state) =>
                                                        File(pickImage!.path));
                                              }
                                              setState(() {
                                                isPick = true;
                                              });

                                              await ref.refresh(
                                                  profileDataProvider.future);
                                              context.pop();

                                              if (response['statusCode'] ==
                                                  200) {
                                                QuickAlert.show(
                                                  context: context,
                                                  type: QuickAlertType.success,
                                                  title: "Sukses",
                                                  text:
                                                      "Berhasil mengubah foto profil",
                                                );
                                              } else if (response[
                                                      'statusCode'] ==
                                                  412) {
                                                QuickAlert.show(
                                                  context: context,
                                                  type: QuickAlertType.error,
                                                  title:
                                                      "Gagal Mengubah Foto Profil",
                                                  text: response['message'],
                                                );
                                              }
                                            } else {
                                              context.pop();
                                              showToast(
                                                  "Membatalkan pengambilan gambar");
                                            }
                                          } on TimeoutException {
                                            context.pop();
                                            QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.error,
                                              title: "Waktu Habis",
                                              text:
                                                  "Gagal mengubah foto profil, silahkan coba sekali lagi",
                                            );
                                          } catch (e) {
                                            print("Error Upload: $e");
                                            context.pop();
                                            QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.error,
                                              title: "Server Error",
                                              text:
                                                  "Gagal mengubah foto profil, silahkan coba sekali lagi. Error: $e",
                                            );
                                          }
                                        } on TimeoutException {
                                          context.pop();
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: "Waktu Habis",
                                            text:
                                                "Gagal mengunggah foto profil, silahkan coba sekali lagi",
                                          );
                                        } catch (e) {
                                          print("Error Upload: $e");
                                          context.pop();
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: "Server Error",
                                            text:
                                                "Gagal menunggah foto profil, silahkan coba sekali lagi. Error: $e",
                                          );
                                        }
                                      }
                                    }
                                  },
                                  profilePicture: ref.watch(imagePicked) != null
                                      ? "file"
                                      : data.image,
                                  imageFile: ref.watch(imagePicked),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height - 350,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextFormField(
                                            focusNode: _focus,
                                            controller: name,
                                            decoration: InputDecoration(
                                              counterText: '',
                                              suffixIconConstraints:
                                                  BoxConstraints(
                                                      minHeight: 24,
                                                      minWidth: 24),
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
                                              labelText: 'Username',
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          ProfileTextField(
                                            controller: address,
                                            textInputType: TextInputType.name,
                                            error: "kosong",
                                            hint: "alamat rumah",
                                            labelText: "Alamat Rumah",
                                            readOnly: false,
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          ProfileTextField(
                                            controller: dob,
                                            textInputType: TextInputType.name,
                                            error: "kosong",
                                            hint: "Tanggal Lahir",
                                            labelText: "Tanggal Lahir",
                                            readOnly: true,
                                            onTap: () {
                                              showDatePicker(
                                                context: context,
                                                initialDate: selectedDate,
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime.now(),
                                                builder: (BuildContext context,
                                                    Widget? child) {
                                                  return Theme(
                                                    data: ThemeData.light()
                                                        .copyWith(
                                                      colorScheme:
                                                          ColorScheme.light(
                                                        primary: primary,
                                                        onPrimary: white,
                                                        onSurface: Colors.black,
                                                      ),
                                                    ),
                                                    child: child!,
                                                  );
                                                },
                                              ).then((pickedDate) {
                                                if (pickedDate != null &&
                                                    pickedDate !=
                                                        selectedDate) {
                                                  setState(() {
                                                    selectedDate = pickedDate;
                                                    dob.text =
                                                        formatDate2(pickedDate);
                                                    dobNode.unfocus();
                                                  });
                                                }
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          ProfileTextField(
                                            controller: phoneNumber,
                                            textInputType: TextInputType.number,
                                            error: "kosong",
                                            hint: "Nomor Ponsel",
                                            labelText: "Masukkan Nomor Ponsel",
                                            readOnly: false,
                                          ),
                                          16.height,
                                          Text("Jenis Kelamin", style: body1()),
                                          8.height,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Radio<String>(
                                                value: 'Pria',
                                                groupValue: _selectedGender,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    _selectedGender = value!;
                                                    print(_selectedGender);
                                                  });
                                                },
                                              ),
                                              Text('Pria',
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              24.width,
                                              Radio<String>(
                                                value: 'Wanita',
                                                groupValue: _selectedGender,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    _selectedGender = value!;
                                                    print(_selectedGender);
                                                  });
                                                },
                                              ),
                                              Text('Wanita',
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Button(
                                        onPressed: () async {
                                          bool result =
                                              await checkInternetConnectivity(
                                                  context);
                                          if (result) {
                                            if (!isPhoneNumberValid(
                                                phoneNumber.text)) {
                                              showToast(
                                                  "Nomor ponsel tidak valid");
                                              return;
                                            }
                                            final data = <String, String>{
                                              'fullName': name.text,
                                              'address': address.text,
                                              'dob': dob.text,
                                              'gender': _selectedGender! ?? "",
                                              'phoneNumber': phoneNumber.text,
                                            };
                                            try {
                                              showDialogLoading(context);
                                              final response =
                                                  await profileServices()
                                                      .updateProfile(data)
                                                      .timeout(
                                                        Duration(
                                                            seconds:
                                                                apiWaitTime),
                                                      );
                                              Navigator.of(context).pop();
                                              if (response['statusCode'] ==
                                                  200) {
                                                await ref.refresh(
                                                    profileDataProvider.future);
                                                Navigator.of(context).pop();
                                                showToast("Berhasil menyimpan profil");
                                              } else {
                                                showToast("Gagal menyimpan profil");
                                              }
                                            } catch (e) {
                                              print(e);
                                              Navigator.of(context).pop();
                                            }
                                          }
                                        },
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "SIMPAN",
                                            style: h3(
                                              color: white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            error: (error, e) => Text(e.toString()),
            loading: () => Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            ),
          ),
    );
  }
}
