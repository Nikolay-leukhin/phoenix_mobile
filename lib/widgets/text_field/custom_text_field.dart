import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.hintText,
      required this.controller,
      this.mask,
      required this.width,
      this.keyboardType,
      this.labelText,
      this.obscured = false,
      this.onChange,
      this.error = false,
      this.errorText,
      this.backgroundColor = AppColors.backgroundSecondary,
      this.suffixIcon,
      this.suffixIconCallback,
      this.secondSuffixIconCallback,
      this.readOnly = false,
      this.height = 56});

  CustomTextField.password({
    super.key,
    this.hintText,
    required this.controller,
    this.mask,
    required this.width,
    this.labelText,
    this.onChange,
    required this.obscured,
    this.error = false,
    this.errorText,
    this.backgroundColor = AppColors.backgroundSecondary,
    this.height = 56,
    this.readOnly = false,
    required this.suffixIconCallback,
    this.secondSuffixIconCallback,
  })  : keyboardType = TextInputType.number,
        suffixIcon = Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SuffixIconPassword(
              callback: suffixIconCallback!,
              visible: !obscured,
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        );

  CustomTextField.withTwoIcon({
    super.key,
    this.hintText,
    this.mask,
    required this.controller,
    required this.width,
    required this.suffixIconCallback,
    required this.secondSuffixIconCallback,
    this.labelText,
    this.onChange,
    this.error = false,
    this.errorText,
    this.backgroundColor = AppColors.backgroundSecondary,
    this.height = 56,
    this.readOnly = false,
    this.obscured = true,
  })  : keyboardType = TextInputType.visiblePassword,
        suffixIcon = Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: suffixIconCallback!,
                child: SvgPicture.asset('assets/icons/scaner.svg')),
            const SizedBox(
              width: 4,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                  onTap: secondSuffixIconCallback!,
                  child: SvgPicture.asset('assets/icons/clipboard.svg')),
            )
          ],
        );

  CustomTextField.withOneIcon({
    super.key,
    this.hintText,
    this.mask,
    required this.controller,
    this.keyboardType,
    required this.width,
    required this.suffixIconCallback,
    Widget? suffixIconChild,
    this.secondSuffixIconCallback,
    this.labelText,
    this.onChange,
    this.error = false,
    this.errorText,
    this.backgroundColor = AppColors.backgroundSecondary,
    this.height = 56,
    this.readOnly = false,
    this.obscured = true,
  }) : suffixIcon = Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: suffixIconCallback,
                child: suffixIconChild ??
                    const CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.primary,
                    ),
              ),
            ),
          ],
        );

  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final double width;
  final double height;
  final String? labelText;
  final bool obscured;
  final bool error;
  final String? errorText;
  final VoidCallback? suffixIconCallback;
  final VoidCallback? secondSuffixIconCallback;
  final Widget? suffixIcon;
  final Function(String?)? onChange;
  final Color backgroundColor;
  final MaskTextInputFormatter? mask;
  final bool readOnly;

  final Color _negative = AppColors.negative;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              
              maxLines: 1,
              readOnly: readOnly,
              inputFormatters: mask == null ? [] : [mask!],
              obscureText: obscured,
              onChanged: onChange,
              style: AppTypography.font16w400.copyWith(color: Colors.black),
              decoration: InputDecoration(
                isDense: true,
                  fillColor: backgroundColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColors.disableButton,
                    ),
                  ),
                  suffixIcon: suffixIcon,
                  suffixIconConstraints:
                      const BoxConstraints(maxHeight: 45, maxWidth: 70),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      )),
                  labelText: labelText,
                  labelStyle: AppTypography.font16w400
                      .copyWith(color: AppColors.hintText),
                  floatingLabelStyle: AppTypography.font12w400
                      .copyWith(color: error ? _negative : Colors.black),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  hintText: hintText ?? labelText,
                  hintStyle: AppTypography.font16w400
                      .copyWith(color: AppColors.hintText),
                      ),
              keyboardType: keyboardType,
              controller: controller,
            ),
          ),
          if (error) ...[
            Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                Text(
                  '* ${errorText!}',
                  style: AppTypography.font14w400.copyWith(color: _negative),
                )
              ],
            )
          ]
        ],
      ),
    );
  }
}

class SuffixIconPassword extends StatelessWidget {
  const SuffixIconPassword(
      {super.key, required this.callback, required this.visible});

  final VoidCallback callback;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.all(8),
        width: 40,
        height: 40,
        child: SvgPicture.asset(
          'assets/icons/eye.svg',
          width: 24,
          height: 24,
          //color: visible ? AppColors.primary : const Color(0xff757575),
          colorFilter: ColorFilter.mode(
              visible ? AppColors.primary : AppColors.disabledTextButton,
              BlendMode.srcIn),
        ),
      ),
    );
  }
}
