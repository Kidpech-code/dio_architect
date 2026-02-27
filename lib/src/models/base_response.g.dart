// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginationMetaImpl _$$PaginationMetaImplFromJson(Map<String, dynamic> json) =>
    _$PaginationMetaImpl(
      currentPage: (json['current_page'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      path: json['path'] as String?,
    );

Map<String, dynamic> _$$PaginationMetaImplToJson(
  _$PaginationMetaImpl instance,
) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'per_page': instance.perPage,
      'total': instance.total,
      'path': instance.path,
    };

_$BaseResponseImpl<T> _$$BaseResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$BaseResponseImpl<T>(
      data: fromJsonT(json['data']),
      message: json['message'] as String?,
      meta: json['meta'] == null
          ? null
          : PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
      statusCode: (json['status_code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$BaseResponseImplToJson<T>(
  _$BaseResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': toJsonT(instance.data),
      'message': instance.message,
      'meta': instance.meta,
      'status_code': instance.statusCode,
    };

_$BaseListResponseImpl<T> _$$BaseListResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$BaseListResponseImpl<T>(
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
      message: json['message'] as String?,
      meta: json['meta'] == null
          ? null
          : PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
      statusCode: (json['status_code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$BaseListResponseImplToJson<T>(
  _$BaseListResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data.map(toJsonT).toList(),
      'message': instance.message,
      'meta': instance.meta,
      'status_code': instance.statusCode,
    };
