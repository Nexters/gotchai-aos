import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class ScreenUtil {
  ScreenUtil._internal({
    double screenWidthBase = 384,
    double screenHeightBase = 823.5,
  })  : _screenWidthBase = screenWidthBase,
        _screenHeightBase = screenHeightBase;

  static ScreenUtil? _instance;

  factory ScreenUtil({
    double screenWidthBase = 384,
    double screenHeightBase = 823.5,
  }) {
    _instance ??= ScreenUtil._internal(
      screenWidthBase: screenWidthBase,
      screenHeightBase: screenHeightBase,
    );
    return _instance!;
  }

  factory ScreenUtil.setContext(
    BuildContext context, {
    double screenWidthBase = 384,
    double screenHeightBase = 823.5,
  }) {
    _instance ??= ScreenUtil._internal(
      screenWidthBase: screenWidthBase,
      screenHeightBase: screenHeightBase,
    );
    _instance!._context = context;
    return _instance!;
  }

  BuildContext? _context;

  MediaQueryData get _mediaQueryData {
    MediaQueryData data =
        MediaQueryData.fromView(PlatformDispatcher.instance.views.first);
    if (_context != null) {
      try {
        data = MediaQuery.of(_context!);
      } catch (_) {
        debugPrint('[ScreenUtil] MediaQuery.of(context) failed: $e\n');
      }
    }
    return data;
  }

  final double _screenWidthBase;
  final double _screenHeightBase;

  double get screenWidthBase => _screenWidthBase;
  double get screenHeightBase => _screenHeightBase;

  double get compositorWidth => _mediaQueryData.size.width;
  double get compositorHeight => _mediaQueryData.size.height;
  bool get isPortrait => _mediaQueryData.orientation == Orientation.portrait;

  double get designWidthScale => isPortrait
      ? compositorHeight / _screenWidthBase
      : compositorWidth / _screenWidthBase;
  double get designHeightScale => isPortrait
      ? compositorWidth / _screenHeightBase
      : compositorHeight / _screenHeightBase;

  double setWidth(num width) {
    return width * designWidthScale;
  }

  double setHeight(num height) {
    return height * designHeightScale;
  }
}
