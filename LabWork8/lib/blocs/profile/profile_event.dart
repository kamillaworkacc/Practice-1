part of 'profile_bloc.dart';

sealed class ProfileEvent {}

class ProfileRequested extends ProfileEvent {
  ProfileRequested({this.id = 1});

  final int id;
}

