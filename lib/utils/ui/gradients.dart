import 'package:flutter/material.dart';
import 'package:phoenix_mobile/utils/ui/colors.dart';

abstract class AppGradients {
  static const gradientBlueWhite = LinearGradient(
    end: Alignment(0.96, 0.27),
    begin: Alignment(-0.96, -0.27),
    colors: [Color(0xFF48BDFF), Color(0xFF0084FF)],
  );

  static const gradientGreenDark = LinearGradient(
      begin: Alignment(-0.12, 0.99),
      end: Alignment(0.12, -0.99),
      colors: [
        Color(0xff3FCA3B),
        Color(0xff2FC294),
      ]);

  static final gradientWhiteGray = LinearGradient(
    begin: const Alignment(-0.12, 0.99),
    end: const Alignment(0.12, -0.99),
    colors: [
      Colors.black.withOpacity(0.6499999761581421),
      Colors.black.withOpacity(0)
    ],
  );

  static const gradientBlackGrey = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.black, AppColors.switcherBackground]);

  static const shrek = LinearGradient(
    end: Alignment(0.98, -0.18),
    begin: Alignment(-0.98, 0.18),
    colors: [Color(0xFF2F9B67), Color(0xFF0D4128)],
  );

  static const accentGreen = LinearGradient(
    begin: Alignment(0.96, 0.28),
    end: Alignment(-0.96, -0.28),
    colors: [Color(0xFF48BDFF), Color(0xFF0084FF)],
  );

  static const purple = LinearGradient(
    end: Alignment(0.96, 0.27),
    begin: Alignment(-0.96, -0.27),
    colors: [Color(0xFF783996), Color(0xFFA946D8)],
  );
}
