// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_start_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestStartResponse _$TestStartResponseFromJson(Map<String, dynamic> json) =>
    TestStartResponse(
      quizIds: (json['quizIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$TestStartResponseToJson(TestStartResponse instance) =>
    <String, dynamic>{
      'quizIds': instance.quizIds,
    };
