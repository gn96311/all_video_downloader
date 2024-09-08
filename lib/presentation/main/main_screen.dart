import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/presentation/main/provider/bottom_nav_provider.dart';
import 'package:all_video_downloader/presentation/pages/finish_tab/finish_tab_screen.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/home_tab_screen.dart';
import 'package:all_video_downloader/presentation/pages/progress_tab/progress_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    final bottomNavState = ref.watch(bottomNavProvider);

    return WillPopScope(
      onWillPop: () async {
        if (await webViewController!.canGoBack()){
          webViewController!.goBack();
          debugPrint(webViewController!.canGoBack().toString());
          return false;
        } else{
          return false;
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: bottomNavState.index,
          children: [
            _buildNavigator(BottomNav.home.index, HomeTabScreen(onWebViewCreated: (controller) {setState(() {
              webViewController = controller;
            });})),
            _buildNavigator(BottomNav.progress.index, ProgressTabScreen()),
            _buildNavigator(BottomNav.finish.index, FinishTabScreen()),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            items: List.generate(
              BottomNav.values.length,
              (index) => BottomNavigationBarItem(
                icon: BottomNav.values[index].icon,
                label: BottomNav.values[index].toNmae,
              ),
            ),
            onTap: (index) {
              ref.read(bottomNavProvider.notifier).changeNavIndex(index);
            },
            currentIndex: bottomNavState.index,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigator(int tabIndex, Widget child) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => child,
        );
      },
    );
  }
}
