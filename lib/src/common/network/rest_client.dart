import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RestClient implements Interceptor {
  late final String? _baseUrl;
  static const Duration _connectTimeout = Duration(milliseconds: 5000);

  final _dio = Dio();

  Dio get dio => _dio;

  Future<void> init() async {
    _baseUrl = dotenv.env['baseUrl'];
    _dio.options = BaseOptions(
      baseUrl: '$_baseUrl/api/v1',
      connectTimeout: _connectTimeout,
      headers: {
        'Accept': 'application/json',
      },
    );
    _dio.interceptors
        .addAll([this, LogInterceptor(requestBody: true, responseBody: true)]);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}
