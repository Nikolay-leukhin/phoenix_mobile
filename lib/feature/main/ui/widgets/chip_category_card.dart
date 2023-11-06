import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izobility_mobile/feature/main/bloc/notifications/notifications_cubit.dart';
import 'package:izobility_mobile/feature/main/data/notification_repository.dart';
import 'package:izobility_mobile/utils/utils.dart';

class ChipCategoryCard extends StatefulWidget {
  final String text;
  final bool isActive;
  final int index;

  const ChipCategoryCard(
      {super.key,
      required this.text,
      required this.isActive,
      required this.index});

  @override
  State<ChipCategoryCard> createState() => _ChipCategoryCardState();
}

class _ChipCategoryCardState extends State<ChipCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // context.read<NotificationsCubit>().changeFilterCategory(widget.index);
        // log(context
        //     .read<NotificationsRepository>()
        //     .currentFilterIndex
        //     .toString());
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: widget.isActive ? AppColors.primary : Colors.white),
        child: Text(
          widget.text,
          style: AppTypography.font12w700.copyWith(
              color: widget.isActive ? Colors.white : AppColors.grey600),
        ),
      ),
    );
  }
}
