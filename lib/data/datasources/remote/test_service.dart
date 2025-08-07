import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:turing/data/datasources/http_interceptor.dart';
import 'package:turing/data/models/base_response.dart';
import 'package:turing/data/models/exam_list_response.dart';
import 'package:turing/data/models/grade_quiz_response.dart';
import 'package:turing/data/models/quiz_response.dart';
import 'package:turing/data/models/test_start_response.dart';

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
        final result = ExamListResponse.fromJson(data['data']);
        return Success(result);
      } else {
        final err = json.decode(response.body);
        return Error('시험 목록 조회 실패 : ${err['data']['message']}',
            code: response.statusCode);
      }
    } catch (e) {
      return Error('예외 발생: ${e.toString()}');
    }
  }

  Future<BaseResponse<TestStartResponse>> postTestStart(int id) async {
    final url = Uri.https(baseDomain, '$basePath/exams/$id/start');

    try {
      final response = await client.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        final result = TestStartResponse.fromJson(data['data']);
        return Success(result);
      } else {
        final err = json.decode(response.body);
        return Error('퀴즈 시작 실패 : ${err['data']['message']}',
            code: response.statusCode);
      }
    } catch (e) {
      return Error('예외 발생: ${e.toString()}');
    }
  }

  Future<BaseResponse<QuizResponse>> getQuiz(int id) async {
    final url = Uri.https(baseDomain, '$basePath/quizzes/$id');

    try {
      final response = await client.get(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        final result = QuizResponse.fromJson(data['data']);
        return Success(result);
      } else {
        final err = json.decode(response.body);
        return Error('퀴즈 조회 실패 : ${err['data']['message']}',
            code: response.statusCode);
      }
    } catch (e) {
      return Error('예외 발생: ${e.toString()}');
    }
  }

  Future<BaseResponse<GradeQuizResponse>> postGradeQuiz(
      int examId, int quizId) async {
    final url = Uri.https(baseDomain, '$basePath/quizzes/grade');

    try {
      final response = await client.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: json.encode({'examId': examId, 'quizId': quizId}),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        final result = GradeQuizResponse.fromJson(data['data']);
        return Success(result);
      } else {
        final err = json.decode(response.body);
        return Error('퀴즈 채점 실패 : ${err['data']['message']}',
            code: response.statusCode);
      }
    } catch (e) {
      return Error('예외 발생: ${e.toString()}');
    }
  }
}
