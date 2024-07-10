// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:flutter_coffee_application/Page/admin/history_order.dart';
// import 'package:flutter_coffee_application/Page/admin/scan_qr.dart';
// import 'package:flutter_coffee_application/component/history.dart';
// import 'package:flutter_coffee_application/resource/provider/order_provider.dart';
// import 'package:flutter_coffee_application/style/typhography.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nb_utils/nb_utils.dart';

// import '../../style/color.dart';

// class HomeAdmin extends ConsumerStatefulWidget {
//   const HomeAdmin({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _HomeAdminState();
// }

// class _HomeAdminState extends ConsumerState<HomeAdmin> {
//   int _selectedIndex = 0;
//   final datad = false;

//   var screens = [
//     HomeAdminPage(),
//     ScanQr(),
//     HistoryOrderPage(),
//   ];

//   var listBottomNavigation = [
//     BottomNavigationBarItem(
//         icon: Icon(Icons.home), label: 'Home', backgroundColor: white),
//     BottomNavigationBarItem(
//         icon: Icon(Icons.qr_code_scanner_rounded),
//         label: 'Scan',
//         backgroundColor: white),
//     BottomNavigationBarItem(
//         icon: Icon(Icons.file_copy),
//         label: 'History Penjualan',
//         backgroundColor: white),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         unselectedItemColor: grey1,
//         items: listBottomNavigation,
//         currentIndex: _selectedIndex,
//         selectedItemColor: primary,
//         onTap: _onItemTapped,
//         showUnselectedLabels: true,
//       ),
//       body: screens[_selectedIndex],
//     );
//   }
// }

// class HomeAdminPage extends ConsumerStatefulWidget {
//   const HomeAdminPage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _HomeAdminPageState();
// }

// class _HomeAdminPageState extends ConsumerState<HomeAdminPage> {
//   @override
//   Widget build(BuildContext context) {
//     // today order provider
//     final todayOrder = ref.watch(todayOrderProvider);
//     return Scaffold(
//         body: Container(
//       color: grey3,
//       child: Column(
//         children: [
//           SizedBox(
//             height: 50,
//           ),
//           Text("Order Hari Ini", style: h1(color: primary),),
//           SizedBox(
//             height: 30,
//           ),
//           // Provider
//           todayOrder.when(
//             data: (todayOrderData) {
//               return Expanded(
//                 child: ListView.builder(
//                   itemCount: todayOrderData.length,
//                   itemBuilder: (context, index) {
//                     return Column(
//                       children: [
//                         Container(
//                             width: MediaQuery.of(context).size.width,
//                             padding: EdgeInsets.all(16),
//                             color: white,
//                             child:
//                                 HistoryOrder(modelOrder: todayOrderData[index])),
//                         index != index - 1
//                             ? SizedBox(
//                                 height: 20,
//                               )
//                             : SizedBox(),
//                       ],
//                     );
//                   },
//                 ),
//               );
//             },
//             error: (error, s) => Text(error.toString()),
//             loading: () => Center(
//               child: CircularProgressIndicator(),
//             ),
//           )
//         ],
//       ),
//     ));
//   }
// }
