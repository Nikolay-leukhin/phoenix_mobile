import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/feature/wallet/ui/widgets/wallet_action.dart';
import 'package:izobility_mobile/utils/ui/colors.dart';
import 'package:izobility_mobile/utils/ui/fonts.dart';
import 'package:izobility_mobile/widgets/app_bar/custom_app_bar.dart';
import 'package:izobility_mobile/widgets/scaffold/home_scaffold.dart';
import 'package:izobility_mobile/widgets/snack_bar/custom_snack_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';

class WalletReplenishScreen extends StatefulWidget {
  const WalletReplenishScreen({super.key});

  @override
  State<WalletReplenishScreen> createState() => _WalletReplenishScreenState();
}

class _WalletReplenishScreenState extends State<WalletReplenishScreen> {
  @override
  Widget build(BuildContext context) {
    final walletRepository = RepositoryProvider.of<WalletRepository>(context);

    final sizeOf = MediaQuery.sizeOf(context);

    final address = walletRepository.walletModel!.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain);
    return HomeScaffold(
      appBar: CustomAppBar(
        context: context,
        text: 'Получить %Валюты%',
        isBack: true,
        onTap: () {
          context.pop();
        },
      ),
      body: Container(
        color: AppColors.purpleBcg,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: QrImageView(
                      data: address,
                      version: QrVersions.auto,
                      size: sizeOf.width / 2,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: sizeOf.width / 2,
                    child: Text(
                      address,
                      maxLines: 2,
                      style: AppTypography.font14w400
                          .copyWith(color: AppColors.disabledTextButton),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: sizeOf.width * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WalletAction(
                          iconColor: Colors.black,
                          title: 'Копировать',
                          icon: 'assets/icons/copy.svg',
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: address));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(CustomSnackBar.snackBarCopied);
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        WalletAction(
                          iconColor: Colors.black,
                          title: 'Поделиться',
                          icon: 'assets/icons/share.svg',
                          onTap: () async{
                            await Share.share(address);
                          },
                          isActive: true,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
