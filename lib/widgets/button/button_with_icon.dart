import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class CustomButtonWithIcon extends StatefulWidget {
  final String text;

  final VoidCallback onTap;

  final double width;
  final double height;

  final bool isActive;

  final double radius;

  final Color color;

  final Color textColor;
  final String asset;

  CustomButtonWithIcon(
      {super.key,
        required this.text,
        required this.onTap,
        required this.width,
        this.isActive = true,
        this.height = 55,
        this.radius = 12,
        this.textColor = Colors.black,
        this.color = Colors.white,
        required this.asset});

  @override
  State<CustomButtonWithIcon> createState() => _CustomButtonWithIconState();
}

class _CustomButtonWithIconState extends State<CustomButtonWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        child: TextButton(
            onPressed: widget.isActive ? widget.onTap : () {},
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor:widget.color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.radius))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  widget.asset,
                  width: 24,
                  height: 24,
                  color: Colors.black,
                ),
                const SizedBox(width: 8,),
                Text(widget.text,
                    style: AppTypography.font12w400.copyWith(
                        color: widget.isActive ? widget.textColor : AppColors.grey400)),
              ],
            )));
  }
}