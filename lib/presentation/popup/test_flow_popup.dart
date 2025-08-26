import 'package:flutter/material.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/widgets/button.dart';

enum QuizResult { correct, wrong, timeout }

class TestFlowPopup {
  static Future<void> showAnswerDialog(
    BuildContext context,
    String answer,
    QuizResult type,
    VoidCallback onButtonPressed,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: GotchaiColorStyles.gray900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 16.h,
              ),
              switch (type) {
                QuizResult.correct => Image.asset(
                    "assets/icon/icon_correct.png",
                    width: 190.w,
                    height: 123.h,
                  ),
                QuizResult.wrong => Image.asset(
                    "assets/icon/icon_wrong.png",
                    width: 190.w,
                    height: 123.h,
                  ),
                QuizResult.timeout => Image.asset(
                    "assets/icon/icon_timeout.png",
                    width: 190.w,
                    height: 123.h,
                  ),
              },
              SizedBox(height: 36.h),
              Text(
                  switch (type) {
                    QuizResult.correct => "AI를 찾아냈어요!",
                    QuizResult.wrong => "사람이 작성한 대답이에요",
                    QuizResult.timeout => "시간이 초과됐어요!",
                  },
                  style: GotchaiTextStyles.subtitle1),
              SizedBox(height: 20.h),
              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: GotchaiColorStyles.gray800,
                    borderRadius: BorderRadius.circular(16.w),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("정답 공개",
                          style: GotchaiTextStyles.body4
                              .copyWith(color: GotchaiColorStyles.gray200)),
                      Divider(
                        color: GotchaiColorStyles.gray600,
                      ),
                      Text(
                        answer,
                        style: GotchaiTextStyles.body1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
              SizedBox(height: 32.h),
              Button(
                onTap: onButtonPressed,
                width: double.infinity,
                height: 57.h,
                child: Container(
                  width: double.infinity,
                  height: 57.h,
                  decoration: BoxDecoration(
                    color: GotchaiColorStyles.primary400,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      type == QuizResult.timeout ? "다음 문제로 넘어가기" : "다음",
                      style:
                          GotchaiTextStyles.body2.copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
