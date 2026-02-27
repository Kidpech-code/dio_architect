// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaginationMeta _$PaginationMetaFromJson(Map<String, dynamic> json) {
  return _PaginationMeta.fromJson(json);
}

/// @nodoc
mixin _$PaginationMeta {
  @JsonKey(name: 'current_page')
  int? get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page')
  int? get lastPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int? get perPage => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;

  /// Serializes this PaginationMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginationMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginationMetaCopyWith<PaginationMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationMetaCopyWith<$Res> {
  factory $PaginationMetaCopyWith(
    PaginationMeta value,
    $Res Function(PaginationMeta) then,
  ) = _$PaginationMetaCopyWithImpl<$Res, PaginationMeta>;
  @useResult
  $Res call({
    @JsonKey(name: 'current_page') int? currentPage,
    @JsonKey(name: 'last_page') int? lastPage,
    @JsonKey(name: 'per_page') int? perPage,
    int? total,
    String? path,
  });
}

/// @nodoc
class _$PaginationMetaCopyWithImpl<$Res, $Val extends PaginationMeta>
    implements $PaginationMetaCopyWith<$Res> {
  _$PaginationMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginationMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = freezed,
    Object? lastPage = freezed,
    Object? perPage = freezed,
    Object? total = freezed,
    Object? path = freezed,
  }) {
    return _then(
      _value.copyWith(
            currentPage: freezed == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int?,
            lastPage: freezed == lastPage
                ? _value.lastPage
                : lastPage // ignore: cast_nullable_to_non_nullable
                      as int?,
            perPage: freezed == perPage
                ? _value.perPage
                : perPage // ignore: cast_nullable_to_non_nullable
                      as int?,
            total: freezed == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int?,
            path: freezed == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginationMetaImplCopyWith<$Res>
    implements $PaginationMetaCopyWith<$Res> {
  factory _$$PaginationMetaImplCopyWith(
    _$PaginationMetaImpl value,
    $Res Function(_$PaginationMetaImpl) then,
  ) = __$$PaginationMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'current_page') int? currentPage,
    @JsonKey(name: 'last_page') int? lastPage,
    @JsonKey(name: 'per_page') int? perPage,
    int? total,
    String? path,
  });
}

