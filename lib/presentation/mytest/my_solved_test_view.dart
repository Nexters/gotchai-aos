import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turing/core/constants/Constants.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/size_extension.dart';
import 'package:turing/core/utils/text_style.dart';
import 'package:turing/data/models/my_solved_test_response.dart';
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
      ref.read(mySolvedTestViewModelProvider.notifier).getMySolvedTestList();
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
            SizedBox(height: 40.h),
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
                        viewModel.getMySolvedTestList();
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 40.h),
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

  Widget _buildListItem(MySolvedTest item) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: GotchaiColorStyles.gray900,
        borderRadius: BorderRadius.circular(12.w),
      ),
      margin: EdgeInsets.only(bottom: 30.h),
      child: Row(
        children: [
          Image.network(
            item.iconImage,
            width: 22.w,
            height: 22.w,
            fit: BoxFit.fill,
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
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
