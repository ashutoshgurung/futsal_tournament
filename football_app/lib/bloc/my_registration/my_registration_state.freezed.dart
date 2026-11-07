// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_registration_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegistrationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegistrationState()';
}


}

/// @nodoc
class $RegistrationStateCopyWith<$Res>  {
$RegistrationStateCopyWith(RegistrationState _, $Res Function(RegistrationState) __);
}


/// Adds pattern-matching-related methods to [RegistrationState].
extension RegistrationStatePatterns on RegistrationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RegistrationInitial value)?  initial,TResult Function( RegistrationLoading value)?  loading,TResult Function( RegistrationLoaded value)?  loaded,TResult Function( RegistrationError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RegistrationInitial() when initial != null:
return initial(_that);case RegistrationLoading() when loading != null:
return loading(_that);case RegistrationLoaded() when loaded != null:
return loaded(_that);case RegistrationError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RegistrationInitial value)  initial,required TResult Function( RegistrationLoading value)  loading,required TResult Function( RegistrationLoaded value)  loaded,required TResult Function( RegistrationError value)  error,}){
final _that = this;
switch (_that) {
case RegistrationInitial():
return initial(_that);case RegistrationLoading():
return loading(_that);case RegistrationLoaded():
return loaded(_that);case RegistrationError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RegistrationInitial value)?  initial,TResult? Function( RegistrationLoading value)?  loading,TResult? Function( RegistrationLoaded value)?  loaded,TResult? Function( RegistrationError value)?  error,}){
final _that = this;
switch (_that) {
case RegistrationInitial() when initial != null:
return initial(_that);case RegistrationLoading() when loading != null:
return loading(_that);case RegistrationLoaded() when loaded != null:
return loaded(_that);case RegistrationError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<MyRegistrationModel> registrations)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RegistrationInitial() when initial != null:
return initial();case RegistrationLoading() when loading != null:
return loading();case RegistrationLoaded() when loaded != null:
return loaded(_that.registrations);case RegistrationError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<MyRegistrationModel> registrations)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case RegistrationInitial():
return initial();case RegistrationLoading():
return loading();case RegistrationLoaded():
return loaded(_that.registrations);case RegistrationError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<MyRegistrationModel> registrations)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case RegistrationInitial() when initial != null:
return initial();case RegistrationLoading() when loading != null:
return loading();case RegistrationLoaded() when loaded != null:
return loaded(_that.registrations);case RegistrationError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class RegistrationInitial implements RegistrationState {
  const RegistrationInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegistrationState.initial()';
}


}




/// @nodoc


class RegistrationLoading implements RegistrationState {
  const RegistrationLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegistrationState.loading()';
}


}




/// @nodoc


class RegistrationLoaded implements RegistrationState {
  const RegistrationLoaded(final  List<MyRegistrationModel> registrations): _registrations = registrations;
  

 final  List<MyRegistrationModel> _registrations;
 List<MyRegistrationModel> get registrations {
  if (_registrations is EqualUnmodifiableListView) return _registrations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_registrations);
}


/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrationLoadedCopyWith<RegistrationLoaded> get copyWith => _$RegistrationLoadedCopyWithImpl<RegistrationLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationLoaded&&const DeepCollectionEquality().equals(other._registrations, _registrations));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_registrations));

@override
String toString() {
  return 'RegistrationState.loaded(registrations: $registrations)';
}


}

/// @nodoc
abstract mixin class $RegistrationLoadedCopyWith<$Res> implements $RegistrationStateCopyWith<$Res> {
  factory $RegistrationLoadedCopyWith(RegistrationLoaded value, $Res Function(RegistrationLoaded) _then) = _$RegistrationLoadedCopyWithImpl;
@useResult
$Res call({
 List<MyRegistrationModel> registrations
});




}
/// @nodoc
class _$RegistrationLoadedCopyWithImpl<$Res>
    implements $RegistrationLoadedCopyWith<$Res> {
  _$RegistrationLoadedCopyWithImpl(this._self, this._then);

  final RegistrationLoaded _self;
  final $Res Function(RegistrationLoaded) _then;

/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? registrations = null,}) {
  return _then(RegistrationLoaded(
null == registrations ? _self._registrations : registrations // ignore: cast_nullable_to_non_nullable
as List<MyRegistrationModel>,
  ));
}


}

/// @nodoc


class RegistrationError implements RegistrationState {
  const RegistrationError(this.message);
  

 final  String message;

/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrationErrorCopyWith<RegistrationError> get copyWith => _$RegistrationErrorCopyWithImpl<RegistrationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RegistrationState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $RegistrationErrorCopyWith<$Res> implements $RegistrationStateCopyWith<$Res> {
  factory $RegistrationErrorCopyWith(RegistrationError value, $Res Function(RegistrationError) _then) = _$RegistrationErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$RegistrationErrorCopyWithImpl<$Res>
    implements $RegistrationErrorCopyWith<$Res> {
  _$RegistrationErrorCopyWithImpl(this._self, this._then);

  final RegistrationError _self;
  final $Res Function(RegistrationError) _then;

/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(RegistrationError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