/// @nodoc
class __$$PaginationMetaImplCopyWithImpl<$Res>
    extends _$PaginationMetaCopyWithImpl<$Res, _$PaginationMetaImpl>
    implements _$$PaginationMetaImplCopyWith<$Res> {
  __$$PaginationMetaImplCopyWithImpl(
    _$PaginationMetaImpl _value,
    $Res Function(_$PaginationMetaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginationMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = freezed,
    Object? lastPage = freezed,
    Object? perPage = freezed,
    Object? total = freezed,
    Object? path = freezed,
  }) {
    return _then(
      _$PaginationMetaImpl(
        currentPage: freezed == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int?,
        lastPage: freezed == lastPage
            ? _value.lastPage
            : lastPage // ignore: cast_nullable_to_non_nullable
                  as int?,
        perPage: freezed == perPage
            ? _value.perPage
            : perPage // ignore: cast_nullable_to_non_nullable
                  as int?,
        total: freezed == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int?,
        path: freezed == path
            ? _value.path
            : path // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginationMetaImpl implements _PaginationMeta {
  const _$PaginationMetaImpl({
    @JsonKey(name: 'current_page') this.currentPage,
    @JsonKey(name: 'last_page') this.lastPage,
    @JsonKey(name: 'per_page') this.perPage,
    this.total,
    this.path,
  });

  factory _$PaginationMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginationMetaImplFromJson(json);

  @override
  @JsonKey(name: 'current_page')
  final int? currentPage;
  @override
  @JsonKey(name: 'last_page')
  final int? lastPage;
  @override
  @JsonKey(name: 'per_page')
  final int? perPage;
  @override
  final int? total;
  @override
  final String? path;

  @override
  String toString() {
    return 'PaginationMeta(currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage, total: $total, path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationMetaImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, currentPage, lastPage, perPage, total, path);

  /// Create a copy of PaginationMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationMetaImplCopyWith<_$PaginationMetaImpl> get copyWith =>
      __$$PaginationMetaImplCopyWithImpl<_$PaginationMetaImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginationMetaImplToJson(this);
  }
}

abstract class _PaginationMeta implements PaginationMeta {
  const factory _PaginationMeta({
    @JsonKey(name: 'current_page') final int? currentPage,
    @JsonKey(name: 'last_page') final int? lastPage,
    @JsonKey(name: 'per_page') final int? perPage,
    final int? total,
    final String? path,
  }) = _$PaginationMetaImpl;

  factory _PaginationMeta.fromJson(Map<String, dynamic> json) =
      _$PaginationMetaImpl.fromJson;

  @override
  @JsonKey(name: 'current_page')
  int? get currentPage;
  @override
  @JsonKey(name: 'last_page')
  int? get lastPage;
  @override
  @JsonKey(name: 'per_page')
  int? get perPage;
  @override
  int? get total;
  @override
  String? get path;

  /// Create a copy of PaginationMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginationMetaImplCopyWith<_$PaginationMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) {
  return _BaseResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$BaseResponse<T> {
  T get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  PaginationMeta? get meta => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_code')
  int? get statusCode => throw _privateConstructorUsedError;

  /// Serializes this BaseResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BaseResponseCopyWith<T, BaseResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseResponseCopyWith<T, $Res> {
  factory $BaseResponseCopyWith(
    BaseResponse<T> value,
    $Res Function(BaseResponse<T>) then,
  ) = _$BaseResponseCopyWithImpl<T, $Res, BaseResponse<T>>;
  @useResult
  $Res call({
    T data,
    String? message,
    PaginationMeta? meta,
    @JsonKey(name: 'status_code') int? statusCode,
  });

  $PaginationMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class _$BaseResponseCopyWithImpl<T, $Res, $Val extends BaseResponse<T>>
    implements $BaseResponseCopyWith<T, $Res> {
  _$BaseResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? message = freezed,
    Object? meta = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(
      _value.copyWith(
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as T,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            meta: freezed == meta
                ? _value.meta
                : meta // ignore: cast_nullable_to_non_nullable
                      as PaginationMeta?,
            statusCode: freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationMetaCopyWith<$Res>? get meta {
    if (_value.meta == null) {
      return null;
    }

    return $PaginationMetaCopyWith<$Res>(_value.meta!, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BaseResponseImplCopyWith<T, $Res>
    implements $BaseResponseCopyWith<T, $Res> {
  factory _$$BaseResponseImplCopyWith(
    _$BaseResponseImpl<T> value,
    $Res Function(_$BaseResponseImpl<T>) then,
  ) = __$$BaseResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({
    T data,
    String? message,
    PaginationMeta? meta,
    @JsonKey(name: 'status_code') int? statusCode,
  });

  @override
  $PaginationMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class __$$BaseResponseImplCopyWithImpl<T, $Res>
    extends _$BaseResponseCopyWithImpl<T, $Res, _$BaseResponseImpl<T>>
    implements _$$BaseResponseImplCopyWith<T, $Res> {
  __$$BaseResponseImplCopyWithImpl(
    _$BaseResponseImpl<T> _value,
    $Res Function(_$BaseResponseImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? message = freezed,
    Object? meta = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(
      _$BaseResponseImpl<T>(
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as T,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        meta: freezed == meta
            ? _value.meta
            : meta // ignore: cast_nullable_to_non_nullable
                  as PaginationMeta?,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$BaseResponseImpl<T> implements _BaseResponse<T> {
  const _$BaseResponseImpl({
    required this.data,
    this.message,
    this.meta,
    @JsonKey(name: 'status_code') this.statusCode,
  });

  factory _$BaseResponseImpl.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$$BaseResponseImplFromJson(json, fromJsonT);

  @override
  final T data;
  @override
  final String? message;
  @override
  final PaginationMeta? meta;
  @override
  @JsonKey(name: 'status_code')
  final int? statusCode;

  @override
  String toString() {
    return 'BaseResponse<$T>(data: $data, message: $message, meta: $meta, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseResponseImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.meta, meta) || other.meta == meta) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(data),
    message,
    meta,
    statusCode,
  );

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseResponseImplCopyWith<T, _$BaseResponseImpl<T>> get copyWith =>
      __$$BaseResponseImplCopyWithImpl<T, _$BaseResponseImpl<T>>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$BaseResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _BaseResponse<T> implements BaseResponse<T> {
  const factory _BaseResponse({
    required final T data,
    final String? message,
    final PaginationMeta? meta,
    @JsonKey(name: 'status_code') final int? statusCode,
  }) = _$BaseResponseImpl<T>;

  factory _BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) = _$BaseResponseImpl<T>.fromJson;

  @override
  T get data;
  @override
  String? get message;
  @override
  PaginationMeta? get meta;
  @override
  @JsonKey(name: 'status_code')
  int? get statusCode;

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BaseResponseImplCopyWith<T, _$BaseResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

BaseListResponse<T> _$BaseListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) {
  return _BaseListResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$BaseListResponse<T> {
  List<T> get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  PaginationMeta? get meta => throw _privateConstructorUsedError;
  @JsonKey(name: 'status_code')
  int? get statusCode => throw _privateConstructorUsedError;

  /// Serializes this BaseListResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of BaseListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BaseListResponseCopyWith<T, BaseListResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseListResponseCopyWith<T, $Res> {
  factory $BaseListResponseCopyWith(
    BaseListResponse<T> value,
    $Res Function(BaseListResponse<T>) then,
  ) = _$BaseListResponseCopyWithImpl<T, $Res, BaseListResponse<T>>;
  @useResult
  $Res call({
    List<T> data,
    String? message,
    PaginationMeta? meta,
    @JsonKey(name: 'status_code') int? statusCode,
  });

  $PaginationMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class _$BaseListResponseCopyWithImpl<T, $Res, $Val extends BaseListResponse<T>>
    implements $BaseListResponseCopyWith<T, $Res> {
  _$BaseListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BaseListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = freezed,
    Object? meta = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(
      _value.copyWith(
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<T>,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            meta: freezed == meta
                ? _value.meta
                : meta // ignore: cast_nullable_to_non_nullable
                      as PaginationMeta?,
            statusCode: freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }

  /// Create a copy of BaseListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationMetaCopyWith<$Res>? get meta {
    if (_value.meta == null) {
      return null;
    }

    return $PaginationMetaCopyWith<$Res>(_value.meta!, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BaseListResponseImplCopyWith<T, $Res>
    implements $BaseListResponseCopyWith<T, $Res> {
  factory _$$BaseListResponseImplCopyWith(
    _$BaseListResponseImpl<T> value,
    $Res Function(_$BaseListResponseImpl<T>) then,
  ) = __$$BaseListResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({
    List<T> data,
    String? message,
    PaginationMeta? meta,
    @JsonKey(name: 'status_code') int? statusCode,
  });

  @override
  $PaginationMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class __$$BaseListResponseImplCopyWithImpl<T, $Res>
    extends _$BaseListResponseCopyWithImpl<T, $Res, _$BaseListResponseImpl<T>>
    implements _$$BaseListResponseImplCopyWith<T, $Res> {
  __$$BaseListResponseImplCopyWithImpl(
    _$BaseListResponseImpl<T> _value,
    $Res Function(_$BaseListResponseImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of BaseListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = freezed,
    Object? meta = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(
      _$BaseListResponseImpl<T>(
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<T>,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        meta: freezed == meta
            ? _value.meta
            : meta // ignore: cast_nullable_to_non_nullable
                  as PaginationMeta?,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$BaseListResponseImpl<T> implements _BaseListResponse<T> {
  const _$BaseListResponseImpl({
    required final List<T> data,
    this.message,
    this.meta,
    @JsonKey(name: 'status_code') this.statusCode,
  }) : _data = data;

  factory _$BaseListResponseImpl.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$$BaseListResponseImplFromJson(json, fromJsonT);

  final List<T> _data;
  @override
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final String? message;
  @override
  final PaginationMeta? meta;
  @override
  @JsonKey(name: 'status_code')
  final int? statusCode;

  @override
  String toString() {
    return 'BaseListResponse<$T>(data: $data, message: $message, meta: $meta, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseListResponseImpl<T> &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.meta, meta) || other.meta == meta) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_data),
    message,
    meta,
    statusCode,
  );

  /// Create a copy of BaseListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseListResponseImplCopyWith<T, _$BaseListResponseImpl<T>> get copyWith =>
      __$$BaseListResponseImplCopyWithImpl<T, _$BaseListResponseImpl<T>>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$BaseListResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _BaseListResponse<T> implements BaseListResponse<T> {
  const factory _BaseListResponse({
    required final List<T> data,
    final String? message,
    final PaginationMeta? meta,
    @JsonKey(name: 'status_code') final int? statusCode,
  }) = _$BaseListResponseImpl<T>;

  factory _BaseListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) = _$BaseListResponseImpl<T>.fromJson;

  @override
  List<T> get data;
  @override
  String? get message;
  @override
  PaginationMeta? get meta;
  @override
  @JsonKey(name: 'status_code')
  int? get statusCode;

  /// Create a copy of BaseListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BaseListResponseImplCopyWith<T, _$BaseListResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
