import 'package:all_video_downloader/domain/repository_interface/repository_interface.dart';
import 'package:all_video_downloader/domain/usecase/common/usecase.dart';

abstract class LocalUsecase<T extends Repository> extends Usecase<T> {}