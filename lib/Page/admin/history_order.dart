// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:flutter_coffee_application/resource/provider/order_provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nb_utils/nb_utils.dart';

// import '../../component/history.dart';
// import '../../style/color.dart';
// import '../../style/typhography.dart';

// class HistoryOrderPage extends ConsumerStatefulWidget {
//   const HistoryOrderPage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _HistoryOrderPageState();
// }

// class _HistoryOrderPageState extends ConsumerState<HistoryOrderPage> {
//   @override
//   Widget build(BuildContext context) {
//     // all order provider
//     final todayOrder = ref.watch(allOrderProvider);
//     return Scaffold(
//         body: Container(
//       color: grey3,
//       child: Column(
//         children: [
//           SizedBox(
//             height: 50,
//           ),
//           Text("History Penjualan", style: h1(color: primary),),
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
