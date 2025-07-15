import 'package:turing/data/datasources/login_service.dart';
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

  Future<void> login() async {
    state = const LoginLoading();

    await LoginService().login("", "KAKAO").then((result) {
      if (result is Success<LoginResponse>) {
        NavigationService().navigateClearTo(NavigationRoute.home);
      } else if (result is Error<LoginResponse>) {
        state = const LoginFailure('로그인 실패');
      }
    });
  }
}
