import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/login/login_view_model.dart';
import 'package:turing/presentation/popup/custom_snackbar.dart';
import 'package:turing/widgets/button.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(loginViewModelProvider.notifier);

    ref.listen<LoginState>(loginViewModelProvider, (previous, next) {
      if (next is LoginFailure) {
        CustomSnackBar.showError(context, next.message);
      }
    });

    return Scaffold(
        body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 166.h),
                Image.asset('assets/icon/gotchai_logo.png',
                    width: 235.w, height: 54.h, fit: BoxFit.fill),
                SizedBox(height: 12.h),
                Text(
                  '인간 사이 숨은 AI 찾기',
                  style: GotchaiTextStyles.body2
                      .copyWith(color: GotchaiColorStyles.gray200),
                ),
                SizedBox(height: 302.h),
                GestureDetector(
                  onTap: () {
                    viewModel.kakaoLogin();
                  },
                  child: Image.asset(
                    "assets/icon/icon_kakao_login.png",
                    width: 327.w,
                    height: 57.h,
                  ),
                ),
                SizedBox(height: 16.h),
                Button(
                  onTap: () {
                    viewModel.testLogin();
                  },
                  width: 327.w,
                  height: 57.h,
                  child: Container(
                    width: 327.w,
                    height: 57.h,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        "테스트 로그인",
                        style: GotchaiTextStyles.body3
                            .copyWith(color: GotchaiColorStyles.gray200),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
