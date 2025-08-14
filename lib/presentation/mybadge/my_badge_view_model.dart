import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:turing/data/models/my_badge_response.dart';

part 'my_badge_view_model.g.dart';

@riverpod
class MyBadgeViewModel extends _$MyBadgeViewModel {
  @override
  List<MyBadgeItem> build() {
    getMyBadgeList();
    return [];
  }

  Future<void> getMyBadgeList() async {
    state = [
      MyBadgeItem(
          id: 0,
          examId: 0,
          name: "test",
          description: "test",
          image: "",
          tier: "GOLD",
          createdAt: ""),
      MyBadgeItem(
          id: 0,
          examId: 0,
          name: "test",
          description: "test",
          image: "",
          tier: "GOLD",
          createdAt: ""),
      MyBadgeItem(
          id: 0,
          examId: 0,
          name: "test",
          description: "test",
          image: "",
          tier: "GOLD",
          createdAt: "")
    ];
  }
}
