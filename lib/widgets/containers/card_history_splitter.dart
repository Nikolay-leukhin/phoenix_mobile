import 'package:flutter/material.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:intl/intl.dart';

class CardHistorySplitter extends StatelessWidget {
  const CardHistorySplitter({Key? key, required this.dateTime}) : super(key: key);

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: AppColors.backgroundSecondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CardHistorySubSplitter(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              textAlign: TextAlign.center,
              DateFormat("d MMMM y").format(dateTime),
            ),
          ),
          const CardHistorySubSplitter(),
        ],
      ),
    );
  }
}

class CardHistorySubSplitter extends StatelessWidget {
  const CardHistorySubSplitter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 36,
        height: 1,
        decoration: const BoxDecoration(
            color: AppColors.violetBlue
        ),
    );
  }
}

// Localizations.localeOf(context).languageCode для локального перевода месяцев
