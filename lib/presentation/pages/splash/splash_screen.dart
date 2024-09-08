import 'dart:async';

import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/presentation/routes/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () => context.go(RoutePath.main));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
                Text('AllVideoDownloader',
                    style: CustomThemeData.themeData.textTheme.displaySmall),
                SizedBox(
                  height: 50,
                ),
                Text(
                  '당신이 원하는 그 어떤 동영상이든\n마음대로 다운로드 하세요!',
                  textAlign: TextAlign.center,
                  style: CustomThemeData.themeData.textTheme.titleMedium,
                ),
                SizedBox(
                  height: 50,
                ),
                AspectRatio(child: Image.asset(AppIcons.mainLogo), aspectRatio: 16/12,)
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 80,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 0,),
                child: Container(
                  height: 16,
                  child: LinearProgressIndicator(),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(width: 1, color: AppColors.lessImportant),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Loading...',
                style: CustomThemeData.themeData.textTheme.titleSmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
