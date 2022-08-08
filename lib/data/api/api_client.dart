import 'package:dio/dio.dart';

class ApiClient {
  late final Dio dio;
  ApiClient._sharedInstance() : dio = Dio();
  static final ApiClient _shared = ApiClient._sharedInstance();
  factory ApiClient.instance() => _shared;
}
