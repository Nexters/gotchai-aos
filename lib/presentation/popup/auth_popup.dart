import 'package:flutter/material.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/widgets/button.dart';

class AuthPopup {
  static Future<void> showAuthDialog(
    BuildContext context,
    String title,
    String description,
    String confirmButtonText,
    VoidCallback onCancelPressed,
    VoidCallback onConfirmPressed,
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
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 48.h,
              ),
              Text(title,
                  textAlign: TextAlign.center,
                  style: GotchaiTextStyles.body1
                      .copyWith(color: GotchaiColorStyles.gray100)),
              description.isEmpty
                  ? SizedBox.shrink()
                  : Column(
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          description,
                          textAlign: TextAlign.center,
                          style: GotchaiTextStyles.body5
                              .copyWith(color: GotchaiColorStyles.gray300),
                        ),
                      ],
                    ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: Button(
                    onTap: onCancelPressed,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: GotchaiColorStyles.gray700,
                      borderRadius: BorderRadius.circular(16.w),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "취소",
                      style: GotchaiTextStyles.body3
                          .copyWith(color: GotchaiColorStyles.gray200),
                    ),
                  )),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                      child: Button(
                    onTap: onConfirmPressed,
                    height: 48.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: GotchaiColorStyles.primary400,
                      borderRadius: BorderRadius.circular(16.w),
                    ),
                    child: Text(
                      confirmButtonText,
                      style:
                          GotchaiTextStyles.body3.copyWith(color: Colors.black),
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        );
      },
    );
  }
}
