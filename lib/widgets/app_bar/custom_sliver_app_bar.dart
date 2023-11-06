import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_sliver_app_bar_delegate.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar(
      {super.key,
      required this.height,
      this.color = AppColors.purple100,
      this.isInfo = false,
      required this.isBack,
      required this.title,
      this.isSetting = false,
      this.onTapRightIcon});

  final double height;
  final Color color;
  final bool isBack;
  final String title;
  final bool isInfo;
  final bool isSetting;
  final Function()? onTapRightIcon;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: SliverAppBarDelegate(
        minHeight: height,
        maxHeight: height,
        child: Container(
          color: color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isBack) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 24,
                      )),
                ),
              ] else ...[
                const SizedBox(
                  height: 24,
                  width: 55,
                )
              ],
              Text(title,
                  style: AppTypography.font18w700
                      .copyWith(color: AppColors.textPrimary)),
              if (isInfo) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: onTapRightIcon ??
                          () {
                            context.push(RouteNames.walletInfoCurrency);
                          },
                      icon: Icon(
                        !isSetting ? Icons.info_outline : Icons.settings,
                        size: 24,
                        color: Colors.black,
                      )),
                ),
              ] else ...[
                const SizedBox(
                  height: 24,
                  width: 55,
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
