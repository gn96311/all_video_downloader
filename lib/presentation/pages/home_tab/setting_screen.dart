import 'dart:io';

import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/core/utils/widgets/setting_container.dart';
import 'package:all_video_downloader/data/local_storage/folder_provider.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/webview_controller.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  bool _isOnlyWifi = true;
  Directory? downloadPath;

  @override
  void initState() {
    _loadSettings();
    _loadDownloadPath();
    super.initState();
  }

  Future<void> _loadDownloadPath() async {
    Directory? path = await getBestVideoDownloaderFolder();
    setState(() {
      downloadPath = path;
    });
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isOnlyWifi = prefs.getBool('isOnlyWifi') ?? true;
    });
  }

  Future<void> _setOnlyWifi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isOnlyWifi = !_isOnlyWifi;
    });
    await prefs.setBool('isOnlyWifi', _isOnlyWifi);
  }

  @override
  Widget build(BuildContext context) {
    String? downloadPathString = downloadPath?.path;
    InAppWebViewController? webViewController = ref.watch(webViewControllerProvider);
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onTap: () {
              context.pop();
            },
          ),
          title: Text(
            'Settings',
            style: CustomThemeData.themeData.textTheme.titleLarge,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  '다운로드 설정',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.secondary,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8,),
                SettingContainer(null, null, downloadPathString ?? 'Unknown path', mainSettingText: '다운로드 위치',),
                Divider(color: AppColors.containerBackgroundColor, thickness: 1,),
                SettingContainer(_setOnlyWifi, _isOnlyWifi, null, mainSettingText: '와이파이 사용 여부',),
                Divider(color: AppColors.containerBackgroundColor, thickness: 1,),
                SizedBox(height: 16,),
                const Text(
                  '브라우저 설정',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.secondary,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8,),
                GestureDetector(
                  onTap: () async {
                    showWebInfoDeleteDialog(context, () => deleteCacheFunction(webViewController!), '캐시 삭제', '캐시를 지우겠습니까?');
                  },
                  child: SettingContainer(null, null, null, mainSettingText: '캐시 지우기',)
                  ,),
                Divider(color: AppColors.containerBackgroundColor, thickness: 1,),
                GestureDetector(
                  onTap: () async {
                    showWebInfoDeleteDialog(context, () => deleteCookieFunction(webViewController!), '쿠키 삭제', '쿠키를 지우겠습니까?');
                  },
                    child: SettingContainer(null, null, null, mainSettingText: '쿠키 지우기',)),
                Divider(color: AppColors.containerBackgroundColor, thickness: 1,),
                SizedBox(height: 16,),
                Text(
                  '기타 설정 및 설명',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.secondary,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8,),
                SettingContainer(null, null, null, mainSettingText: '언어 선택',),
                Divider(color: AppColors.containerBackgroundColor, thickness: 1,),
                SettingContainer(null, null, null, mainSettingText: '개인 정보 정책',),
                Divider(color: AppColors.containerBackgroundColor, thickness: 1,),
                SettingContainer(null, null, null, mainSettingText: '현재 버전 정보',),
                Divider(color: AppColors.containerBackgroundColor, thickness: 1,),
                SettingContainer(null, null, null, mainSettingText: '의견은 이곳을 통해 제시 부탁드립니다.',),
                Divider(color: AppColors.containerBackgroundColor, thickness: 1,),
              ],
            ),
          ),
        ));
  }

  void showWebInfoDeleteDialog(BuildContext context, Function deleteFunction, title, content) {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(onPressed: () async {
            await deleteFunction();
            Navigator.of(context).pop();
          }, child: Text('삭제')),
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text('취소')),
        ],
      );
    });
  }

  Future<void> deleteCacheFunction(InAppWebViewController webViewController) async {
    await webViewController.clearCache();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('캐시 삭제 완료하였습니다.')));
  }

  Future<void> deleteCookieFunction(InAppWebViewController webViewController) async {
    final cookieManager = CookieManager.instance();
    await cookieManager.deleteAllCookies();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('쿠키 삭제 완료하였습니다.')));
  }
}
