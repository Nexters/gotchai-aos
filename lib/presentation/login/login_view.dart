import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/login/login_view_model.dart';
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
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 400.h),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Image.asset('assets/icon/gotchai_logo.png',
                width: double.infinity, height: 120.h, fit: BoxFit.fitWidth)),
        SizedBox(height: 20.h),
        Text(
          '인간 사이 숨은 AI 찾기',
          style: GotchaiTextStyles.body2
              .copyWith(color: GotchaiColorStyles.gray200),
        ),
        SizedBox(height: 600.h),
        GestureDetector(
            onTap: () {
              viewModel.kakaoLogin();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Image.asset(
                "assets/icon/icon_kakao_login.png",
                width: double.infinity,
                height: 200.h,
              ),
            )),
        SizedBox(height: 20.h),
        Button(
          onTap: () {
            viewModel.testLogin();
          },
          width: double.infinity,
          height: 120.h,
          child: Container(
            width: double.infinity,
            height: 120.h,
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
    ));
  }
}
