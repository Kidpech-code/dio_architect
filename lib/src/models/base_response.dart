// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.freezed.dart';
part 'base_response.g.dart';

// ─── Pagination Meta ─────────────────────────────────────────────────────────

@freezed
class PaginationMeta with _$PaginationMeta {
  const factory PaginationMeta({
    @JsonKey(name: 'current_page') int? currentPage,
    @JsonKey(name: 'last_page') int? lastPage,
    @JsonKey(name: 'per_page') int? perPage,
    int? total,
    String? path,
  }) = _PaginationMeta;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);
}

// ─── Base API Envelope ───────────────────────────────────────────────────────

/// Generic REST envelope supporting payloads like:
/// ```json
/// { "data": T, "meta": {...}, "message": "..." }
/// ```
///
/// Deserialize with the [fromJson] factory:
/// ```dart
/// final response = BaseResponse.fromJson(
///   json,
///   (raw) => User.fromJson(raw as Map<String, dynamic>),
/// );
/// ```
@Freezed(genericArgumentFactories: true)
class BaseResponse<T> with _$BaseResponse<T> {
  const factory BaseResponse({
    required T data,
    String? message,
    PaginationMeta? meta,
    @JsonKey(name: 'status_code') int? statusCode,
  }) = _BaseResponse<T>;

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);
}

// ─── List Envelope ────────────────────────────────────────────────────────────

/// Convenience wrapper for paginated list responses.
/// ```json
/// { "data": [T, T, ...], "meta": { "total": 100, ... } }
/// ```
@Freezed(genericArgumentFactories: true)
class BaseListResponse<T> with _$BaseListResponse<T> {
  const factory BaseListResponse({
    required List<T> data,
    String? message,
    PaginationMeta? meta,
    @JsonKey(name: 'status_code') int? statusCode,
  }) = _BaseListResponse<T>;

  factory BaseListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseListResponseFromJson(json, fromJsonT);
}
