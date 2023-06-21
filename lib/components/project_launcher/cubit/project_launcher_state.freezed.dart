// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_launcher_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProjectLauncherState {
  int get currentPage => throw _privateConstructorUsedError;
  Project get data => throw _privateConstructorUsedError;
  Project? get projectInstance => throw _privateConstructorUsedError;
  ProjectType get projectType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectLauncherStateCopyWith<ProjectLauncherState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectLauncherStateCopyWith<$Res> {
  factory $ProjectLauncherStateCopyWith(ProjectLauncherState value,
          $Res Function(ProjectLauncherState) then) =
      _$ProjectLauncherStateCopyWithImpl<$Res, ProjectLauncherState>;
  @useResult
  $Res call(
      {int currentPage,
      Project data,
      Project? projectInstance,
      ProjectType projectType});
}

/// @nodoc
class _$ProjectLauncherStateCopyWithImpl<$Res,
        $Val extends ProjectLauncherState>
    implements $ProjectLauncherStateCopyWith<$Res> {
  _$ProjectLauncherStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? data = null,
    Object? projectInstance = freezed,
    Object? projectType = null,
  }) {
    return _then(_value.copyWith(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Project,
      projectInstance: freezed == projectInstance
          ? _value.projectInstance
          : projectInstance // ignore: cast_nullable_to_non_nullable
              as Project?,
      projectType: null == projectType
          ? _value.projectType
          : projectType // ignore: cast_nullable_to_non_nullable
              as ProjectType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProjectLauncherStateCopyWith<$Res>
    implements $ProjectLauncherStateCopyWith<$Res> {
  factory _$$_ProjectLauncherStateCopyWith(_$_ProjectLauncherState value,
          $Res Function(_$_ProjectLauncherState) then) =
      __$$_ProjectLauncherStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentPage,
      Project data,
      Project? projectInstance,
      ProjectType projectType});
}

/// @nodoc
class __$$_ProjectLauncherStateCopyWithImpl<$Res>
    extends _$ProjectLauncherStateCopyWithImpl<$Res, _$_ProjectLauncherState>
    implements _$$_ProjectLauncherStateCopyWith<$Res> {
  __$$_ProjectLauncherStateCopyWithImpl(_$_ProjectLauncherState _value,
      $Res Function(_$_ProjectLauncherState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? data = null,
    Object? projectInstance = freezed,
    Object? projectType = null,
  }) {
    return _then(_$_ProjectLauncherState(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Project,
      projectInstance: freezed == projectInstance
          ? _value.projectInstance
          : projectInstance // ignore: cast_nullable_to_non_nullable
              as Project?,
      projectType: null == projectType
          ? _value.projectType
          : projectType // ignore: cast_nullable_to_non_nullable
              as ProjectType,
    ));
  }
}

/// @nodoc

class _$_ProjectLauncherState implements _ProjectLauncherState {
  const _$_ProjectLauncherState(
      {this.currentPage = 0,
      required this.data,
      this.projectInstance,
      this.projectType = ProjectType.codde_pi});

  @override
  @JsonKey()
  final int currentPage;
  @override
  final Project data;
  @override
  final Project? projectInstance;
  @override
  @JsonKey()
  final ProjectType projectType;

  @override
  String toString() {
    return 'ProjectLauncherState(currentPage: $currentPage, data: $data, projectInstance: $projectInstance, projectType: $projectType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectLauncherState &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.projectInstance, projectInstance) ||
                other.projectInstance == projectInstance) &&
            (identical(other.projectType, projectType) ||
                other.projectType == projectType));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, currentPage, data, projectInstance, projectType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProjectLauncherStateCopyWith<_$_ProjectLauncherState> get copyWith =>
      __$$_ProjectLauncherStateCopyWithImpl<_$_ProjectLauncherState>(
          this, _$identity);
}

abstract class _ProjectLauncherState implements ProjectLauncherState {
  const factory _ProjectLauncherState(
      {final int currentPage,
      required final Project data,
      final Project? projectInstance,
      final ProjectType projectType}) = _$_ProjectLauncherState;

  @override
  int get currentPage;
  @override
  Project get data;
  @override
  Project? get projectInstance;
  @override
  ProjectType get projectType;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectLauncherStateCopyWith<_$_ProjectLauncherState> get copyWith =>
      throw _privateConstructorUsedError;
}
