// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'controller_widget_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ControllerWidgetId _$ControllerWidgetIdFromJson(Map<String, dynamic> json) {
  return _ControllerWidgetId.fromJson(json);
}

/// @nodoc
mixin _$ControllerWidgetId {
  ControllerClass get class_ =>
      throw _privateConstructorUsedError; // toString <=> uid
  String get description => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<ControllerApiAttribute> get api => throw _privateConstructorUsedError;
  ControllerCommitFrequency get commitFrequency =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ControllerWidgetIdCopyWith<ControllerWidgetId> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ControllerWidgetIdCopyWith<$Res> {
  factory $ControllerWidgetIdCopyWith(
          ControllerWidgetId value, $Res Function(ControllerWidgetId) then) =
      _$ControllerWidgetIdCopyWithImpl<$Res, ControllerWidgetId>;
  @useResult
  $Res call(
      {ControllerClass class_,
      String description,
      String name,
      List<ControllerApiAttribute> api,
      ControllerCommitFrequency commitFrequency});
}

/// @nodoc
class _$ControllerWidgetIdCopyWithImpl<$Res, $Val extends ControllerWidgetId>
    implements $ControllerWidgetIdCopyWith<$Res> {
  _$ControllerWidgetIdCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? class_ = null,
    Object? description = null,
    Object? name = null,
    Object? api = null,
    Object? commitFrequency = null,
  }) {
    return _then(_value.copyWith(
      class_: null == class_
          ? _value.class_
          : class_ // ignore: cast_nullable_to_non_nullable
              as ControllerClass,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      api: null == api
          ? _value.api
          : api // ignore: cast_nullable_to_non_nullable
              as List<ControllerApiAttribute>,
      commitFrequency: null == commitFrequency
          ? _value.commitFrequency
          : commitFrequency // ignore: cast_nullable_to_non_nullable
              as ControllerCommitFrequency,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ControllerWidgetIdCopyWith<$Res>
    implements $ControllerWidgetIdCopyWith<$Res> {
  factory _$$_ControllerWidgetIdCopyWith(_$_ControllerWidgetId value,
          $Res Function(_$_ControllerWidgetId) then) =
      __$$_ControllerWidgetIdCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ControllerClass class_,
      String description,
      String name,
      List<ControllerApiAttribute> api,
      ControllerCommitFrequency commitFrequency});
}

/// @nodoc
class __$$_ControllerWidgetIdCopyWithImpl<$Res>
    extends _$ControllerWidgetIdCopyWithImpl<$Res, _$_ControllerWidgetId>
    implements _$$_ControllerWidgetIdCopyWith<$Res> {
  __$$_ControllerWidgetIdCopyWithImpl(
      _$_ControllerWidgetId _value, $Res Function(_$_ControllerWidgetId) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? class_ = null,
    Object? description = null,
    Object? name = null,
    Object? api = null,
    Object? commitFrequency = null,
  }) {
    return _then(_$_ControllerWidgetId(
      class_: null == class_
          ? _value.class_
          : class_ // ignore: cast_nullable_to_non_nullable
              as ControllerClass,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      api: null == api
          ? _value._api
          : api // ignore: cast_nullable_to_non_nullable
              as List<ControllerApiAttribute>,
      commitFrequency: null == commitFrequency
          ? _value.commitFrequency
          : commitFrequency // ignore: cast_nullable_to_non_nullable
              as ControllerCommitFrequency,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ControllerWidgetId implements _ControllerWidgetId {
  const _$_ControllerWidgetId(
      {required this.class_,
      required this.description,
      required this.name,
      required final List<ControllerApiAttribute> api,
      this.commitFrequency = ControllerCommitFrequency.triggered})
      : _api = api;

  factory _$_ControllerWidgetId.fromJson(Map<String, dynamic> json) =>
      _$$_ControllerWidgetIdFromJson(json);

  @override
  final ControllerClass class_;
// toString <=> uid
  @override
  final String description;
  @override
  final String name;
  final List<ControllerApiAttribute> _api;
  @override
  List<ControllerApiAttribute> get api {
    if (_api is EqualUnmodifiableListView) return _api;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_api);
  }

  @override
  @JsonKey()
  final ControllerCommitFrequency commitFrequency;

  @override
  String toString() {
    return 'ControllerWidgetId(class_: $class_, description: $description, name: $name, api: $api, commitFrequency: $commitFrequency)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ControllerWidgetId &&
            (identical(other.class_, class_) || other.class_ == class_) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._api, _api) &&
            (identical(other.commitFrequency, commitFrequency) ||
                other.commitFrequency == commitFrequency));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, class_, description, name,
      const DeepCollectionEquality().hash(_api), commitFrequency);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ControllerWidgetIdCopyWith<_$_ControllerWidgetId> get copyWith =>
      __$$_ControllerWidgetIdCopyWithImpl<_$_ControllerWidgetId>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ControllerWidgetIdToJson(
      this,
    );
  }
}

