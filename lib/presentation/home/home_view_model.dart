import 'package:turing/data/datasources/remote/profile_service.dart';
import 'package:turing/data/datasources/remote/test_service.dart';
import 'package:turing/data/models/root_response.dart';
import 'package:turing/data/models/my_badge_response.dart';
import 'package:turing/data/models/my_ranking_response.dart';
import 'package:turing/data/models/test_list_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';

part 'home_view_model.g.dart';

class HomesState {
  final List<Test> testList;
  final MyBadgeItem recentBadge;
  final int ranking;
  final String name;
  final String errorMessage;

  const HomesState(
      {required this.testList,
      required this.recentBadge,
      required this.ranking,
      required this.name,
      required this.errorMessage});

  HomesState copyWith(
      {List<Test>? testList,
      MyBadgeItem? recentBadge,
      int? ranking,
      String? name,
      String? errorMessage}) {
    return HomesState(
      testList: testList ?? this.testList,
      recentBadge: recentBadge ?? this.recentBadge,
      ranking: ranking ?? this.ranking,
      name: name ?? this.name,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomesState build() {
    getMyRanking();
    getExamList();
    getMyBadgeList();
    return HomesState(
        testList: [],
        recentBadge: MyBadgeItem.empty(),
        ranking: 0,
        name: '',
        errorMessage: "");
  }

  Future<void> getExamList() async {
    await TestService().getExamList().then((result) {
      if (result is Success<TestListResponse>) {
        state = state.copyWith(testList: result.data.list, errorMessage: "");
      } else if (result is Error<TestListResponse>) {
        state = state.copyWith(errorMessage: result.message);
      }
    }).catchError((error) {
      state = state.copyWith(errorMessage: error.toString());
    });
  }

  Future<void> getMyRanking() async {
    await ProfileService().getMyRanking().then((result) {
      if (result is Success<MyRankingResponse>) {
        state = state.copyWith(
            ranking: result.data.rating,
            name: result.data.name,
            errorMessage: "");
      } else if (result is Error<MyRankingResponse>) {
        state = state.copyWith(errorMessage: result.message);
      }
    }).catchError((error) {
      state = state.copyWith(errorMessage: error.toString());
    });
  }

  Future<void> getMyBadgeList() async {
    await ProfileService().getMyBadgeList().then((result) {
      if (result is Success<MyBadgeResponse>) {
        final badges = result.data.badges;
        state = state.copyWith(
            recentBadge: badges.isNotEmpty ? badges.first : MyBadgeItem.empty(),
            errorMessage: "");
      } else if (result is Error<MyBadgeResponse>) {
        state = state.copyWith(errorMessage: result.message);
      }
    }).catchError((error) {
      state = state.copyWith(errorMessage: error.toString());
    });
  }

  void navigateToTestFlow() {
    NavigationService().navigateWithSlide(NavigationRoute.testCover);
  }

  void navigateToMyBadge() {
    NavigationService().navigateWithSlide(NavigationRoute.myBadge);
  }

  void navigateToMySolvedTest() {
    NavigationService().navigateWithSlide(NavigationRoute.mySolvedTest);
  }

  void navigateToSetting() {
    NavigationService().navigateWithSlide(NavigationRoute.setting);
  }
}
