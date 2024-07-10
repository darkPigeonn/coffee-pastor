// import 'package:flutter/material.dart';

// class CustomCarouselIndicator extends StatelessWidget {
//   final int itemCount;
//   final int currentIndex;
//   final Color currentIndicatorColor;
//   final Color indicatorBackgroundColor;
//   final double indicatorWidth;
//   final double indicatorHeight;
//   final double indicatorSpacing;
//   final double circleIndicatorSize;

//   const CustomCarouselIndicator({
//     required this.itemCount,
//     required this.currentIndex,
//     this.currentIndicatorColor = Colors.black,
//     this.indicatorBackgroundColor = Colors.grey,
//     this.indicatorWidth = 50,
//     this.indicatorHeight = 5,
//     this.indicatorSpacing = 5,
//     this.circleIndicatorSize = 8,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(itemCount, (index) {
//         bool isCurrentPage = index == currentIndex;
//         return Container(
//           width: isCurrentPage ? indicatorWidth : circleIndicatorSize,
//           height: indicatorHeight,
//           margin: EdgeInsets.symmetric(horizontal: indicatorSpacing / 2),
//           decoration: BoxDecoration(
//             color: isCurrentPage ? currentIndicatorColor : indicatorBackgroundColor,
//             borderRadius: BorderRadius.circular(isCurrentPage ? 0 : 50),
//           ),
//         );
//       }),
//     );
//   }
// }
