import 'dart:convert';
import 'dart:io';

import 'package:all_video_downloader/core/utils/rest_client/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter_hls_parser/flutter_hls_parser.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

//----------------------------------- case1 & 공통 ------------------------------------------------

Future<Map<String, dynamic>> fetchAndStoreM3U8Response(List<String> m3u8UrlList, Map<String, String> headers) async {
  final dio = RestClient().getDio;
  Map<String, dynamic> responseMap = {};
  try{
    for (String m3u8Url in m3u8UrlList) {
      final response = await dio.get(
          m3u8Url, options: Options(headers: headers));
      responseMap[m3u8Url] = response.data;
    }
  } catch (e) {
    print('영상을 클릭한 후, 다시 시도해주세요.');
  }

  return responseMap;
}


// m3u8에서 옵션을 추출한 뒤, segment를 분리하는 함수. streamOption을 return함
Future<List<Map<String, String>>> getStreamOptions(Map<String, dynamic> responseMap, Map<String, String> headers) async {
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
        final bandwidth =(variant.format.bitrate! / 1000).toStringAsFixed(0) + ' kbps';
        final codecs = variant.format.codecs ?? "unknown Codecs";
        final totalDuration = await _getTotalDuration(variant.url.toString(), headers);
        final sizeInMB = ((variant.format.bitrate! / 8) * totalDuration) / (1024 * 1024);

        videoStreamOptions.add({
          'url': variant.url.toString(),
          'resolution': resolution,
          'bandwidth': bandwidth,
          'codecs': codecs,
          'audio_group': variant.audioGroupId ?? '',
          'type': 'video',
          'size': '${sizeInMB.toStringAsFixed(2)} MB',
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
          'size' : 'Unknown Size',
        });
      }
    }
  }
  return combinedOptions;
}

