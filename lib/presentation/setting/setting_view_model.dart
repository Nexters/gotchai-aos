import 'package:turing/core/utils/url_util.dart';
import 'package:turing/data/datasources/remote/login_service.dart';
import 'package:turing/data/models/root_response.dart';
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

class SettingSuccess extends SettingState {
  final String message;
  const SettingSuccess(this.message);
}

enum UrlType { security, policy, ask }

@riverpod
class SettingViewModel extends _$SettingViewModel {
  @override
  SettingState build() {
    return const SettingInitial();
  }

  String policy = "https://pretty-icicle-cfc.notion.site/gotchai2?pvs=74";
  String security = "https://pretty-icicle-cfc.notion.site/gotchai";
  String ask = "https://forms.gle/bWFFvVC1iyTSRuGP6";

  Future<void> logout() async {
    await LoginService().logout().then((result) {
      if (result is Success<void>) {
        state = SettingSuccess("로그아웃 성공");
        NavigationService().navigateClear(NavigationRoute.login);
      } else if (result is Error<void>) {
        state = SettingFailure('로그아웃 실패 : ${result.message}');
      }
    }).catchError((error) {
      state = SettingFailure('예외 발생 : ${error.toString()}');
    });
  }

  Future<void> withdrawal() async {
    await LoginService().withdrawal().then((result) {
      if (result is Success<void>) {
        state = SettingSuccess("회원탈퇴 성공");
        NavigationService().navigateClear(NavigationRoute.login);
      } else if (result is Error<void>) {
        state = SettingFailure('탈퇴 실패 : ${result.message}');
      }
    }).catchError((error) {
      state = SettingFailure('예외 발생 : ${error.toString()}');
    });
  }

  void navigateToBack() {
    NavigationService().goBack();
  }

  void openUrl(UrlType type) {
    String url;
    switch (type) {
      case UrlType.policy:
        url = policy;
        break;
      case UrlType.security:
        url = security;
        break;
      case UrlType.ask:
        url = ask;
        break;
    }
    UrlUtil.launchURL(url);
  }
}
