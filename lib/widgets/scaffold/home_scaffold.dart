import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold(
      {super.key,
      required this.body,
      required this.appBar,
      this.backgroundColor = AppColors.backgroundContent});

  final Widget body;
  final AppBar appBar;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar,
          body: body,
        ),
      ),
    );
  }
}
