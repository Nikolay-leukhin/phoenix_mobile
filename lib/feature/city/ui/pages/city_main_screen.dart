import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:phoenix_mobile/feature/city/data/city_repository.dart';
import 'package:phoenix_mobile/utils/ui/gradients.dart';
import 'package:phoenix_mobile/utils/utils.dart';
import 'package:phoenix_mobile/widgets/button/button_with_icon.dart';
import 'package:phoenix_mobile/widgets/button/custom_button.dart';
import 'package:phoenix_mobile/widgets/text_field/multylines_text_field.dart';

class CityMainScreen extends StatefulWidget {
  const CityMainScreen({super.key});

  @override
  State<CityMainScreen> createState() => _CityMainScreenState();
}

class _CityMainScreenState extends State<CityMainScreen> {
  final separateHeight8 = const SliverToBoxAdapter(
    child: SizedBox(
      height: 8,
    ),
  );
  final separateHeight16 = const SliverToBoxAdapter(
    child: SizedBox(
      height: 16,
    ),
  );

  final messageController = TextEditingController();

  bool buttonActive = false;

  @override
  void initState() {
    final repository = RepositoryProvider.of<CityRepository>(context);
    messageController.text = repository.message ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<CityRepository>(context);
    final bool bannerActive = repository.images.isEmpty;
    void validate() => setState(() {
      buttonActive = messageController.text.isNotEmpty &&
          (repository.imagesAsBytes.isNotEmpty || repository.scannedCode.isNotEmpty);
    });
    return Scaffold(
      backgroundColor: AppColors.purpleBcg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                context.go(RouteNames.main);
              },
              child: SvgPicture.asset(
                'assets/icons/back.svg',
                width: 24,
                height: 24,
                color: Colors.black,
              ),
            ),
            Text(
              'Город',
              style: AppTypography.font16w700.copyWith(color: Colors.black),
            ),
            InkWell(
              onTap: () {
                context.push(RouteNames.cityHistory);
              },
              child: SvgPicture.asset(
                'assets/icons/clock.svg',
                width: 24,
                height: 24,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                'Загрузите фото',
                style: AppTypography.font18w700.copyWith(color: Colors.black),
              ),
            ),
            separateHeight8,
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {}, // TODO скан кода, в репозитории его хранить в scanCode
                child: Container(
                  width: double.infinity,
                  height: 120 * MediaQuery.sizeOf(context).width / 360,
                  decoration: BoxDecoration(
                      gradient: bannerActive ? AppGradients.accentGreen : null,
                      color: bannerActive ? null : AppColors.disableButton,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/aritem.svg',
                          width: 48,
                          height: 48,
                          color: bannerActive ? Colors.white : AppColors.grey400,
                        ),
                        Text(
                          'Отсканировать местность',
                          style: AppTypography.font18w700.copyWith(
                            color:
                                bannerActive ? Colors.white : AppColors.grey400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            separateHeight8,
            if (repository.scannedCode.isNotEmpty)...[
              const SliverToBoxAdapter(child: ScanSuccessAlert()),
              separateHeight8,
            ],
            SliverToBoxAdapter(
              child: CustomButtonWithIcon(
                text: 'Загрузить фото из галереи',
                onTap: () async {
                  await repository.getImagesFromGallery();
                  print(repository.imagesAsBytes);
                  validate();
                },
                width: double.infinity,
                asset: 'assets/icons/add_file.svg',
                isActive: repository.scannedCode.isEmpty,
              ),
            ),
            separateHeight8,
            SliverToBoxAdapter(
              child: CustomButtonWithIcon(
                text: 'Сфотографировать',
                onTap: () async {
                  await repository.getImageFromCamera();
                  validate();
                },
                width: double.infinity,
                asset: 'assets/icons/camera.svg',
                isActive: repository.scannedCode.isEmpty,
              ),
            ),
            separateHeight16,
            if (!bannerActive) ...[
              SliverToBoxAdapter(
                child: Text(
                  'Загруженные фото',
                  style: AppTypography.font18w700.copyWith(color: Colors.black),
                ),
              ),
              separateHeight8,
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                          width: 160 * MediaQuery.sizeOf(context).width / 360,
                          height: 160 * MediaQuery.sizeOf(context).width / 360,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  image: MemoryImage(
                                      repository.imagesAsBytes[index]),
                                  fit: BoxFit.cover),
                              color: Colors.grey[300]),
                          padding: EdgeInsets.all(5),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                repository.images.removeAt(index);
                                repository.imagesAsBytes.removeAt(index);
                                setState(() {});
                              },
                              child: SvgPicture.asset(
                                'assets/icons/cross_rounded.svg',
                                width: 24,
                                height: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    childCount: repository.imagesAsBytes.length),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    maxCrossAxisExtent:
                        160 * MediaQuery.sizeOf(context).width / 360,
                    childAspectRatio: 1),
              ),
              separateHeight16,
            ],
            SliverToBoxAdapter(
              child: Text(
                'Дополните проблему',
                style: AppTypography.font18w700.copyWith(color: Colors.black),
              ),
            ),
            separateHeight8,
            SliverToBoxAdapter(
              child: MultilineTextField(
                controller: messageController,
                onChange: (value) {
                  repository.message = value;
                  validate();
                },
              ),
            ),
            separateHeight16,
            SliverToBoxAdapter(
              child: CustomButton(
                  text: 'Отправить',
                  onTap: () {},
                  width: double.infinity,
                  isActive: buttonActive),
            )
          ],
        ),
      ),
    );
  }
}

class ScanSuccessAlert extends StatelessWidget {
  const ScanSuccessAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12)
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Проблема обнаружена', style: AppTypography.font16w400.copyWith(color: Colors.black),),
              Text('Уже готовы её решать!', style: AppTypography.font12w400.copyWith(color: AppColors.primary),),
            ],
          ),
          SvgPicture.asset('assets/icons/success_scan.svg', width: 24, height: 24,)
        ],
      ),
    );
  }
}
