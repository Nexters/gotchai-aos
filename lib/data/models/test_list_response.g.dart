// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestListResponse _$TestListResponseFromJson(Map<String, dynamic> json) =>
    TestListResponse(
      list: (json['list'] as List<dynamic>)
          .map((e) => Test.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TestListResponseToJson(TestListResponse instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

Test _$TestFromJson(Map<String, dynamic> json) => Test(
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

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
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
