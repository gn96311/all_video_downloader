import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

Future<Directory?> getBestVideoDownloaderFolder() async {
  try {
    Directory? downloadDirectory = await getExternalStorageDirectory();

    if (downloadDirectory == null){
      return null;
    }

    String downloadsPath = path.join(downloadDirectory.parent.parent.parent.parent.path, 'Download');

    Directory bestVideoDownloaderDir = Directory(path.join(downloadsPath, 'BestVideoDownloader'));

    if (!bestVideoDownloaderDir.existsSync()){
      bestVideoDownloaderDir.createSync(recursive: true);
    }

    return bestVideoDownloaderDir;
  } catch (e) {
    return null;
  }
}