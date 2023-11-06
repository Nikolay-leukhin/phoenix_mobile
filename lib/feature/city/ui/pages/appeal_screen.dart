import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:phoenix_mobile/feature/city/data/city_repository.dart';
import 'package:phoenix_mobile/models/city_history_item.dart';
import 'package:phoenix_mobile/utils/ui/colors.dart';
import 'package:phoenix_mobile/utils/ui/fonts.dart';
import 'package:phoenix_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:phoenix_mobile/widgets/text_field/multylines_text_field.dart';

class CityAppealScreen extends StatefulWidget {
  const CityAppealScreen({super.key, required this.id});

  final String id;

  @override
  State<CityAppealScreen> createState() => _CityAppealScreenState();
}

class _CityAppealScreenState extends State<CityAppealScreen> {
  late final CityHistoryItem appeal;

  @override
  void initState() {
    appeal =
        RepositoryProvider.of<CityRepository>(context).getAppeal(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const separateHeight8 = SliverToBoxAdapter(
      child: SizedBox(
        height: 8,
      ),
    );
    const separateHeight16 = SliverToBoxAdapter(
      child: SizedBox(
        height: 16,
      ),
    );

    return Scaffold(
      appBar: CustomAppBar(
        text: 'Заявка ${appeal.id}',
        isBack: true,
        context: context,
        onTap: context.pop,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!appeal.fulfilled) ...[
                    SvgPicture.asset(
                      'assets/icons/clock.svg',
                      color: Colors.black,
                      width: 24,
                      height: 24,
                    ),
                  ] else ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/main_coin.png',
                            width: 24, height: 24),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          '+${appeal.reward}',
                          style: AppTypography.font20w700
                              .copyWith(color: AppColors.primary),
                        )
                      ],
                    )
                  ],
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    appeal.fulfilled ? 'Исполнено' : 'В обработке',
                    style:
                        AppTypography.font18w700.copyWith(color: Colors.black),
                  )
                ],
              ),
            ),
          ),
          separateHeight16,
          if (appeal.images.isNotEmpty) ...[
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Загруженные фото',
                  style: AppTypography.font18w700.copyWith(color: Colors.black),
                ),
              ),
            ),
            separateHeight8,
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                          width: 160 * MediaQuery.sizeOf(context).width / 360,
                          height: 160 * MediaQuery.sizeOf(context).width / 360,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  image: MemoryImage(appeal.images[index]),
                                  fit: BoxFit.cover),
                              color: Colors.grey[300]),
                        ),
                    childCount: appeal.images.length),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    maxCrossAxisExtent:
                        160 * MediaQuery.sizeOf(context).width / 360,
                    childAspectRatio: 1),
              ),
            ),
            separateHeight16,
          ],
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Дополнение проблемы',
                style: AppTypography.font18w700.copyWith(color: Colors.black),
              ),
            ),
          ),
          separateHeight8,
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: MultilineTextField(
                controller: TextEditingController(),
                readOnly: true,
                initialText: appeal.message,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
