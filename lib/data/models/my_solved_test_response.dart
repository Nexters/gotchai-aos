import 'package:json_annotation/json_annotation.dart';

part 'my_solved_test_response.g.dart';

@JsonSerializable()
class MySolvedTestResponse {
  final List<MySolvedTest> list;

  MySolvedTestResponse({
    required this.list,
  });

  factory MySolvedTestResponse.fromJson(Map<String, dynamic> json) =>
      _$MySolvedTestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MySolvedTestResponseToJson(this);
}

@JsonSerializable()
class MySolvedTest {
  final int id;
  final String title;
  final String iconImage;
  final int correctAnswerRate;
  final int totalQuizCount;
  final int correctAnswerCount;
  final String solvedAt;

  MySolvedTest({
    required this.id,
    required this.title,
    required this.iconImage,
    required this.correctAnswerRate,
    required this.totalQuizCount,
    required this.correctAnswerCount,
    required this.solvedAt,
  });

  MySolvedTest.empty()
      : id = 0,
        title = '',
        iconImage = '',
        correctAnswerRate = 0,
        totalQuizCount = 0,
        correctAnswerCount = 0,
        solvedAt = '';

  factory MySolvedTest.fromJson(Map<String, dynamic> json) =>
      _$MySolvedTestFromJson(json);

  Map<String, dynamic> toJson() => _$MySolvedTestToJson(this);
}
