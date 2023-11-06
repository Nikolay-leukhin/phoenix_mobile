import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class OutLineTextField extends StatelessWidget {
  final double width;
  final double height;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyBoardType;
  final bool obscureText;
  final int maxLines;
  final int? maxLength;
  final ValueChanged<String>? onChange;
  final String icon;
  final Function() onTapSuffixIcon;

  const OutLineTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.width = 290,
      this.height = 50,
      this.obscureText = false,
      this.maxLines = 1,
      this.maxLength,
      this.keyBoardType = TextInputType.text,
      this.onChange,
      this.icon = "",
      required this.onTapSuffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: Colors.grey)),
      child: TextFormField(
        maxLines: maxLines,
        maxLength: maxLength,
        onChanged: onChange ?? (value) {},
        style: AppTypography.font16w400.copyWith(color: Colors.black),
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          counterText: '',
          hintText: hintText,
          hintStyle: AppTypography.font16w400.copyWith(color: Colors.grey),
          suffixIcon: icon != ""
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: onTapSuffixIcon,
                          child: SvgPicture.asset(
                            icon,
                            width: 24,
                            height: 24,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : null,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        controller: controller,
      ),
    );
  }
}
