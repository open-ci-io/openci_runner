// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'android_runner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AndroidRunner _$AndroidRunnerFromJson(Map<String, dynamic> json) {
  return _IosRunner.fromJson(json);
}

/// @nodoc
mixin _$AndroidRunner {
  String get key => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AndroidRunnerCopyWith<AndroidRunner> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AndroidRunnerCopyWith<$Res> {
  factory $AndroidRunnerCopyWith(
          AndroidRunner value, $Res Function(AndroidRunner) then) =
      _$AndroidRunnerCopyWithImpl<$Res, AndroidRunner>;
  @useResult
  $Res call({String key, String error});
}

/// @nodoc
class _$AndroidRunnerCopyWithImpl<$Res, $Val extends AndroidRunner>
    implements $AndroidRunnerCopyWith<$Res> {
  _$AndroidRunnerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IosRunnerImplCopyWith<$Res>
    implements $AndroidRunnerCopyWith<$Res> {
  factory _$$IosRunnerImplCopyWith(
          _$IosRunnerImpl value, $Res Function(_$IosRunnerImpl) then) =
      __$$IosRunnerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String key, String error});
}

/// @nodoc
class __$$IosRunnerImplCopyWithImpl<$Res>
    extends _$AndroidRunnerCopyWithImpl<$Res, _$IosRunnerImpl>
    implements _$$IosRunnerImplCopyWith<$Res> {
  __$$IosRunnerImplCopyWithImpl(
      _$IosRunnerImpl _value, $Res Function(_$IosRunnerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? error = null,
  }) {
    return _then(_$IosRunnerImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IosRunnerImpl implements _IosRunner {
  const _$IosRunnerImpl({required this.key, required this.error});

  factory _$IosRunnerImpl.fromJson(Map<String, dynamic> json) =>
      _$$IosRunnerImplFromJson(json);

  @override
  final String key;
  @override
  final String error;

  @override
  String toString() {
    return 'AndroidRunner(key: $key, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IosRunnerImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, key, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IosRunnerImplCopyWith<_$IosRunnerImpl> get copyWith =>
      __$$IosRunnerImplCopyWithImpl<_$IosRunnerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IosRunnerImplToJson(
      this,
    );
  }
}

abstract class _IosRunner implements AndroidRunner {
  const factory _IosRunner(
      {required final String key,
      required final String error}) = _$IosRunnerImpl;

  factory _IosRunner.fromJson(Map<String, dynamic> json) =
      _$IosRunnerImpl.fromJson;

  @override
  String get key;
  @override
  String get error;
  @override
  @JsonKey(ignore: true)
  _$$IosRunnerImplCopyWith<_$IosRunnerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
