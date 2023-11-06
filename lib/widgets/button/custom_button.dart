import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class CustomButton extends StatefulWidget {
  final String text;

  final VoidCallback onTap;

  final double width;
  final double height;

  final bool isActive;

  final double radius;

  final Color color;

  final bool withBorder;

  Gradient? gradient;

  final double fontSize;

  final Color textColor;

  CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.width,
      this.isActive = true,
      this.withBorder = true,
      this.height = 55,
      this.radius = 12,
      this.gradient,
      this.fontSize = 16,
      this.textColor = Colors.white,
      this.color = AppColors.primary});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          gradient: widget.gradient,
          borderRadius: BorderRadius.circular(widget.radius),
          border: Border.all(
              width: widget.withBorder ? 0.50 : 0,
              color: widget.isActive ? AppColors.primary : AppColors.disable),
        ),
        child: TextButton(
            onPressed: widget.isActive ? widget.onTap : () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
                backgroundColor: widget.gradient == null
                    ? widget.isActive
                        ? widget.color
                        : AppColors.disableButton
                    : Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.radius))),
            child: Text(widget.text,
                style: AppTypography.font16w600
                    .copyWith(color: widget.textColor, fontSize: widget.fontSize))));
  }
}
