import 'package:json_annotation/json_annotation.dart';

part 'my_ranking_response.g.dart';

@JsonSerializable()
class MyRankingResponse {
  final String name;
  final int rating;

  MyRankingResponse({
    required this.name,
    required this.rating,
  });

  factory MyRankingResponse.fromJson(Map<String, dynamic> json) =>
      _$MyRankingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyRankingResponseToJson(this);
}
