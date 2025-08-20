import 'package:flutter/material.dart';
import 'package:turing/core/constants/Constants.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/data/models/test_list_response.dart';
import 'package:turing/presentation/popup/custom_toast.dart';

class HomeTestWidget extends StatelessWidget {
  final List<Test> testList;
  final ValueChanged<Test> onItemTap;
  final Future<void> Function() onRefresh;

  const HomeTestWidget({
    super.key,
    required this.testList,
    required this.onItemTap,
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
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(
              left: Constants.horizontalPadding,
              right: Constants.horizontalPadding,
              top: 20.h),
          decoration: BoxDecoration(
            color: GotchaiColorStyles.gray900,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Image.asset(
                'assets/icon/icon_ab.png',
                width: 40.w,
                height: 20.h,
              ),
              SizedBox(height: 16.h),
              // 텍스트
              Text(
                "테스트",
                style: GotchaiTextStyles.body2,
              ),
              SizedBox(height: 10.h),
              Text(
                "${testList.length}개의 새로운 테스트가 있어요",
                style: GotchaiTextStyles.body4
                    .copyWith(color: GotchaiColorStyles.gray400),
              ),
              SizedBox(height: 16.h),

              ...testList.map((test) {
                return GestureDetector(
                  onTap: () {
                    test.isSolved
                        ? CustomToast.showInfo(context, "이미 푼 문제입니다")
                        : onItemTap(test);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 10.w,
                    ),
                    decoration: BoxDecoration(
                      color: GotchaiColorStyles.gray800,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 80.w,
                              height: 80.w,
                              decoration: BoxDecoration(
                                color: GotchaiColorStyles.gray900,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.network(
                                  test.iconImage,
                                  width: 56.w,
                                  height: 56.w,
                                  fit: BoxFit.fill,
                                  color: test.isSolved
                                      ? Colors.grey.shade700
                                      : null,
                                  colorBlendMode:
                                      test.isSolved ? BlendMode.modulate : null,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/icon/icon_empty_graphic.png',
                                      width: 56.w,
                                      height: 56.w,
                                      fit: BoxFit.fill,
                                    );
                                  },
                                ),
                              ),
                            ),
                            test.isSolved
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(42, 43, 47, 0.7),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 3.h),
                                    child: Center(
                                      child: Text(
                                        "풀기 완료",
                                        style: GotchaiTextStyles.body6.copyWith(
                                          color: GotchaiColorStyles.gray50,
                                        ),
                                      ),
                                    ))
                                : SizedBox.shrink(),
                          ],
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                test.title,
                                style: GotchaiTextStyles.body3,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                test.subTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GotchaiTextStyles.body5.copyWith(
                                  color: GotchaiColorStyles.gray400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: 10.h)
            ],
          ),
        ),
      ),
    );
  }
}
