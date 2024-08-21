import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/core/theme/custom/custom_theme.dart';
import 'package:flutter/material.dart';

class CustomThemeData{
  static ThemeData get themeData => ThemeData(
    useMaterial3: true,
    colorScheme: CustomTheme.colorScheme,
    fontFamily: 'Pretendard',
    textTheme: CustomTheme.textTheme,
    dividerTheme: DividerThemeData(color: AppColors.black)
  );
}