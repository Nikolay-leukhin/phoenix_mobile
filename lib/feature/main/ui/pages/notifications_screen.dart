import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/main/bloc/notifications/notifications_cubit.dart';
import 'package:izobility_mobile/feature/main/data/notification_repository.dart';
import 'package:izobility_mobile/feature/main/ui/widgets/chips_category_list.dart';
import 'package:izobility_mobile/feature/main/ui/widgets/notifications_date_sector.dart';
import 'package:izobility_mobile/utils/utils.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:izobility_mobile/widgets/scaffold/home_scaffold.dart';
import 'package:sliver_tools/sliver_tools.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<NotificationsCubit>().loadNotifications();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notificationsRepository =
        RepositoryProvider.of<NotificationsRepository>(context);

    return HomeScaffold(
      appBar: CustomAppBar(
        isBack: true,
        text: 'Уведомления',
        context: context,
        onTap: () {
          context.pop();
        },
      ),
      body: Container(
        padding: const EdgeInsets.all(16).copyWith(bottom: 0),
        color: AppColors.purpleBcg,
        child: RefreshIndicator(
          onRefresh: () async {
            await BlocProvider.of<NotificationsCubit>(context)
                .loadNotifications();
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            controller: _scrollController,
            slivers: [
              SliverPersistentHeader(
                floating: true,
                pinned: false,
                delegate: ChipsCategoryList(),
              ),
              BlocBuilder<NotificationsCubit, NotificationsState>(
                buildWhen: (prev, cur) {
                  return cur is NotificationsLoadedSuccessState ||
                      prev is NotificationsInitial;
                },
                builder: (context, state) {
                  if (state is NotificationsLoadedSuccessState ||
                      state is NotificationsFiltersUpdated) {
                    return MultiSliver(
                      children: notificationsRepository.notificationsByDates
                          .map((e) =>
                              NotificationsDateSector(notificationsByDate: e))
                          .toList(),
                    );
                  } else if (state is NotificationsWaitingState) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Container();
                },
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
