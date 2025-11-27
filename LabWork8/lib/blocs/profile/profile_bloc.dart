import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labwork8/models/profile.dart';
import 'package:labwork8/services/profile_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._profileService) : super(ProfileInitial()) {
    on<ProfileRequested>(_onProfileRequested);
  }

  final ProfileService _profileService;

  Future<void> _onProfileRequested(
    ProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadInProgress());
    try {
      final profile = await _profileService.fetchProfile(id: event.id);
      emit(ProfileLoadSuccess(profile));
    } on DioException catch (e) {
      addError(e, e.stackTrace);
      String message = 'Network error: ';
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        message += 'Connection timeout. Please check your internet.';
      } else if (e.type == DioExceptionType.connectionError) {
        message += 'No internet connection.';
      } else if (e.response != null) {
        message += 'Server error: ${e.response?.statusCode}';
      } else {
        message += e.message ?? 'Unknown network error';
      }
      emit(ProfileLoadFailure(message));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      final errorMessage = error.toString();
      emit(ProfileLoadFailure('Failed to load profile data: $errorMessage'));
    }
  }
}

