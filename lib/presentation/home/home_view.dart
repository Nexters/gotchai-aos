import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/data/models/test_list_response.dart';
import 'package:turing/presentation/home/home_view_model.dart';
import 'package:turing/presentation/home/widget/home_profile_widget.dart';
import 'package:turing/presentation/testflow/test_view_model.dart';
import 'package:turing/presentation/home/widget/home_test_widget.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';
import 'package:turing/widgets/button.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(homeViewModelProvider.notifier);
    final testViewModel = ref.watch(testViewModelProvider.notifier);
    final homeState = ref.watch(homeViewModelProvider);

    Future<void> _precacheTestImages(List<Test> testList) async {
      final validImages = testList
          .where((test) => test.iconImage.isNotEmpty)
          .map((test) => test.iconImage)
          .toList();

      if (validImages.isEmpty) return;

      final futures = validImages
          .map((imageUrl) =>
                  precacheImage(Image.network(imageUrl).image, context)
                      .catchError((_) => null) // 에러 무시
              )
          .toList();

      try {
        await Future.wait(futures, eagerError: false);
      } catch (e) {
        print("⚠️ 프리캐시 중 오류: $e");
      }
    }

    ref.listen<HomeState>(homeViewModelProvider, (previous, next) {
      if (previous is HomeLoading &&
          next is HomeLoaded &&
          next.testList.isNotEmpty) {
        _precacheTestImages(next.testList);
      }
    });

    void onItemTap(Test test) {
      testViewModel.setCurTestInfo(test);
      NavigationService().navigateWithSlide(NavigationRoute.testCover);
    }

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/icon/gotchai_logo.png',
                              width: 60.w, height: 60.h, fit: BoxFit.fill),
                          Button(
                              child: Image.asset('assets/icon/icon_setting.png',
                                  width: 24.w, height: 24.w, fit: BoxFit.fill),
                              onTap: () {}),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 80.w,
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
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Expanded(
                        child: TabBarView(children: [
                      switch (homeState) {
                        HomeInitial() => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        HomeLoading() => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        HomeLoaded(testList: final testList) => HomeTestWidget(
                            testList: testList,
                            onItemTap: onItemTap,
                            onRefresh: () async {
                              await viewModel.getExamList();
                            }),
                        HomeError(message: final message) => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('오류: $message'),
                                ElevatedButton(
                                  onPressed: () => viewModel.getExamList(),
                                  child: Text('다시 시도'),
                                ),
                              ],
                            ),
                          ),
                      },
                      Align(
                          alignment: Alignment.topCenter,
                          child: HomeProfileWidget(
                            onRefresh: () async {},
                            onBadgeForwardTap: () {},
                            onSolvedTestForwardTap: () {},
                          ))
                    ])),
                  ],
                ))));
  }
}
