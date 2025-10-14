// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jwt_pair_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JwtPairModel {

 String? get access; String? get refresh;
/// Create a copy of JwtPairModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JwtPairModelCopyWith<JwtPairModel> get copyWith => _$JwtPairModelCopyWithImpl<JwtPairModel>(this as JwtPairModel, _$identity);

  /// Serializes this JwtPairModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JwtPairModel&&(identical(other.access, access) || other.access == access)&&(identical(other.refresh, refresh) || other.refresh == refresh));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,access,refresh);

@override
String toString() {
  return 'JwtPairModel(access: $access, refresh: $refresh)';
}


}

/// @nodoc
abstract mixin class $JwtPairModelCopyWith<$Res>  {
  factory $JwtPairModelCopyWith(JwtPairModel value, $Res Function(JwtPairModel) _then) = _$JwtPairModelCopyWithImpl;
@useResult
$Res call({
 String? access, String? refresh
});




}
/// @nodoc
class _$JwtPairModelCopyWithImpl<$Res>
    implements $JwtPairModelCopyWith<$Res> {
  _$JwtPairModelCopyWithImpl(this._self, this._then);

  final JwtPairModel _self;
  final $Res Function(JwtPairModel) _then;

/// Create a copy of JwtPairModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? access = freezed,Object? refresh = freezed,}) {
  return _then(_self.copyWith(
access: freezed == access ? _self.access : access // ignore: cast_nullable_to_non_nullable
as String?,refresh: freezed == refresh ? _self.refresh : refresh // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JwtPairModel].
extension JwtPairModelPatterns on JwtPairModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JwtPairModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JwtPairModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JwtPairModel value)  $default,){
final _that = this;
switch (_that) {
case _JwtPairModel():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JwtPairModel value)?  $default,){
final _that = this;
switch (_that) {
case _JwtPairModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? access,  String? refresh)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JwtPairModel() when $default != null:
return $default(_that.access,_that.refresh);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? access,  String? refresh)  $default,) {final _that = this;
switch (_that) {
case _JwtPairModel():
return $default(_that.access,_that.refresh);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? access,  String? refresh)?  $default,) {final _that = this;
switch (_that) {
case _JwtPairModel() when $default != null:
return $default(_that.access,_that.refresh);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JwtPairModel implements JwtPairModel {
  const _JwtPairModel({this.access, this.refresh});
  factory _JwtPairModel.fromJson(Map<String, dynamic> json) => _$JwtPairModelFromJson(json);

@override final  String? access;
@override final  String? refresh;

/// Create a copy of JwtPairModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JwtPairModelCopyWith<_JwtPairModel> get copyWith => __$JwtPairModelCopyWithImpl<_JwtPairModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JwtPairModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JwtPairModel&&(identical(other.access, access) || other.access == access)&&(identical(other.refresh, refresh) || other.refresh == refresh));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,access,refresh);

@override
String toString() {
  return 'JwtPairModel(access: $access, refresh: $refresh)';
}


}

/// @nodoc
abstract mixin class _$JwtPairModelCopyWith<$Res> implements $JwtPairModelCopyWith<$Res> {
  factory _$JwtPairModelCopyWith(_JwtPairModel value, $Res Function(_JwtPairModel) _then) = __$JwtPairModelCopyWithImpl;
@override @useResult
$Res call({
 String? access, String? refresh
});




}
/// @nodoc
class __$JwtPairModelCopyWithImpl<$Res>
    implements _$JwtPairModelCopyWith<$Res> {
  __$JwtPairModelCopyWithImpl(this._self, this._then);

  final _JwtPairModel _self;
  final $Res Function(_JwtPairModel) _then;

/// Create a copy of JwtPairModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? access = freezed,Object? refresh = freezed,}) {
  return _then(_JwtPairModel(
access: freezed == access ? _self.access : access // ignore: cast_nullable_to_non_nullable
as String?,refresh: freezed == refresh ? _self.refresh : refresh // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
