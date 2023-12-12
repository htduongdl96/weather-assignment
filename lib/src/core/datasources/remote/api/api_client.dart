import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../local/storage.dart';
import 'base/api_error.dart';
import 'interceptors/api_log_interceptor.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';

@module
abstract class ApiModule {
  @singleton
  Dio dio() => Dio(
        BaseOptions(
          headers: {'accept': 'application/json'},
          queryParameters: {
            'device_id': Storage.deviceId,
          },
        ),
      )..interceptors.addAll([
          AuthInterceptor(),
          if (kDebugMode) ApiLogInterceptor(),
          ErrorInterceptor(),
        ]);
}

extension FutureX<T extends Object> on Future<T> {
  Future<Result<T, ApiError>> result() async {
    try {
      final result = await this;
      return Success(result);
    } on DioException catch (err) {
      return Failure(ErrorInterceptor.resolve(err));
    } on ApiError catch (err) {
      return Failure(err);
    } catch (error) {
      return Failure(ApiError.internal(error.toString()));
    }
  }
}
