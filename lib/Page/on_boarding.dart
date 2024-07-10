// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/Button.dart';
import 'package:flutter_coffee_application/component/Home/navbar_home.dart';
import 'package:flutter_coffee_application/component/Icon.dart';
import 'package:flutter_coffee_application/component/show_dialog.dart';
import 'package:flutter_coffee_application/resource/services/api/auth/auth_services.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../style/typhography.dart';

class OnBoarding extends ConsumerStatefulWidget {
  const OnBoarding({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnBoardingState();
}

class _OnBoardingState extends ConsumerState<OnBoarding> {
  final List<String> imageList = [
    'assets/image/ver1.jpeg',
    'assets/image/ver2.jpeg',
    'assets/image/ver3.jpeg',
  ];
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          color: primary,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Builder(
                builder: (context) {
                  final double height = MediaQuery.of(context).size.height;
                  return CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      height: height,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                    ),
                    items: imageList
                        .map((item) => Container(
                              child: Center(
                                  child: Image.asset(
                                item,
                                fit: BoxFit.cover,
                                height: height,
                              )),
                            ))
                        .toList(),
                  );
                },
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [
                        0.1,
                        0.2,
                        0.3,
                        0.7,
                      ],
                      colors: [
                        white.withOpacity(0),
                        white.withOpacity(0.3),
                        white.withOpacity(0.7),
                        white,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Button(
                      width: MediaQuery.of(context).size.width - 32,
                      color: primary,
                      onPressed: () async {
                        showDialogLoading(context);
                        await AuthServices().signInWithGoogle();
                        context.pop();
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage("assets/logo/google.png"),
                            radius: 16,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "Masuk dengan Google",
                                style: h3(color: white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    12.height,
                    Button(
                      width: MediaQuery.of(context).size.width - 32,
                      color: primary,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                            (route) => false);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.people_alt,
                            color: white,
                            size: 32,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "Masuk sebagai Tamu",
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
            ],
          ),
        ),
      ),
    );
  }
}
