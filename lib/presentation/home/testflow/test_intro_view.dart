import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/home/testflow/test_view_model.dart';
import 'package:turing/widgets/button.dart';

class TestIntroView extends ConsumerWidget {
  const TestIntroView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exam = ref.watch(testViewModelProvider);

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: 100.h, left: 10.w, right: 10.w),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Button(
              onTap: () {},
              child: Image.asset("assets/icon/icon_back.png",
                  width: 20.w, height: 20.w, fit: BoxFit.fill),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 80.h,
          ),
          Button(
            onTap: () {},
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
                  "다음",
                  style: GotchaiTextStyles.body2.copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
