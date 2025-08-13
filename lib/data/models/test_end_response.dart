import 'package:json_annotation/json_annotation.dart';

part 'test_end_response.g.dart';

@JsonSerializable()
class TestEndResponse {
  final int answerCount;
  final Badge badge;

  const TestEndResponse({
    required this.answerCount,
    required this.badge,
  });

  factory TestEndResponse.fromJson(Map<String, dynamic> json) =>
      _$TestEndResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TestEndResponseToJson(this);
}

@JsonSerializable()
class Badge {
  final int id;
  final int examId;
  final String name;
  final String description;
  final String image;
  final String tier;
  final String createdAt;

  const Badge({
    required this.id,
    required this.examId,
    required this.name,
    required this.description,
    required this.image,
    required this.tier,
    required this.createdAt,
  });

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);

  Map<String, dynamic> toJson() => _$BadgeToJson(this);
}
