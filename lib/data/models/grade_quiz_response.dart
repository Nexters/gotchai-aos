import 'package:json_annotation/json_annotation.dart';

part 'grade_quiz_response.g.dart';

@JsonSerializable()
class GradeQuizResponse {
  final String contents;
  final bool isAnswer;
  final bool isTimeout;

  GradeQuizResponse({
    required this.contents,
    required this.isAnswer,
    required this.isTimeout,
  });

  factory GradeQuizResponse.fromJson(Map<String, dynamic> json) =>
      _$GradeQuizResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GradeQuizResponseToJson(this);
}
