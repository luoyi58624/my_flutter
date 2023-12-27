// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ThemeModel {
  Color? get primaryColor => throw _privateConstructorUsedError;
  Color? get successColor => throw _privateConstructorUsedError;
  Color? get warningColor => throw _privateConstructorUsedError;
  Color? get errorColor => throw _privateConstructorUsedError;
  Color? get infoColor => throw _privateConstructorUsedError;
  double? get appbarHeight => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThemeModelCopyWith<ThemeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeModelCopyWith<$Res> {
  factory $ThemeModelCopyWith(
          ThemeModel value, $Res Function(ThemeModel) then) =
      _$ThemeModelCopyWithImpl<$Res, ThemeModel>;
  @useResult
  $Res call(
      {Color? primaryColor,
      Color? successColor,
      Color? warningColor,
      Color? errorColor,
      Color? infoColor,
      double? appbarHeight});
}

/// @nodoc
class _$ThemeModelCopyWithImpl<$Res, $Val extends ThemeModel>
    implements $ThemeModelCopyWith<$Res> {
  _$ThemeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primaryColor = freezed,
    Object? successColor = freezed,
    Object? warningColor = freezed,
    Object? errorColor = freezed,
    Object? infoColor = freezed,
    Object? appbarHeight = freezed,
  }) {
    return _then(_value.copyWith(
      primaryColor: freezed == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      successColor: freezed == successColor
          ? _value.successColor
          : successColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      warningColor: freezed == warningColor
          ? _value.warningColor
          : warningColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      errorColor: freezed == errorColor
          ? _value.errorColor
          : errorColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      infoColor: freezed == infoColor
          ? _value.infoColor
          : infoColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      appbarHeight: freezed == appbarHeight
          ? _value.appbarHeight
          : appbarHeight // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ThemeModelImplCopyWith<$Res>
    implements $ThemeModelCopyWith<$Res> {
  factory _$$ThemeModelImplCopyWith(
          _$ThemeModelImpl value, $Res Function(_$ThemeModelImpl) then) =
      __$$ThemeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Color? primaryColor,
      Color? successColor,
      Color? warningColor,
      Color? errorColor,
      Color? infoColor,
      double? appbarHeight});
}

/// @nodoc
class __$$ThemeModelImplCopyWithImpl<$Res>
    extends _$ThemeModelCopyWithImpl<$Res, _$ThemeModelImpl>
    implements _$$ThemeModelImplCopyWith<$Res> {
  __$$ThemeModelImplCopyWithImpl(
      _$ThemeModelImpl _value, $Res Function(_$ThemeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primaryColor = freezed,
    Object? successColor = freezed,
    Object? warningColor = freezed,
    Object? errorColor = freezed,
    Object? infoColor = freezed,
    Object? appbarHeight = freezed,
  }) {
    return _then(_$ThemeModelImpl(
      primaryColor: freezed == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      successColor: freezed == successColor
          ? _value.successColor
          : successColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      warningColor: freezed == warningColor
          ? _value.warningColor
          : warningColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      errorColor: freezed == errorColor
          ? _value.errorColor
          : errorColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      infoColor: freezed == infoColor
          ? _value.infoColor
          : infoColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      appbarHeight: freezed == appbarHeight
          ? _value.appbarHeight
          : appbarHeight // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$ThemeModelImpl implements _ThemeModel {
  const _$ThemeModelImpl(
      {this.primaryColor,
      this.successColor,
      this.warningColor,
      this.errorColor,
      this.infoColor,
      this.appbarHeight});

  @override
  final Color? primaryColor;
  @override
  final Color? successColor;
  @override
  final Color? warningColor;
  @override
  final Color? errorColor;
  @override
  final Color? infoColor;
  @override
  final double? appbarHeight;

  @override
  String toString() {
    return 'ThemeModel(primaryColor: $primaryColor, successColor: $successColor, warningColor: $warningColor, errorColor: $errorColor, infoColor: $infoColor, appbarHeight: $appbarHeight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemeModelImpl &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.successColor, successColor) ||
                other.successColor == successColor) &&
            (identical(other.warningColor, warningColor) ||
                other.warningColor == warningColor) &&
            (identical(other.errorColor, errorColor) ||
                other.errorColor == errorColor) &&
            (identical(other.infoColor, infoColor) ||
                other.infoColor == infoColor) &&
            (identical(other.appbarHeight, appbarHeight) ||
                other.appbarHeight == appbarHeight));
  }

  @override
  int get hashCode => Object.hash(runtimeType, primaryColor, successColor,
      warningColor, errorColor, infoColor, appbarHeight);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemeModelImplCopyWith<_$ThemeModelImpl> get copyWith =>
      __$$ThemeModelImplCopyWithImpl<_$ThemeModelImpl>(this, _$identity);
}

abstract class _ThemeModel implements ThemeModel {
  const factory _ThemeModel(
      {final Color? primaryColor,
      final Color? successColor,
      final Color? warningColor,
      final Color? errorColor,
      final Color? infoColor,
      final double? appbarHeight}) = _$ThemeModelImpl;

  @override
  Color? get primaryColor;
  @override
  Color? get successColor;
  @override
  Color? get warningColor;
  @override
  Color? get errorColor;
  @override
  Color? get infoColor;
  @override
  double? get appbarHeight;
  @override
  @JsonKey(ignore: true)
  _$$ThemeModelImplCopyWith<_$ThemeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
