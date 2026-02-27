// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NetworkFailure {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NetworkFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'NetworkFailure()';
  }
}

/// @nodoc
class $NetworkFailureCopyWith<$Res> {
  $NetworkFailureCopyWith(NetworkFailure _, $Res Function(NetworkFailure) __);
}

/// Adds pattern-matching-related methods to [NetworkFailure].
extension NetworkFailurePatterns on NetworkFailure {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NoConnection value)? noConnection,
    TResult Function(_Timeout value)? timeout,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_BadRequest value)? badRequest,
    TResult Function(_ServerError value)? serverError,
    TResult Function(_Unknown value)? unknown,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NoConnection() when noConnection != null:
        return noConnection(_that);
      case _Timeout() when timeout != null:
        return timeout(_that);
      case _Unauthorized() when unauthorized != null:
        return unauthorized(_that);
      case _BadRequest() when badRequest != null:
        return badRequest(_that);
      case _ServerError() when serverError != null:
        return serverError(_that);
      case _Unknown() when unknown != null:
        return unknown(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(NoConnection value) noConnection,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_BadRequest value) badRequest,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_Unknown value) unknown,
  }) {
    final _that = this;
    switch (_that) {
      case NoConnection():
        return noConnection(_that);
      case _Timeout():
        return timeout(_that);
      case _Unauthorized():
        return unauthorized(_that);
      case _BadRequest():
        return badRequest(_that);
      case _ServerError():
        return serverError(_that);
      case _Unknown():
        return unknown(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoConnection value)? noConnection,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_BadRequest value)? badRequest,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_Unknown value)? unknown,
  }) {
    final _that = this;
    switch (_that) {
      case NoConnection() when noConnection != null:
        return noConnection(_that);
      case _Timeout() when timeout != null:
        return timeout(_that);
      case _Unauthorized() when unauthorized != null:
        return unauthorized(_that);
      case _BadRequest() when badRequest != null:
        return badRequest(_that);
      case _ServerError() when serverError != null:
        return serverError(_that);
      case _Unknown() when unknown != null:
        return unknown(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noConnection,
    TResult Function()? timeout,
    TResult Function(String? message)? unauthorized,
    TResult Function(String message)? badRequest,
    TResult Function(int statusCode, String? message)? serverError,
    TResult Function(String? message, Object? error, StackTrace? stackTrace)?
        unknown,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case NoConnection() when noConnection != null:
        return noConnection();
      case _Timeout() when timeout != null:
        return timeout();
      case _Unauthorized() when unauthorized != null:
        return unauthorized(_that.message);
      case _BadRequest() when badRequest != null:
        return badRequest(_that.message);
      case _ServerError() when serverError != null:
        return serverError(_that.statusCode, _that.message);
      case _Unknown() when unknown != null:
        return unknown(_that.message, _that.error, _that.stackTrace);
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
  TResult when<TResult extends Object?>({
    required TResult Function() noConnection,
    required TResult Function() timeout,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String message) badRequest,
    required TResult Function(int statusCode, String? message) serverError,
    required TResult Function(
            String? message, Object? error, StackTrace? stackTrace)
        unknown,
  }) {
    final _that = this;
    switch (_that) {
      case NoConnection():
        return noConnection();
      case _Timeout():
        return timeout();
      case _Unauthorized():
        return unauthorized(_that.message);
      case _BadRequest():
        return badRequest(_that.message);
      case _ServerError():
        return serverError(_that.statusCode, _that.message);
      case _Unknown():
        return unknown(_that.message, _that.error, _that.stackTrace);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noConnection,
    TResult? Function()? timeout,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String message)? badRequest,
    TResult? Function(int statusCode, String? message)? serverError,
    TResult? Function(String? message, Object? error, StackTrace? stackTrace)?
        unknown,
  }) {
    final _that = this;
    switch (_that) {
      case NoConnection() when noConnection != null:
        return noConnection();
      case _Timeout() when timeout != null:
        return timeout();
      case _Unauthorized() when unauthorized != null:
        return unauthorized(_that.message);
      case _BadRequest() when badRequest != null:
        return badRequest(_that.message);
      case _ServerError() when serverError != null:
        return serverError(_that.statusCode, _that.message);
      case _Unknown() when unknown != null:
        return unknown(_that.message, _that.error, _that.stackTrace);
      case _:
        return null;
    }
  }
}

