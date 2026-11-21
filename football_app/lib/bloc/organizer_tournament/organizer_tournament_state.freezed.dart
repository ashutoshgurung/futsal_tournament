// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organizer_tournament_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrganizerTournamentState {

 List<OrganizerTournament> get tournaments; OrganizerTournamentStatus? get filter;// null = All
// Used by the UI to show the "deleted / Undo" snackbar.
 OrganizerTournament? get lastDeleted; int get lastDeletedIndex;
/// Create a copy of OrganizerTournamentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganizerTournamentStateCopyWith<OrganizerTournamentState> get copyWith => _$OrganizerTournamentStateCopyWithImpl<OrganizerTournamentState>(this as OrganizerTournamentState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizerTournamentState&&const DeepCollectionEquality().equals(other.tournaments, tournaments)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.lastDeleted, lastDeleted) || other.lastDeleted == lastDeleted)&&(identical(other.lastDeletedIndex, lastDeletedIndex) || other.lastDeletedIndex == lastDeletedIndex));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tournaments),filter,lastDeleted,lastDeletedIndex);

@override
String toString() {
  return 'OrganizerTournamentState(tournaments: $tournaments, filter: $filter, lastDeleted: $lastDeleted, lastDeletedIndex: $lastDeletedIndex)';
}


}

/// @nodoc
abstract mixin class $OrganizerTournamentStateCopyWith<$Res>  {
  factory $OrganizerTournamentStateCopyWith(OrganizerTournamentState value, $Res Function(OrganizerTournamentState) _then) = _$OrganizerTournamentStateCopyWithImpl;
@useResult
$Res call({
 List<OrganizerTournament> tournaments, OrganizerTournamentStatus? filter, OrganizerTournament? lastDeleted, int lastDeletedIndex
});


$OrganizerTournamentCopyWith<$Res>? get lastDeleted;

}
/// @nodoc
class _$OrganizerTournamentStateCopyWithImpl<$Res>
    implements $OrganizerTournamentStateCopyWith<$Res> {
  _$OrganizerTournamentStateCopyWithImpl(this._self, this._then);

  final OrganizerTournamentState _self;
  final $Res Function(OrganizerTournamentState) _then;

/// Create a copy of OrganizerTournamentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tournaments = null,Object? filter = freezed,Object? lastDeleted = freezed,Object? lastDeletedIndex = null,}) {
  return _then(_self.copyWith(
tournaments: null == tournaments ? _self.tournaments : tournaments // ignore: cast_nullable_to_non_nullable
as List<OrganizerTournament>,filter: freezed == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as OrganizerTournamentStatus?,lastDeleted: freezed == lastDeleted ? _self.lastDeleted : lastDeleted // ignore: cast_nullable_to_non_nullable
as OrganizerTournament?,lastDeletedIndex: null == lastDeletedIndex ? _self.lastDeletedIndex : lastDeletedIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of OrganizerTournamentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrganizerTournamentCopyWith<$Res>? get lastDeleted {
    if (_self.lastDeleted == null) {
    return null;
  }

  return $OrganizerTournamentCopyWith<$Res>(_self.lastDeleted!, (value) {
    return _then(_self.copyWith(lastDeleted: value));
  });
}
}


/// Adds pattern-matching-related methods to [OrganizerTournamentState].
extension OrganizerTournamentStatePatterns on OrganizerTournamentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrganizerTournamentState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrganizerTournamentState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrganizerTournamentState value)  $default,){
final _that = this;
switch (_that) {
case _OrganizerTournamentState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrganizerTournamentState value)?  $default,){
final _that = this;
switch (_that) {
case _OrganizerTournamentState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<OrganizerTournament> tournaments,  OrganizerTournamentStatus? filter,  OrganizerTournament? lastDeleted,  int lastDeletedIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrganizerTournamentState() when $default != null:
return $default(_that.tournaments,_that.filter,_that.lastDeleted,_that.lastDeletedIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<OrganizerTournament> tournaments,  OrganizerTournamentStatus? filter,  OrganizerTournament? lastDeleted,  int lastDeletedIndex)  $default,) {final _that = this;
switch (_that) {
case _OrganizerTournamentState():
return $default(_that.tournaments,_that.filter,_that.lastDeleted,_that.lastDeletedIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<OrganizerTournament> tournaments,  OrganizerTournamentStatus? filter,  OrganizerTournament? lastDeleted,  int lastDeletedIndex)?  $default,) {final _that = this;
switch (_that) {
case _OrganizerTournamentState() when $default != null:
return $default(_that.tournaments,_that.filter,_that.lastDeleted,_that.lastDeletedIndex);case _:
  return null;

}
}

}

/// @nodoc


class _OrganizerTournamentState extends OrganizerTournamentState {
  const _OrganizerTournamentState({final  List<OrganizerTournament> tournaments = const [], this.filter, this.lastDeleted, this.lastDeletedIndex = 0}): _tournaments = tournaments,super._();
  

 final  List<OrganizerTournament> _tournaments;
@override@JsonKey() List<OrganizerTournament> get tournaments {
  if (_tournaments is EqualUnmodifiableListView) return _tournaments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tournaments);
}

@override final  OrganizerTournamentStatus? filter;
// null = All
// Used by the UI to show the "deleted / Undo" snackbar.
@override final  OrganizerTournament? lastDeleted;
@override@JsonKey() final  int lastDeletedIndex;

/// Create a copy of OrganizerTournamentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrganizerTournamentStateCopyWith<_OrganizerTournamentState> get copyWith => __$OrganizerTournamentStateCopyWithImpl<_OrganizerTournamentState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrganizerTournamentState&&const DeepCollectionEquality().equals(other._tournaments, _tournaments)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.lastDeleted, lastDeleted) || other.lastDeleted == lastDeleted)&&(identical(other.lastDeletedIndex, lastDeletedIndex) || other.lastDeletedIndex == lastDeletedIndex));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tournaments),filter,lastDeleted,lastDeletedIndex);

@override
String toString() {
  return 'OrganizerTournamentState(tournaments: $tournaments, filter: $filter, lastDeleted: $lastDeleted, lastDeletedIndex: $lastDeletedIndex)';
}


}

