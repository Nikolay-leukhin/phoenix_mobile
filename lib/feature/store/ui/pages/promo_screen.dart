// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:izobility_mobile/feature/store/ui/widgets/profuct_my_coin_quantity.dart';
// import 'package:izobility_mobile/feature/store/ui/widgets/store_item_quantity_container.dart';
// import 'package:izobility_mobile/feature/store/ui/widgets/store_price_container.dart';
// import 'package:izobility_mobile/localization/app_localizations.dart';
// import 'package:izobility_mobile/utils/ui/colors.dart';
// import 'package:izobility_mobile/utils/ui/fonts.dart';
// import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
// import 'package:izobility_mobile/widgets/button/custom_button.dart';
// import 'package:izobility_mobile/widgets/scaffold/home_scaffold.dart';

// class PromoScreen extends StatefulWidget {
//   const PromoScreen({super.key});

//   @override
//   State<PromoScreen> createState() => _PromoScreenState();
// }

// class _PromoScreenState extends State<PromoScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final localize = AppLocalizations.of(context)!;

//     return HomeScaffold(
//       appBar: CustomAppBar(
//         context: context,
//         text: localize.promo_codes,
//         isBack: true,
//         onTap: () {
//           context.pop();
//         },
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Промокод на бесплатный бургер в ресторанах Burger King",
//                 style: AppTypography.font20w700.copyWith(color: Colors.black),
//                 textAlign: TextAlign.start,
//               ),
//               const SizedBox(height: 16),
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: AppColors.disableButton,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   children: [
//                     Text(
//                       "Ваш промокод",
//                       style: AppTypography.font14w700
//                           .copyWith(color: AppColors.grey500),
//                     ),
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     Container(
//                       width: 100,
//                       height: 18,
//                       decoration: BoxDecoration(
//                         color: AppColors.grey500,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),
//                StorePriceContainer(
                
//                ),
//               const SizedBox(
//                 height: 4,
//               ),
//               const StoreItemQuantityContainer(
//                 itemsLost: 0,
//                 itemsAll: 5,
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               Text(
//                 "У вас есть",
//                 style: AppTypography.font18w700.copyWith(color: Colors.black),
//               ),
//               ProductMyCoinQuantity(
//                 imagePath: 'assets/icons/coin.svg',
//                 quantity: 900,
//               ),
//               ProductMyCoinQuantity(
//                 imagePath: 'assets/icons/coin.svg',
//                 quantity: 900,
//               ),
//               ProductMyCoinQuantity(
//                 imagePath: 'assets/icons/coin.svg',
//                 quantity: 900,
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               CustomButton(
//                   isActive: false,
//                   text: "Получить",
//                   onTap: () {},
//                   width: double.infinity),
//               const SizedBox(
//                 height: 8,
//               ),
//               CustomButton(
//                   isActive: true,
//                   text: "Купить монет",
//                   onTap: () {},
//                   width: double.infinity),
//               const SizedBox(
//                 height: 16,
//               ),
//               Text(
//                 'Описание',
//                 style: AppTypography.font18w700.copyWith(color: Colors.black),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "Есть над чем задуматься: предприниматели в сети интернет лишь добавляют фракционных разногласий и ассоциативно распределены по отраслям. В целом, конечно, постоянное информационно-пропагандистское обеспечение нашей деятельности способствует повышению качества анализа существующих паттернов поведения.",
//                 style:
//                     AppTypography.font12w400.copyWith(color: AppColors.grey500),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

