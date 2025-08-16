import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:turing/data/datasources/http_interceptor.dart';
import 'package:turing/data/datasources/local/token_service.dart';
import 'package:turing/data/models/base_response.dart';
import 'package:turing/data/models/login_response.dart';

class LoginService {
  final String baseDomain = dotenv.env['BASE_DEV_URL'] ?? '';
  final String basePath = dotenv.env['BASE_PATH'] ?? '';
  final client = InterceptedClient.build(interceptors: [HttpInterceptor()]);

  Future<BaseResponse<LoginResponse>> login(String token) async {
    final url = Uri.https(baseDomain, '$basePath/auth/login/kakao');

    try {
      final response = await client.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: json.encode({'accessToken': token}),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        final result = LoginResponse.fromJson(data['data']);

        await TokenService.saveTokens(
          accessToken: result.accessToken,
          refreshToken: result.refreshToken,
        );
        return Success(result);
      } else {
        final err = json.decode(response.body);
        return Error('로그인 실패 : ${err['data']['message']}',
            code: response.statusCode);
      }
    } catch (e) {
      return Error('예외 발생: ${e.toString()}');
    }
  }

  Future<BaseResponse<LoginResponse>> refresh(String refreshToken) async {
    final url = Uri.https(baseDomain, '$basePath/auth/refresh');

    try {
      final response = await client.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: json.encode({'refreshToken': refreshToken}),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        final result = LoginResponse.fromJson(data['data']);

        await TokenService.saveTokens(
          accessToken: result.accessToken,
          refreshToken: result.refreshToken,
        );
        return Success(result);
      } else {
        final err = json.decode(response.body);
        return Error('로그인 실패 : ${err['data']['message']}',
            code: response.statusCode);
      }
    } catch (e) {
      return Error('예외 발생: ${e.toString()}');
    }
  }

  Future<BaseResponse<void>> logout() async {
    final url = Uri.https(baseDomain, '$basePath/auth/logout');

    try {
      final response = await client.post(url, headers: {
        "Content-Type": "application/json; charset=UTF-8",
      });
      if (response.statusCode >= 200 && response.statusCode < 300) {
        await TokenService.clearTokens();
        return Success(null);
      } else {
        final err = json.decode(response.body);
        return Error('로그인 실패 : ${err['data']['message']}',
            code: response.statusCode);
      }
    } catch (e) {
      return Error('예외 발생: ${e.toString()}');
    }
  }
}
