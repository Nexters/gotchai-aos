import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/log_util.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/home/widget/home_test_widget.dart';
import 'package:turing/widgets/button.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(top: 100.h, left: 10.w, right: 10.w),
            child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/icon/gotchai_logo.png',
                            width: 60.w, height: 60.h, fit: BoxFit.fill),
                        Button(
                            child: Image.asset('assets/icon/icon_setting.png',
                                width: 12.w, height: 12.w, fit: BoxFit.fill),
                            onTap: () {}),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.topLeft, // TabBar를 중앙 정렬
                      child: SizedBox(
                        width: 80.w, // TabBar의 가로 크기를 제한
                        child: TabBar(
                          dividerHeight: 0,
                          labelColor: GotchaiColorStyles.primary400,
                          unselectedLabelColor: GotchaiColorStyles.gray600,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: GotchaiColorStyles.primary400,
                          labelStyle: GotchaiTextStyles.body2,
                          unselectedLabelStyle: GotchaiTextStyles.body2,
                          tabs: const [
                            Tab(
                              text: '테스트',
                            ),
                            Tab(text: '내 업적'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Expanded(
                        child: TabBarView(children: [
                      HomeTestWidget(
                        items: [
                          'asdf',
                          'asdf',
                          'asdf',
                          'asdf',
                          'asdf',
                          'asdf',
                          'asdf',
                          'asdf',
                          'asdf',
                          'asdf',
                        ],
                        onItemTap: (index) {
                          logger.d(index);
                        },
                      ),
                      Center(
                        child: Text(
                          '내 업적 페이지입니다',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ]))
                  ],
                ))));
  }
}
