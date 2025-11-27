import 'package:dio/dio.dart';
import 'package:labwork8/models/profile.dart';

import 'rest_client.dart';

class ProfileService {
  ProfileService({Dio? dio}) {
    final dioInstance = dio ??
        Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        );
    
    // Add interceptor to log requests
    dioInstance.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
      ),
    );
    
    _client = RestClient(dioInstance);
  }

  late final RestClient _client;

  Future<Profile> fetchProfile({int id = 1}) {
    return _client.getProfile(id);
  }
}

