import 'package:flutter/material.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';

class HomeTestWidget extends StatelessWidget {
  final List<String> items;
  final ValueChanged<int> onItemTap;

  const HomeTestWidget({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GotchaiColorStyles.gray900,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              "13개의 새로운 테스트가 있어요",
              style: GotchaiTextStyles.body4
                  .copyWith(color: GotchaiColorStyles.gray400),
            ),
            SizedBox(height: 30.h),

            ...items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return GestureDetector(
                onTap: () {
                  onItemTap(index);
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
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/icon/icon_empty_graphic.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item,
                              style: GotchaiTextStyles.body2,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Items',
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
