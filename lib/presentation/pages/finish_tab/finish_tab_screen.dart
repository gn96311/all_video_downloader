import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/presentation/pages/finish_tab/finished_widget.dart';
import 'package:flutter/material.dart';

class FinishTabScreen extends StatelessWidget {
  const FinishTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            height: 60,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Completed',style: CustomThemeData.themeData.textTheme.titleMedium,),
                        Text('(/Download/VideoDownloader/)', style: CustomThemeData.themeData.textTheme.labelSmall,)
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      height: 30,
                      width: 30,
                      alignment: Alignment.center,
                      child: Text('25'),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(1, 1),
                              color: AppColors.shadowColor.withOpacity(0.2),
                              blurRadius: 2,
                              spreadRadius: 2)
                        ],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Icon(
                      Icons.more_vert,
                      size: 30,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: FinishedWidget(
            title: 'Title of Video if has long name, describe like this.',
            entireVolume: 120.02,
          ),
        ),
      ),
    );
  }
}
