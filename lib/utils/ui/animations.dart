import 'package:flutter/material.dart';

import '../utils.dart';

class AppAnimations {
  static const circularProgressIndicator = SizedBox(
    width: 44,
    height: 44,
    child: CircularProgressIndicator(
      color: AppColors.primary,
      strokeWidth: 3,
    ),
  );
}