part of 'wallet_auth_cubit.dart';

@immutable
sealed class WalletAuthState {}

final class WalletAuthInitial extends WalletAuthState {}

final class WalletAuthLoadingState extends WalletAuthState {}

final class WalletAuthSuccessState extends WalletAuthState {}

final class WalletAuthFailureState extends WalletAuthState {}

