import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/post_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/posts")
  Future<List<PostModel>> getPosts();

  @GET("/posts/{id}")
  Future<PostModel> getPost(@Path("id") int id);
}


