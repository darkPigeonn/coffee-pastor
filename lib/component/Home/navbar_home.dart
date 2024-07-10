import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_coffee_application/Page/booking/booking.dart';
import 'package:flutter_coffee_application/Page/home.dart';
import 'package:flutter_coffee_application/Page/profile/profile_page.dart';
import 'package:flutter_coffee_application/Page/scan.dart';
import 'package:flutter_coffee_application/Page/store/store_page.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final users = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;

  var screens = [
    HomePage(),
    StorePage(),
    QRCode(),
    BookingPage(),
    ProfilePage(),
  ];

  var screensNotLogin = [
    HomePage(),
    StorePage(),
    BookingPage(),
    ProfilePage(),
  ];

  var listBottomNavigation = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home), label: 'Home', backgroundColor: white),
    BottomNavigationBarItem(
        icon: Icon(Icons.corporate_fare_rounded),
        label: 'Store',
        backgroundColor: white),
    BottomNavigationBarItem(
        icon: Icon(Icons.star), label: 'Reward', backgroundColor: white),
    BottomNavigationBarItem(
        icon: Icon(Icons.file_copy), label: 'Reservasi', backgroundColor: white),
    BottomNavigationBarItem(
        icon: Icon(Icons.person), label: 'Akun', backgroundColor: white),
  ];

  var listBottomNavigationNotLogin = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home), label: 'Home', backgroundColor: white),
    BottomNavigationBarItem(
        icon: Icon(Icons.discount), label: 'Store', backgroundColor: white),
    BottomNavigationBarItem(
        icon: Icon(Icons.file_copy), label: 'Reservasi', backgroundColor: white),
    BottomNavigationBarItem(
        icon: Icon(Icons.person), label: 'Akun', backgroundColor: white),
  ];

  List<BottomNavigationBarItem> getBottomNavigationItems(bool isLoggedIn) {
    return isLoggedIn ? listBottomNavigation : listBottomNavigationNotLogin;
  }

  List<Widget> getScreens(bool isLoggedIn) {
    return isLoggedIn ? screens : screensNotLogin;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn = users != null;
    final bottomNavigationItems = getBottomNavigationItems(isUserLoggedIn);
    final currentScreens = getScreens(isUserLoggedIn);

    return Scaffold(
      body: currentScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primary,
        unselectedItemColor: grey1,
        showUnselectedLabels: true,
        selectedLabelStyle: body1(),
        unselectedLabelStyle: body1(),
        items: bottomNavigationItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
