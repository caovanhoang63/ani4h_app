import 'package:dio/dio.dart';
import '../exception/failure.dart';

mixin DioExceptionMapper {
  Failure mapDioExceptionToFailure(DioException e, StackTrace s) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Failure(
          message: 'Connection timeout with API server. Please try again later',
          exception: e,
          stackTrace: s,
        );
      case DioExceptionType.sendTimeout:
        return Failure(
          message: 'Send timeout with API server. Check your internet connection',
          exception: e,
          stackTrace: s,
        );
      case DioExceptionType.receiveTimeout:
        return Failure(
          message: 'Receive timeout in connection with API server. Check your internet connection and try again',
          exception: e,
          stackTrace: s,
        );
      case DioExceptionType.badCertificate:
        return Failure(
          message: 'Bad certificate',
          exception: e,
          stackTrace: s,
        );
      case DioExceptionType.badResponse:
        return Failure(
          message: _getErrorMessage(e.response?.statusCode),
          exception: e,
          stackTrace: s,
        );
      case DioExceptionType.cancel:
        return Failure(
          message: 'Request to API server was cancelled',
          exception: e,
          stackTrace: s,
        );
      case DioExceptionType.unknown:
        return Failure(
          message: 'An unknown error occurred',
          exception: e,
          stackTrace: s,
        );
      case DioExceptionType.connectionError:
        return Failure(
          message: 'Connection error',
          exception: e,
          stackTrace: s,
        );

    }
  }
}

String _getErrorMessage(int? statusCode) {
  switch (statusCode) {
    case 400:
      return 'Bad request, please try again later';
    case 401:
      return 'Unauthorized, please try again later';
    case 403:
      return 'Forbidden, please try again later';
    case 404:
      return 'Not found, please try again later';
    case 498:
      return 'Refresh token expired, please try again later';
    case 500:
      return 'Internal server error, please try again later';
    case 503:
      return 'Service unavailable, please try again later';
    default:
      return 'An error occurred';
  }
}