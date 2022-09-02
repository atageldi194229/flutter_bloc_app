import 'package:dio/dio.dart';

final localhostOptions = BaseOptions(
  baseUrl: "https://jsonplaceholder.typicode.com",
  connectTimeout: 5000,
  receiveTimeout: 3000,
  sendTimeout: 3000,
);

class ApiClient {
  late final Dio dio;
  ApiClient._sharedInstance() : dio = Dio(localhostOptions);
  static final ApiClient _shared = ApiClient._sharedInstance();
  factory ApiClient() => _shared;
}

class ApiLoader {
  final String path;
  late Future<Response> Function() loader;

  ApiLoader({
    required this.path,
    required Future<Response> Function(String path) loader,
  }) {
    this.loader = () => loader(path);
  }
}
