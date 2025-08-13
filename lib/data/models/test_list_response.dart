import 'package:json_annotation/json_annotation.dart';

part 'test_list_response.g.dart';

@JsonSerializable()
class TestListResponse {
  final List<Test> list;

  TestListResponse({
    required this.list,
  });

  factory TestListResponse.fromJson(Map<String, dynamic> json) =>
      _$TestListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TestListResponseToJson(this);
}

@JsonSerializable()
class Test {
  final int id;
  final String title;
  final String subTitle;
  final String description;
  final String prompt;
  final String backgroundImage;
  final String iconImage;
  final String coverImage;
  final String theme;
  final String createdAt;

  Test({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.prompt,
    required this.backgroundImage,
    required this.iconImage,
    required this.coverImage,
    required this.theme,
    required this.createdAt,
  });

  Test.empty()
      : id = 0,
        title = '',
        subTitle = '',
        description = '',
        prompt = '',
        backgroundImage = '',
        iconImage = '',
        coverImage = '',
        theme = '',
        createdAt = '';

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);

  Map<String, dynamic> toJson() => _$TestToJson(this);
}
