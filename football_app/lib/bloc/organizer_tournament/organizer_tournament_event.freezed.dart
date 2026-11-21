// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organizer_tournament_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrganizerTournamentEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizerTournamentEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrganizerTournamentEvent()';
}


}

/// @nodoc
class $OrganizerTournamentEventCopyWith<$Res>  {
$OrganizerTournamentEventCopyWith(OrganizerTournamentEvent _, $Res Function(OrganizerTournamentEvent) __);
}


/// Adds pattern-matching-related methods to [OrganizerTournamentEvent].
extension OrganizerTournamentEventPatterns on OrganizerTournamentEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OrganizerTournamentCreated value)?  created,TResult Function( OrganizerTournamentDeleted value)?  deleted,TResult Function( OrganizerTournamentDeleteUndone value)?  deleteUndone,TResult Function( OrganizerTournamentFilterChanged value)?  filterChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OrganizerTournamentCreated() when created != null:
return created(_that);case OrganizerTournamentDeleted() when deleted != null:
return deleted(_that);case OrganizerTournamentDeleteUndone() when deleteUndone != null:
return deleteUndone(_that);case OrganizerTournamentFilterChanged() when filterChanged != null:
return filterChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OrganizerTournamentCreated value)  created,required TResult Function( OrganizerTournamentDeleted value)  deleted,required TResult Function( OrganizerTournamentDeleteUndone value)  deleteUndone,required TResult Function( OrganizerTournamentFilterChanged value)  filterChanged,}){
final _that = this;
switch (_that) {
case OrganizerTournamentCreated():
return created(_that);case OrganizerTournamentDeleted():
return deleted(_that);case OrganizerTournamentDeleteUndone():
return deleteUndone(_that);case OrganizerTournamentFilterChanged():
return filterChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OrganizerTournamentCreated value)?  created,TResult? Function( OrganizerTournamentDeleted value)?  deleted,TResult? Function( OrganizerTournamentDeleteUndone value)?  deleteUndone,TResult? Function( OrganizerTournamentFilterChanged value)?  filterChanged,}){
final _that = this;
switch (_that) {
case OrganizerTournamentCreated() when created != null:
return created(_that);case OrganizerTournamentDeleted() when deleted != null:
return deleted(_that);case OrganizerTournamentDeleteUndone() when deleteUndone != null:
return deleteUndone(_that);case OrganizerTournamentFilterChanged() when filterChanged != null:
return filterChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( OrganizerTournament tournament)?  created,TResult Function( OrganizerTournament tournament)?  deleted,TResult Function()?  deleteUndone,TResult Function( OrganizerTournamentStatus? filter)?  filterChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OrganizerTournamentCreated() when created != null:
return created(_that.tournament);case OrganizerTournamentDeleted() when deleted != null:
return deleted(_that.tournament);case OrganizerTournamentDeleteUndone() when deleteUndone != null:
return deleteUndone();case OrganizerTournamentFilterChanged() when filterChanged != null:
return filterChanged(_that.filter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( OrganizerTournament tournament)  created,required TResult Function( OrganizerTournament tournament)  deleted,required TResult Function()  deleteUndone,required TResult Function( OrganizerTournamentStatus? filter)  filterChanged,}) {final _that = this;
switch (_that) {
case OrganizerTournamentCreated():
return created(_that.tournament);case OrganizerTournamentDeleted():
return deleted(_that.tournament);case OrganizerTournamentDeleteUndone():
return deleteUndone();case OrganizerTournamentFilterChanged():
return filterChanged(_that.filter);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( OrganizerTournament tournament)?  created,TResult? Function( OrganizerTournament tournament)?  deleted,TResult? Function()?  deleteUndone,TResult? Function( OrganizerTournamentStatus? filter)?  filterChanged,}) {final _that = this;
switch (_that) {
case OrganizerTournamentCreated() when created != null:
return created(_that.tournament);case OrganizerTournamentDeleted() when deleted != null:
return deleted(_that.tournament);case OrganizerTournamentDeleteUndone() when deleteUndone != null:
return deleteUndone();case OrganizerTournamentFilterChanged() when filterChanged != null:
return filterChanged(_that.filter);case _:
  return null;

}
}

}

/// @nodoc


class OrganizerTournamentCreated implements OrganizerTournamentEvent {
  const OrganizerTournamentCreated(this.tournament);
  

 final  OrganizerTournament tournament;

/// Create a copy of OrganizerTournamentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganizerTournamentCreatedCopyWith<OrganizerTournamentCreated> get copyWith => _$OrganizerTournamentCreatedCopyWithImpl<OrganizerTournamentCreated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizerTournamentCreated&&(identical(other.tournament, tournament) || other.tournament == tournament));
}


@override
int get hashCode => Object.hash(runtimeType,tournament);

@override
String toString() {
  return 'OrganizerTournamentEvent.created(tournament: $tournament)';
}


}

