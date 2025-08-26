import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/login/login_view_model.dart';
import 'package:turing/presentation/popup/custom_toast.dart';

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
        CustomToast.showError(context, next.message);
      }

      if (next is LoginSuccess) {
        CustomToast.showSuccess(context, next.message);
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
                    width: 251.w, height: 70.h, fit: BoxFit.fill),
                SizedBox(height: 4.h),
                Text(
                  '인간 사이 숨은 AI 찾기',
                  style: GotchaiTextStyles.body2
                      .copyWith(color: GotchaiColorStyles.gray200),
                ),
                SizedBox(height: 332.h),
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
              ],
            )));
  }
}
