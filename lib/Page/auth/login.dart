// import 'package:flutter/material.dart';
// import 'package:flutter_coffee_application/Page/auth/signup.dart';
// import 'package:flutter_coffee_application/component/TextField.dart';
// import 'package:flutter_coffee_application/component/button.dart';
// import 'package:flutter_coffee_application/style/typhography.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import '../../style/color.dart';

// class LoginPage extends ConsumerStatefulWidget {
//   const LoginPage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
// }

// class _LoginPageState extends ConsumerState<LoginPage> {
//   final email = TextEditingController();
//   final pass = TextEditingController();
//   final emailNode = FocusNode();
//   final passNode = FocusNode();
//   bool validate = false;
//   bool enable = false;

//   @override
//   void initState() {
//     email.addListener(validateInputs);
//     pass.addListener(validateInputs);
//     emailNode.addListener(_onFocusChange);
//     passNode.addListener(_onFocusChange);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     email.dispose();
//     pass.dispose();
//     emailNode.removeListener(_onFocusChange);
//     passNode.removeListener(_onFocusChange);
//     super.dispose();
//   }

//   void validateInputs() {
//     if (email.text.isEmpty || pass.text.isEmpty) {
//       setState(() {
//         enable = false;
//       });
//     } else {
//       setState(() {
//         enable = true;
//       });
//     }
//   }

//   void _onFocusChange() {
//     debugPrint("Email Focus: ${emailNode.hasFocus.toString()}");
//     debugPrint("Pass Focus: ${passNode.hasFocus.toString()}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width,
//               color: grey3,
//               height: 120,
//               child: Stack(
//                 children: [
//                   Positioned(
//                     top: 10,
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     child: Align(
//                       child: Text(
//                         "Masuk",
//                         style: h2(color: primary),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 10,
//                     bottom: 0,
//                     left: 20,
//                     child: GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: Container(
//                         width: 25,
//                         height: 25,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: primary,
//                             width: 2.3,
//                           ),
//                         ),
//                         child: Icon(
//                           Icons.arrow_back_ios_rounded,
//                           color: primary,
//                           size: 16,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: (Container(
//                 margin: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 20,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Masukkan email",
//                       style: h2(color: primary),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     LoginTextField(
//                       focus: emailNode,
//                       controller: email,
//                       textInputType: TextInputType.emailAddress,
//                       error: validate ? "belum diisi" : null,
//                       hint: "email",
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       "Masukkan password",
//                       style: h2(color: primary),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     LoginTextField(
//                       focus: passNode,
//                       controller: pass,
//                       textInputType: TextInputType.text,
//                       error: validate ? "belum diisi" : null,
//                       hint: "password",
//                     ),
//                     const SizedBox(
//                       height: 65,
//                     ),
//                     ButtonSubmit(
//                       enable: enable,
//                       onPressed: () {
//                         setState(() {
//                           validate = email.text.isEmpty;
//                           validate = pass.text.isEmpty;
//                         });
//                       },
//                       width: MediaQuery.of(context).size.width - 40,
//                       height: 55,
//                       child: Text(
//                         "Lanjutkan",
//                         style: h3(color: white),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Belum mendaftar?",
//                           style: paragraf(color: primaryPastel),
//                         ),
//                         TextButton(
//                           style: TextButton.styleFrom(
//                               foregroundColor: white),
//                           child: Text(
//                             "Buat akun di sini!",
//                             style: h3(
//                               color: primary,
//                             ),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               PageTransition(
//                                   child: SignUp(googleSignIn: false,),
//                                   type: PageTransitionType.rightToLeft),
//                             );
//                           },
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
