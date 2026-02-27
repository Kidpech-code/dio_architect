// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NetworkFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noConnection,
    required TResult Function() timeout,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String message) badRequest,
    required TResult Function(int statusCode, String? message) serverError,
    required TResult Function(
      String? message,
      Object? error,
      StackTrace? stackTrace,
    ) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noConnection,
    TResult? Function()? timeout,
    TResult? Function(String? message)? unauthorized,
    TResult? Function(String message)? badRequest,
    TResult? Function(int statusCode, String? message)? serverError,
    TResult? Function(String? message, Object? error, StackTrace? stackTrace)?
        unknown,
  }) =>
      throw _privateConstructorUsedError;
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
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoConnection value) noConnection,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_BadRequest value) badRequest,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_Unknown value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoConnection value)? noConnection,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_BadRequest value)? badRequest,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_Unknown value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NoConnection value)? noConnection,
    TResult Function(_Timeout value)? timeout,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_BadRequest value)? badRequest,
    TResult Function(_ServerError value)? serverError,
    TResult Function(_Unknown value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkFailureCopyWith<$Res> {
  factory $NetworkFailureCopyWith(
    NetworkFailure value,
    $Res Function(NetworkFailure) then,
  ) = _$NetworkFailureCopyWithImpl<$Res, NetworkFailure>;
}

/// @nodoc
class _$NetworkFailureCopyWithImpl<$Res, $Val extends NetworkFailure>
    implements $NetworkFailureCopyWith<$Res> {
  _$NetworkFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NoConnectionImplCopyWith<$Res> {
  factory _$$NoConnectionImplCopyWith(
    _$NoConnectionImpl value,
    $Res Function(_$NoConnectionImpl) then,
  ) = __$$NoConnectionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoConnectionImplCopyWithImpl<$Res>
    extends _$NetworkFailureCopyWithImpl<$Res, _$NoConnectionImpl>
    implements _$$NoConnectionImplCopyWith<$Res> {
  __$$NoConnectionImplCopyWithImpl(
    _$NoConnectionImpl _value,
    $Res Function(_$NoConnectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NoConnectionImpl implements NoConnection {
  const _$NoConnectionImpl();

  @override
  String toString() {
    return 'NetworkFailure.noConnection()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NoConnectionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noConnection,
    required TResult Function() timeout,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String message) badRequest,
    required TResult Function(int statusCode, String? message) serverError,
    required TResult Function(
      String? message,
      Object? error,
      StackTrace? stackTrace,
    ) unknown,
  }) {
    return noConnection();
  }

  @override
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
    return noConnection?.call();
  }

  @override
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
    if (noConnection != null) {
      return noConnection();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoConnection value) noConnection,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_BadRequest value) badRequest,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_Unknown value) unknown,
  }) {
    return noConnection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoConnection value)? noConnection,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_BadRequest value)? badRequest,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_Unknown value)? unknown,
  }) {
    return noConnection?.call(this);
  }

  @override
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
    if (noConnection != null) {
      return noConnection(this);
    }
    return orElse();
  }
}

abstract class NoConnection implements NetworkFailure {
  const factory NoConnection() = _$NoConnectionImpl;
}

/// @nodoc
abstract class _$$TimeoutImplCopyWith<$Res> {
  factory _$$TimeoutImplCopyWith(
    _$TimeoutImpl value,
    $Res Function(_$TimeoutImpl) then,
  ) = __$$TimeoutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TimeoutImplCopyWithImpl<$Res>
    extends _$NetworkFailureCopyWithImpl<$Res, _$TimeoutImpl>
    implements _$$TimeoutImplCopyWith<$Res> {
  __$$TimeoutImplCopyWithImpl(
    _$TimeoutImpl _value,
    $Res Function(_$TimeoutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TimeoutImpl implements _Timeout {
  const _$TimeoutImpl();

  @override
  String toString() {
    return 'NetworkFailure.timeout()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TimeoutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noConnection,
    required TResult Function() timeout,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String message) badRequest,
    required TResult Function(int statusCode, String? message) serverError,
    required TResult Function(
      String? message,
      Object? error,
      StackTrace? stackTrace,
    ) unknown,
  }) {
    return timeout();
  }

  @override
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
    return timeout?.call();
  }

  @override
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
    if (timeout != null) {
      return timeout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoConnection value) noConnection,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_BadRequest value) badRequest,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_Unknown value) unknown,
  }) {
    return timeout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoConnection value)? noConnection,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_BadRequest value)? badRequest,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_Unknown value)? unknown,
  }) {
    return timeout?.call(this);
  }

  @override
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
    if (timeout != null) {
      return timeout(this);
    }
    return orElse();
  }
}

