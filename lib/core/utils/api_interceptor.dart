import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add common headers, e.g., Authorization token
    options.headers['Content-Type'] = 'application/json';
    options.headers['Authorization'] = 'Bearer YOUR_API_TOKEN'; // Replace with actual token logic
    print('Request[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log successful responses
    print('Response[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle errors globally
    print('Error[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (err.response?.statusCode == 401) {
      // Handle token refresh logic or re-login
      print('Unauthorized! Handle token refresh or logout.');
    }
    super.onError(err, handler);
  }
}
