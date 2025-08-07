import 'package:flutter/material.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/data/models/exam_list_response.dart';

class HomeTestWidget extends StatelessWidget {
  final List<Exam> examList;
  final ValueChanged<Exam> onItemTap;

  const HomeTestWidget({
    super.key,
    required this.examList,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GotchaiColorStyles.gray900,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            Image.asset(
              'assets/icon/icon_ab.png',
              width: 20.w,
              height: 10.w,
            ),
            SizedBox(height: 20.h),
            // 텍스트
            Text(
              "테스트",
              style: GotchaiTextStyles.body2,
            ),
            SizedBox(height: 10.h),
            Text(
              "${examList.length}개의 새로운 테스트가 있어요",
              style: GotchaiTextStyles.body4
                  .copyWith(color: GotchaiColorStyles.gray400),
            ),
            SizedBox(height: 30.h),

            ...examList.map((exam) {
              return GestureDetector(
                onTap: () {
                  onItemTap(exam);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: GotchaiColorStyles.gray800,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20.w),
                          child: Image.network(
                            exam.iconImage,
                            width: 40.w,
                            height: 40.w,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/icon/icon_empty_graphic.png',
                                width: 40.w,
                                height: 40.w,
                                fit: BoxFit.cover,
                              );
                            },
                          )),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exam.title,
                              style: GotchaiTextStyles.body2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              exam.subTitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GotchaiTextStyles.body4.copyWith(
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
            })
          ],
        ),
      ),
    );
  }
}
