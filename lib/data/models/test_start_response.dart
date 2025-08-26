import 'package:json_annotation/json_annotation.dart';

part 'test_start_response.g.dart';

@JsonSerializable()
class TestStartResponse {
  final List<int> quizIds;

  TestStartResponse({
    required this.quizIds,
  });

  factory TestStartResponse.fromJson(Map<String, dynamic> json) =>
      _$TestStartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TestStartResponseToJson(this);
}
