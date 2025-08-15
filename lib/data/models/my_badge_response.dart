import 'package:json_annotation/json_annotation.dart';

part 'my_badge_response.g.dart';

@JsonSerializable()
class MyBadgeResponse {
  final List<MyBadgeItem> badges;
  final int totalBadgeCount;

  MyBadgeResponse({
    required this.badges,
    required this.totalBadgeCount,
  });

  factory MyBadgeResponse.fromJson(Map<String, dynamic> json) =>
      _$MyBadgeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyBadgeResponseToJson(this);
}

@JsonSerializable()
class MyBadgeItem {
  final int id;
  final String name;
  final String image;
  final String acquiredAt;

  MyBadgeItem({
    required this.id,
    required this.name,
    required this.image,
    required this.acquiredAt,
  });

  factory MyBadgeItem.fromJson(Map<String, dynamic> json) =>
      _$MyBadgeItemFromJson(json);

  Map<String, dynamic> toJson() => _$MyBadgeItemToJson(this);
}
