import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'news_event.dart';
import 'news_state.dart';
import '../services/api_service.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final ApiService _apiService;

  NewsBloc({ApiService? apiService})
      : _apiService = apiService ??
            ApiService(Dio(), baseUrl: "https://jsonplaceholder.typicode.com/"),
        super(NewsInitial()) {
    on<NewsLoadRequested>(_onNewsLoadRequested);
    on<NewsRefreshRequested>(_onNewsRefreshRequested);
  }

  Future<void> _onNewsLoadRequested(
    NewsLoadRequested event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoading());
    try {
      final posts = await _apiService.getPosts();
      emit(NewsLoaded(posts));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  Future<void> _onNewsRefreshRequested(
    NewsRefreshRequested event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoading());
    try {
      final posts = await _apiService.getPosts();
      emit(NewsLoaded(posts));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}

