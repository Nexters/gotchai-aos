import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:turing/core/utils/log_util.dart';
import 'package:turing/data/datasources/remote/login_service.dart';
import 'package:turing/data/models/base_response.dart';
import 'package:turing/data/models/login_response.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_view_model.g.dart';

sealed class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginFailure extends LoginState {
  final String message;
  const LoginFailure(this.message);
}

@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  LoginState build() {
    return const LoginInitial();
  }

  Future<void> kakaoLogin() async {
    state = const LoginLoading();
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      if (isInstalled) {
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
          await login(token.accessToken);
        } catch (e) {
          state = LoginFailure('로그인 실패 : $e');
        }
      } else {
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          await login(token.accessToken);
        } catch (e) {
          state = LoginFailure('로그인 실패 : $e');
        }
      }
    } catch (e) {
      state = LoginFailure('로그인 실패 : $e');
    }
  }

  Future<void> login(String accessToken) async {
    await LoginService().login(accessToken).then((result) {
      if (result is Success<LoginResponse>) {
        NavigationService().navigateClear(NavigationRoute.home);
      } else if (result is Error<LoginResponse>) {
        state = LoginFailure('로그인 실패 : ${result.message}');
      }
    }).catchError((error) {
      state = LoginFailure('로그인 실패 : $error');
      logger.e('로그인 실패 : $error');
    });
  }
}