abstract class _Timeout implements NetworkFailure {
  const factory _Timeout() = _$TimeoutImpl;
}

/// @nodoc
abstract class _$$UnauthorizedImplCopyWith<$Res> {
  factory _$$UnauthorizedImplCopyWith(
    _$UnauthorizedImpl value,
    $Res Function(_$UnauthorizedImpl) then,
  ) = __$$UnauthorizedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$UnauthorizedImplCopyWithImpl<$Res>
    extends _$NetworkFailureCopyWithImpl<$Res, _$UnauthorizedImpl>
    implements _$$UnauthorizedImplCopyWith<$Res> {
  __$$UnauthorizedImplCopyWithImpl(
    _$UnauthorizedImpl _value,
    $Res Function(_$UnauthorizedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed}) {
    return _then(
      _$UnauthorizedImpl(
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String?,
      ),
    );
  }
}

/// @nodoc

class _$UnauthorizedImpl implements _Unauthorized {
  const _$UnauthorizedImpl({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'NetworkFailure.unauthorized(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnauthorizedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnauthorizedImplCopyWith<_$UnauthorizedImpl> get copyWith =>
      __$$UnauthorizedImplCopyWithImpl<_$UnauthorizedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noConnection,
    required TResult Function() timeout,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String message) badRequest,
    required TResult Function(int statusCode, String? message) serverError,
    required TResult Function(
      String? message,
      Object? error,
      StackTrace? stackTrace,
    ) unknown,
  }) {
    return unauthorized(message);
  }

  @override
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
    return unauthorized?.call(message);
  }

  @override
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
    if (unauthorized != null) {
      return unauthorized(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoConnection value) noConnection,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_BadRequest value) badRequest,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_Unknown value) unknown,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoConnection value)? noConnection,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_BadRequest value)? badRequest,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_Unknown value)? unknown,
  }) {
    return unauthorized?.call(this);
  }

  @override
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
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }
}

abstract class _Unauthorized implements NetworkFailure {
  const factory _Unauthorized({final String? message}) = _$UnauthorizedImpl;

  String? get message;

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnauthorizedImplCopyWith<_$UnauthorizedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BadRequestImplCopyWith<$Res> {
  factory _$$BadRequestImplCopyWith(
    _$BadRequestImpl value,
    $Res Function(_$BadRequestImpl) then,
  ) = __$$BadRequestImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$BadRequestImplCopyWithImpl<$Res>
    extends _$NetworkFailureCopyWithImpl<$Res, _$BadRequestImpl>
    implements _$$BadRequestImplCopyWith<$Res> {
  __$$BadRequestImplCopyWithImpl(
    _$BadRequestImpl _value,
    $Res Function(_$BadRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$BadRequestImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$BadRequestImpl implements _BadRequest {
  const _$BadRequestImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'NetworkFailure.badRequest(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadRequestImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BadRequestImplCopyWith<_$BadRequestImpl> get copyWith =>
      __$$BadRequestImplCopyWithImpl<_$BadRequestImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noConnection,
    required TResult Function() timeout,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String message) badRequest,
    required TResult Function(int statusCode, String? message) serverError,
    required TResult Function(
      String? message,
      Object? error,
      StackTrace? stackTrace,
    ) unknown,
  }) {
    return badRequest(message);
  }

  @override
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
    return badRequest?.call(message);
  }

  @override
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
    if (badRequest != null) {
      return badRequest(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoConnection value) noConnection,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_BadRequest value) badRequest,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_Unknown value) unknown,
  }) {
    return badRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoConnection value)? noConnection,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_BadRequest value)? badRequest,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_Unknown value)? unknown,
  }) {
    return badRequest?.call(this);
  }

  @override
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
    if (badRequest != null) {
      return badRequest(this);
    }
    return orElse();
  }
}

abstract class _BadRequest implements NetworkFailure {
  const factory _BadRequest({required final String message}) = _$BadRequestImpl;

  String get message;

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BadRequestImplCopyWith<_$BadRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServerErrorImplCopyWith<$Res> {
  factory _$$ServerErrorImplCopyWith(
    _$ServerErrorImpl value,
    $Res Function(_$ServerErrorImpl) then,
  ) = __$$ServerErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int statusCode, String? message});
}

