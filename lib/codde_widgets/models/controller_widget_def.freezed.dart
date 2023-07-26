// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'controller_widget_def.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ControllerWidgetDef _$ControllerWidgetDefFromJson(Map<String, dynamic> json) {
  return _ControllerWidgetDef.fromJson(json);
}

/// @nodoc
mixin _$ControllerWidgetDef {
  ControllerClass get class_ =>
      throw _privateConstructorUsedError; // toString <=> uid
  String get description => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<ControllerApiAttribute> get api => throw _privateConstructorUsedError;
  ControllerCommitFrequency get commitFrequency =>
      throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ControllerWidgetDefCopyWith<ControllerWidgetDef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ControllerWidgetDefCopyWith<$Res> {
  factory $ControllerWidgetDefCopyWith(
          ControllerWidgetDef value, $Res Function(ControllerWidgetDef) then) =
      _$ControllerWidgetDefCopyWithImpl<$Res, ControllerWidgetDef>;
  @useResult
  $Res call(
      {ControllerClass class_,
      String description,
      String name,
      List<ControllerApiAttribute> api,
      ControllerCommitFrequency commitFrequency,
      int size});
}

/// @nodoc
class _$ControllerWidgetDefCopyWithImpl<$Res, $Val extends ControllerWidgetDef>
    implements $ControllerWidgetDefCopyWith<$Res> {
  _$ControllerWidgetDefCopyWithImpl(this._value, this._then);

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
    Object? size = null,
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
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ControllerWidgetDefCopyWith<$Res>
    implements $ControllerWidgetDefCopyWith<$Res> {
  factory _$$_ControllerWidgetDefCopyWith(_$_ControllerWidgetDef value,
          $Res Function(_$_ControllerWidgetDef) then) =
      __$$_ControllerWidgetDefCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ControllerClass class_,
      String description,
      String name,
      List<ControllerApiAttribute> api,
      ControllerCommitFrequency commitFrequency,
      int size});
}

/// @nodoc
class __$$_ControllerWidgetDefCopyWithImpl<$Res>
    extends _$ControllerWidgetDefCopyWithImpl<$Res, _$_ControllerWidgetDef>
    implements _$$_ControllerWidgetDefCopyWith<$Res> {
  __$$_ControllerWidgetDefCopyWithImpl(_$_ControllerWidgetDef _value,
      $Res Function(_$_ControllerWidgetDef) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? class_ = null,
    Object? description = null,
    Object? name = null,
    Object? api = null,
    Object? commitFrequency = null,
    Object? size = null,
  }) {
    return _then(_$_ControllerWidgetDef(
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
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ControllerWidgetDef implements _ControllerWidgetDef {
  const _$_ControllerWidgetDef(
      {required this.class_,
      required this.description,
      required this.name,
      required final List<ControllerApiAttribute> api,
      this.commitFrequency = ControllerCommitFrequency.triggered,
      required this.size})
      : _api = api;

  factory _$_ControllerWidgetDef.fromJson(Map<String, dynamic> json) =>
      _$$_ControllerWidgetDefFromJson(json);

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
  final int size;

  @override
  String toString() {
    return 'ControllerWidgetDef(class_: $class_, description: $description, name: $name, api: $api, commitFrequency: $commitFrequency, size: $size)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ControllerWidgetDef &&
            (identical(other.class_, class_) || other.class_ == class_) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._api, _api) &&
            (identical(other.commitFrequency, commitFrequency) ||
                other.commitFrequency == commitFrequency) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, class_, description, name,
      const DeepCollectionEquality().hash(_api), commitFrequency, size);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ControllerWidgetDefCopyWith<_$_ControllerWidgetDef> get copyWith =>
      __$$_ControllerWidgetDefCopyWithImpl<_$_ControllerWidgetDef>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ControllerWidgetDefToJson(
      this,
    );
  }
}

abstract class _ControllerWidgetDef implements ControllerWidgetDef {
  const factory _ControllerWidgetDef(
      {required final ControllerClass class_,
      required final String description,
      required final String name,
      required final List<ControllerApiAttribute> api,
      final ControllerCommitFrequency commitFrequency,
      required final int size}) = _$_ControllerWidgetDef;

  factory _ControllerWidgetDef.fromJson(Map<String, dynamic> json) =
      _$_ControllerWidgetDef.fromJson;

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
  int get size;
  @override
  @JsonKey(ignore: true)
  _$$_ControllerWidgetDefCopyWith<_$_ControllerWidgetDef> get copyWith =>
      throw _privateConstructorUsedError;
}
