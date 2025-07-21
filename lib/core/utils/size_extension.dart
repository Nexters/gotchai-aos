import 'package:turing/core/utils/screen_util.dart';

extension ResponsiveScaleExtension on num {
  double get w => ScreenUtil().setWidth(this);

  double get h => ScreenUtil().setHeight(this);
}
