import 'dart:convert';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:turing/core/utils/logging_interceptor.dart';
import 'package:turing/data/models/base_response.dart';
import 'package:turing/data/models/login_response.dart';

class LoginService {
  final String baseDomain = '';
  static const String basePath = '';
  final client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  Future<BaseResponse<LoginResponse>> login(String token, String type) async {
    return Success(
        LoginResponse.fromJson({"access_token": "", "refresh_token": ""}));
    // final url = Uri.https(baseDomain, basePath, {
    //   'social': type,
    // });

    // try {
    //   final response = await client.post(
    //     url,
    //     headers: {
    //       "Content-Type": "application/json; charset=UTF-8",
    //     },
    //     body: json.encode({'token': token}),
    //   );

    //   if (response.statusCode >= 200 && response.statusCode < 300) {
    //     final data = json.decode(response.body);
    //     final loginData = LoginResponse.fromJson(data);
    //     return Success(loginData);
    //   } else {
    //     return Error('로그인 실패', code: response.statusCode);
    //   }
    // } catch (e) {
    //   return Error('예외 발생: ${e.toString()}');
    // }
  }
}
