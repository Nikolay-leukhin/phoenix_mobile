import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izobility_mobile/feature/main/bloc/notifications/notifications_cubit.dart';
import 'package:izobility_mobile/feature/main/data/notification_repository.dart';
import 'package:izobility_mobile/feature/main/ui/widgets/chip_category_card.dart';
import 'package:izobility_mobile/utils/utils.dart';

class ChipsCategoryList extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final categoryFilterList =
        context.read<NotificationsRepository>().filterCategories;
    final currentIndex =
        context.read<NotificationsRepository>().currentFilterIndex;

    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.bottomLeft,
          height: double.infinity,
          color: AppColors.purpleBcg,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
            itemBuilder: ((context, index) => ChipCategoryCard(
                  index: index,
                  text: categoryFilterList[index],
                  isActive: currentIndex == index,
                )),
            itemCount: categoryFilterList.length,
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => 28;

  @override
  double get minExtent => 28;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
