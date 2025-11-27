part of 'profile_bloc.dart';

sealed class ProfileState {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileLoadInProgress extends ProfileState {
  const ProfileLoadInProgress();
}

final class ProfileLoadSuccess extends ProfileState {
  const ProfileLoadSuccess(this.profile);

  final Profile profile;
}

final class ProfileLoadFailure extends ProfileState {
  const ProfileLoadFailure(this.message);

  final String message;
}

