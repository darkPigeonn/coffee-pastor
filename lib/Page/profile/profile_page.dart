// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/auth/auth_page.dart';
import 'package:flutter_coffee_application/Page/profile/detail_page.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/Button.dart';
import 'package:flutter_coffee_application/component/show_dialog.dart';
import 'package:flutter_coffee_application/resource/provider/auth/auth_provider.dart';
import 'package:flutter_coffee_application/resource/provider/profile_provider.dart';
import 'package:flutter_coffee_application/resource/services/api/auth/auth_services.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    ref.refresh(profileDataProvider.future);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(profileDataProvider);
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
            ),
            Text(
              "Akun",
              style: h1(),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          ref.watch(isLogin)
                              ? user.when(
                                  data: (data) {
                                    return InkWell(
                                      onTap: () async {
                                        DetailPage(
                                          user: data,
                                        ).launch(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                          decoration: BoxDecoration(
                                            color: primary,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                flex: 2,
                                                child: CircleAvatar(
                                                  backgroundImage:
                                                      NetworkImage(data.image),
                                                  radius: 30,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                flex: 8,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data.fullName
                                                          .capitalizeEachWord(),
                                                      style: h2(color: white),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    data.phoneNumber == ''
                                                        ? SizedBox()
                                                        : Text(
                                                            data.phoneNumber,
                                                            style: TextStyle(
                                                                color: white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  error: (error, e) => Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: IconButton(
                                            onPressed: () async {
                                              bool result =
                                                  await checkInternetConnectivity(
                                                      context);
                                              if (result) {
                                                await ref.refresh(
                                                    profileDataProvider.future);
                                              }
                                            },
                                            icon: Icon(Icons.refresh_rounded,
                                                color: primary),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  loading: () => Center(
                                    child: CircularProgressIndicator(
                                      color: primary,
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AuthPage()),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 70,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        color: primary,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Login ke akunmu sekarang",
                                            style: h2(color: Colors.white),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 16),
                          //   child: Container(
                          //     width: MediaQuery.of(context).size.width,
                          //     padding: EdgeInsets.symmetric(
                          //         horizontal: 16, vertical: 12),
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.all(
                          //         Radius.circular(10),
                          //       ),
                          //       color: white,
                          //       boxShadow: [
                          //         BoxShadow(
                          //           color: Colors.grey.withOpacity(0.5),
                          //           spreadRadius: 2,
                          //           blurRadius: 5,
                          //           offset: Offset(
                          //               0, 3), // changes position of shadow
                          //         ),
                          //       ],
                          //     ),
                          //     child: Row(
                          //       children: [
                          //         Flexible(
                          //           flex: 2,
                          //           child: CircleAvatar(
                          //             backgroundImage:
                          //                 AssetImage("assets/image/image1.jpg"),
                          //             radius: 30,
                          //           ),
                          //         ),
                          //         SizedBox(
                          //           width: 8,
                          //         ),
                          //         Expanded(
                          //           flex: 8,
                          //           child: Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               Text(
                          //                 "Diskon 50% menunggumu!",
                          //                 style: TextStyle(
                          //                     fontSize: 16,
                          //                     fontWeight: FontWeight.bold,
                          //                     color: primaryLight),
                          //               ),
                          //               Text(
                          //                 "Ajak teman kamu download aplikasi coffee shop",
                          //                 maxLines: 2,
                          //                 overflow: TextOverflow.ellipsis,
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      // Divider(
                      //   thickness: 10,
                      //   color: Colors.grey[200],
                      // ),
                      // SizedBox(
                      //   height: 8,
                      // ),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: Column(children: [
                      //     Container(
                      //       width: MediaQuery.of(context).size.width,
                      //       padding: EdgeInsets.symmetric(vertical: 6),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text("Alamat Tersimpan"),
                      //           Icon(
                      //             Icons.arrow_forward_ios_outlined,
                      //             size: 17,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Divider(),
                      //     Container(
                      //       width: MediaQuery.of(context).size.width,
                      //       padding: EdgeInsets.symmetric(vertical: 6),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text("Pembayaran"),
                      //           Icon(
                      //             Icons.arrow_forward_ios_outlined,
                      //             size: 17,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Divider(),
                      //     Container(
                      //       width: MediaQuery.of(context).size.width,
                      //       padding: EdgeInsets.symmetric(vertical: 6),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text("Pusat Bantuan"),
                      //           Icon(
                      //             Icons.arrow_forward_ios_outlined,
                      //             size: 17,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Divider(),
                      //     Container(
                      //       width: MediaQuery.of(context).size.width,
                      //       padding: EdgeInsets.symmetric(vertical: 6),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text("Pengaturan"),
                      //           Icon(
                      //             Icons.arrow_forward_ios_outlined,
                      //             size: 17,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Divider(),
                      //   ]),
                      // ),
                      // Container(
                      //   height: 10,
                      // ),
                      // Divider(
                      //   thickness: 10,
                      //   color: Colors.grey[200],
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 16),
                      //   child: Column(
                      //     children: [
                      //       Container(
                      //         width: MediaQuery.of(context).size.width,
                      //         padding: EdgeInsets.symmetric(vertical: 6),
                      //         child: Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text("Panduan Layanan"),
                      //             Icon(
                      //               Icons.arrow_forward_ios_outlined,
                      //               size: 17,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Divider(),
                      //       Container(
                      //         width: MediaQuery.of(context).size.width,
                      //         padding: EdgeInsets.symmetric(vertical: 6),
                      //         child: Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text("Kebijakan Privasi"),
                      //             Icon(
                      //               Icons.arrow_forward_ios_outlined,
                      //               size: 17,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Divider(),
                      //       Container(
                      //         width: MediaQuery.of(context).size.width,
                      //         child: Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text("Media Sosial"),
                      //             Row(
                      //               children: [
                      //                 IconSosMed(
                      //                   imagePath: "assets/logo/Instagram.png",
                      //                   onTap: () {},
                      //                 ),
                      //                 SizedBox(
                      //                   width: 5,
                      //                 ),
                      //                 IconSosMed(
                      //                   imagePath: "assets/logo/facebook.png",
                      //                   onTap: () {},
                      //                 ),
                      //                 SizedBox(
                      //                   width: 5,
                      //                 ),
                      //                 IconSosMed(
                      //                   imagePath: "assets/logo/youtube.png",
                      //                   onTap: () {},
                      //                 ),
                      //                 SizedBox(
                      //                   width: 5,
                      //                 ),
                      //                 IconSosMed(
                      //                   imagePath: "assets/logo/x.png",
                      //                   onTap: () {},
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Divider(),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Divider(
                      //   thickness: 10,
                      //   color: Colors.grey[200],
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 16,
                      //   ),
                      //   child: Text(
                      //     'Butuh Bantuan?',
                      //     style: TextStyle(
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 16,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 16,
                      //   ),
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     padding: EdgeInsets.symmetric(
                      //         horizontal: 16, vertical: 12),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.all(
                      //         Radius.circular(10),
                      //       ),
                      //       color: white,
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.grey.withOpacity(0.5),
                      //           spreadRadius: 2,
                      //           blurRadius: 5,
                      //           offset:
                      //               Offset(0, 3), // changes position of shadow
                      //         ),
                      //       ],
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         Flexible(
                      //           flex: 2,
                      //           child: Image.asset("assets/logo/whatsapp.png"),
                      //         ),
                      //         SizedBox(
                      //           width: 8,
                      //         ),
                      //         Expanded(
                      //           flex: 15,
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text(
                      //                 "coffee Shop Customer Service (chat only)",
                      //                 style: TextStyle(
                      //                   color: Colors.black,
                      //                   fontSize: 14,
                      //                 ),
                      //               ),
                      //               Text(
                      //                 "0812-0000-0000",
                      //                 style: TextStyle(
                      //                     color: Colors.green[700],
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         Flexible(
                      //           flex: 1,
                      //           child: Icon(
                      //             Icons.arrow_forward_ios_outlined,
                      //             size: 17,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Divider(
                      //   thickness: 10,
                      //   color: Colors.grey[200],
                      // ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Visibility(
                          visible: ref.watch(isLogin),
                          child: Button(
                            color: dangerDark,
                            width: MediaQuery.of(context).size.width - 32,
                            onPressed: () => warningDialog(context,
                                () async {
                              bool res =
                                  await checkInternetConnectivity(context);
                              if (res) {
                                showDialogLoading(context);
                                try {
                                  Map<String, dynamic> response =
                                      await AuthServices().logoutData();
                                  if (response["code"] == 200) {
                                    await AuthServices().signOut();
                                    await sp.remove("token");
                                    ref
                                        .watch(isLogin.notifier)
                                        .update((state) => false);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AuthPage()),
                                      (route) => false,
                                    );
                                  } else {
                                    // Handle logout failure
                                    print(
                                        "Logout failed: ${response["message"]}");
                                  }
                                } catch (e) {
                                  // Handle logout error
                                  print("Error during logout: $e");
                                }
                              }
                            }, "Keluar Akun",
                                "Apakah Anda yakin ingin keluar dari akun?"),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout_outlined,
                                  color: white,
                                  size: 32,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Keluar dari Akun",
                                      style: h3(color: white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Divider(
                      //   thickness: 10,
                      //   color: Colors.grey[200],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
