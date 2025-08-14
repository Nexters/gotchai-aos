import 'package:json_annotation/json_annotation.dart';

part 'my_badge_response.g.dart';

@JsonSerializable()
class MyBadgeResponse {
  final List<MyBadgeItem> list;

  MyBadgeResponse({
    required this.list,
  });

  factory MyBadgeResponse.fromJson(Map<String, dynamic> json) =>
      _$MyBadgeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyBadgeResponseToJson(this);
}

@JsonSerializable()
class MyBadgeItem {
  final int id;
  final int examId;
  final String name;
  final String description;
  final String image;
  final String tier;
  final String createdAt;

  MyBadgeItem({
    required this.id,
    required this.examId,
    required this.name,
    required this.description,
    required this.image,
    required this.tier,
    required this.createdAt,
  });

  factory MyBadgeItem.fromJson(Map<String, dynamic> json) =>
      _$MyBadgeItemFromJson(json);

  Map<String, dynamic> toJson() => _$MyBadgeItemToJson(this);
}
