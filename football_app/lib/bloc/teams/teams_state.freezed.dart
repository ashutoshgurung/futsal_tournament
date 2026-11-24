// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teams_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeamsState {

 TeamsStatus get status; List<Team> get teams; String get query; String? get errorMessage;
/// Create a copy of TeamsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamsStateCopyWith<TeamsState> get copyWith => _$TeamsStateCopyWithImpl<TeamsState>(this as TeamsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.teams, teams)&&(identical(other.query, query) || other.query == query)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(teams),query,errorMessage);

@override
String toString() {
  return 'TeamsState(status: $status, teams: $teams, query: $query, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TeamsStateCopyWith<$Res>  {
  factory $TeamsStateCopyWith(TeamsState value, $Res Function(TeamsState) _then) = _$TeamsStateCopyWithImpl;
@useResult
$Res call({
 TeamsStatus status, List<Team> teams, String query, String? errorMessage
});




}
/// @nodoc
class _$TeamsStateCopyWithImpl<$Res>
    implements $TeamsStateCopyWith<$Res> {
  _$TeamsStateCopyWithImpl(this._self, this._then);

  final TeamsState _self;
  final $Res Function(TeamsState) _then;

/// Create a copy of TeamsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? teams = null,Object? query = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TeamsStatus,teams: null == teams ? _self.teams : teams // ignore: cast_nullable_to_non_nullable
as List<Team>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TeamsState].
extension TeamsStatePatterns on TeamsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamsState value)  $default,){
final _that = this;
switch (_that) {
case _TeamsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamsState value)?  $default,){
final _that = this;
switch (_that) {
case _TeamsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TeamsStatus status,  List<Team> teams,  String query,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamsState() when $default != null:
return $default(_that.status,_that.teams,_that.query,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TeamsStatus status,  List<Team> teams,  String query,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TeamsState():
return $default(_that.status,_that.teams,_that.query,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TeamsStatus status,  List<Team> teams,  String query,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TeamsState() when $default != null:
return $default(_that.status,_that.teams,_that.query,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TeamsState extends TeamsState {
  const _TeamsState({this.status = TeamsStatus.initial, final  List<Team> teams = const [], this.query = '', this.errorMessage}): _teams = teams,super._();
  

@override@JsonKey() final  TeamsStatus status;
 final  List<Team> _teams;
@override@JsonKey() List<Team> get teams {
  if (_teams is EqualUnmodifiableListView) return _teams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_teams);
}

@override@JsonKey() final  String query;
@override final  String? errorMessage;

/// Create a copy of TeamsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamsStateCopyWith<_TeamsState> get copyWith => __$TeamsStateCopyWithImpl<_TeamsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._teams, _teams)&&(identical(other.query, query) || other.query == query)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_teams),query,errorMessage);

@override
String toString() {
  return 'TeamsState(status: $status, teams: $teams, query: $query, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TeamsStateCopyWith<$Res> implements $TeamsStateCopyWith<$Res> {
  factory _$TeamsStateCopyWith(_TeamsState value, $Res Function(_TeamsState) _then) = __$TeamsStateCopyWithImpl;
@override @useResult
$Res call({
 TeamsStatus status, List<Team> teams, String query, String? errorMessage
});




}
/// @nodoc
class __$TeamsStateCopyWithImpl<$Res>
    implements _$TeamsStateCopyWith<$Res> {
  __$TeamsStateCopyWithImpl(this._self, this._then);

  final _TeamsState _self;
  final $Res Function(_TeamsState) _then;

/// Create a copy of TeamsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? teams = null,Object? query = null,Object? errorMessage = freezed,}) {
  return _then(_TeamsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TeamsStatus,teams: null == teams ? _self._teams : teams // ignore: cast_nullable_to_non_nullable
as List<Team>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
