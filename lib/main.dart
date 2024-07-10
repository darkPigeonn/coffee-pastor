// ignore_for_file: avoid_print, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_coffee_application/Page/splash_screen.dart';
import 'package:flutter_coffee_application/firebase_options.dart';
import 'package:flutter_coffee_application/resource/services/notification_services.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
// import 'package:package_info_plus/package_info_plus.dart';

import 'resource/const_db.dart';

const kWindowsScheme = 'sample';
late SharedPreferences sp;
// late PackageInfo packageInfo;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeSharedPreferences();
  await Firebase.initializeApp(
    name: "imavistatic",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initFCM();
  await initSQLiteDB();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // packageInfo = await PackageInfo.fromPlatform();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    name: "imavistatic",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (message.notification != null) {
    print('Handling a background message: ${message.notification}');
  }
}

Future<void> initializeSharedPreferences() async {
  sp = await SharedPreferences.getInstance();
}

Future<void> initSQLiteDB() async {
  userCartDB = await openDatabase(
    join(await getDatabasesPath(), 'cart_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE carts(cartId TEXT PRIMARY KEY, productId TEXT, productName TEXT, productImages TEXT, quantities INTEGER, subtotal INTEGER, description TEXT)',
      );
    },
    version: 1,
  );
}

// void _registerWindowsProtocol() {
//   if (!kIsWeb) {
//     if (Platform.isWindows) {
//       // registerProtocolHandler(kWindowsScheme);
//     }
//   }
// }

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // final _navigatorKey = GlobalKey<NavigatorState>();
  // late AppLinks _appLinks;
  // StreamSubscription<Uri>? _linkSubscription;

  // @override
  // void initState() {
  //   super.initState();
  //   initDeepLinks();
  // }

  // @override
  // void dispose() {
  //   _linkSubscription?.cancel();
  //   super.dispose();
  // }

  // Future<void> initDeepLinks() async {
  //   _appLinks = AppLinks();

  //   // Handle initial deep links
  //   final initialUri = await _appLinks.getInitialLink();
  //   if (initialUri != null) {
  //     openAppLink(initialUri);
  //   }

  //   // Listen for incoming deep links
  //   _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
  //     if (uri != null) {
  //       print('onAppLink: $uri');
  //       openAppLink(uri);
  //     }
  //   });
  // }

  // void openAppLink(Uri uri) {
  //   _navigatorKey.currentState?.pushNamed(uri.fragment);
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: transparentColor,
      statusBarBrightness: Brightness.dark,
    ));
    return MaterialApp(
      // navigatorKey: _navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        progressIndicatorTheme: ProgressIndicatorThemeData(color: primary),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: primary,
          ),
          hintStyle: body3(color: primary),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryDark,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primary, width: 3),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(primary),
            foregroundColor: MaterialStateProperty.all<Color>(white),
          ),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all<Color>(primary),
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: primary,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          iconTheme: IconThemeData(
            color: white,
          ),
          elevation: 4,
          surfaceTintColor: white,
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        Widget routeWidget = defaultScreen();

        final routeName = settings.name;
        if (routeName != null) {
          if (routeName.startsWith('/book/')) {
            routeWidget = customScreen(
              routeName.substring(routeName.indexOf('/book/')),
            );
          } else if (routeName == '/book') {
            routeWidget = customScreen("None");
          }
        }

        return MaterialPageRoute(
          builder: (context) => routeWidget,
          settings: settings,
          fullscreenDialog: true,
        );
      },
      home: SplashScreenPage(),
    );
  }

  Widget defaultScreen() {
    return Scaffold(
      appBar: AppBar(title: const Text('Default Screen')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SelectableText('''
            Launch an intent to get to the second screen.

            On web:
            http://localhost:<port>/#/book/1 for example.

            On windows & macOS, open your browser:
            sample://foo/#/book/hello-deep-linking

            This example code triggers new page from URL fragment.
            '''),
            const SizedBox(height: 20),
            // buildWindowsUnregisterBtn(),
          ],
        ),
      ),
    );
  }

  Widget customScreen(String bookId) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Center(child: Text('Opened with parameter: $bookId')),
    );
  }

  // Widget buildWindowsUnregisterBtn() {
  //   if (!kIsWeb) {
  //     if (Platform.isWindows) {
  //       return TextButton(
  //           onPressed: () => unregisterProtocolHandler(kWindowsScheme),
  //           child: const Text('Remove Windows protocol registration'));
  //     }
  //   }
  //   return const SizedBox.shrink();
  // }
}
