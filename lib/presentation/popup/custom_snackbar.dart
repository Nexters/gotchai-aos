import 'package:flutter/material.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turing/core/utils/text_style.dart';

class CustomSnackBar {
  static void showError(BuildContext context, String message) {
    _showSnackBar(
      context: context,
      message: message,
      backgroundColor: GotchaiColorStyles.red,
      icon: Icons.error,
      iconColor: Colors.white,
    );
  }

  static void showInfo(BuildContext context, String message) {
    _showSnackBar(
      context: context,
      message: message,
      backgroundColor: GotchaiColorStyles.gray700,
      icon: Icons.info,
      iconColor: GotchaiColorStyles.primary400,
    );
  }

  static void _showSnackBar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    IconData? icon,
    Color? iconColor,
    Duration? duration,
    EdgeInsets? margin,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: iconColor ?? Colors.white,
                size: 20.w,
              ),
              SizedBox(width: 8.w),
            ],
            Expanded(
              child: Text(
                message,
                style: GotchaiTextStyles.body3.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration ?? Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        margin:
            margin ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.w),
        ),
      ),
    );
  }
}
