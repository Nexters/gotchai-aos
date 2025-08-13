import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/home/testflow/test_view_model.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';
import 'package:turing/widgets/button.dart';

class TestCoverView extends ConsumerWidget {
  const TestCoverView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exam = ref.watch(testViewModelProvider);

    void navigateToBack() {
      NavigationService().goBack();
    }

    void navigateToTestIntro() {
      NavigationService().navigateWithFade(NavigationRoute.testIntro);
    }

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: 120.h, left: 10.w, right: 10.w),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Button(
              onTap: navigateToBack,
              child: Image.asset("assets/icon/icon_back.png",
                  width: 12.w, height: 12.w, fit: BoxFit.fill),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Image.network(exam.iconImage,
              width: 20.w, height: 20.w, fit: BoxFit.fill),
          SizedBox(
            height: 20.h,
          ),
          Text(
            exam.title,
            style: GotchaiTextStyles.title2.copyWith(
              color: GotchaiColorStyles.primary400,
            ),
          ),
          Text(
            exam.subTitle,
            style: GotchaiTextStyles.title4.copyWith(
              color: GotchaiColorStyles.white,
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Text(
            "AI가 한 말은 무엇일까요?",
            style: GotchaiTextStyles.body3.copyWith(
              color: GotchaiColorStyles.gray300,
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(100.w),
              child: Image.network(
                exam.coverImage,
                width: 130.w,
                height: 130.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/icon/icon_empty_graphic.png',
                    width: 130.w,
                    height: 130.w,
                    fit: BoxFit.cover,
                  );
                },
              )),
          SizedBox(
            height: 80.h,
          ),
          Button(
            onTap: navigateToTestIntro,
            width: double.infinity,
            height: 120.h,
            child: Container(
              width: double.infinity,
              height: 120.h,
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
          SizedBox(height: 16.h),
          Button(
            onTap: () {},
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
