import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izobility_mobile/utils/utils.dart';

class ProfileSwitchCard extends StatefulWidget {
  final String? iconPath;

  final String label;

  final String description;

  final bool switchMode;

  const ProfileSwitchCard({
    super.key,
    this.iconPath,
    required this.label,
    required this.description,
    this.switchMode = false,
  });

  @override
  State<ProfileSwitchCard> createState() => _ProfileSwitchCardState();
}

class _ProfileSwitchCardState extends State<ProfileSwitchCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (widget.iconPath != null)
            Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(widget.iconPath!)),
          SizedBox(
            width: widget.iconPath == null ? size.width * 0.722 : size.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: AppTypography.font16w500
                      .copyWith(color: AppColors.textPrimary, height: 1),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.description,
                  style: AppTypography.font12w400
                      .copyWith(color: AppColors.textSecondary),
                )
              ],
            ),
          ),
          const Spacer(),
          Switch.adaptive(
            value: widget.switchMode, onChanged: (v) {}
            )
        ],
      ),
    );
  }
}
