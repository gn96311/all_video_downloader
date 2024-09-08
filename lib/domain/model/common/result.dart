import 'package:all_video_downloader/core/utils/error/error_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;

  const factory Result.failure(ErrorResponse error) = Error<T>;
}