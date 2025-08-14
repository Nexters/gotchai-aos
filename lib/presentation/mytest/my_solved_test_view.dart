import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/constants/Constants.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/presentation/mytest/my_solved_test_view_model.dart';
import 'package:turing/widgets/button.dart';

class MySolvedTestView extends ConsumerStatefulWidget {
  const MySolvedTestView({
    super.key,
  });

  @override
  ConsumerState<MySolvedTestView> createState() => _MySolvedTestViewState();
}

class _MySolvedTestViewState extends ConsumerState<MySolvedTestView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mySolvedTestViewModelProvider.notifier).getMySolvedTest();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mySolvedTestViewModelProvider);
    final viewModel = ref.read(mySolvedTestViewModelProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: Constants.topPadding,
            left: Constants.horizontalPadding,
            right: Constants.horizontalPadding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button(
                    onTap: viewModel.navigateToback,
                    child: Image.asset("assets/icon/icon_back.png",
                        width: Constants.iconSize,
                        height: Constants.iconSize,
                        fit: BoxFit.fill)),
                Text("내가 풀었던 테스트", style: GotchaiTextStyles.body1),
                SizedBox(width: 12.w)
              ],
            ),
            SizedBox(height: 80.h),
            Expanded(
              child: state.isEmpty
                  ? Center(
                      child: Text(
                        "풀었던 테스트가 없습니다",
                        style: GotchaiTextStyles.body3
                            .copyWith(color: GotchaiColorStyles.gray500),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        viewModel.getMySolvedTest();
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...state.map((item) {
                              return _buildListItem(item);
                            }),
                            SizedBox(height: 100.h)
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String item) {
    return Container(
      padding: EdgeInsets.all(20.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: GotchaiColorStyles.gray900,
        borderRadius: BorderRadius.circular(12.w),
      ),
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Image.asset("assets/icon/icon_empty_graphic.png",
              width: 20.w, height: 20.w),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item,
                  style: GotchaiTextStyles.body3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  "7개중 4개 맞췄어요",
                  style: GotchaiTextStyles.body4
                      .copyWith(color: GotchaiColorStyles.gray500),
                ),
              ],
            ),
          ),
          Spacer(),
          Text(
            "57%",
            style: GotchaiTextStyles.body4
                .copyWith(color: GotchaiColorStyles.blue),
          )
        ],
      ),
    );
  }
}
