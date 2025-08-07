import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:turing/data/datasources/http_interceptor.dart';
import 'package:turing/data/models/base_response.dart';
import 'package:turing/data/models/exam_list_response.dart';

class TestService {
  final String baseDomain = dotenv.env['BASE_DEV_URL'] ?? '';
  final String basePath = dotenv.env['BASE_PATH'] ?? '';
  final client = InterceptedClient.build(interceptors: [HttpInterceptor()]);

  Future<BaseResponse<ExamListResponse>> getExamList() async {
    final url = Uri.https(baseDomain, '$basePath/exams');

    try {
      final response = await client.get(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        final examData = ExamListResponse.fromJson(data['data']);
        return Success(examData);
      } else {
        final err = json.decode(response.body);
        return Error('시험 목록 조회 실패 : ${err['data']['message']}',
            code: response.statusCode);
      }
    } catch (e) {
      return Error('예외 발생: ${e.toString()}');
    }
  }
}