/// @nodoc
abstract mixin class _$OrganizerTournamentStateCopyWith<$Res> implements $OrganizerTournamentStateCopyWith<$Res> {
  factory _$OrganizerTournamentStateCopyWith(_OrganizerTournamentState value, $Res Function(_OrganizerTournamentState) _then) = __$OrganizerTournamentStateCopyWithImpl;
@override @useResult
$Res call({
 List<OrganizerTournament> tournaments, OrganizerTournamentStatus? filter, OrganizerTournament? lastDeleted, int lastDeletedIndex
});


@override $OrganizerTournamentCopyWith<$Res>? get lastDeleted;

}
/// @nodoc
class __$OrganizerTournamentStateCopyWithImpl<$Res>
    implements _$OrganizerTournamentStateCopyWith<$Res> {
  __$OrganizerTournamentStateCopyWithImpl(this._self, this._then);

  final _OrganizerTournamentState _self;
  final $Res Function(_OrganizerTournamentState) _then;

/// Create a copy of OrganizerTournamentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tournaments = null,Object? filter = freezed,Object? lastDeleted = freezed,Object? lastDeletedIndex = null,}) {
  return _then(_OrganizerTournamentState(
tournaments: null == tournaments ? _self._tournaments : tournaments // ignore: cast_nullable_to_non_nullable
as List<OrganizerTournament>,filter: freezed == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as OrganizerTournamentStatus?,lastDeleted: freezed == lastDeleted ? _self.lastDeleted : lastDeleted // ignore: cast_nullable_to_non_nullable
as OrganizerTournament?,lastDeletedIndex: null == lastDeletedIndex ? _self.lastDeletedIndex : lastDeletedIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of OrganizerTournamentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrganizerTournamentCopyWith<$Res>? get lastDeleted {
    if (_self.lastDeleted == null) {
    return null;
  }

  return $OrganizerTournamentCopyWith<$Res>(_self.lastDeleted!, (value) {
    return _then(_self.copyWith(lastDeleted: value));
  });
}
}

// dart format on
