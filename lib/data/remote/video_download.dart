import 'dart:io';

import 'package:all_video_downloader/core/utils/rest_client/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter_hls_parser/flutter_hls_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';

//----------------------------------- case1 & 공통 ------------------------------------------------

Future<Map<String, dynamic>> fetchAndStoreM3U8Response(List<String> m3u8UrlList, Map<String, String> headers) async {
  final dio = RestClient().getDio;
  Map<String, dynamic> responseMap = {};

  for (String m3u8Url in m3u8UrlList) {
    final response = await dio.get(m3u8Url, options: Options(headers: headers));
    responseMap[m3u8Url] = response.data;
  }

  return responseMap;
}


// m3u8에서 옵션을 추출한 뒤, segment를 분리하는 함수. streamOption을 return함
Future<List<Map<String, String>>> getStreamOptions(Map<String, dynamic> responseMap) async {
  List<Map<String, String>> videoStreamOptions = [];
  List<Map<String, String>> audioStreamOptions = [];
  Map<String, String>? highestQualityIndependentAudio;
  bool masterPlaylistFound = false;

  for (var entry in responseMap.entries) {
    final m3u8Url = entry.key;
    final data = entry.value;
    final hlsParser = HlsPlaylistParser.create();
    final playlist = await hlsParser.parseString(Uri.parse(m3u8Url), data);

    if (playlist is HlsMasterPlaylist) {
      masterPlaylistFound = true;

      // 비디오 스트림 추가
      for (final variant in playlist.variants) {
        final resolution = variant.format.height?.toString() ?? "unknown Resoluation";
        final bandwidth = (variant.format.bitrate! / 1000).toStringAsFixed(0) + ' kbps';
        final codecs = variant.format.codecs ?? "unknown Codecs";

        videoStreamOptions.add({
          'url': variant.url.toString(),
          'resolution': resolution,
          'bandwidth': bandwidth,
          'codecs': codecs,
          'audio_group': variant.audioGroupId ?? '',
          'type': 'video',
        });
      }

      // 오디오 스트림 추가
      for (final audioRendition in playlist.audios) {
        final groupId = audioRendition.groupId;
        final bitrateMatch = RegExp(r'audio-(\d+)').firstMatch(groupId ?? '');
        final audioBitrate = bitrateMatch != null ? int.parse(bitrateMatch.group(1)!) : audioRendition.format.bitrate;

        final audioStream = {
          'url': audioRendition.url.toString(),
          'resolution': "Audio Only",
          'bandwidth': "${(audioBitrate! / 1000).toStringAsFixed(0)} kbps",
          'codecs': audioRendition.format.codecs ?? "Unknown Codecs",
          'audio_group': groupId ?? '',
          'type': 'audio',
        };

        audioStreamOptions.add(audioStream);

        // 그룹 매칭이 없을 경우, 가장 높은 퀄리티의 Audio tracking
        if (groupId == null || groupId.isEmpty) {
          if (highestQualityIndependentAudio == null || audioBitrate > int.parse(highestQualityIndependentAudio['bandwidth']!.replaceAll(' kbps', ''))) {
            highestQualityIndependentAudio = audioStream;
          }
        }
      }
    }
  }

  // 자동으로 대응하는 비디오와 오디오 쌍을 매칭
  List<Map<String, String>> combinedOptions = [];
  for (final videoOption in videoStreamOptions){
    final matchingAudio = audioStreamOptions.firstWhere((audioOption) => audioOption['audio_group'] == videoOption['audio_group'], orElse: () => highestQualityIndependentAudio ?? <String, String> {});
    combinedOptions.add(videoOption);
    if (matchingAudio.isNotEmpty){
      combinedOptions.add(matchingAudio);
    }
  }

  if (!masterPlaylistFound) {
    for (var entry in responseMap.entries) {
      final m3u8Url = entry.key;
      final data = entry.value;
      final hlsParser = HlsPlaylistParser.create();
      final playlist = await hlsParser.parseString(Uri.parse(m3u8Url), data);

      if (playlist is HlsMediaPlaylist) {
        combinedOptions.add({
          'url': m3u8Url,
          'resolution': "Unknown Resolution",
          'bandwidth': "Unknown Bandwidth",
          'codecs': "Unknown Codecs",
          'type': 'video',
        });
      }
    }
  }
  return combinedOptions;
}

// master playlist로부터 media playlist를 분리해, 바로 다운로드 하는 함수(simple downloader)
Future<void> convertVideo(Map<String, String?> selectedUrls, {String? title}) async {
  if (selectedUrls != null) {
    final directory = await getApplicationDocumentsDirectory();
    final segmentsDir = Directory('${directory.path}/outputPath');
    if (!segmentsDir.existsSync()) {
      segmentsDir.createSync();
    }
    String sanitizedFileName = title!.replaceAll(' ', '_');
    String outputPath = getUniqueFilePath('${segmentsDir.path}/$sanitizedFileName.mp4');

    String command;
    if (selectedUrls['audioUrl'] != null) {
      command =
      "-y -i ${selectedUrls['videoUrl']} -i ${selectedUrls['audioUrl']} -map 0:v -map 1:a -c copy -bsf:a aac_adtstoasc -f mp4 $outputPath";
    } else {
      command =
      "-y -i ${selectedUrls['videoUrl']} -map 0:v -map 0:a? -c copy -bsf:a aac_adtstoasc -f mp4 $outputPath";
    }

    await FFmpegKit.execute(command).then((session) async {
      final returnCode = await session.getReturnCode();
      final failStackTrace = await session.getFailStackTrace();
      final logs = await session.getLogs();

      if (ReturnCode.isSuccess(returnCode)) {
        print('Video conversion succeeded: $outputPath');
      } else if (ReturnCode.isCancel(returnCode)) {
        print('Video conversion canceled');
        print(failStackTrace);
        logs.forEach((log) {
          print(log.getMessage());
        });
      } else {
        print('Video conversion failed with return code: $returnCode');
        print(failStackTrace);
        logs.forEach((log) {
          print(log.getMessage());
        });
      }
    });
  }
}

