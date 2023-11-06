// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:izobility_mobile/feature/main/ui/widgets/notification_card_container.dart.dart';
// import 'package:izobility_mobile/models/notification.dart';
// import 'package:izobility_mobile/utils/logic/enums.dart';
// import 'package:izobility_mobile/utils/utils.dart';
//
//
//
// class NotificationCoinCard extends StatelessWidget {
//   final Notificatian data;
//   final NotificationPositionEnum pose;
//
//   const NotificationCoinCard({super.key, required this.data, required this.pose});
//
//   @override
//   Widget build(BuildContext context) {
//     return NotificationCardContainer(
//       pose: pose,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Flexible(
//                 child: Text(
//                   "${data.type == NotificationTransactionTypeEnum.get ? "Вы получили монеты в" : "Вы отправили монеты в"}  ${data.name.toUpperCase()}",
//                   style: AppTypography.font14w700.copyWith(
//                     color: AppColors.grey700,
//                   ),
//                   softWrap: true,
//                 ),
//               ),
//               Text(
//                 "${data.dateCreate.hour}:${data.dateCreate.minute}",
//                 style: AppTypography.font12w400
//                     .copyWith(color: AppColors.grey600),
//               )
//             ],
//           ),
//           const SizedBox(
//             height: 3,
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 '${data.count}',
//                 style: AppTypography.font20w700
//                     .copyWith(color: AppColors.primary),
//               ),
//               const SizedBox(
//                 width: 4,
//               ),
//               SvgPicture.asset(
//                 data.coinImagePath,
//                 width: 24.5,
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }