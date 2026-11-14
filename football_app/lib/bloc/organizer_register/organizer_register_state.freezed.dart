// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organizer_register_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrganizerRegisterState {

 RegisterStatus get status; bool get hidePassword; bool get agreed; String? get errorMessage;
/// Create a copy of OrganizerRegisterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganizerRegisterStateCopyWith<OrganizerRegisterState> get copyWith => _$OrganizerRegisterStateCopyWithImpl<OrganizerRegisterState>(this as OrganizerRegisterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizerRegisterState&&(identical(other.status, status) || other.status == status)&&(identical(other.hidePassword, hidePassword) || other.hidePassword == hidePassword)&&(identical(other.agreed, agreed) || other.agreed == agreed)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,hidePassword,agreed,errorMessage);

@override
String toString() {
  return 'OrganizerRegisterState(status: $status, hidePassword: $hidePassword, agreed: $agreed, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $OrganizerRegisterStateCopyWith<$Res>  {
  factory $OrganizerRegisterStateCopyWith(OrganizerRegisterState value, $Res Function(OrganizerRegisterState) _then) = _$OrganizerRegisterStateCopyWithImpl;
@useResult
$Res call({
 RegisterStatus status, bool hidePassword, bool agreed, String? errorMessage
});




}
/// @nodoc
class _$OrganizerRegisterStateCopyWithImpl<$Res>
    implements $OrganizerRegisterStateCopyWith<$Res> {
  _$OrganizerRegisterStateCopyWithImpl(this._self, this._then);

  final OrganizerRegisterState _self;
  final $Res Function(OrganizerRegisterState) _then;

/// Create a copy of OrganizerRegisterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? hidePassword = null,Object? agreed = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RegisterStatus,hidePassword: null == hidePassword ? _self.hidePassword : hidePassword // ignore: cast_nullable_to_non_nullable
as bool,agreed: null == agreed ? _self.agreed : agreed // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrganizerRegisterState].
extension OrganizerRegisterStatePatterns on OrganizerRegisterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrganizerRegisterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrganizerRegisterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrganizerRegisterState value)  $default,){
final _that = this;
switch (_that) {
case _OrganizerRegisterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrganizerRegisterState value)?  $default,){
final _that = this;
switch (_that) {
case _OrganizerRegisterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RegisterStatus status,  bool hidePassword,  bool agreed,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrganizerRegisterState() when $default != null:
return $default(_that.status,_that.hidePassword,_that.agreed,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RegisterStatus status,  bool hidePassword,  bool agreed,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _OrganizerRegisterState():
return $default(_that.status,_that.hidePassword,_that.agreed,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RegisterStatus status,  bool hidePassword,  bool agreed,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _OrganizerRegisterState() when $default != null:
return $default(_that.status,_that.hidePassword,_that.agreed,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _OrganizerRegisterState implements OrganizerRegisterState {
  const _OrganizerRegisterState({this.status = RegisterStatus.initial, this.hidePassword = true, this.agreed = false, this.errorMessage});
  

@override@JsonKey() final  RegisterStatus status;
@override@JsonKey() final  bool hidePassword;
@override@JsonKey() final  bool agreed;
@override final  String? errorMessage;

/// Create a copy of OrganizerRegisterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrganizerRegisterStateCopyWith<_OrganizerRegisterState> get copyWith => __$OrganizerRegisterStateCopyWithImpl<_OrganizerRegisterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrganizerRegisterState&&(identical(other.status, status) || other.status == status)&&(identical(other.hidePassword, hidePassword) || other.hidePassword == hidePassword)&&(identical(other.agreed, agreed) || other.agreed == agreed)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,hidePassword,agreed,errorMessage);

@override
String toString() {
  return 'OrganizerRegisterState(status: $status, hidePassword: $hidePassword, agreed: $agreed, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$OrganizerRegisterStateCopyWith<$Res> implements $OrganizerRegisterStateCopyWith<$Res> {
  factory _$OrganizerRegisterStateCopyWith(_OrganizerRegisterState value, $Res Function(_OrganizerRegisterState) _then) = __$OrganizerRegisterStateCopyWithImpl;
@override @useResult
$Res call({
 RegisterStatus status, bool hidePassword, bool agreed, String? errorMessage
});




}
/// @nodoc
class __$OrganizerRegisterStateCopyWithImpl<$Res>
    implements _$OrganizerRegisterStateCopyWith<$Res> {
  __$OrganizerRegisterStateCopyWithImpl(this._self, this._then);

  final _OrganizerRegisterState _self;
  final $Res Function(_OrganizerRegisterState) _then;

/// Create a copy of OrganizerRegisterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? hidePassword = null,Object? agreed = null,Object? errorMessage = freezed,}) {
  return _then(_OrganizerRegisterState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RegisterStatus,hidePassword: null == hidePassword ? _self.hidePassword : hidePassword // ignore: cast_nullable_to_non_nullable
as bool,agreed: null == agreed ? _self.agreed : agreed // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
