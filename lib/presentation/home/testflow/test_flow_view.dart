import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/presentation/home/testflow/test_view_model.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';
import 'package:turing/widgets/button.dart';

class TestFlowView extends ConsumerStatefulWidget {
  const TestFlowView({super.key});

  @override
  ConsumerState<TestFlowView> createState() => _TestFlowViewState();
}

class _TestFlowViewState extends ConsumerState<TestFlowView> {
  @override
  Widget build(BuildContext context) {
    final exam = ref.watch(testViewModelProvider);
    double _progress = 0.5;

    void navigateToBack() {
      NavigationService().goBackUntil(NavigationRoute.testCover);
    }

    return Scaffold(
      body: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
            child: Image.network(
              exam.backgroundImage,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Color.fromRGBO(0, 0, 0, 0.7),
          ),
          Padding(
            padding: EdgeInsets.only(top: 120.h, left: 10.w, right: 10.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Button(
                    onTap: navigateToBack,
                    child: Image.asset("assets/icon/icon_close.png",
                        width: 12.w, height: 12.w, fit: BoxFit.fill),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  width: double.infinity,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.2),
                    borderRadius: BorderRadius.circular(1.w),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _progress,
                    child: Container(
                      decoration: BoxDecoration(
                        color: GotchaiColorStyles.primary400,
                        borderRadius: BorderRadius.circular(1.w),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
