import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/utils/logic/mask_text_field.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';
import 'package:izobility_mobile/widgets/scaffold/home_scaffold.dart';
import 'package:izobility_mobile/widgets/text_field/custom_text_field.dart';

class CardsAddScreen extends StatefulWidget {
  const CardsAddScreen({super.key});

  @override
  State<CardsAddScreen> createState() => _CardsAddScreenState();
}

class _CardsAddScreenState extends State<CardsAddScreen> {
  final _cardNumberController = TextEditingController();
  final _cvvController = TextEditingController();

  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: HomeScaffold(
        backgroundColor: AppColors.purpleBcg,
        appBar: CustomAppBar(
          backgroundColor: Colors.transparent,
          context: context,
          isBack: true,
          onTap: () {
            context.pop();
          },
          text: "Привязать новую кару",
        ),
        body: Container(
          padding: const EdgeInsets.all(16).copyWith(bottom: 0),
          child:
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            CustomTextField(
              mask: AppMask.maskCardFormatter,
              backgroundColor: Colors.white,
              hintText: "Номер карты",
              controller: _cardNumberController,
              width: double.infinity,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  mask: AppMask.maskDateFormatter,
                  backgroundColor: Colors.white,
                  hintText: "Срок действия",
                  controller: _cvvController,
                  width: size.width * 0.4333,
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  mask: AppMask.maskCvvFormatter,
                  backgroundColor: Colors.white,
                  hintText: "CVV / CVC",
                  controller: _dateController,
                  width: size.width * 0.4333,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            CustomButton(
                text: "Продолжить", onTap: () {}, width: double.infinity),
            const SizedBox(
              height: 32,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Включите NFC\nи приложите карту",
                      style: AppTypography.font24w700,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Мы автоматически соберём данные и внесём их",
                      style: AppTypography.font12w400,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xff1F1F1F),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          width: size.width * 0.4444,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28.5, vertical: 4),
                          child: Text(
                            "Включить NFC",
                            style: AppTypography.font14w700,
                          ),
                        ),
                      ),
                    )
                  ]),
            )
          ]),
        ),
      ),
    );
  }
}
