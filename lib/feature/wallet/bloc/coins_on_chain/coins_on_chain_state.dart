part of 'coins_on_chain_cubit.dart';

@immutable
sealed class CoinsOnChainState {}

final class CoinsOnChainInitial extends CoinsOnChainState {}

final class CoinsOnChainLoading extends CoinsOnChainState {}

final class CoinsOnChainFailure extends CoinsOnChainState {}

final class CoinsOnChainSuccess extends CoinsOnChainState {}
