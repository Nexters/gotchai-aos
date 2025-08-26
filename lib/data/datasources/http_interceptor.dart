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
            final refreshed = await refreshToken();

            if (refreshed) {
              final originalRequest = response.request;

              if (originalRequest != null) {
                final newAccessToken = await TokenService.getAccessToken();
                originalRequest.headers['Authorization'] =
                    'Bearer $newAccessToken';

                if (originalRequest is Request) {
                  final newRequest = Request(
                    originalRequest.method,
                    originalRequest.url,
                  )
                    ..headers.addAll(originalRequest.headers)
                    ..bodyBytes = await originalRequest.finalize().toBytes();

                  final streamedResponse = await newRequest.send();
                  return await Response.fromStream(streamedResponse);
                }
              }
            }
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
      return false;
    }

    await LoginService().refresh(refresh).then((result) {
      if (result is Success<LoginResponse>) {
        return true;
      } else if (result is Error<LoginResponse>) {
        TokenService.clearTokens();
        return false;
      }
    }).catchError((error) {
      TokenService.clearTokens();
      return false;
    });

    return false;
  }
}
