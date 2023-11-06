part of 'profile_photo_cubit.dart';

@immutable
sealed class ProfilePhotoState {}

final class ProfilePhotoInitial extends ProfilePhotoState {}

final class ProfilePhotoLoading extends ProfilePhotoState {}

final class ProfilePhotoSuccess extends ProfilePhotoState {}

final class ProfilePhotoFailure extends ProfilePhotoState {}

