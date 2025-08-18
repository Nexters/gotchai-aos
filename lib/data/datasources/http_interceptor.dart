import 'dart:async';
import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:turing/core/utils/log_util.dart';
import 'package:turing/data/datasources/local/token_service.dart';
import 'package:turing/data/datasources/remote/login_service.dart';
import 'package:turing/data/models/root_response.dart';
import 'package:turing/data/models/login_response.dart';

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

    if (response.statusCode == 401) {
      if (response is Response) {
        try {
          final responseData = json.decode(response.body);
          final errorCode = responseData['data']?['errorCode'];

          if (errorCode == "UNAUTHENTICATED_USER") {
            await refreshToken();
          }
        } catch (e) {
          await TokenService.clearTokens();
        }
      }
    }

    return response;
  }

  Future<bool> refreshToken() async {
    final refresh = await TokenService.getRefreshToken();

    if (refresh == null) {
      logger.d("refreshToken이 없습니다");
      return false;
    }

    await LoginService().refresh(refresh).then((result) {
      if (result is Success<LoginResponse>) {
      } else if (result is Error<LoginResponse>) {
        logger.e('토큰 갱신 실패: ${result.message}');
      }
    }).catchError((error) {
      logger.e('토큰 갱신 실패: ${error.toString()}');
      TokenService.clearTokens();
    });

    return true;
  }
}
