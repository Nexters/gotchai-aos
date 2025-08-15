import 'package:turing/data/datasources/remote/test_service.dart';
import 'package:turing/data/models/base_response.dart';
import 'package:turing/data/models/test_list_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';

part 'home_view_model.g.dart';

sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<Test> testList;

  const HomeLoaded(this.testList);
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeState build() {
    getExamList();
    return const HomeInitial();
  }

  Future<void> getExamList() async {
    await TestService().getExamList().then((result) {
      if (result is Success<TestListResponse>) {
        state = HomeLoaded(result.data.list);
      } else if (result is Error<TestListResponse>) {
        state = HomeError(result.message);
      }
    }).catchError((error) {
      state = HomeError('예상치 못한 오류가 발생했습니다: ${error.toString()}');
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
