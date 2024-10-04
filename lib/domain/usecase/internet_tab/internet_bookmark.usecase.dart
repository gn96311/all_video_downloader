import 'package:all_video_downloader/core/utils/error/error_response.dart';
import 'package:all_video_downloader/core/utils/extensions.dart';
import 'package:all_video_downloader/data/entity/internet_bookmark.entity.dart';
import 'package:all_video_downloader/data/entity/internet_history.entity.dart';
import 'package:all_video_downloader/domain/model/common/result.dart';
import 'package:all_video_downloader/domain/repository_interface/internet_bookmark.repository_interface.dart';
import 'package:all_video_downloader/domain/repository_interface/internet_history.repository_interface.dart';
import 'package:all_video_downloader/domain/usecase/common/local.usecase.dart';
import 'package:all_video_downloader/domain/usecase/common/usecase.dart';

class InternetBookmarkUsecase<T> {
  final InternetBookmarkRepositoryInterface _internetBookmarkRepository;

  InternetBookmarkUsecase(this._internetBookmarkRepository);

  Future<Result<T>> execute<T>({required Usecase usecase}) async {
    return await usecase(_internetBookmarkRepository);
  }
}

class GetInternetBookmarkUsecase extends LocalUsecase<InternetBookmarkRepositoryInterface> {
  GetInternetBookmarkUsecase();

  @override
  Future call(InternetBookmarkRepositoryInterface repository) async {
    final result = await repository.getInternetBookmarkList();
    return (result.status.isSuccess)
        ? Result.success(result.data)
        : Result.failure(
      ErrorResponse(
        status: result.status,
        code: result.code,
        message: result.message,
      ),
    );
  }
}

class InsertInternetBookmarkUsecase extends LocalUsecase<InternetBookmarkRepositoryInterface> {
  final InternetBookmarkEntity internetBookmarkEntity;
  InsertInternetBookmarkUsecase({required this.internetBookmarkEntity});

  @override
  Future call(InternetBookmarkRepositoryInterface repository) async {
    final result = await repository.insertInternetBookmark(internetBookmark: internetBookmarkEntity);
    return (result.status.isSuccess)
        ? Result.success(result.data)
        : Result.failure(
      ErrorResponse(
        status: result.status,
        code: result.code,
        message: result.message,
      ),
    );
  }
}

class DeleteInternetBookmarkUsecase extends LocalUsecase<InternetBookmarkRepositoryInterface> {
  final String bookmarkId;
  DeleteInternetBookmarkUsecase({required this.bookmarkId});

  @override
  Future call(InternetBookmarkRepositoryInterface repository) async {
    final result = await repository.deleteInternetBookmark(bookmarkId: bookmarkId);
    return (result.status.isSuccess)
        ? Result.success(result.data)
        : Result.failure(
      ErrorResponse(
        status: result.status,
        code: result.code,
        message: result.message,
      ),
    );
  }
}

class ClearInternetBookmarkUsecase extends LocalUsecase<InternetBookmarkRepositoryInterface> {
  ClearInternetBookmarkUsecase();

  @override
  Future call(InternetBookmarkRepositoryInterface repository) async {
    final result = await repository.clearInternetBookmark();
    return (result.status.isSuccess)
        ? Result.success(result.data)
        : Result.failure(
      ErrorResponse(
        status: result.status,
        code: result.code,
        message: result.message,
      ),
    );
  }
}