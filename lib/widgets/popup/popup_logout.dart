import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class PopupChoose extends StatefulWidget {
  final Function onAccept;
  final Function onDecline;
  final String label;
  final String? description;

  const PopupChoose(
      {super.key,
      required this.onAccept,
      required this.onDecline,
      required this.label,
      this.description});

  @override
  State<PopupChoose> createState() => _PopupChooseState();
}

class _PopupChooseState extends State<PopupChoose> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Dialog(
      insetPadding: EdgeInsets.zero,
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              width: size.width * 0.872,
              constraints: const BoxConstraints(minHeight: 164),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: size.width * 0.55),
                    child: Column(
                      children: [
                        Text(
                          widget.label,
                          style:
                              AppTypography.font18w700.copyWith(color: Colors.black),
                        ),
                        if (widget.description != null)
                          Text(
                            widget.description!,
                            style: AppTypography.font12w400
                                .copyWith(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 296),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PopupActionButton(
                          isDark: true,
                          onTap: () {
                            widget.onDecline();
                          },
                          color: AppColors.primary,
                          text: "Нет",
                          width: size.width * 0.35,
                        ),
                        PopupActionButton(
                          isDark: false,
                          onTap: () {
                            widget.onAccept();
                          },
                          color: AppColors.primary,
                          text: "Да",
                          width: size.width * 0.35,
                        )
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}

class PopupActionButton extends StatelessWidget {
  final Function onTap;
  final Color color;
  final String text;
  final double width;
  final bool isDark;

  const PopupActionButton(
      {super.key,
      required this.onTap,
      required this.color,
      required this.text,
      required this.width,
      required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark ? color : Colors.transparent,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: isDark
                ? null
                : Border.all(width: 1, color: AppColors.disableButton),
          ),
          constraints: const BoxConstraints(maxWidth: 140),
          height: 40,
          alignment: Alignment.center,
          width: width,
          child: Text(
            text,
            style: AppTypography.font16w500
                .copyWith(color: isDark ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
