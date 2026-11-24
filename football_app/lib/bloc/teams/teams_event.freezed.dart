// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teams_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeamsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeamsEvent()';
}


}

/// @nodoc
class $TeamsEventCopyWith<$Res>  {
$TeamsEventCopyWith(TeamsEvent _, $Res Function(TeamsEvent) __);
}


/// Adds pattern-matching-related methods to [TeamsEvent].
extension TeamsEventPatterns on TeamsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TeamsStarted value)?  started,TResult Function( TeamsRefreshed value)?  refreshed,TResult Function( TeamsSearchChanged value)?  searchChanged,TResult Function( TeamsTeamAdded value)?  teamAdded,TResult Function( TeamsTeamDeleted value)?  teamDeleted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TeamsStarted() when started != null:
return started(_that);case TeamsRefreshed() when refreshed != null:
return refreshed(_that);case TeamsSearchChanged() when searchChanged != null:
return searchChanged(_that);case TeamsTeamAdded() when teamAdded != null:
return teamAdded(_that);case TeamsTeamDeleted() when teamDeleted != null:
return teamDeleted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TeamsStarted value)  started,required TResult Function( TeamsRefreshed value)  refreshed,required TResult Function( TeamsSearchChanged value)  searchChanged,required TResult Function( TeamsTeamAdded value)  teamAdded,required TResult Function( TeamsTeamDeleted value)  teamDeleted,}){
final _that = this;
switch (_that) {
case TeamsStarted():
return started(_that);case TeamsRefreshed():
return refreshed(_that);case TeamsSearchChanged():
return searchChanged(_that);case TeamsTeamAdded():
return teamAdded(_that);case TeamsTeamDeleted():
return teamDeleted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TeamsStarted value)?  started,TResult? Function( TeamsRefreshed value)?  refreshed,TResult? Function( TeamsSearchChanged value)?  searchChanged,TResult? Function( TeamsTeamAdded value)?  teamAdded,TResult? Function( TeamsTeamDeleted value)?  teamDeleted,}){
final _that = this;
switch (_that) {
case TeamsStarted() when started != null:
return started(_that);case TeamsRefreshed() when refreshed != null:
return refreshed(_that);case TeamsSearchChanged() when searchChanged != null:
return searchChanged(_that);case TeamsTeamAdded() when teamAdded != null:
return teamAdded(_that);case TeamsTeamDeleted() when teamDeleted != null:
return teamDeleted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  refreshed,TResult Function( String query)?  searchChanged,TResult Function( Team team)?  teamAdded,TResult Function( String id)?  teamDeleted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TeamsStarted() when started != null:
return started();case TeamsRefreshed() when refreshed != null:
return refreshed();case TeamsSearchChanged() when searchChanged != null:
return searchChanged(_that.query);case TeamsTeamAdded() when teamAdded != null:
return teamAdded(_that.team);case TeamsTeamDeleted() when teamDeleted != null:
return teamDeleted(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  refreshed,required TResult Function( String query)  searchChanged,required TResult Function( Team team)  teamAdded,required TResult Function( String id)  teamDeleted,}) {final _that = this;
switch (_that) {
case TeamsStarted():
return started();case TeamsRefreshed():
return refreshed();case TeamsSearchChanged():
return searchChanged(_that.query);case TeamsTeamAdded():
return teamAdded(_that.team);case TeamsTeamDeleted():
return teamDeleted(_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  refreshed,TResult? Function( String query)?  searchChanged,TResult? Function( Team team)?  teamAdded,TResult? Function( String id)?  teamDeleted,}) {final _that = this;
switch (_that) {
case TeamsStarted() when started != null:
return started();case TeamsRefreshed() when refreshed != null:
return refreshed();case TeamsSearchChanged() when searchChanged != null:
return searchChanged(_that.query);case TeamsTeamAdded() when teamAdded != null:
return teamAdded(_that.team);case TeamsTeamDeleted() when teamDeleted != null:
return teamDeleted(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class TeamsStarted implements TeamsEvent {
  const TeamsStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamsStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeamsEvent.started()';
}


}




/// @nodoc


class TeamsRefreshed implements TeamsEvent {
  const TeamsRefreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamsRefreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeamsEvent.refreshed()';
}


}




/// @nodoc


class TeamsSearchChanged implements TeamsEvent {
  const TeamsSearchChanged(this.query);
  

 final  String query;

/// Create a copy of TeamsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamsSearchChangedCopyWith<TeamsSearchChanged> get copyWith => _$TeamsSearchChangedCopyWithImpl<TeamsSearchChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamsSearchChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'TeamsEvent.searchChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class $TeamsSearchChangedCopyWith<$Res> implements $TeamsEventCopyWith<$Res> {
  factory $TeamsSearchChangedCopyWith(TeamsSearchChanged value, $Res Function(TeamsSearchChanged) _then) = _$TeamsSearchChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$TeamsSearchChangedCopyWithImpl<$Res>
    implements $TeamsSearchChangedCopyWith<$Res> {
  _$TeamsSearchChangedCopyWithImpl(this._self, this._then);

  final TeamsSearchChanged _self;
  final $Res Function(TeamsSearchChanged) _then;

/// Create a copy of TeamsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(TeamsSearchChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TeamsTeamAdded implements TeamsEvent {
  const TeamsTeamAdded(this.team);
  

 final  Team team;

/// Create a copy of TeamsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamsTeamAddedCopyWith<TeamsTeamAdded> get copyWith => _$TeamsTeamAddedCopyWithImpl<TeamsTeamAdded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamsTeamAdded&&const DeepCollectionEquality().equals(other.team, team));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(team));

@override
String toString() {
  return 'TeamsEvent.teamAdded(team: $team)';
}


}

/// @nodoc
abstract mixin class $TeamsTeamAddedCopyWith<$Res> implements $TeamsEventCopyWith<$Res> {
  factory $TeamsTeamAddedCopyWith(TeamsTeamAdded value, $Res Function(TeamsTeamAdded) _then) = _$TeamsTeamAddedCopyWithImpl;
@useResult
$Res call({
 Team team
});




}
/// @nodoc
class _$TeamsTeamAddedCopyWithImpl<$Res>
    implements $TeamsTeamAddedCopyWith<$Res> {
  _$TeamsTeamAddedCopyWithImpl(this._self, this._then);

  final TeamsTeamAdded _self;
  final $Res Function(TeamsTeamAdded) _then;

/// Create a copy of TeamsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? team = freezed,}) {
  return _then(TeamsTeamAdded(
freezed == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as Team,
  ));
}


}

/// @nodoc


class TeamsTeamDeleted implements TeamsEvent {
  const TeamsTeamDeleted(this.id);
  

 final  String id;

/// Create a copy of TeamsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamsTeamDeletedCopyWith<TeamsTeamDeleted> get copyWith => _$TeamsTeamDeletedCopyWithImpl<TeamsTeamDeleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamsTeamDeleted&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'TeamsEvent.teamDeleted(id: $id)';
}


}

/// @nodoc
abstract mixin class $TeamsTeamDeletedCopyWith<$Res> implements $TeamsEventCopyWith<$Res> {
  factory $TeamsTeamDeletedCopyWith(TeamsTeamDeleted value, $Res Function(TeamsTeamDeleted) _then) = _$TeamsTeamDeletedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$TeamsTeamDeletedCopyWithImpl<$Res>
    implements $TeamsTeamDeletedCopyWith<$Res> {
  _$TeamsTeamDeletedCopyWithImpl(this._self, this._then);

  final TeamsTeamDeleted _self;
  final $Res Function(TeamsTeamDeleted) _then;

/// Create a copy of TeamsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(TeamsTeamDeleted(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
