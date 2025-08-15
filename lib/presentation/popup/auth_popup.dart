import 'package:flutter/material.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
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
            borderRadius: BorderRadius.circular(12.w),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.w),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Text(title,
                  textAlign: TextAlign.center,
                  style: GotchaiTextStyles.body1
                      .copyWith(color: GotchaiColorStyles.gray100)),
              SizedBox(height: 20.h),
              description.isEmpty
                  ? SizedBox.shrink()
                  : Text(
                      description,
                      textAlign: TextAlign.center,
                      style: GotchaiTextStyles.body5
                          .copyWith(color: GotchaiColorStyles.gray300),
                    ),
              description.isEmpty
                  ? SizedBox(
                      height: 40.h,
                    )
                  : SizedBox(height: 60.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: Button(
                    onTap: onCancelPressed,
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    decoration: BoxDecoration(
                      color: GotchaiColorStyles.gray700,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "취소",
                      style: GotchaiTextStyles.body3
                          .copyWith(color: GotchaiColorStyles.gray200),
                      textAlign: TextAlign.center,
                    ),
                  )),
                  SizedBox(
                    width: 4.w,
                  ),
                  Expanded(
                      child: Button(
                    onTap: onConfirmPressed,
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    decoration: BoxDecoration(
                      color: GotchaiColorStyles.primary400,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      confirmButtonText,
                      textAlign: TextAlign.center,
                      style:
                          GotchaiTextStyles.body3.copyWith(color: Colors.black),
                    ),
                  )),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