/// @nodoc
class __$$ServerErrorImplCopyWithImpl<$Res>
    extends _$NetworkFailureCopyWithImpl<$Res, _$ServerErrorImpl>
    implements _$$ServerErrorImplCopyWith<$Res> {
  __$$ServerErrorImplCopyWithImpl(
    _$ServerErrorImpl _value,
    $Res Function(_$ServerErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? statusCode = null, Object? message = freezed}) {
    return _then(
      _$ServerErrorImpl(
        statusCode: null == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                as int,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String?,
      ),
    );
  }
}

/// @nodoc

class _$ServerErrorImpl implements _ServerError {
  const _$ServerErrorImpl({required this.statusCode, this.message});

  @override
  final int statusCode;
  @override
  final String? message;

  @override
  String toString() {
    return 'NetworkFailure.serverError(statusCode: $statusCode, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerErrorImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusCode, message);

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerErrorImplCopyWith<_$ServerErrorImpl> get copyWith =>
      __$$ServerErrorImplCopyWithImpl<_$ServerErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noConnection,
    required TResult Function() timeout,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String message) badRequest,
    required TResult Function(int statusCode, String? message) serverError,
    required TResult Function(
      String? message,
      Object? error,
      StackTrace? stackTrace,
    ) unknown,
  }) {
    return serverError(statusCode, message);
  }

  @override
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
    return serverError?.call(statusCode, message);
  }

  @override
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
    if (serverError != null) {
      return serverError(statusCode, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoConnection value) noConnection,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_BadRequest value) badRequest,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_Unknown value) unknown,
  }) {
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoConnection value)? noConnection,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_BadRequest value)? badRequest,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_Unknown value)? unknown,
  }) {
    return serverError?.call(this);
  }

  @override
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
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }
}

abstract class _ServerError implements NetworkFailure {
  const factory _ServerError({
    required final int statusCode,
    final String? message,
  }) = _$ServerErrorImpl;

  int get statusCode;
  String? get message;

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerErrorImplCopyWith<_$ServerErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownImplCopyWith<$Res> {
  factory _$$UnknownImplCopyWith(
    _$UnknownImpl value,
    $Res Function(_$UnknownImpl) then,
  ) = __$$UnknownImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message, Object? error, StackTrace? stackTrace});
}

/// @nodoc
class __$$UnknownImplCopyWithImpl<$Res>
    extends _$NetworkFailureCopyWithImpl<$Res, _$UnknownImpl>
    implements _$$UnknownImplCopyWith<$Res> {
  __$$UnknownImplCopyWithImpl(
    _$UnknownImpl _value,
    $Res Function(_$UnknownImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(
      _$UnknownImpl(
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String?,
        error: freezed == error ? _value.error : error,
        stackTrace: freezed == stackTrace
            ? _value.stackTrace
            : stackTrace // ignore: cast_nullable_to_non_nullable
                as StackTrace?,
      ),
    );
  }
}

/// @nodoc

class _$UnknownImpl implements _Unknown {
  const _$UnknownImpl({this.message, this.error, this.stackTrace});

  @override
  final String? message;
  @override
  final Object? error;
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'NetworkFailure.unknown(message: $message, error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        message,
        const DeepCollectionEquality().hash(error),
        stackTrace,
      );

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownImplCopyWith<_$UnknownImpl> get copyWith =>
      __$$UnknownImplCopyWithImpl<_$UnknownImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noConnection,
    required TResult Function() timeout,
    required TResult Function(String? message) unauthorized,
    required TResult Function(String message) badRequest,
    required TResult Function(int statusCode, String? message) serverError,
    required TResult Function(
      String? message,
      Object? error,
      StackTrace? stackTrace,
    ) unknown,
  }) {
    return unknown(message, error, stackTrace);
  }

  @override
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
    return unknown?.call(message, error, stackTrace);
  }

  @override
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
    if (unknown != null) {
      return unknown(message, error, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoConnection value) noConnection,
    required TResult Function(_Timeout value) timeout,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_BadRequest value) badRequest,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_Unknown value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoConnection value)? noConnection,
    TResult? Function(_Timeout value)? timeout,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_BadRequest value)? badRequest,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_Unknown value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
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
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _Unknown implements NetworkFailure {
  const factory _Unknown({
    final String? message,
    final Object? error,
    final StackTrace? stackTrace,
  }) = _$UnknownImpl;

  String? get message;
  Object? get error;
  StackTrace? get stackTrace;

  /// Create a copy of NetworkFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownImplCopyWith<_$UnknownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
