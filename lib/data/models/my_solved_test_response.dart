import 'package:json_annotation/json_annotation.dart';

part 'my_solved_test_response.g.dart';

@JsonSerializable()
class MySolvedTestResponse {
  final List<MySolvedTest> list;

  MySolvedTestResponse({
    required this.list,
  });

  factory MySolvedTestResponse.fromJson(Map<String, dynamic> json) =>
      _$MySolvedTestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MySolvedTestResponseToJson(this);
}

@JsonSerializable()
class MySolvedTest {
  final int id;
  final String title;
  final String subTitle;
  final String description;
  final String prompt;
  final String backgroundImage;
  final String iconImage;
  final String coverImage;
  final String theme;
  final bool isSolved;
  final String createdAt;

  MySolvedTest({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.prompt,
    required this.backgroundImage,
    required this.iconImage,
    required this.coverImage,
    required this.theme,
    required this.isSolved,
    required this.createdAt,
  });

  MySolvedTest.empty()
      : id = 0,
        title = '',
        subTitle = '',
        description = '',
        prompt = '',
        backgroundImage = '',
        iconImage = '',
        coverImage = '',
        theme = '',
        isSolved = false,
        createdAt = '';

  factory MySolvedTest.fromJson(Map<String, dynamic> json) =>
      _$MySolvedTestFromJson(json);

  Map<String, dynamic> toJson() => _$MySolvedTestToJson(this);
}
