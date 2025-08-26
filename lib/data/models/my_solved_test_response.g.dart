// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_solved_test_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MySolvedTestResponse _$MySolvedTestResponseFromJson(
        Map<String, dynamic> json) =>
    MySolvedTestResponse(
      list: (json['list'] as List<dynamic>)
          .map((e) => MySolvedTest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MySolvedTestResponseToJson(
        MySolvedTestResponse instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

MySolvedTest _$MySolvedTestFromJson(Map<String, dynamic> json) => MySolvedTest(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      iconImage: json['iconImage'] as String,
      correctAnswerRate: (json['correctAnswerRate'] as num).toInt(),
      totalQuizCount: (json['totalQuizCount'] as num).toInt(),
      correctAnswerCount: (json['correctAnswerCount'] as num).toInt(),
      solvedAt: json['solvedAt'] as String,
    );

Map<String, dynamic> _$MySolvedTestToJson(MySolvedTest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'iconImage': instance.iconImage,
      'correctAnswerRate': instance.correctAnswerRate,
      'totalQuizCount': instance.totalQuizCount,
      'correctAnswerCount': instance.correctAnswerCount,
      'solvedAt': instance.solvedAt,
    };
