import 'package:all_video_downloader/presentation/pages/finish_tab/finish_tab_screen.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/home_tab_screen.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/progress_tab_screen.dart';
import 'package:all_video_downloader/presentation/pages/setting/setting_screen.dart';
import 'package:all_video_downloader/presentation/pages/splash/splash_screen.dart';
import 'package:all_video_downloader/presentation/routes/route_path.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RoutePath.homeTab,
      name: 'homeTab',
      builder: (context, state) => const HomeTabScreen(),
    ),
    GoRoute(
      path: RoutePath.splash,
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RoutePath.setting,
      name: 'setting',
      builder: (context, state) => const SettingScreen(),
    ),
    GoRoute(
      path: RoutePath.finishTab,
      name: 'finishTab',
      builder: (context, state) => const FinishTabScreen(),
    ),
    GoRoute(
      path: RoutePath.progressTab,
      name: 'progressTab',
      builder: (context, state) => const ProgressTabScreen(),
    ),
  ],
  initialLocation: RoutePath.splash,
);
