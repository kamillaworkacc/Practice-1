import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'post_event.dart';
import 'post_state.dart';
import '../services/api_service.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final ApiService _apiService;

  PostBloc({ApiService? apiService})
      : _apiService = apiService ??
            ApiService(Dio(), baseUrl: "https://jsonplaceholder.typicode.com/"),
        super(PostInitial()) {
    on<PostLoadRequested>(_onPostLoadRequested);
  }

  Future<void> _onPostLoadRequested(
    PostLoadRequested event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoading());
    try {
      final post = await _apiService.getPost(event.postId);
      emit(PostLoaded(post));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}

