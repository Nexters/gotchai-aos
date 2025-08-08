// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_end_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestEndResponse _$TestEndResponseFromJson(Map<String, dynamic> json) =>
    TestEndResponse(
      answerCount: (json['answerCount'] as num).toInt(),
      badge: Badge.fromJson(json['badge'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TestEndResponseToJson(TestEndResponse instance) =>
    <String, dynamic>{
      'answerCount': instance.answerCount,
      'badge': instance.badge,
    };

Badge _$BadgeFromJson(Map<String, dynamic> json) => Badge(
      id: (json['id'] as num).toInt(),
      examId: (json['examId'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      tier: json['tier'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$BadgeToJson(Badge instance) => <String, dynamic>{
      'id': instance.id,
      'examId': instance.examId,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'tier': instance.tier,
      'createdAt': instance.createdAt,
    };
