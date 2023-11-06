import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    required context,
    required String text,
    Function()? onTap,
    required bool isBack,
    List<Widget>? actions,
    Color backgroundColor = Colors.white,
    bottom
  }) : super(
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.transparent,
          titleSpacing: 12,
          backgroundColor: backgroundColor,
          centerTitle: true,
          actions: actions,
          bottom: bottom,
          leading: isBack
              ? InkWell(
                  onTap: onTap,
                  child: Container(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "assets/icons/back.svg",
                        width: 24,
                        height: 24,
                        color: Colors.black,
                      )),
                )
              : null,
          title: Text(
            text,
            style: AppTypography.font16w700.copyWith(color: Colors.black),
          ),
        );
}
