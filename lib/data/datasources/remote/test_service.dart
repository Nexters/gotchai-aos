import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:turing/data/datasources/http_interceptor.dart';
import 'package:turing/data/models/base_response.dart';
import 'package:turing/data/models/login_response.dart';

class TestService {
  final String baseDomain = dotenv.env['BASE_DEV_URL'] ?? '';
  final String basePath = dotenv.env['BASE_PATH'] ?? '';
  final client = InterceptedClient.build(interceptors: [HttpInterceptor()]);

  Future<BaseResponse<LoginResponse>> getExamList() async {
    final url = Uri.https(baseDomain, '$basePath/exams');

    try {
      final response = await client.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        final loginData = LoginResponse.fromJson(data['data']);
        return Success(loginData);
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
