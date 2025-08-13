import 'package:flutter/material.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
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
            borderRadius: BorderRadius.circular(12.w),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 아이콘
              switch (type) {
                QuizResult.correct => Image.asset(
                    "assets/icon/icon_correct.png",
                    width: 80.w,
                    height: 60.w,
                  ),
                QuizResult.wrong => Image.asset(
                    "assets/icon/icon_wrong.png",
                    width: 80.w,
                    height: 60.w,
                  ),
                QuizResult.timeout => Image.asset(
                    "assets/icon/icon_timeout.png",
                    width: 80.w,
                    height: 60.w,
                  ),
              },

              SizedBox(height: 30.h),

              Text(
                  switch (type) {
                    QuizResult.correct => "AI를 찾아냈어요!",
                    QuizResult.wrong => "사람이 작성한 대답이에요",
                    QuizResult.timeout => "시간이 초과됐어요!",
                  },
                  style: GotchaiTextStyles.subtitle1),

              SizedBox(height: 30.h),

              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.w, vertical: 30.h),
                  decoration: BoxDecoration(
                    color: GotchaiColorStyles.gray800,
                    borderRadius: BorderRadius.circular(8.w),
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

              SizedBox(height: 60.h),

              Button(
                onTap: onButtonPressed,
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
