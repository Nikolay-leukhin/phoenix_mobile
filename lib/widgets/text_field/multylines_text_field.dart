import 'package:flutter/material.dart';
import 'package:phoenix_mobile/utils/utils.dart';

class MultilineTextField extends StatelessWidget {
  const MultilineTextField({super.key, required this.controller, this.onChange, this.readOnly = false, this.initialText});

  final TextEditingController controller;
  final bool readOnly;
  final Function(String)? onChange;
  final String? initialText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120 * MediaQuery.sizeOf(context).width / 360,
      child: TextFormField(
        initialValue: initialText,
        maxLines: 5,
        readOnly: readOnly,
        onChanged: onChange,
        decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(16),
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: AppColors.grey200,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: AppColors.grey200,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: AppColors.grey200,
              ),
            ),
            hintText: 'Ваше сообщение тут',
            hintStyle: AppTypography.font16w400
                .copyWith(color: AppColors.hintText)),
      ),
    );
  }
}