/// @nodoc
abstract mixin class $OrganizerTournamentCreatedCopyWith<$Res> implements $OrganizerTournamentEventCopyWith<$Res> {
  factory $OrganizerTournamentCreatedCopyWith(OrganizerTournamentCreated value, $Res Function(OrganizerTournamentCreated) _then) = _$OrganizerTournamentCreatedCopyWithImpl;
@useResult
$Res call({
 OrganizerTournament tournament
});


$OrganizerTournamentCopyWith<$Res> get tournament;

}
/// @nodoc
class _$OrganizerTournamentCreatedCopyWithImpl<$Res>
    implements $OrganizerTournamentCreatedCopyWith<$Res> {
  _$OrganizerTournamentCreatedCopyWithImpl(this._self, this._then);

  final OrganizerTournamentCreated _self;
  final $Res Function(OrganizerTournamentCreated) _then;

/// Create a copy of OrganizerTournamentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tournament = null,}) {
  return _then(OrganizerTournamentCreated(
null == tournament ? _self.tournament : tournament // ignore: cast_nullable_to_non_nullable
as OrganizerTournament,
  ));
}

/// Create a copy of OrganizerTournamentEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrganizerTournamentCopyWith<$Res> get tournament {
  
  return $OrganizerTournamentCopyWith<$Res>(_self.tournament, (value) {
    return _then(_self.copyWith(tournament: value));
  });
}
}

/// @nodoc


class OrganizerTournamentDeleted implements OrganizerTournamentEvent {
  const OrganizerTournamentDeleted(this.tournament);
  

 final  OrganizerTournament tournament;

/// Create a copy of OrganizerTournamentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganizerTournamentDeletedCopyWith<OrganizerTournamentDeleted> get copyWith => _$OrganizerTournamentDeletedCopyWithImpl<OrganizerTournamentDeleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizerTournamentDeleted&&(identical(other.tournament, tournament) || other.tournament == tournament));
}


@override
int get hashCode => Object.hash(runtimeType,tournament);

@override
String toString() {
  return 'OrganizerTournamentEvent.deleted(tournament: $tournament)';
}


}

/// @nodoc
abstract mixin class $OrganizerTournamentDeletedCopyWith<$Res> implements $OrganizerTournamentEventCopyWith<$Res> {
  factory $OrganizerTournamentDeletedCopyWith(OrganizerTournamentDeleted value, $Res Function(OrganizerTournamentDeleted) _then) = _$OrganizerTournamentDeletedCopyWithImpl;
@useResult
$Res call({
 OrganizerTournament tournament
});


$OrganizerTournamentCopyWith<$Res> get tournament;

}
/// @nodoc
class _$OrganizerTournamentDeletedCopyWithImpl<$Res>
    implements $OrganizerTournamentDeletedCopyWith<$Res> {
  _$OrganizerTournamentDeletedCopyWithImpl(this._self, this._then);

  final OrganizerTournamentDeleted _self;
  final $Res Function(OrganizerTournamentDeleted) _then;

/// Create a copy of OrganizerTournamentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tournament = null,}) {
  return _then(OrganizerTournamentDeleted(
null == tournament ? _self.tournament : tournament // ignore: cast_nullable_to_non_nullable
as OrganizerTournament,
  ));
}

/// Create a copy of OrganizerTournamentEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrganizerTournamentCopyWith<$Res> get tournament {
  
  return $OrganizerTournamentCopyWith<$Res>(_self.tournament, (value) {
    return _then(_self.copyWith(tournament: value));
  });
}
}

/// @nodoc


class OrganizerTournamentDeleteUndone implements OrganizerTournamentEvent {
  const OrganizerTournamentDeleteUndone();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizerTournamentDeleteUndone);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrganizerTournamentEvent.deleteUndone()';
}


}




/// @nodoc


class OrganizerTournamentFilterChanged implements OrganizerTournamentEvent {
  const OrganizerTournamentFilterChanged(this.filter);
  

 final  OrganizerTournamentStatus? filter;

/// Create a copy of OrganizerTournamentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganizerTournamentFilterChangedCopyWith<OrganizerTournamentFilterChanged> get copyWith => _$OrganizerTournamentFilterChangedCopyWithImpl<OrganizerTournamentFilterChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizerTournamentFilterChanged&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,filter);

@override
String toString() {
  return 'OrganizerTournamentEvent.filterChanged(filter: $filter)';
}


}

/// @nodoc
abstract mixin class $OrganizerTournamentFilterChangedCopyWith<$Res> implements $OrganizerTournamentEventCopyWith<$Res> {
  factory $OrganizerTournamentFilterChangedCopyWith(OrganizerTournamentFilterChanged value, $Res Function(OrganizerTournamentFilterChanged) _then) = _$OrganizerTournamentFilterChangedCopyWithImpl;
@useResult
$Res call({
 OrganizerTournamentStatus? filter
});




}
/// @nodoc
class _$OrganizerTournamentFilterChangedCopyWithImpl<$Res>
    implements $OrganizerTournamentFilterChangedCopyWith<$Res> {
  _$OrganizerTournamentFilterChangedCopyWithImpl(this._self, this._then);

  final OrganizerTournamentFilterChanged _self;
  final $Res Function(OrganizerTournamentFilterChanged) _then;

/// Create a copy of OrganizerTournamentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = freezed,}) {
  return _then(OrganizerTournamentFilterChanged(
freezed == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as OrganizerTournamentStatus?,
  ));
}


}

// dart format on
