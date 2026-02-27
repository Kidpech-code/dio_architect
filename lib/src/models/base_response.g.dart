// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaginationMeta _$PaginationMetaFromJson(Map<String, dynamic> json) =>
    _PaginationMeta(
      currentPage: (json['current_page'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      path: json['path'] as String?,
    );

Map<String, dynamic> _$PaginationMetaToJson(_PaginationMeta instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'per_page': instance.perPage,
      'total': instance.total,
      'path': instance.path,
    };

_BaseResponse<T> _$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _BaseResponse<T>(
      data: fromJsonT(json['data']),
      message: json['message'] as String?,
      meta: json['meta'] == null
          ? null
          : PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
      statusCode: (json['status_code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BaseResponseToJson<T>(
  _BaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': toJsonT(instance.data),
      'message': instance.message,
      'meta': instance.meta,
      'status_code': instance.statusCode,
    };

_BaseListResponse<T> _$BaseListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _BaseListResponse<T>(
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
      message: json['message'] as String?,
      meta: json['meta'] == null
          ? null
          : PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
      statusCode: (json['status_code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BaseListResponseToJson<T>(
  _BaseListResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data.map(toJsonT).toList(),
      'message': instance.message,
      'meta': instance.meta,
      'status_code': instance.statusCode,
    };
