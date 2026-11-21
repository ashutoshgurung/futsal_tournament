// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organizer_tournament_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrganizerTournament {

 String get id; String get name; String get location; DateTime get startDate; DateTime get endDate; int get teams;
/// Create a copy of OrganizerTournament
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganizerTournamentCopyWith<OrganizerTournament> get copyWith => _$OrganizerTournamentCopyWithImpl<OrganizerTournament>(this as OrganizerTournament, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizerTournament&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.teams, teams) || other.teams == teams));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,location,startDate,endDate,teams);

@override
String toString() {
  return 'OrganizerTournament(id: $id, name: $name, location: $location, startDate: $startDate, endDate: $endDate, teams: $teams)';
}


}

/// @nodoc
abstract mixin class $OrganizerTournamentCopyWith<$Res>  {
  factory $OrganizerTournamentCopyWith(OrganizerTournament value, $Res Function(OrganizerTournament) _then) = _$OrganizerTournamentCopyWithImpl;
@useResult
$Res call({
 String id, String name, String location, DateTime startDate, DateTime endDate, int teams
});




}
/// @nodoc
class _$OrganizerTournamentCopyWithImpl<$Res>
    implements $OrganizerTournamentCopyWith<$Res> {
  _$OrganizerTournamentCopyWithImpl(this._self, this._then);

  final OrganizerTournament _self;
  final $Res Function(OrganizerTournament) _then;

/// Create a copy of OrganizerTournament
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? location = null,Object? startDate = null,Object? endDate = null,Object? teams = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,teams: null == teams ? _self.teams : teams // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OrganizerTournament].
extension OrganizerTournamentPatterns on OrganizerTournament {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrganizerTournament value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrganizerTournament() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrganizerTournament value)  $default,){
final _that = this;
switch (_that) {
case _OrganizerTournament():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrganizerTournament value)?  $default,){
final _that = this;
switch (_that) {
case _OrganizerTournament() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String location,  DateTime startDate,  DateTime endDate,  int teams)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrganizerTournament() when $default != null:
return $default(_that.id,_that.name,_that.location,_that.startDate,_that.endDate,_that.teams);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String location,  DateTime startDate,  DateTime endDate,  int teams)  $default,) {final _that = this;
switch (_that) {
case _OrganizerTournament():
return $default(_that.id,_that.name,_that.location,_that.startDate,_that.endDate,_that.teams);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String location,  DateTime startDate,  DateTime endDate,  int teams)?  $default,) {final _that = this;
switch (_that) {
case _OrganizerTournament() when $default != null:
return $default(_that.id,_that.name,_that.location,_that.startDate,_that.endDate,_that.teams);case _:
  return null;

}
}

}

/// @nodoc


class _OrganizerTournament extends OrganizerTournament {
  const _OrganizerTournament({required this.id, required this.name, required this.location, required this.startDate, required this.endDate, required this.teams}): super._();
  

@override final  String id;
@override final  String name;
@override final  String location;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  int teams;

/// Create a copy of OrganizerTournament
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrganizerTournamentCopyWith<_OrganizerTournament> get copyWith => __$OrganizerTournamentCopyWithImpl<_OrganizerTournament>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrganizerTournament&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.teams, teams) || other.teams == teams));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,location,startDate,endDate,teams);

@override
String toString() {
  return 'OrganizerTournament(id: $id, name: $name, location: $location, startDate: $startDate, endDate: $endDate, teams: $teams)';
}


}

/// @nodoc
abstract mixin class _$OrganizerTournamentCopyWith<$Res> implements $OrganizerTournamentCopyWith<$Res> {
  factory _$OrganizerTournamentCopyWith(_OrganizerTournament value, $Res Function(_OrganizerTournament) _then) = __$OrganizerTournamentCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String location, DateTime startDate, DateTime endDate, int teams
});




}
/// @nodoc
class __$OrganizerTournamentCopyWithImpl<$Res>
    implements _$OrganizerTournamentCopyWith<$Res> {
  __$OrganizerTournamentCopyWithImpl(this._self, this._then);

  final _OrganizerTournament _self;
  final $Res Function(_OrganizerTournament) _then;

/// Create a copy of OrganizerTournament
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? location = null,Object? startDate = null,Object? endDate = null,Object? teams = null,}) {
  return _then(_OrganizerTournament(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,teams: null == teams ? _self.teams : teams // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
