// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaginationMeta {
  @JsonKey(name: 'current_page')
  int? get currentPage;
  @JsonKey(name: 'last_page')
  int? get lastPage;
  @JsonKey(name: 'per_page')
  int? get perPage;
  int? get total;
  String? get path;

  /// Create a copy of PaginationMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaginationMetaCopyWith<PaginationMeta> get copyWith =>
      _$PaginationMetaCopyWithImpl<PaginationMeta>(
          this as PaginationMeta, _$identity);

  /// Serializes this PaginationMeta to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaginationMeta &&
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

  @override
  String toString() {
    return 'PaginationMeta(currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage, total: $total, path: $path)';
  }
}

/// @nodoc
abstract mixin class $PaginationMetaCopyWith<$Res> {
  factory $PaginationMetaCopyWith(
          PaginationMeta value, $Res Function(PaginationMeta) _then) =
      _$PaginationMetaCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page') int? currentPage,
      @JsonKey(name: 'last_page') int? lastPage,
      @JsonKey(name: 'per_page') int? perPage,
      int? total,
      String? path});
}

/// @nodoc
class _$PaginationMetaCopyWithImpl<$Res>
    implements $PaginationMetaCopyWith<$Res> {
  _$PaginationMetaCopyWithImpl(this._self, this._then);

  final PaginationMeta _self;
  final $Res Function(PaginationMeta) _then;

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
    return _then(_self.copyWith(
      currentPage: freezed == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      lastPage: freezed == lastPage
          ? _self.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int?,
      perPage: freezed == perPage
          ? _self.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      path: freezed == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [PaginationMeta].
extension PaginationMetaPatterns on PaginationMeta {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PaginationMeta value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaginationMeta() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PaginationMeta value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginationMeta():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PaginationMeta value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginationMeta() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'current_page') int? currentPage,
            @JsonKey(name: 'last_page') int? lastPage,
            @JsonKey(name: 'per_page') int? perPage,
            int? total,
            String? path)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaginationMeta() when $default != null:
        return $default(_that.currentPage, _that.lastPage, _that.perPage,
            _that.total, _that.path);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'current_page') int? currentPage,
            @JsonKey(name: 'last_page') int? lastPage,
            @JsonKey(name: 'per_page') int? perPage,
            int? total,
            String? path)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginationMeta():
        return $default(_that.currentPage, _that.lastPage, _that.perPage,
            _that.total, _that.path);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @JsonKey(name: 'current_page') int? currentPage,
            @JsonKey(name: 'last_page') int? lastPage,
            @JsonKey(name: 'per_page') int? perPage,
            int? total,
            String? path)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaginationMeta() when $default != null:
        return $default(_that.currentPage, _that.lastPage, _that.perPage,
            _that.total, _that.path);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PaginationMeta implements PaginationMeta {
  const _PaginationMeta(
      {@JsonKey(name: 'current_page') this.currentPage,
      @JsonKey(name: 'last_page') this.lastPage,
      @JsonKey(name: 'per_page') this.perPage,
      this.total,
      this.path});
  factory _PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);

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

  /// Create a copy of PaginationMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaginationMetaCopyWith<_PaginationMeta> get copyWith =>
      __$PaginationMetaCopyWithImpl<_PaginationMeta>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PaginationMetaToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaginationMeta &&
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

  @override
  String toString() {
    return 'PaginationMeta(currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage, total: $total, path: $path)';
  }
}

/// @nodoc
abstract mixin class _$PaginationMetaCopyWith<$Res>
    implements $PaginationMetaCopyWith<$Res> {
  factory _$PaginationMetaCopyWith(
          _PaginationMeta value, $Res Function(_PaginationMeta) _then) =
      __$PaginationMetaCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page') int? currentPage,
      @JsonKey(name: 'last_page') int? lastPage,
      @JsonKey(name: 'per_page') int? perPage,
      int? total,
      String? path});
}

