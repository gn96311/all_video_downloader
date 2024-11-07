import 'dart:io';

import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/core/utils/widgets/shadow_container.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class FinishedWidget extends StatelessWidget {
  String title;
  double entireVolume;
  String thumbPath;
  String videoPath;
  final void Function(String videoPath, String thumbPath) onDelete;

  FinishedWidget(
      {super.key,
      required this.title,
      required this.entireVolume,
      required this.thumbPath,
      required this.videoPath,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ShadowContainerWidget(
      outsidePadding: EdgeInsets.zero,
      insidePadding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(5),
      height: 120,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            showThumbnail(thumbPath),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: CustomThemeData.themeData.textTheme.titleSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      PopupMenuButton(
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            child: Text('비디오 삭제'),
                            value: 'deleteVideo',
                          )
                        ],
                        icon: Icon(
                          Icons.more_vert,
                          size: 24,
                          color: AppColors.primary,
                        ),
                        onSelected: (result) async {
                          if (result == 'deleteVideo') {
                            final isConfirm = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('해당 비디오를 삭제하시겠습니까?'),
                                    actions: [
                                      TextButton(onPressed: () => Navigator.pop(context, false), child: Text('취소')),
                                      TextButton(onPressed: () => Navigator.pop(context, true), child: Text('확인')),
                                    ],
                                  );
                                },
                                barrierDismissible: true);
                            if (isConfirm == true){
                              onDelete(videoPath, thumbPath);
                            }
                          }
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${entireVolume.toStringAsFixed(2)} MB',
                    style: CustomThemeData.themeData.textTheme.labelSmall,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget showThumbnail(String imagePath) {
    return imagePath.startsWith('assets/')
        ? Image.asset(
            imagePath,
            height: 88,
            width: 120,
          )
        : Image.file(
            File(imagePath),
            height: 88,
            width: 120,
          );
  }
}
