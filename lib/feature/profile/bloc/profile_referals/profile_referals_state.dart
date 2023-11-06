part of 'profile_referals_cubit.dart';

@immutable
sealed class ProfileReferalsState {}

final class ProfileReferalsInitial extends ProfileReferalsState {}

final class ProfileReferalsLoading extends ProfileReferalsState {}


final class ProfileReferalsFailure extends ProfileReferalsState {}


final class ProfileReferalsSuccess extends ProfileReferalsState {}

