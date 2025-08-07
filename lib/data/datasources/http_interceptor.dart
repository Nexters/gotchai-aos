import 'dart:async';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:turing/core/utils/log_util.dart';
import 'package:turing/data/datasources/local/token_service.dart';

class HttpInterceptor extends InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    try {
      final accessToken = await TokenService.getAccessToken();

      if (accessToken != null && accessToken.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $accessToken';
      }

      if (request is Request) {
        logger.d(
            '----- Request -----\n$request\n${request.headers}\n${request.body}');
      } else {
        logger.d('----- Request -----\n$request\n${request.headers}');
      }

      return request;
    } catch (e) {
      if (request is Request) {
        logger.d(
            '----- Request -----\n$request\n${request.headers}\n${request.body}');
      } else {
        logger.d('----- Request -----\n$request\n${request.headers}');
      }
      return request;
    }
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    if (response is Response) {
      logger.d(
        '----- Response -----\nCode: ${response.statusCode},\nBody: ${response.body}',
      );
    } else {
      logger.d('----- Response -----\nCode: ${response.statusCode}');
    }

    // if (response.statusCode == 401) {
    //   await TokenService.clearTokens();
    // }

    return response;
  }
}
