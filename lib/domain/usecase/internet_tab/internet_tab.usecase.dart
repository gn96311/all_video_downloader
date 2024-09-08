import 'package:all_video_downloader/core/utils/error/error_response.dart';
import 'package:all_video_downloader/core/utils/extensions.dart';
import 'package:all_video_downloader/data/entity/internet_tab.entity.dart';
import 'package:all_video_downloader/domain/model/common/result.dart';
import 'package:all_video_downloader/domain/repository_interface/internet_tab.repository_interface.dart';
import 'package:all_video_downloader/domain/usecase/common/local.usecase.dart';
import 'package:all_video_downloader/domain/usecase/common/usecase.dart';

class InternetTabUsecase<T> {
  final InternetTabInterfaceRepository _internetTabRepository;

  InternetTabUsecase(this._internetTabRepository);

  Future<Result<T>> execute<T>({required Usecase usecase}) async {
    return await usecase(_internetTabRepository);
  }
}

class GetInternetTabListUsecase
    extends LocalUsecase<InternetTabInterfaceRepository> {
  GetInternetTabListUsecase();

  @override
  Future call(InternetTabInterfaceRepository repository) async {
    final result = await repository.getInternetTabList();
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

class InsertInternetTabUsecase
    extends LocalUsecase<InternetTabInterfaceRepository> {
  final InternetTabEntity internetTabEntity;

  InsertInternetTabUsecase({required this.internetTabEntity});

  @override
  Future call(InternetTabInterfaceRepository repository) async {
    final result =
        await repository.insertInternetTab(internetTab: internetTabEntity);
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

class DeleteInternetUsecase
    extends LocalUsecase<InternetTabInterfaceRepository> {
  final String tabId;

  DeleteInternetUsecase({required this.tabId});

  @override
  Future call(InternetTabInterfaceRepository repository) async {
    final result =
    await repository.deleteInternetTab(tabId: tabId);
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

class ClearInternetTabUsecase
    extends LocalUsecase<InternetTabInterfaceRepository> {

  ClearInternetTabUsecase();

  @override
  Future call(InternetTabInterfaceRepository repository) async {
    final result =
    await repository.clearInternetTab();
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
