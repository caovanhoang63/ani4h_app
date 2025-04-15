import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure implements Exception {
  const factory Failure({
    required String message,
    int? statusCode,
    Exception? exception,
    @Default(StackTrace.empty) StackTrace stackTrace,
  }) = _Failure;
}

Exception toException(Object e) {
  if (e is Exception) {
    return e;
  } else {
    return Exception('Unknown error: $e');
  }
}