Future<double> _getTotalDuration(String mediaUrl, Map<String, String>headers) async {
  double totalDuration = 0.0;
  final Dio dio = RestClient().getDio;

  try {
    final response = await dio.get(mediaUrl, options: Options(headers: headers));
    final playlistContent = response.data;

    final hlsParser = HlsPlaylistParser.create();
    final playlist = await hlsParser.parseString(Uri.parse(mediaUrl), playlistContent);

    // 미디어 플레이리스트라면 각 세그먼트의 길이 계산
    if (playlist is HlsMediaPlaylist) {
      for (final segment in playlist.segments) {
        totalDuration += segment.durationUs! / 1000000; // microseconds to seconds
      }
    }
  } catch (e) {
  }
  return totalDuration;
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

//각 파일별 유니크한 이름을 return하는 함수
String getUniqueFilePath(String basePath) {
  int counter = 1;
  String newFilePath = basePath;
  while (File(newFilePath).existsSync()) {
    newFilePath = basePath.replaceFirst(RegExp(r'\.mp4$'), '($counter).mp4');
    counter++;
  }
  return newFilePath;
}

// currentUrl로부터 현재 baseUrl을 얻는 함수
String getBaseUrl(String currentUrl) {
  Uri uri = Uri.parse(currentUrl);
  return '${uri.scheme}://${uri.host}';
}

//m3u8의 body를 받아서, 영상의 길이 및 세그먼트의 개수를 받는 함수.
Future<Map<String, dynamic>> analyzeM3U8(String m3u8Content) async {
  List<String> lines = LineSplitter().convert(m3u8Content);

  double totalDuration = 0;
  int segmentCount = 0;

  for (var lineNumber = 0; lineNumber < lines.length; lineNumber++) {
    if (lines[lineNumber].startsWith('#EXTINF')) {
      final duration = double.parse(lines[lineNumber].split(':')[1].split(',')[0]);
      totalDuration += duration;
      segmentCount++;
    }
  }
  return {
    'totalDuration' : totalDuration,
    'segmentCount': segmentCount,
  };
}

//----------------------------------- case2 -------------------------------------------------------

Future<void> processM3U8(String m3u8Content, String outputFileName, Map<String, String> header, WidgetRef ref) async {
  // 혹시 https말고 http로 오는 곳이 있으면, 수정해야함.
  final segmentUrls = RegExp(r'https?://[^\s]+').allMatches(m3u8Content).map((m) => m.group(0)!).toList();
  await downloadAndMergeSegments(segmentUrls, outputFileName, header, ref);
}



Future<void> downloadAndMergeSegments(List<String> segmentUrls, String outputFileName, Map<String, String> headers, WidgetRef ref) async {
  final directory = await getApplicationDocumentsDirectory();
  final segmentsDir = Directory('${directory.path}/downloadedSegments');
  if (!segmentsDir.existsSync()) {
    segmentsDir.createSync(recursive: true);
  }

  List<String> segmentPaths = [];
  Map<String, String> urlToSegmentPathMap = {};

  for (int urlNumber = 0; urlNumber < segmentUrls.length; urlNumber++) {
    String url = segmentUrls[urlNumber];
    final segmentName = url.split('/').last;
    final segmentNameWithNewExtension = '${segmentName.split('.').first}.ts';
    final segmentPath = '${segmentsDir.path}/$segmentNameWithNewExtension';
    segmentPaths.add(segmentPath);
    urlToSegmentPathMap[url] = segmentNameWithNewExtension;
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
    if (await segmentsDir.exists()){
      await segmentsDir.delete(recursive: true);
      print('Deleted Directory ${segmentsDir.path}');
    }
  } catch (e) {
    print('Failed to delete segments: $e');
  }
}

//----------------------------------- case3 -------------------------------------------------------

Future<bool> mergeSegmentsFuction(String id, List<String> segmentPaths, String outputFileName, WidgetRef ref) async {
  //TODO: 나중에 저장위치 Download 폴더로 바꿔야함
  final directory = await getApplicationDocumentsDirectory();
  final externalDirectory = await getExternalStorageDirectory();
  final segmentsDir = Directory('${directory.path}/$id');
  final outputDir = Directory('${externalDirectory!.path}/Download/movie');
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }
  String firstSanitizedFileName = sanitizeFileName(outputFileName);
  String sanitizedFileName = firstSanitizedFileName.replaceAll(' ', '_');
  String outputPath = '${outputDir.path}/$sanitizedFileName.mp4';

  final segmentListFilePath = '${directory.path}/$id/segment_list.txt';
  final segmentListFile = File(segmentListFilePath);
  final segmentListContent = segmentPaths.map((path) => "file '$path'").join('\n');
  await segmentListFile.writeAsString(segmentListContent);

  final command = "-y -f concat -safe 0 -i $segmentListFilePath -c copy $outputPath";

  final session = await FFmpegKit.execute(command);
  final returnCode = await session.getReturnCode();
  final failStackTrace = await session.getFailStackTrace();
  final logs = await session.getLogs();

  if (ReturnCode.isSuccess(returnCode)) {
    print('Video conversion succeeded: $outputPath');
    await cleanupSegmentsAndListFile(segmentPaths, segmentsDir);
    return true;
  } else if (ReturnCode.isCancel(returnCode)) {
    print('Video conversion canceled');
    try {
      await cleanupSegmentsAndListFile(segmentPaths, segmentsDir);
    } catch (e) {
    }
    print(failStackTrace);
    logs.forEach((log) {
      print(log.getMessage());
    });
    return false;
  } else {
    print('Video conversion failed with return code: $returnCode');
    try {
      await cleanupSegmentsAndListFile(segmentPaths, segmentsDir);
    } catch (e) {
    }
    print(failStackTrace);
    logs.forEach((log) {
      print(log.getMessage());
    });
    return false;
  }
}

String sanitizeFileName(String fileName) {
  return fileName.replaceAll(RegExp(r'[\/:*?"<>|.]'), '_');
}