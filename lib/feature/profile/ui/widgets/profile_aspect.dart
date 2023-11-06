import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/utils.dart';


class ProfileAspect extends StatefulWidget {
  final String label;
  final String text;

  const ProfileAspect({super.key, required this.label, required this.text});

  @override
  State<ProfileAspect> createState() => _ProfileAspectState();
}

class _ProfileAspectState extends State<ProfileAspect> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: AppTypography.font16w500.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(widget.text,
                style: AppTypography.font12w400
                    .copyWith(color: AppColors.textSecondary))
          ],
        ),
      ),
    );
  }
}
