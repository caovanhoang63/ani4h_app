import 'package:freezed_annotation/freezed_annotation.dart';

part 'paging.freezed.dart';
part 'paging.g.dart';

@freezed
sealed class Paging with _$Paging {
  const factory Paging({
    String? cursor,
    String? nextCursor,
    required int pageSize,
    required int page,
  }) = _Paging;

  factory Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);
}