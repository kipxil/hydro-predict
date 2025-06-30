// api_client.dart
import 'package:dio/dio.dart';
import 'api_config.dart';

class ApiClient {
  final Dio _dio;

  ApiClient() : _dio = Dio(BaseOptions(baseUrl: ApiConfig.baseUrl));

  Future<Response> get(String path) =>
      _dio.get(path).timeout(ApiConfig.timeout);

  Future<Response> delete(String path) =>
      _dio.delete(path).timeout(ApiConfig.timeout);

  // Bisa tambah POST, PUT, DELETE, dll.
}
