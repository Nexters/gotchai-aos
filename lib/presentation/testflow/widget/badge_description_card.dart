import 'package:flutter/material.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/widgets/button.dart';

class BadgeDescriptionCard extends StatelessWidget {
  final String theme;
  final String prompt;
  final String iconImage;
  final VoidCallback onTap;

  const BadgeDescriptionCard({
    super.key,
    required this.theme,
    required this.prompt,
    required this.iconImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(191, 201, 231, 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.only(top: 40.h, right: 20.w, left: 20.w, bottom: 8.h),
      child: Column(
        children: [
          Text(
            theme,
            style: GotchaiTextStyles.subtitle2
                .copyWith(color: GotchaiColorStyles.primary300),
          ),
          Text("이 프롬프트로 만들었어요", style: GotchaiTextStyles.subtitle1),
          SizedBox(height: 16.h),
          ClipOval(
              child: Image.network(
            iconImage,
            width: 133.w,
            height: 133.w,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/icon/icon_empty_graphic.png',
                width: 133.w,
                height: 133.w,
                fit: BoxFit.fill,
              );
            },
          )),
          SizedBox(height: 16.h),
          Text(prompt,
              textAlign: TextAlign.center,
              style: GotchaiTextStyles.body4
                  .copyWith(color: Color.fromRGBO(255, 255, 255, 0.8))),
          SizedBox(height: 32.h),
          Divider(
            color: GotchaiColorStyles.gray500,
          ),
          Button(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              onTap: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icon/icon_copy.png',
                      width: 10.w, height: 10.w),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text("프롬프트 복사하기",
                      style: GotchaiTextStyles.body3
                          .copyWith(color: GotchaiColorStyles.primary400))
                ],
              ))
        ],
      ),
    );
  }
}