/// @nodoc

class NoConnection implements NetworkFailure {
  const NoConnection();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NoConnection);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'NetworkFailure.noConnection()';
  }
}

/// @nodoc

class _Timeout implements NetworkFailure {
  const _Timeout();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Timeout);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'NetworkFailure.timeout()';
  }
}

/// @nodoc

class _Unauthorized implements NetworkFailure {
  const _Unauthorized({this.message});

  final String? message;

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnauthorizedCopyWith<_Unauthorized> get copyWith =>
      __$UnauthorizedCopyWithImpl<_Unauthorized>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Unauthorized &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'NetworkFailure.unauthorized(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$UnauthorizedCopyWith<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  factory _$UnauthorizedCopyWith(
          _Unauthorized value, $Res Function(_Unauthorized) _then) =
      __$UnauthorizedCopyWithImpl;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$UnauthorizedCopyWithImpl<$Res>
    implements _$UnauthorizedCopyWith<$Res> {
  __$UnauthorizedCopyWithImpl(this._self, this._then);

  final _Unauthorized _self;
  final $Res Function(_Unauthorized) _then;

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_Unauthorized(
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _BadRequest implements NetworkFailure {
  const _BadRequest({required this.message});

  final String message;

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BadRequestCopyWith<_BadRequest> get copyWith =>
      __$BadRequestCopyWithImpl<_BadRequest>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BadRequest &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'NetworkFailure.badRequest(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$BadRequestCopyWith<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  factory _$BadRequestCopyWith(
          _BadRequest value, $Res Function(_BadRequest) _then) =
      __$BadRequestCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$BadRequestCopyWithImpl<$Res> implements _$BadRequestCopyWith<$Res> {
  __$BadRequestCopyWithImpl(this._self, this._then);

  final _BadRequest _self;
  final $Res Function(_BadRequest) _then;

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_BadRequest(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _ServerError implements NetworkFailure {
  const _ServerError({required this.statusCode, this.message});

  final int statusCode;
  final String? message;

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ServerErrorCopyWith<_ServerError> get copyWith =>
      __$ServerErrorCopyWithImpl<_ServerError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ServerError &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusCode, message);

  @override
  String toString() {
    return 'NetworkFailure.serverError(statusCode: $statusCode, message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ServerErrorCopyWith<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  factory _$ServerErrorCopyWith(
          _ServerError value, $Res Function(_ServerError) _then) =
      __$ServerErrorCopyWithImpl;
  @useResult
  $Res call({int statusCode, String? message});
}

/// @nodoc
class __$ServerErrorCopyWithImpl<$Res> implements _$ServerErrorCopyWith<$Res> {
  __$ServerErrorCopyWithImpl(this._self, this._then);

  final _ServerError _self;
  final $Res Function(_ServerError) _then;

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? statusCode = null,
    Object? message = freezed,
  }) {
    return _then(_ServerError(
      statusCode: null == statusCode
          ? _self.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _Unknown implements NetworkFailure {
  const _Unknown({this.message, this.error, this.stackTrace});

  final String? message;
  final Object? error;
  final StackTrace? stackTrace;

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnknownCopyWith<_Unknown> get copyWith =>
      __$UnknownCopyWithImpl<_Unknown>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Unknown &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message,
      const DeepCollectionEquality().hash(error), stackTrace);

  @override
  String toString() {
    return 'NetworkFailure.unknown(message: $message, error: $error, stackTrace: $stackTrace)';
  }
}

/// @nodoc
abstract mixin class _$UnknownCopyWith<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  factory _$UnknownCopyWith(_Unknown value, $Res Function(_Unknown) _then) =
      __$UnknownCopyWithImpl;
  @useResult
  $Res call({String? message, Object? error, StackTrace? stackTrace});
}

/// @nodoc
class __$UnknownCopyWithImpl<$Res> implements _$UnknownCopyWith<$Res> {
  __$UnknownCopyWithImpl(this._self, this._then);

  final _Unknown _self;
  final $Res Function(_Unknown) _then;

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = freezed,
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_Unknown(
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error ? _self.error : error,
      stackTrace: freezed == stackTrace
          ? _self.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

// dart format on