/// @nodoc
class __$PaginationMetaCopyWithImpl<$Res>
    implements _$PaginationMetaCopyWith<$Res> {
  __$PaginationMetaCopyWithImpl(this._self, this._then);

  final _PaginationMeta _self;
  final $Res Function(_PaginationMeta) _then;

  /// Create a copy of PaginationMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? currentPage = freezed,
    Object? lastPage = freezed,
    Object? perPage = freezed,
    Object? total = freezed,
    Object? path = freezed,
  }) {
    return _then(_PaginationMeta(
      currentPage: freezed == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      lastPage: freezed == lastPage
          ? _self.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int?,
      perPage: freezed == perPage
          ? _self.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      path: freezed == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$BaseResponse<T> {
  T get data;
  String? get message;
  PaginationMeta? get meta;
  @JsonKey(name: 'status_code')
  int? get statusCode;

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BaseResponseCopyWith<T, BaseResponse<T>> get copyWith =>
      _$BaseResponseCopyWithImpl<T, BaseResponse<T>>(
          this as BaseResponse<T>, _$identity);

  /// Serializes this BaseResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BaseResponse<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.meta, meta) || other.meta == meta) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(data), message, meta, statusCode);

  @override
  String toString() {
    return 'BaseResponse<$T>(data: $data, message: $message, meta: $meta, statusCode: $statusCode)';
  }
}

/// @nodoc
abstract mixin class $BaseResponseCopyWith<T, $Res> {
  factory $BaseResponseCopyWith(
          BaseResponse<T> value, $Res Function(BaseResponse<T>) _then) =
      _$BaseResponseCopyWithImpl;
  @useResult
  $Res call(
      {T data,
      String? message,
      PaginationMeta? meta,
      @JsonKey(name: 'status_code') int? statusCode});

  $PaginationMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class _$BaseResponseCopyWithImpl<T, $Res>
    implements $BaseResponseCopyWith<T, $Res> {
  _$BaseResponseCopyWithImpl(this._self, this._then);

  final BaseResponse<T> _self;
  final $Res Function(BaseResponse<T>) _then;

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
    return _then(_self.copyWith(
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      meta: freezed == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PaginationMeta?,
      statusCode: freezed == statusCode
          ? _self.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationMetaCopyWith<$Res>? get meta {
    if (_self.meta == null) {
      return null;
    }

    return $PaginationMetaCopyWith<$Res>(_self.meta!, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// Adds pattern-matching-related methods to [BaseResponse].
extension BaseResponsePatterns<T> on BaseResponse<T> {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_BaseResponse<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BaseResponse() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_BaseResponse<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BaseResponse():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_BaseResponse<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BaseResponse() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(T data, String? message, PaginationMeta? meta,
            @JsonKey(name: 'status_code') int? statusCode)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BaseResponse() when $default != null:
        return $default(
            _that.data, _that.message, _that.meta, _that.statusCode);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(T data, String? message, PaginationMeta? meta,
            @JsonKey(name: 'status_code') int? statusCode)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BaseResponse():
        return $default(
            _that.data, _that.message, _that.meta, _that.statusCode);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(T data, String? message, PaginationMeta? meta,
            @JsonKey(name: 'status_code') int? statusCode)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BaseResponse() when $default != null:
        return $default(
            _that.data, _that.message, _that.meta, _that.statusCode);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _BaseResponse<T> implements BaseResponse<T> {
  const _BaseResponse(
      {required this.data,
      this.message,
      this.meta,
      @JsonKey(name: 'status_code') this.statusCode});
  factory _BaseResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);

  @override
  final T data;
  @override
  final String? message;
  @override
  final PaginationMeta? meta;
  @override
  @JsonKey(name: 'status_code')
  final int? statusCode;

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BaseResponseCopyWith<T, _BaseResponse<T>> get copyWith =>
      __$BaseResponseCopyWithImpl<T, _BaseResponse<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$BaseResponseToJson<T>(this, toJsonT);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BaseResponse<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.meta, meta) || other.meta == meta) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(data), message, meta, statusCode);

  @override
  String toString() {
    return 'BaseResponse<$T>(data: $data, message: $message, meta: $meta, statusCode: $statusCode)';
  }
}

/// @nodoc
abstract mixin class _$BaseResponseCopyWith<T, $Res>
    implements $BaseResponseCopyWith<T, $Res> {
  factory _$BaseResponseCopyWith(
          _BaseResponse<T> value, $Res Function(_BaseResponse<T>) _then) =
      __$BaseResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {T data,
      String? message,
      PaginationMeta? meta,
      @JsonKey(name: 'status_code') int? statusCode});

  @override
  $PaginationMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class __$BaseResponseCopyWithImpl<T, $Res>
    implements _$BaseResponseCopyWith<T, $Res> {
  __$BaseResponseCopyWithImpl(this._self, this._then);

  final _BaseResponse<T> _self;
  final $Res Function(_BaseResponse<T>) _then;

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = freezed,
    Object? message = freezed,
    Object? meta = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(_BaseResponse<T>(
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      meta: freezed == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PaginationMeta?,
      statusCode: freezed == statusCode
          ? _self.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationMetaCopyWith<$Res>? get meta {
    if (_self.meta == null) {
      return null;
    }

    return $PaginationMetaCopyWith<$Res>(_self.meta!, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// @nodoc
mixin _$BaseListResponse<T> {
  List<T> get data;
  String? get message;
  PaginationMeta? get meta;
  @JsonKey(name: 'status_code')
  int? get statusCode;

  /// Create a copy of BaseListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BaseListResponseCopyWith<T, BaseListResponse<T>> get copyWith =>
      _$BaseListResponseCopyWithImpl<T, BaseListResponse<T>>(
          this as BaseListResponse<T>, _$identity);

  /// Serializes this BaseListResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BaseListResponse<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.meta, meta) || other.meta == meta) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(data), message, meta, statusCode);

  @override
  String toString() {
    return 'BaseListResponse<$T>(data: $data, message: $message, meta: $meta, statusCode: $statusCode)';
  }
}

/// @nodoc
abstract mixin class $BaseListResponseCopyWith<T, $Res> {
  factory $BaseListResponseCopyWith(
          BaseListResponse<T> value, $Res Function(BaseListResponse<T>) _then) =
      _$BaseListResponseCopyWithImpl;
  @useResult
  $Res call(
      {List<T> data,
      String? message,
      PaginationMeta? meta,
      @JsonKey(name: 'status_code') int? statusCode});

  $PaginationMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class _$BaseListResponseCopyWithImpl<T, $Res>
    implements $BaseListResponseCopyWith<T, $Res> {
  _$BaseListResponseCopyWithImpl(this._self, this._then);

  final BaseListResponse<T> _self;
  final $Res Function(BaseListResponse<T>) _then;

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
    return _then(_self.copyWith(
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      meta: freezed == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PaginationMeta?,
      statusCode: freezed == statusCode
          ? _self.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of BaseListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationMetaCopyWith<$Res>? get meta {
    if (_self.meta == null) {
      return null;
    }

    return $PaginationMetaCopyWith<$Res>(_self.meta!, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// Adds pattern-matching-related methods to [BaseListResponse].
extension BaseListResponsePatterns<T> on BaseListResponse<T> {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_BaseListResponse<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BaseListResponse() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_BaseListResponse<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BaseListResponse():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_BaseListResponse<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BaseListResponse() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<T> data, String? message, PaginationMeta? meta,
            @JsonKey(name: 'status_code') int? statusCode)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BaseListResponse() when $default != null:
        return $default(
            _that.data, _that.message, _that.meta, _that.statusCode);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<T> data, String? message, PaginationMeta? meta,
            @JsonKey(name: 'status_code') int? statusCode)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BaseListResponse():
        return $default(
            _that.data, _that.message, _that.meta, _that.statusCode);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<T> data, String? message, PaginationMeta? meta,
            @JsonKey(name: 'status_code') int? statusCode)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BaseListResponse() when $default != null:
        return $default(
            _that.data, _that.message, _that.meta, _that.statusCode);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _BaseListResponse<T> implements BaseListResponse<T> {
  const _BaseListResponse(
      {required final List<T> data,
      this.message,
      this.meta,
      @JsonKey(name: 'status_code') this.statusCode})
      : _data = data;
  factory _BaseListResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$BaseListResponseFromJson(json, fromJsonT);

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

  /// Create a copy of BaseListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BaseListResponseCopyWith<T, _BaseListResponse<T>> get copyWith =>
      __$BaseListResponseCopyWithImpl<T, _BaseListResponse<T>>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$BaseListResponseToJson<T>(this, toJsonT);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BaseListResponse<T> &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.meta, meta) || other.meta == meta) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_data), message, meta, statusCode);

  @override
  String toString() {
    return 'BaseListResponse<$T>(data: $data, message: $message, meta: $meta, statusCode: $statusCode)';
  }
}

/// @nodoc
abstract mixin class _$BaseListResponseCopyWith<T, $Res>
    implements $BaseListResponseCopyWith<T, $Res> {
  factory _$BaseListResponseCopyWith(_BaseListResponse<T> value,
          $Res Function(_BaseListResponse<T>) _then) =
      __$BaseListResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<T> data,
      String? message,
      PaginationMeta? meta,
      @JsonKey(name: 'status_code') int? statusCode});

  @override
  $PaginationMetaCopyWith<$Res>? get meta;
}

/// @nodoc
class __$BaseListResponseCopyWithImpl<T, $Res>
    implements _$BaseListResponseCopyWith<T, $Res> {
  __$BaseListResponseCopyWithImpl(this._self, this._then);

  final _BaseListResponse<T> _self;
  final $Res Function(_BaseListResponse<T>) _then;

  /// Create a copy of BaseListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
    Object? message = freezed,
    Object? meta = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(_BaseListResponse<T>(
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      meta: freezed == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as PaginationMeta?,
      statusCode: freezed == statusCode
          ? _self.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of BaseListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationMetaCopyWith<$Res>? get meta {
    if (_self.meta == null) {
      return null;
    }

    return $PaginationMetaCopyWith<$Res>(_self.meta!, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

// dart format on
