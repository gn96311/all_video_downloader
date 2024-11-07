import 'dart:io';

import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:all_video_downloader/presentation/pages/finish_tab/finished_widget.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class FinishTabScreen extends StatefulWidget {
  const FinishTabScreen({super.key});

  @override
  State<FinishTabScreen> createState() => _FinishTabScreenState();
}

class _FinishTabScreenState extends State<FinishTabScreen> {
  late Stream<List<Map<String, dynamic>>> _videoStream;

  @override
  void initState() {
    _videoStream = _getVideoStream();
    super.initState();
  }

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
              padding:
                  const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Completed',
                          style:
                              CustomThemeData.themeData.textTheme.titleMedium,
                        ),
                        Text(
                          '(/Download/movie/)',
                          style: CustomThemeData.themeData.textTheme.labelSmall,
                        )
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  SizedBox(
                    width: 16,
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
        body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _videoStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading videos'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No Video File in Download Folder'));
            }

            // todo: hasError뜸. 확인해봐야함.

            final videos = snapshot.data!;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    final video = videos[index];
                    return Column(children: [
                      FinishedWidget(
                        title: video['title'],
                        entireVolume: video['size'],
                        thumbPath: video['thumbnail'],
                        videoPath: video['path'],
                        onDelete: _deleteAndRefresh,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]);
                  },
                  itemCount: videos.length),
            );
          },
        ),
      ),
    );
  }

  Stream<List<Map<String, dynamic>>> _getVideoStream() async* {
    while (true) {
      yield await _loadVideos();
      await Future.delayed(Duration(milliseconds: 500));
    }
  }

  Future<List<Map<String, dynamic>>> _loadVideos() async {
    final directory = await getExternalStorageDirectory();
    final videoDir = Directory('${directory!.path}/Download/movie/');

    if (await videoDir.exists()) {
      final videoFiles = videoDir
          .listSync()
          .where((file) => file.path.endsWith('.mp4'))
          .toList();

      List<Future<Map<String, dynamic>>> videoDetailsFutures =
          videoFiles.map((videoFile) async {
        final videoName = videoFile.path.split('/').last;
        final fileSize = ((await videoFile.stat()).size / (1024 * 1024));
        final thumbPath = await VideoThumbnail.thumbnailFile(
          video: videoFile.path,
          thumbnailPath: (await getTemporaryDirectory()).path,
          imageFormat: ImageFormat.WEBP,
          maxWidth: 64,
          quality: 75,
        );

        return {
          'path': videoFile.path,
          'title': videoName,
          'size': fileSize,
          'thumbnail': thumbPath,
        };
      }).toList();

      return await Future.wait(videoDetailsFutures);
    } else {
      return [];
    }
  }

  Future<void> _deleteAndRefresh(String videoPath, String thumbPath) async {
    try {
      final videoFile = File(videoPath);
      final thumbFile = File(thumbPath);

      if (await videoFile.exists()) {
        await videoFile.delete();
      }
      if (await thumbFile.exists()) {
        await thumbFile.delete();
      }

      setState(() {
        _videoStream = _getVideoStream();
      });
    } catch (e) {}
  }
}
