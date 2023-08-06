// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'controller_map.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ControllerMap _$ControllerMapFromJson(Map<String, dynamic> json) {
  return _ControllerMap.fromJson(json);
}

/// @nodoc
mixin _$ControllerMap {
  String get path => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;
  int? get width => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;
  int? get nextLayerId => throw _privateConstructorUsedError;
  int? get nextObjectId => throw _privateConstructorUsedError;
  ControllerProperties? get properties => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ControllerMapCopyWith<ControllerMap> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ControllerMapCopyWith<$Res> {
  factory $ControllerMapCopyWith(
          ControllerMap value, $Res Function(ControllerMap) then) =
      _$ControllerMapCopyWithImpl<$Res, ControllerMap>;
  @useResult
  $Res call(
      {String path,
      String? uid,
      int? width,
      int? height,
      int? nextLayerId,
      int? nextObjectId,
      ControllerProperties? properties});
}

/// @nodoc
class _$ControllerMapCopyWithImpl<$Res, $Val extends ControllerMap>
    implements $ControllerMapCopyWith<$Res> {
  _$ControllerMapCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? uid = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? nextLayerId = freezed,
    Object? nextObjectId = freezed,
    Object? properties = freezed,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      nextLayerId: freezed == nextLayerId
          ? _value.nextLayerId
          : nextLayerId // ignore: cast_nullable_to_non_nullable
              as int?,
      nextObjectId: freezed == nextObjectId
          ? _value.nextObjectId
          : nextObjectId // ignore: cast_nullable_to_non_nullable
              as int?,
      properties: freezed == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as ControllerProperties?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ControllerMapCopyWith<$Res>
    implements $ControllerMapCopyWith<$Res> {
  factory _$$_ControllerMapCopyWith(
          _$_ControllerMap value, $Res Function(_$_ControllerMap) then) =
      __$$_ControllerMapCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String path,
      String? uid,
      int? width,
      int? height,
      int? nextLayerId,
      int? nextObjectId,
      ControllerProperties? properties});
}

/// @nodoc
class __$$_ControllerMapCopyWithImpl<$Res>
    extends _$ControllerMapCopyWithImpl<$Res, _$_ControllerMap>
    implements _$$_ControllerMapCopyWith<$Res> {
  __$$_ControllerMapCopyWithImpl(
      _$_ControllerMap _value, $Res Function(_$_ControllerMap) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? uid = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? nextLayerId = freezed,
    Object? nextObjectId = freezed,
    Object? properties = freezed,
  }) {
    return _then(_$_ControllerMap(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      nextLayerId: freezed == nextLayerId
          ? _value.nextLayerId
          : nextLayerId // ignore: cast_nullable_to_non_nullable
              as int?,
      nextObjectId: freezed == nextObjectId
          ? _value.nextObjectId
          : nextObjectId // ignore: cast_nullable_to_non_nullable
              as int?,
      properties: freezed == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as ControllerProperties?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ControllerMap extends _ControllerMap {
  const _$_ControllerMap(
      {required this.path,
      this.uid,
      this.width,
      this.height,
      this.nextLayerId,
      this.nextObjectId,
      this.properties})
      : super._();

  factory _$_ControllerMap.fromJson(Map<String, dynamic> json) =>
      _$$_ControllerMapFromJson(json);

  @override
  final String path;
  @override
  final String? uid;
  @override
  final int? width;
  @override
  final int? height;
  @override
  final int? nextLayerId;
  @override
  final int? nextObjectId;
  @override
  final ControllerProperties? properties;

  @override
  String toString() {
    return 'ControllerMap._genUid(path: $path, uid: $uid, width: $width, height: $height, nextLayerId: $nextLayerId, nextObjectId: $nextObjectId, properties: $properties)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ControllerMap &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.nextLayerId, nextLayerId) ||
                other.nextLayerId == nextLayerId) &&
            (identical(other.nextObjectId, nextObjectId) ||
                other.nextObjectId == nextObjectId) &&
            (identical(other.properties, properties) ||
                other.properties == properties));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, path, uid, width, height,
      nextLayerId, nextObjectId, properties);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ControllerMapCopyWith<_$_ControllerMap> get copyWith =>
      __$$_ControllerMapCopyWithImpl<_$_ControllerMap>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ControllerMapToJson(
      this,
    );
  }
}

abstract class _ControllerMap extends ControllerMap {
  const factory _ControllerMap(
      {required final String path,
      final String? uid,
      final int? width,
      final int? height,
      final int? nextLayerId,
      final int? nextObjectId,
      final ControllerProperties? properties}) = _$_ControllerMap;
  const _ControllerMap._() : super._();

  factory _ControllerMap.fromJson(Map<String, dynamic> json) =
      _$_ControllerMap.fromJson;

  @override
  String get path;
  @override
  String? get uid;
  @override
  int? get width;
  @override
  int? get height;
  @override
  int? get nextLayerId;
  @override
  int? get nextObjectId;
  @override
  ControllerProperties? get properties;
  @override
  @JsonKey(ignore: true)
  _$$_ControllerMapCopyWith<_$_ControllerMap> get copyWith =>
      throw _privateConstructorUsedError;
}
