import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/data/datasources/local/token_service.dart';
import 'package:turing/data/datasources/remote/login_service.dart';
import 'package:turing/data/models/login_response.dart';
import 'package:turing/data/models/root_response.dart';
import 'package:turing/presentation/navigation_route.dart';
import 'package:turing/presentation/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: GotchaiColorStyles.gray950,
      systemNavigationBarIconBrightness: Brightness.light,
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
            home: const SplashScreen(),
            routes: NavigationRoute.routes,
            navigatorKey: NavigationService.navigatorKey,
          );
        });
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    try {
      String targetRoute = NavigationRoute.onboarding;

      await TokenService.getRefreshToken().then((value) {
        if (value != null) {
          LoginService().refresh(value).then((result) {
            if (result is Success<LoginResponse>) {
              targetRoute = NavigationRoute.home;
            } else if (result is Error<LoginResponse>) {
              targetRoute = NavigationRoute.onboarding;
            }
          }).catchError((error) {
            targetRoute = NavigationRoute.onboarding;
          });
        } else {
          targetRoute = NavigationRoute.onboarding;
        }
      });

      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        Navigator.of(context).pushReplacementNamed(targetRoute);
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(NavigationRoute.onboarding);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GotchaiColorStyles.gray950,
      body: Center(
        child: Image.asset(
          "assets/icon/gotchai_logo.png",
          width: 263.w,
          height: 80.h,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
