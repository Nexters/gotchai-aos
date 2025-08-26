import 'package:json_annotation/json_annotation.dart';

part 'quiz_response.g.dart';

@JsonSerializable()
class QuizResponse {
  final int id;
  final String contents;
  final String createdAt;
  final List<QuizPick> quizPicks;

  QuizResponse({
    required this.id,
    required this.contents,
    required this.createdAt,
    required this.quizPicks,
  });

  factory QuizResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuizResponseToJson(this);
}

@JsonSerializable()
class QuizPick {
  final int id;
  final String contents;

  QuizPick({
    required this.id,
    required this.contents,
  });

  factory QuizPick.fromJson(Map<String, dynamic> json) =>
      _$QuizPickFromJson(json);

  Map<String, dynamic> toJson() => _$QuizPickToJson(this);
}
