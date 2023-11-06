import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/city/ui/widgets/history_item.dart';
import 'package:izobility_mobile/models/city_history_item.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';

class CityHistoryScreen extends StatefulWidget {
  const CityHistoryScreen({super.key});

  @override
  State<CityHistoryScreen> createState() => _CityHistoryScreenState();
}

class _CityHistoryScreenState extends State<CityHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        isBack: true,
        onTap: context.pop,
        text: 'История',
      ),
      body: Expanded(
        child: ListView.builder(
            itemBuilder: (ctx, ind) => HistoryItem(
                data: CityHistoryItem(
                    message: 'Там ещё кажется, провода как-то свисают странно',
                    images: [],
                    reward: 15,
                    fulfilled: ind % 2 == 0,
                    id: ind.toString()))),
      ),
    );
  }
}
