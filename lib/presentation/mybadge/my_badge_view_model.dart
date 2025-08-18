import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:turing/data/datasources/remote/profile_service.dart';
import 'package:turing/data/models/root_response.dart';
import 'package:turing/data/models/my_badge_response.dart';
import 'package:turing/presentation/navigation_service.dart';

part 'my_badge_view_model.g.dart';

sealed class MyBadgeState {
  const MyBadgeState();
}

class MyBadgeInitial extends MyBadgeState {
  const MyBadgeInitial();
}

class MyBadgeLoading extends MyBadgeState {
  const MyBadgeLoading();
}

class MyBadgeLoaded extends MyBadgeState {
  final List<MyBadgeItem> badges;
  const MyBadgeLoaded(this.badges);
}

class MyBadgeFailure extends MyBadgeState {
  final String message;
  const MyBadgeFailure(this.message);
}

@riverpod
class MyBadgeViewModel extends _$MyBadgeViewModel {
  @override
  MyBadgeState build() {
    return MyBadgeInitial();
  }

  void navigateToback() {
    NavigationService().goBack();
  }

  Future<void> getMyBadgeList() async {
    await ProfileService().getMyBadgeList().then((result) {
      if (result is Success<MyBadgeResponse>) {
        final badges = result.data.badges;
        final totalBadgeCount = result.data.totalBadgeCount;
        state = MyBadgeLoaded([
          ...badges,
          ...List.generate(
              (totalBadgeCount - badges.length),
              (index) => MyBadgeItem(
                  id: -1, name: "숨겨진 배지", image: "", acquiredAt: ""))
        ]);
      } else if (result is Error<MyBadgeResponse>) {}
    }).catchError((error) {});
  }
}
