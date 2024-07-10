// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:datepicker_dropdown/order_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/component/Home/navbar_home.dart';
import 'package:flutter_coffee_application/component/Toast/show_toast.dart';
import 'package:flutter_coffee_application/resource/services/api/profile_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';

import '../../component/Button.dart';
import '../../component/TextField.dart';
import '../../component/show_dialog.dart';
import '../../resource/const_resource.dart';
import '../../style/color.dart';
import '../../style/typhography.dart';

class SignUp extends ConsumerStatefulWidget {
  Map<String, dynamic> body;
  SignUp({super.key, required this.body});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final name = TextEditingController();
  final address = TextEditingController();
  final dob = TextEditingController();
  final gender = TextEditingController();
  final phoneNumber = TextEditingController();
  final nameNode = FocusNode();
  final addressNode = FocusNode();
  final dobNode = FocusNode();
  final genderNode = FocusNode();
  final phoneNumberNode = FocusNode();
  bool validate = false;
  bool waValidate = false;
  bool refValidate = false;
  bool enable = false;
  int textLength = 0;
  DateTime selectedDate = DateTime.now();
  String _selectedGender = 'Pria';
  DateTime? _dateTime(int? day, int? month, int? year) {
    if (day != null && month != null && year != null) {
      return DateTime(year, month, day);
    }
    return null;
  }

  int _selectedDay = DateTime.now().day;
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;

  bool isPhoneNumberValid(String phoneNumber) {
    final regex = RegExp(r'^0\d{9,12}$');
    return regex.hasMatch(phoneNumber);
  }

  @override
  void initState() {
    name.addListener(validateInputs);
    address.addListener(validateInputs);
    dob.addListener(validateInputs);
    gender.addListener(validateInputs);
    nameNode.addListener(_onFocusChange);
    addressNode.addListener(_onFocusChange);
    phoneNumber.addListener(_onFocusChange);
    dobNode.unfocus();
    genderNode.unfocus();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    address.dispose();
    dob.dispose();
    gender.dispose();
    phoneNumber.dispose();
    nameNode.removeListener(_onFocusChange);
    addressNode.removeListener(_onFocusChange);
    phoneNumberNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void validateInputs() {
    if (name.text.isEmpty ||
        address.text.isEmpty ||
        dob.text.isEmpty ||
        gender.text.isEmpty) {
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
    debugPrint("Address Focus: ${addressNode.hasFocus.toString()}");
    debugPrint("DoB Focus: ${dobNode.hasFocus.toString()}");
    debugPrint("Gender Focus: ${genderNode.hasFocus.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // onPopInvoked: (didPop) => Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => AuthPage()),
      //   (route) => false,
      // ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                40.height,
                Center(
                  child: Text(
                    "Daftar",
                    style: h2(),
                  ),
                ),
                40.height,
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama*", style: body1()),
                      8.height,
                      TextFieldNoTitle(
                        minLines: 1,
                        maxLines: 2,
                        controller: name,
                        textInputType: TextInputType.text,
                        hint: "Isi nama anda",
                      ),
                      16.height,
                      Text("Nomor Telepon*", style: body1()),
                      8.height,
                      TextFieldNoTitle(
                        minLines: 1,
                        maxLines: 2,
                        controller: phoneNumber,
                        textInputType: TextInputType.number,
                        hint: "Isi nomor telepon",
                      ),
                      16.height,
                      Text("Alamat Rumah", style: body1()),
                      8.height,
                      TextFieldNoTitle(
                        minLines: 1,
                        maxLines: 2,
                        controller: address,
                        textInputType: TextInputType.text,
                        hint: "Isi alamat rumah",
                      ),
                      16.height,
                      Text("Tanggal Lahir", style: body1()),
                      8.height,
                      DropdownDatePicker(
                        dateformatorder: OrderFormat.DMY,
                        textStyle: body1(), // default is myd
                        inputDecoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        isDropdownHideUnderline: false,
                        isFormValidator: true,
                        startYear: 1900,
                        endYear: DateTime.now().year,
                        width: 4,
                        onChangedDay: (value) {
                          setState(() {
                            _selectedDay = int.parse(value!);
                          });
                        },
                        onChangedMonth: (value) {
                          setState(() {
                            _selectedMonth = int.parse(value!);
                          });
                        },
                        onChangedYear: (value) {
                          setState(() {
                            _selectedYear = int.parse(value!);
                          });
                        },
                        //boxDecoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey, width: 1.0)),
                        dayFlex: 3,
                        yearFlex: 4,
                        monthFlex: 5,
                        locale: "id_ID", // optional
                        hintDay: 'Tanggal', // optional
                        hintMonth: 'Bulan', // optional
                        hintYear: 'Tahun', // optional
                        hintTextStyle:
                            TextStyle(color: Colors.grey), // optional
                      ),
                      16.height,
                      Text("Jenis Kelamin", style: body1()),
                      8.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                          Text('Pria', style: TextStyle(fontSize: 16)),
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
                          Text('Wanita', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      16.height,
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ButtonSubmit(
                          onPressed: () async {
                            bool result =
                                await checkInternetConnectivity(context);

                            if (result) {
                              if (!isPhoneNumberValid(phoneNumber.text)) {
                                showToast("Nomor ponsel tidak valid");
                                return;
                              }
                              if (name.text.isNotEmpty &&
                                  phoneNumber.text.isNotEmpty) {
                                DateTime? date = _dateTime(_selectedDay,
                                    _selectedMonth, _selectedYear);
                                final data = <String, String>{
                                  'fullName': name.text,
                                  'address': address.text,
                                  'dob': date != null ? formatDate2(date) : "",
                                  'gender': _selectedGender,
                                  'phoneNumber': phoneNumber.text,
                                };
                                try {
                                  showDialogLoading(context);
                                  Map<String, dynamic> response =
                                      await profileServices()
                                          .updateProfile(data)
                                          .timeout(
                                            Duration(seconds: apiWaitTime),
                                          );
                                  finish(context);
                                  if (response['statusCode'] == 200) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Home()),
                                    );
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              } else {
                                showToast("Pastikan semua sudah terisi");
                              }
                            } else {
                              showToast("Cek koneksi internet anda");
                            }
                          },
                          height: 55,
                          child: Text(
                            "Simpan & Lanjutkan",
                            style: h3(color: white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
