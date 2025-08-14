import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:turing/data/models/my_badge_response.dart';
import 'package:turing/presentation/navigation_service.dart';

part 'my_badge_view_model.g.dart';

@riverpod
class MyBadgeViewModel extends _$MyBadgeViewModel {
  @override
  List<MyBadgeItem> build() {
    return [];
  }

  void navigateToback() {
    NavigationService().goBack();
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
