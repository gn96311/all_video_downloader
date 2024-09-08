import 'package:all_video_downloader/presentation/main/main_screen.dart';
import 'package:all_video_downloader/presentation/pages/splash/splash_screen.dart';
import 'package:all_video_downloader/presentation/routes/route_path.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RoutePath.main,
      name: 'main',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: RoutePath.splash,
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
  ],
  initialLocation: RoutePath.splash,
);
