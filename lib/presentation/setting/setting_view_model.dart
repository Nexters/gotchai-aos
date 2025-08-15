import 'package:turing/data/datasources/remote/login_service.dart';
import 'package:turing/data/models/base_response.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setting_view_model.g.dart';

sealed class SettingState {
  const SettingState();
}

class SettingInitial extends SettingState {
  const SettingInitial();
}

class SettingLoading extends SettingState {
  const SettingLoading();
}

class SettingFailure extends SettingState {
  final String message;
  const SettingFailure(this.message);
}

@riverpod
class SettingViewModel extends _$SettingViewModel {
  @override
  SettingState build() {
    return const SettingInitial();
  }

  Future<void> logout() async {
    await LoginService().logout().then((result) {
      if (result is Success<void>) {
        NavigationService().navigateClear(NavigationRoute.login);
      } else if (result is Error<void>) {
        state = SettingFailure('로그아웃 실패 : ${result.message}');
      }
    }).catchError((error) {
      state = SettingFailure('예외 발생 : ${error.toString()}');
    });
  }
}
