import 'package:flutter/material.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/data/models/test_list_response.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: GotchaiColorStyles.gray900,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: RefreshIndicator(
        onRefresh: onRefresh,
        color: GotchaiColorStyles.primary400,
        backgroundColor: GotchaiColorStyles.gray800,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
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
                "${testList.length}개의 새로운 테스트가 있어요",
                style: GotchaiTextStyles.body4
                    .copyWith(color: GotchaiColorStyles.gray400),
              ),
              SizedBox(height: 30.h),

              ...testList.map((test) {
                return GestureDetector(
                  onTap: () {
                    onItemTap(test);
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
                        Stack(
                          children: [
                            Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                color: GotchaiColorStyles.gray900,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.network(
                                  test.iconImage,
                                  width: 22.w,
                                  height: 22.w,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/icon/icon_empty_graphic.png',
                                      width: 24.w,
                                      height: 24.w,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                test.title,
                                style: GotchaiTextStyles.body2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                test.subTitle,
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
              }),
              SizedBox(height: 100.h)
            ],
          ),
        ),
      ),
    );
  }
}
