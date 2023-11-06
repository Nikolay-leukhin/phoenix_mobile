part of 'coin_in_wallet_cubit.dart';

@immutable
sealed class CoinInWalletState {}

final class CoinInWalletInitial extends CoinInWalletState {}

final class CoinInWalletLoadingState extends CoinInWalletState {}

final class CoinInWalletLoadedFailureState extends CoinInWalletState {}

final class CoinInWalletLoadedSuccessState extends CoinInWalletState {}
