import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/constants/Constants.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/testflow/test_view_model.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';
import 'package:turing/widgets/button.dart';

class TestCoverView extends ConsumerWidget {
  const TestCoverView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final test = ref.watch(testViewModelProvider);

    void navigateToBack() {
      NavigationService().goBack();
    }

    void navigateToTestIntro() {
      NavigationService().navigateWithFade(NavigationRoute.testIntro);
    }

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(
          top: Constants.topPadding,
          left: Constants.horizontalPadding,
          right: Constants.horizontalPadding),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Button(
              onTap: navigateToBack,
              child: Image.asset("assets/icon/icon_back.png",
                  width: Constants.iconSize,
                  height: Constants.iconSize,
                  fit: BoxFit.fill),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Image.network(test.iconImage,
              width: 40.w, height: 40.w, fit: BoxFit.fill),
          SizedBox(
            height: 20.h,
          ),
          Text(
            test.title,
            style: GotchaiTextStyles.title2.copyWith(
              color: GotchaiColorStyles.primary400,
            ),
          ),
          Text(
            test.subTitle,
            style: GotchaiTextStyles.title4.copyWith(
              color: GotchaiColorStyles.white,
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Text(
            "AI가 한 말은 무엇일까요?",
            style: GotchaiTextStyles.body3.copyWith(
              color: GotchaiColorStyles.gray300,
            ),
          ),
          SizedBox(
            height: 34.h,
          ),
          ClipOval(
              child: Image.network(
            test.coverImage,
            width: 305.w,
            height: 305.w,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/icon/icon_empty_graphic.png',
                width: 305.w,
                height: 305.w,
                fit: BoxFit.fill,
              );
            },
          )),
          SizedBox(
            height: 44.h,
          ),
          Button(
            onTap: navigateToTestIntro,
            width: 345.w,
            height: 57.h,
            child: Container(
              width: 345.w,
              height: 57.h,
              decoration: BoxDecoration(
                color: GotchaiColorStyles.primary400,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  "시작하기",
                  style: GotchaiTextStyles.body2.copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Button(
            onTap: () {},
            width: 345.w,
            height: 57.h,
            child: Container(
              width: 345.w,
              height: 57.h,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  "테스트 공유하기",
                  style: GotchaiTextStyles.body3
                      .copyWith(color: GotchaiColorStyles.gray200),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