String getUniqueFilePath(String basePath) {
  int counter = 1;
  String newFilePath = basePath;
  while (File(newFilePath).existsSync()) {
    newFilePath = basePath.replaceFirst(RegExp(r'\.mp4$'), '($counter).mp4');
    counter++;
  }
  return newFilePath;
}

//----------------------------------- case2 -------------------------------------------------------

Future<void> processM3U8(String m3u8Content, String outputFileName, Map<String, String> header) async {
  final segmentUrls = RegExp(r'https?://[^\s]+').allMatches(m3u8Content).map((m) => m.group(0)!).toList();
  await downloadAndMergeSegments(segmentUrls, outputFileName, header);
}

Future<void> downloadAndMergeSegments(List<String> segmentUrls, String outputFileName, Map<String, String> headers) async {
  final dio = RestClient().getDio;
  final directory = await getApplicationDocumentsDirectory();
  final segmentsDir = Directory('${directory.path}/downloadedSegments');
  if (!segmentsDir.existsSync()) {
    segmentsDir.createSync();
  }

  List<String> segmentPaths = [];

  for (String url in segmentUrls) {
    final segmentName = url.split('/').last;
    final segmentNameWithNewExtension = '${segmentName.split('.').first}.ts';
    final segmentPath = '${segmentsDir.path}/$segmentNameWithNewExtension';
    segmentPaths.add(segmentPath);

    try {
      await dio.download(url, segmentPath, options: Options(headers: headers));
      print('Downloaded $segmentPath');
    } catch (e) {
      print('Failed to download $url: $e');
    }
  }

  await mergeSegments(segmentPaths, outputFileName);
}


Future<void> mergeSegments(List<String> segmentPaths, String outputFileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final segmentsDir = Directory('${directory.path}/outputPath');
  if (!segmentsDir.existsSync()) {
    segmentsDir.createSync();
  }
  String sanitizedFileName = outputFileName.replaceAll(' ', '_');
  String outputPath = '${segmentsDir.path}/$sanitizedFileName.mp4';

  final segmentListFilePath = '${directory.path}/downloadedSegments/segment_list.txt';
  final segmentListFile = File(segmentListFilePath);
  final segmentListContent = segmentPaths.map((path) => "file '$path'").join('\n');
  await segmentListFile.writeAsString(segmentListContent);

  // for (String segmentPath in segmentPaths) {
  //   await FFprobeKit.getMediaInformation(segmentPath).then((session) async {
  //     final information = await session.getMediaInformation();
  //     if (information != null) {
  //       print('File: $segmentPath');
  //       print('Duration: ${information.getDuration()}');
  //       print('Format: ${information.getFormat()}');
  //       print('Size: ${information.getSize()}');
  //       print('Bitrate: ${information.getBitrate()}');
  //     } else {
  //       print('Failed to retrieve media information for $segmentPath');
  //     }
  //   });
  // }

  final command = "-f concat -safe 0 -i $segmentListFilePath -c copy $outputPath";


  await FFmpegKit.execute(command).then((session) async {
    final returnCode = await session.getReturnCode();
    final failStackTrace = await session.getFailStackTrace();
    final logs = await session.getLogs();

    if (ReturnCode.isSuccess(returnCode)) {
      print('Video conversion succeeded: $outputPath');
      await cleanupSegmentsAndListFile(segmentPaths, segmentsDir);
    } else if (ReturnCode.isCancel(returnCode)) {
      print('Video conversion canceled');
      // print(failStackTrace);
      // logs.forEach((log) {
      //   print(log.getMessage());
      // });
    } else {
      print('Video conversion failed with return code: $returnCode');
      // print(failStackTrace);
      // logs.forEach((log) {
      //   print(log.getMessage());
      // });
    }
  });
}

Future<void> cleanupSegmentsAndListFile(List<String> segmentPaths, Directory segmentsDir) async {
  try {
    // 모든 ts 파일 삭제
    for (String segmentPath in segmentPaths) {
      final file = File(segmentPath);
      if (await file.exists()) {
        await file.delete();
        print('Deleted $segmentPath');
      }
    }

    // segment_list.txt 파일 삭제
    final segmentListFile = File('${segmentsDir.path}/segment_list.txt');
    if (await segmentListFile.exists()) {
      await segmentListFile.delete();
      print('Deleted ${segmentListFile.path}');
    }

    // 다운로드된 세그먼트 디렉토리 삭제
    if (await segmentsDir.exists()) {
      await segmentsDir.delete(recursive: true);
      print('Deleted directory: ${segmentsDir.path}');
    }
  } catch (e) {
    print('Failed to delete segments: $e');
  }
}