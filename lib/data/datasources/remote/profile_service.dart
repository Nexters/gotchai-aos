import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:turing/data/datasources/http_interceptor.dart';
import 'package:turing/data/models/base_response.dart';
import 'package:turing/data/models/my_badge_response.dart';
import 'package:turing/data/models/my_solved_test_response.dart';
import 'package:turing/data/models/my_ranking_response.dart';

class ProfileService {
  final String baseDomain = dotenv.env['BASE_DEV_URL'] ?? '';
  final String basePath = dotenv.env['BASE_PATH'] ?? '';
  final client = InterceptedClient.build(interceptors: [HttpInterceptor()]);

  Future<BaseResponse<MyBadgeResponse>> getMyBadgeList() async {
    final url = Uri.https(baseDomain, '$basePath/users/me/badges');

    try {
      final response = await client.get(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        final result = MyBadgeResponse.fromJson(data['data']);
        return Success(result);
      } else {
        final err = json.decode(response.body);
        return Error('배지 목록 조회 실패 : ${err['data']['message']}',
            code: response.statusCode);
      }
    } catch (e) {
      return Error('예외 발생: ${e.toString()}');
    }
  }

  Future<BaseResponse<MyRankingResponse>> getMyRanking() async {
    final url = Uri.https(baseDomain, '$basePath/users/ranking');

    try {
      final response = await client.get(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        final result = MyRankingResponse.fromJson(data['data']);
        return Success(result);
      } else {
        final err = json.decode(response.body);
        return Error('랭킹 조회 실패 : ${err['data']['message']}',
            code: response.statusCode);
      }
    } catch (e) {
      return Error('예외 발생: ${e.toString()}');
    }
  }

  Future<BaseResponse<MySolvedTestResponse>> getMySolvedTestList() async {
    final url = Uri.https(baseDomain, '$basePath/users/me/exams/solved');

    try {
      final response = await client.get(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        final result = MySolvedTestResponse.fromJson(data['data']);
        return Success(result);
      } else {
        final err = json.decode(response.body);
        return Error('내가 푼 테스트 목록 조회 실패 : ${err['data']['message']}',
            code: response.statusCode);
      }
    } catch (e) {
      return Error('예외 발생: ${e.toString()}');
    }
  }
}
