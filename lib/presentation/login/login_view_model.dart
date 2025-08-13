import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:turing/core/utils/log_util.dart';
import 'package:turing/data/datasources/local/token_service.dart';
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

  Future<void> testLogin() async {
    await TokenService.saveTokens(
      accessToken:
          "eyJhbGciOiJSUzUxMiJ9.eyJpYXQiOjE3NTQ2NTc0NjYsImV4cCI6MTc1NDgzMDI2NiwiaXNzIjoiR290Y2hhaSIsInVzZXJJZCI6IjIiLCJyb2xlcyI6Ik1FTUJFUiJ9.dO_p0kQnweDNRgVkVsFm1JpyrZUSMjjyf7AFspIt_JPK3vPktb3gOm4qgiudsYJkzPvxHPBmGEfPTpFtvshbtDB0bESbnKQvSeiSapcd2huOVWCiRfuU9zAU0JpDkz95YIE6z5CboXrODIW-iT-j1voISEQHBHdmrVhDZYjuBGjuptIoknBR6aZekGFmnsOkYeBNm51chPGc6s8j1J_x4VHUSWuY8_GoVW8E_wcGr5qDCqRScTW-mQZsiYW2sufsCHcliRZGE3ZggSMVrZj3P9z60ZIy0r4qLQ7JqPZK3cHonjq6DbqcpQMPjItGft08v0L9ZWV0lnzWkJuElN0DmA",
      refreshToken:
          "eyJhbGciOiJSUzUxMiJ9.eyJpYXQiOjE3NTQ2NTc0NjYsImV4cCI6MTc1NzA3NjY2NiwiaXNzIjoiR290Y2hhaSIsInVzZXJJZCI6IjIiLCJyb2xlcyI6Ik1FTUJFUiJ9.A_mODV5hi9pyaxWLUdSSPEuZXRNZUXTYoo_zJB9jebT9zCcWqSAyQd4ppSj0AfNpvIkzkEQmJcKdBqWDHT-NtVQvYjqEuPDZUeVdW2mOmAFGtGNPXlaqmW_lyO5-1f91hGcG9KC878Da8pCsRbc9-VBaxQxnsDE1RXPh0ba9x7xSsYWANYMf9qXhFgl3sk6v9M7GZqE_pM4Ykjiv8PpAdJHVdJ7Yr_DMIBr49GDjKi1RHIWziI-yngYvAgk1Umu0OCMDEIT2PlmNQ9N3aHKzbtEUPhPRmMv2W-WJyj9NfR1P5tPYVv1tJEvqPiKE8b1FOHlCmfI71Z8CSN3u8hi9Qw",
    );

    NavigationService().navigateClear(NavigationRoute.home);
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
