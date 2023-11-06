part of 'profile_links_cubit.dart';

@immutable
sealed class ProfileLinksState {}

final class ProfileLinksInitial extends ProfileLinksState {}


final class ProfileLinksLoading extends ProfileLinksState {}

final class ProfileLinksSuccess extends ProfileLinksState {}

final class ProfileLinksFail extends ProfileLinksState {}