import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'storage_service.dart';

class AppException implements Exception {
  final String message;
  final int? statusCode;
  AppException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class ApiClient {
  ApiClient._();
  static late Dio _dio;

  // Change this to your backend base URL
  static const String _baseUrl = 'https://api.superapp.com/api/v1';

  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(_AuthInterceptor());
    _dio.interceptors.add(_LoggingInterceptor());
  }

  static Dio get instance => _dio;

  // ── GET ─────────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await _dio.get(path, queryParameters: queryParameters);
      return _handleResponse(res);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ── POST ────────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> post(String path, {dynamic data}) async {
    try {
      final res = await _dio.post(path, data: data);
      return _handleResponse(res);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ── PATCH ───────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> patch(String path, {dynamic data}) async {
    try {
      final res = await _dio.patch(path, data: data);
      return _handleResponse(res);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ── DELETE ──────────────────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> delete(String path) async {
    try {
      final res = await _dio.delete(path);
      return _handleResponse(res);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // ── Multipart (file upload) ──────────────────────────────────────────────────
  static Future<Map<String, dynamic>> upload(
    String path,
    FormData formData,
  ) async {
    try {
      final res = await _dio.post(path, data: formData);
      return _handleResponse(res);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  static Map<String, dynamic> _handleResponse(Response<dynamic> res) {
    final data = res.data;
    if (data is Map<String, dynamic>) {
      if (data['status'] == true ||
          res.statusCode == 200 ||
          res.statusCode == 201) {
        return data;
      }
      throw AppException(
        data['message'] as String? ?? 'Something went wrong',
        statusCode: res.statusCode,
      );
    }
    throw AppException('Unexpected response format');
  }

  static AppException _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return AppException('no_internet'.tr);
    }
    if (e.type == DioExceptionType.connectionError) {
      return AppException('no_internet'.tr);
    }
    final statusCode = e.response?.statusCode;
    final message = e.response?.data?['message'] as String?;

    if (statusCode == 401) {
      StorageService.clearAll();
      Get.toNamed('/login');
      return AppException(
        'Session expired. Please login again.',
        statusCode: 401,
      );
    }
    if (statusCode == 422) {
      return AppException(message ?? 'Validation failed.', statusCode: 422);
    }
    if (statusCode == 404) {
      return AppException(message ?? 'Resource not found.', statusCode: 404);
    }
    if (statusCode != null && statusCode >= 500) {
      return AppException('server_error'.tr, statusCode: statusCode);
    }
    return AppException(message ?? 'Something went wrong. Please try again.');
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = StorageService.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // ignore: avoid_print
    print('→ [${options.method}] ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    // ignore: avoid_print
    print('← [${response.statusCode}] ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // ignore: avoid_print
    print(
      '✗ [${err.response?.statusCode}] ${err.requestOptions.uri}: ${err.message}',
    );
    handler.next(err);
  }
}
