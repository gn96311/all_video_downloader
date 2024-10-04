import 'package:all_video_downloader/core/utils/error/error_response.dart';
import 'package:all_video_downloader/core/utils/extensions.dart';
import 'package:all_video_downloader/data/entity/internet_history.entity.dart';
import 'package:all_video_downloader/domain/model/common/result.dart';
import 'package:all_video_downloader/domain/repository_interface/internet_history.repository_interface.dart';
import 'package:all_video_downloader/domain/usecase/common/local.usecase.dart';
import 'package:all_video_downloader/domain/usecase/common/usecase.dart';

class InternetHistoryUsecase<T> {
  final InternetHistoryRepositoryInterface _internetHistoryRepository;

  InternetHistoryUsecase(this._internetHistoryRepository);

  Future<Result<T>> execute<T>({required Usecase usecase}) async {
    return await usecase(_internetHistoryRepository);
  }
}

class GetInternetHistoryUsecase extends LocalUsecase<InternetHistoryRepositoryInterface> {
  GetInternetHistoryUsecase();

  @override
  Future call(InternetHistoryRepositoryInterface repository) async {
    final result = await repository.getInternetHistoryList();
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

class InsertInternetHistoryUsecase extends LocalUsecase<InternetHistoryRepositoryInterface> {
  final InternetHistoryEntity internetHistoryEntity;
  InsertInternetHistoryUsecase({required this.internetHistoryEntity});

  @override
  Future call(InternetHistoryRepositoryInterface repository) async {
    final result = await repository.insertInternetHistory(internetHistory: internetHistoryEntity);
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

class DeleteInternetHistoryUsecase extends LocalUsecase<InternetHistoryRepositoryInterface> {
  final String visitedTime;
  DeleteInternetHistoryUsecase({required this.visitedTime});

  @override
  Future call(InternetHistoryRepositoryInterface repository) async {
    final result = await repository.deleteInternetHistory(visitedTime: visitedTime);
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

class ClearInternetHistoryUsecase extends LocalUsecase<InternetHistoryRepositoryInterface> {
  ClearInternetHistoryUsecase();

  @override
  Future call(InternetHistoryRepositoryInterface repository) async {
    final result = await repository.clearInternetHistory();
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