// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_tournaments_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AllTournamentsState {

 AllTournamentsStatus get status; List<TournamentModel> get tournaments; String? get errorMessage;
/// Create a copy of AllTournamentsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AllTournamentsStateCopyWith<AllTournamentsState> get copyWith => _$AllTournamentsStateCopyWithImpl<AllTournamentsState>(this as AllTournamentsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllTournamentsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.tournaments, tournaments)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(tournaments),errorMessage);

@override
String toString() {
  return 'AllTournamentsState(status: $status, tournaments: $tournaments, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AllTournamentsStateCopyWith<$Res>  {
  factory $AllTournamentsStateCopyWith(AllTournamentsState value, $Res Function(AllTournamentsState) _then) = _$AllTournamentsStateCopyWithImpl;
@useResult
$Res call({
 AllTournamentsStatus status, List<TournamentModel> tournaments, String? errorMessage
});




}
/// @nodoc
class _$AllTournamentsStateCopyWithImpl<$Res>
    implements $AllTournamentsStateCopyWith<$Res> {
  _$AllTournamentsStateCopyWithImpl(this._self, this._then);

  final AllTournamentsState _self;
  final $Res Function(AllTournamentsState) _then;

/// Create a copy of AllTournamentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? tournaments = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AllTournamentsStatus,tournaments: null == tournaments ? _self.tournaments : tournaments // ignore: cast_nullable_to_non_nullable
as List<TournamentModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AllTournamentsState].
extension AllTournamentsStatePatterns on AllTournamentsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AllTournamentsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AllTournamentsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AllTournamentsState value)  $default,){
final _that = this;
switch (_that) {
case _AllTournamentsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AllTournamentsState value)?  $default,){
final _that = this;
switch (_that) {
case _AllTournamentsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AllTournamentsStatus status,  List<TournamentModel> tournaments,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AllTournamentsState() when $default != null:
return $default(_that.status,_that.tournaments,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AllTournamentsStatus status,  List<TournamentModel> tournaments,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AllTournamentsState():
return $default(_that.status,_that.tournaments,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AllTournamentsStatus status,  List<TournamentModel> tournaments,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AllTournamentsState() when $default != null:
return $default(_that.status,_that.tournaments,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AllTournamentsState implements AllTournamentsState {
  const _AllTournamentsState({this.status = AllTournamentsStatus.initial, final  List<TournamentModel> tournaments = const <TournamentModel>[], this.errorMessage}): _tournaments = tournaments;
  

@override@JsonKey() final  AllTournamentsStatus status;
 final  List<TournamentModel> _tournaments;
@override@JsonKey() List<TournamentModel> get tournaments {
  if (_tournaments is EqualUnmodifiableListView) return _tournaments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tournaments);
}

@override final  String? errorMessage;

/// Create a copy of AllTournamentsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AllTournamentsStateCopyWith<_AllTournamentsState> get copyWith => __$AllTournamentsStateCopyWithImpl<_AllTournamentsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AllTournamentsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._tournaments, _tournaments)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_tournaments),errorMessage);

@override
String toString() {
  return 'AllTournamentsState(status: $status, tournaments: $tournaments, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AllTournamentsStateCopyWith<$Res> implements $AllTournamentsStateCopyWith<$Res> {
  factory _$AllTournamentsStateCopyWith(_AllTournamentsState value, $Res Function(_AllTournamentsState) _then) = __$AllTournamentsStateCopyWithImpl;
@override @useResult
$Res call({
 AllTournamentsStatus status, List<TournamentModel> tournaments, String? errorMessage
});




}
/// @nodoc
class __$AllTournamentsStateCopyWithImpl<$Res>
    implements _$AllTournamentsStateCopyWith<$Res> {
  __$AllTournamentsStateCopyWithImpl(this._self, this._then);

  final _AllTournamentsState _self;
  final $Res Function(_AllTournamentsState) _then;

/// Create a copy of AllTournamentsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? tournaments = null,Object? errorMessage = freezed,}) {
  return _then(_AllTournamentsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AllTournamentsStatus,tournaments: null == tournaments ? _self._tournaments : tournaments // ignore: cast_nullable_to_non_nullable
as List<TournamentModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
