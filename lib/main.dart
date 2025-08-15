import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor:
          GotchaiColorStyles.gray950, // Navigation Bar 배경색
      systemNavigationBarIconBrightness: Brightness.light, // 아이콘 밝기
    ),
  );

  await dotenv.load(fileName: "assets/config/.env");
  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_NATIVE_KEY'],
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        builder: (context, child) {
          return MaterialApp(
            title: 'Gotchai',
            theme: ThemeData(
              fontFamily: 'Pretendard',
              scaffoldBackgroundColor: GotchaiColorStyles.gray950,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            initialRoute: NavigationRoute.onboarding,
            routes: NavigationRoute.routes,
            navigatorKey: NavigationService.navigatorKey,
          );
        });
  }
}
