import 'package:all_video_downloader/domain/repository_interface/repository_interface.dart';

abstract class Usecase<T extends Repository>{
  Future call(T repository);
}