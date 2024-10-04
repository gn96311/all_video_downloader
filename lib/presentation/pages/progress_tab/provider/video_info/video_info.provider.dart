import 'package:all_video_downloader/presentation/pages/progress_tab/provider/video_info/video_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoInfoProvider = StateProvider<List<VideoInfo>>((ref) => []);