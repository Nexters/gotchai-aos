import 'package:flutter/material.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';

class HomeProfileWidget extends StatelessWidget {
  final Future<void> Function() onRefresh;

  const HomeProfileWidget({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: GotchaiColorStyles.primary400,
      backgroundColor: GotchaiColorStyles.gray800,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40.h),
            ClipOval(
              child: Image.network(
                "",
                width: 50.w,
                height: 50.w,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/icon/icon_empty_graphic.png',
                    width: 50.w,
                    height: 50.w,
                  );
                },
              ),
            ),
            SizedBox(height: 30.h),
            Container(
              width: 40.w,
              height: 80.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFF1E2803),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: GotchaiColorStyles.primary600,
                  width: 1,
                ),
              ),
              child: Text(
                "갓챠135",
                style: GotchaiTextStyles.body4,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/image/image_ranking5.png",
                      width: double.infinity,
                      height: 350.h,
                      fit: BoxFit.fill,
                    )),
                Positioned(
                    left: 10.w,
                    top: 10.w,
                    child: Column(
                      children: [
                        Text("갓챠135님은",
                            style: GotchaiTextStyles.body6.copyWith(
                                color: Color.fromRGBO(255, 255, 255, 0.6))),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text("상위 5%", style: GotchaiTextStyles.subtitle2),
                      ],
                    )),
              ],
            ),
            Container(
                width: double.infinity,
                height: 400.h,
                decoration: BoxDecoration(
                  color: GotchaiColorStyles.gray900,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [],
                ))
          ],
        ),
      ),
    );
  }
}