abstract class _ControllerWidgetId implements ControllerWidgetId {
  const factory _ControllerWidgetId(
      {required final ControllerClass class_,
      required final String description,
      required final String name,
      required final List<ControllerApiAttribute> api,
      final ControllerCommitFrequency commitFrequency}) = _$_ControllerWidgetId;

  factory _ControllerWidgetId.fromJson(Map<String, dynamic> json) =
      _$_ControllerWidgetId.fromJson;

  @override
  ControllerClass get class_;
  @override // toString <=> uid
  String get description;
  @override
  String get name;
  @override
  List<ControllerApiAttribute> get api;
  @override
  ControllerCommitFrequency get commitFrequency;
  @override
  @JsonKey(ignore: true)
  _$$_ControllerWidgetIdCopyWith<_$_ControllerWidgetId> get copyWith =>
      throw _privateConstructorUsedError;
}

ControllerApiAttribute _$ControllerApiAttributeFromJson(
    Map<String, dynamic> json) {
  return _ControllerApiAttribute.fromJson(json);
}

/// @nodoc
mixin _$ControllerApiAttribute {
  String? get key => throw _privateConstructorUsedError;
  String get valueType => throw _privateConstructorUsedError;
  Object? get defaultValue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ControllerApiAttributeCopyWith<ControllerApiAttribute> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ControllerApiAttributeCopyWith<$Res> {
  factory $ControllerApiAttributeCopyWith(ControllerApiAttribute value,
          $Res Function(ControllerApiAttribute) then) =
      _$ControllerApiAttributeCopyWithImpl<$Res, ControllerApiAttribute>;
  @useResult
  $Res call({String? key, String valueType, Object? defaultValue});
}

/// @nodoc
class _$ControllerApiAttributeCopyWithImpl<$Res,
        $Val extends ControllerApiAttribute>
    implements $ControllerApiAttributeCopyWith<$Res> {
  _$ControllerApiAttributeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? valueType = null,
    Object? defaultValue = freezed,
  }) {
    return _then(_value.copyWith(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      valueType: null == valueType
          ? _value.valueType
          : valueType // ignore: cast_nullable_to_non_nullable
              as String,
      defaultValue:
          freezed == defaultValue ? _value.defaultValue : defaultValue,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ControllerApiAttributeCopyWith<$Res>
    implements $ControllerApiAttributeCopyWith<$Res> {
  factory _$$_ControllerApiAttributeCopyWith(_$_ControllerApiAttribute value,
          $Res Function(_$_ControllerApiAttribute) then) =
      __$$_ControllerApiAttributeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? key, String valueType, Object? defaultValue});
}

/// @nodoc
class __$$_ControllerApiAttributeCopyWithImpl<$Res>
    extends _$ControllerApiAttributeCopyWithImpl<$Res,
        _$_ControllerApiAttribute>
    implements _$$_ControllerApiAttributeCopyWith<$Res> {
  __$$_ControllerApiAttributeCopyWithImpl(_$_ControllerApiAttribute _value,
      $Res Function(_$_ControllerApiAttribute) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? valueType = null,
    Object? defaultValue = freezed,
  }) {
    return _then(_$_ControllerApiAttribute(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      valueType: null == valueType
          ? _value.valueType
          : valueType // ignore: cast_nullable_to_non_nullable
              as String,
      defaultValue:
          freezed == defaultValue ? _value.defaultValue : defaultValue,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ControllerApiAttribute implements _ControllerApiAttribute {
  const _$_ControllerApiAttribute(
      {this.key, required this.valueType, this.defaultValue});

  factory _$_ControllerApiAttribute.fromJson(Map<String, dynamic> json) =>
      _$$_ControllerApiAttributeFromJson(json);

  @override
  final String? key;
  @override
  final String valueType;
  @override
  final Object? defaultValue;

  @override
  String toString() {
    return 'ControllerApiAttribute(key: $key, valueType: $valueType, defaultValue: $defaultValue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ControllerApiAttribute &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.valueType, valueType) ||
                other.valueType == valueType) &&
            const DeepCollectionEquality()
                .equals(other.defaultValue, defaultValue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, key, valueType,
      const DeepCollectionEquality().hash(defaultValue));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ControllerApiAttributeCopyWith<_$_ControllerApiAttribute> get copyWith =>
      __$$_ControllerApiAttributeCopyWithImpl<_$_ControllerApiAttribute>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ControllerApiAttributeToJson(
      this,
    );
  }
}

abstract class _ControllerApiAttribute implements ControllerApiAttribute {
  const factory _ControllerApiAttribute(
      {final String? key,
      required final String valueType,
      final Object? defaultValue}) = _$_ControllerApiAttribute;

  factory _ControllerApiAttribute.fromJson(Map<String, dynamic> json) =
      _$_ControllerApiAttribute.fromJson;

  @override
  String? get key;
  @override
  String get valueType;
  @override
  Object? get defaultValue;
  @override
  @JsonKey(ignore: true)
  _$$_ControllerApiAttributeCopyWith<_$_ControllerApiAttribute> get copyWith =>
      throw _privateConstructorUsedError;
}
