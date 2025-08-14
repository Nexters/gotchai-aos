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
      subTitle: json['subTitle'] as String,
      description: json['description'] as String,
      prompt: json['prompt'] as String,
      backgroundImage: json['backgroundImage'] as String,
      iconImage: json['iconImage'] as String,
      coverImage: json['coverImage'] as String,
      theme: json['theme'] as String,
      isSolved: json['isSolved'] as bool,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$MySolvedTestToJson(MySolvedTest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'description': instance.description,
      'prompt': instance.prompt,
      'backgroundImage': instance.backgroundImage,
      'iconImage': instance.iconImage,
      'coverImage': instance.coverImage,
      'theme': instance.theme,
      'isSolved': instance.isSolved,
      'createdAt': instance.createdAt,
    };
