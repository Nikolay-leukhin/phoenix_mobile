import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';

class ApplicationInfoText extends StatelessWidget {
  ApplicationInfoText(
      {Key? key, required this.paramName, required this.paramValue})
      : super(key: key);

  final String paramName;
  final String paramValue;

  final String points = '.' * 200;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          paramName,
          textAlign: TextAlign.left,
          style: AppTypography.font12w400.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Flexible(
          child: Text(
            points,
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: AppTypography.font14w400.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Text(
          paramValue,
          textAlign: TextAlign.right,
          style: AppTypography.font12w400.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
