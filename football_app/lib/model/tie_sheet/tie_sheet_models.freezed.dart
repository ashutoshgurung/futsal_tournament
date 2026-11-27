// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tie_sheet_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Team {

 String get id; String get name; String? get shortName; String? get logoUrl;
/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamCopyWith<Team> get copyWith => _$TeamCopyWithImpl<Team>(this as Team, _$identity);

  /// Serializes this Team to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Team&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shortName, shortName) || other.shortName == shortName)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shortName,logoUrl);

@override
String toString() {
  return 'Team(id: $id, name: $name, shortName: $shortName, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class $TeamCopyWith<$Res>  {
  factory $TeamCopyWith(Team value, $Res Function(Team) _then) = _$TeamCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? shortName, String? logoUrl
});




}
/// @nodoc
class _$TeamCopyWithImpl<$Res>
    implements $TeamCopyWith<$Res> {
  _$TeamCopyWithImpl(this._self, this._then);

  final Team _self;
  final $Res Function(Team) _then;

/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? shortName = freezed,Object? logoUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shortName: freezed == shortName ? _self.shortName : shortName // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Team].
extension TeamPatterns on Team {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Team value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Team() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Team value)  $default,){
final _that = this;
switch (_that) {
case _Team():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Team value)?  $default,){
final _that = this;
switch (_that) {
case _Team() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? shortName,  String? logoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Team() when $default != null:
return $default(_that.id,_that.name,_that.shortName,_that.logoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? shortName,  String? logoUrl)  $default,) {final _that = this;
switch (_that) {
case _Team():
return $default(_that.id,_that.name,_that.shortName,_that.logoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? shortName,  String? logoUrl)?  $default,) {final _that = this;
switch (_that) {
case _Team() when $default != null:
return $default(_that.id,_that.name,_that.shortName,_that.logoUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Team implements Team {
  const _Team({required this.id, required this.name, this.shortName, this.logoUrl});
  factory _Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? shortName;
@override final  String? logoUrl;

/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamCopyWith<_Team> get copyWith => __$TeamCopyWithImpl<_Team>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Team&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shortName, shortName) || other.shortName == shortName)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shortName,logoUrl);

@override
String toString() {
  return 'Team(id: $id, name: $name, shortName: $shortName, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class _$TeamCopyWith<$Res> implements $TeamCopyWith<$Res> {
  factory _$TeamCopyWith(_Team value, $Res Function(_Team) _then) = __$TeamCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? shortName, String? logoUrl
});




}
/// @nodoc
class __$TeamCopyWithImpl<$Res>
    implements _$TeamCopyWith<$Res> {
  __$TeamCopyWithImpl(this._self, this._then);

  final _Team _self;
  final $Res Function(_Team) _then;

/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shortName = freezed,Object? logoUrl = freezed,}) {
  return _then(_Team(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shortName: freezed == shortName ? _self.shortName : shortName // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BracketMatch {

 String get id; int get round; String? get roundName; int get matchNumber; int get bracketPosition; String? get team1Id; String? get team2Id; String? get winnerId; Team? get team1; Team? get team2; Team? get winner; bool get isBye; String get status; String? get nextMatchId; int? get nextMatchSlot; String? get loserNextMatchId; int? get loserNextSlot; int? get team1Score; int? get team2Score; int? get penaltyTeam1; int? get penaltyTeam2;
/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BracketMatchCopyWith<BracketMatch> get copyWith => _$BracketMatchCopyWithImpl<BracketMatch>(this as BracketMatch, _$identity);

  /// Serializes this BracketMatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BracketMatch&&(identical(other.id, id) || other.id == id)&&(identical(other.round, round) || other.round == round)&&(identical(other.roundName, roundName) || other.roundName == roundName)&&(identical(other.matchNumber, matchNumber) || other.matchNumber == matchNumber)&&(identical(other.bracketPosition, bracketPosition) || other.bracketPosition == bracketPosition)&&(identical(other.team1Id, team1Id) || other.team1Id == team1Id)&&(identical(other.team2Id, team2Id) || other.team2Id == team2Id)&&(identical(other.winnerId, winnerId) || other.winnerId == winnerId)&&(identical(other.team1, team1) || other.team1 == team1)&&(identical(other.team2, team2) || other.team2 == team2)&&(identical(other.winner, winner) || other.winner == winner)&&(identical(other.isBye, isBye) || other.isBye == isBye)&&(identical(other.status, status) || other.status == status)&&(identical(other.nextMatchId, nextMatchId) || other.nextMatchId == nextMatchId)&&(identical(other.nextMatchSlot, nextMatchSlot) || other.nextMatchSlot == nextMatchSlot)&&(identical(other.loserNextMatchId, loserNextMatchId) || other.loserNextMatchId == loserNextMatchId)&&(identical(other.loserNextSlot, loserNextSlot) || other.loserNextSlot == loserNextSlot)&&(identical(other.team1Score, team1Score) || other.team1Score == team1Score)&&(identical(other.team2Score, team2Score) || other.team2Score == team2Score)&&(identical(other.penaltyTeam1, penaltyTeam1) || other.penaltyTeam1 == penaltyTeam1)&&(identical(other.penaltyTeam2, penaltyTeam2) || other.penaltyTeam2 == penaltyTeam2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,round,roundName,matchNumber,bracketPosition,team1Id,team2Id,winnerId,team1,team2,winner,isBye,status,nextMatchId,nextMatchSlot,loserNextMatchId,loserNextSlot,team1Score,team2Score,penaltyTeam1,penaltyTeam2]);

@override
String toString() {
  return 'BracketMatch(id: $id, round: $round, roundName: $roundName, matchNumber: $matchNumber, bracketPosition: $bracketPosition, team1Id: $team1Id, team2Id: $team2Id, winnerId: $winnerId, team1: $team1, team2: $team2, winner: $winner, isBye: $isBye, status: $status, nextMatchId: $nextMatchId, nextMatchSlot: $nextMatchSlot, loserNextMatchId: $loserNextMatchId, loserNextSlot: $loserNextSlot, team1Score: $team1Score, team2Score: $team2Score, penaltyTeam1: $penaltyTeam1, penaltyTeam2: $penaltyTeam2)';
}


}

/// @nodoc
abstract mixin class $BracketMatchCopyWith<$Res>  {
  factory $BracketMatchCopyWith(BracketMatch value, $Res Function(BracketMatch) _then) = _$BracketMatchCopyWithImpl;
@useResult
$Res call({
 String id, int round, String? roundName, int matchNumber, int bracketPosition, String? team1Id, String? team2Id, String? winnerId, Team? team1, Team? team2, Team? winner, bool isBye, String status, String? nextMatchId, int? nextMatchSlot, String? loserNextMatchId, int? loserNextSlot, int? team1Score, int? team2Score, int? penaltyTeam1, int? penaltyTeam2
});


$TeamCopyWith<$Res>? get team1;$TeamCopyWith<$Res>? get team2;$TeamCopyWith<$Res>? get winner;

}
/// @nodoc
class _$BracketMatchCopyWithImpl<$Res>
    implements $BracketMatchCopyWith<$Res> {
  _$BracketMatchCopyWithImpl(this._self, this._then);

  final BracketMatch _self;
  final $Res Function(BracketMatch) _then;

/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? round = null,Object? roundName = freezed,Object? matchNumber = null,Object? bracketPosition = null,Object? team1Id = freezed,Object? team2Id = freezed,Object? winnerId = freezed,Object? team1 = freezed,Object? team2 = freezed,Object? winner = freezed,Object? isBye = null,Object? status = null,Object? nextMatchId = freezed,Object? nextMatchSlot = freezed,Object? loserNextMatchId = freezed,Object? loserNextSlot = freezed,Object? team1Score = freezed,Object? team2Score = freezed,Object? penaltyTeam1 = freezed,Object? penaltyTeam2 = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,roundName: freezed == roundName ? _self.roundName : roundName // ignore: cast_nullable_to_non_nullable
as String?,matchNumber: null == matchNumber ? _self.matchNumber : matchNumber // ignore: cast_nullable_to_non_nullable
as int,bracketPosition: null == bracketPosition ? _self.bracketPosition : bracketPosition // ignore: cast_nullable_to_non_nullable
as int,team1Id: freezed == team1Id ? _self.team1Id : team1Id // ignore: cast_nullable_to_non_nullable
as String?,team2Id: freezed == team2Id ? _self.team2Id : team2Id // ignore: cast_nullable_to_non_nullable
as String?,winnerId: freezed == winnerId ? _self.winnerId : winnerId // ignore: cast_nullable_to_non_nullable
as String?,team1: freezed == team1 ? _self.team1 : team1 // ignore: cast_nullable_to_non_nullable
as Team?,team2: freezed == team2 ? _self.team2 : team2 // ignore: cast_nullable_to_non_nullable
as Team?,winner: freezed == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as Team?,isBye: null == isBye ? _self.isBye : isBye // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,nextMatchId: freezed == nextMatchId ? _self.nextMatchId : nextMatchId // ignore: cast_nullable_to_non_nullable
as String?,nextMatchSlot: freezed == nextMatchSlot ? _self.nextMatchSlot : nextMatchSlot // ignore: cast_nullable_to_non_nullable
as int?,loserNextMatchId: freezed == loserNextMatchId ? _self.loserNextMatchId : loserNextMatchId // ignore: cast_nullable_to_non_nullable
as String?,loserNextSlot: freezed == loserNextSlot ? _self.loserNextSlot : loserNextSlot // ignore: cast_nullable_to_non_nullable
as int?,team1Score: freezed == team1Score ? _self.team1Score : team1Score // ignore: cast_nullable_to_non_nullable
as int?,team2Score: freezed == team2Score ? _self.team2Score : team2Score // ignore: cast_nullable_to_non_nullable
as int?,penaltyTeam1: freezed == penaltyTeam1 ? _self.penaltyTeam1 : penaltyTeam1 // ignore: cast_nullable_to_non_nullable
as int?,penaltyTeam2: freezed == penaltyTeam2 ? _self.penaltyTeam2 : penaltyTeam2 // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res>? get team1 {
    if (_self.team1 == null) {
    return null;
  }

  return $TeamCopyWith<$Res>(_self.team1!, (value) {
    return _then(_self.copyWith(team1: value));
  });
}/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res>? get team2 {
    if (_self.team2 == null) {
    return null;
  }

  return $TeamCopyWith<$Res>(_self.team2!, (value) {
    return _then(_self.copyWith(team2: value));
  });
}/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res>? get winner {
    if (_self.winner == null) {
    return null;
  }

  return $TeamCopyWith<$Res>(_self.winner!, (value) {
    return _then(_self.copyWith(winner: value));
  });
}
}


/// Adds pattern-matching-related methods to [BracketMatch].
extension BracketMatchPatterns on BracketMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BracketMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BracketMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BracketMatch value)  $default,){
final _that = this;
switch (_that) {
case _BracketMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BracketMatch value)?  $default,){
final _that = this;
switch (_that) {
case _BracketMatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int round,  String? roundName,  int matchNumber,  int bracketPosition,  String? team1Id,  String? team2Id,  String? winnerId,  Team? team1,  Team? team2,  Team? winner,  bool isBye,  String status,  String? nextMatchId,  int? nextMatchSlot,  String? loserNextMatchId,  int? loserNextSlot,  int? team1Score,  int? team2Score,  int? penaltyTeam1,  int? penaltyTeam2)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BracketMatch() when $default != null:
return $default(_that.id,_that.round,_that.roundName,_that.matchNumber,_that.bracketPosition,_that.team1Id,_that.team2Id,_that.winnerId,_that.team1,_that.team2,_that.winner,_that.isBye,_that.status,_that.nextMatchId,_that.nextMatchSlot,_that.loserNextMatchId,_that.loserNextSlot,_that.team1Score,_that.team2Score,_that.penaltyTeam1,_that.penaltyTeam2);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int round,  String? roundName,  int matchNumber,  int bracketPosition,  String? team1Id,  String? team2Id,  String? winnerId,  Team? team1,  Team? team2,  Team? winner,  bool isBye,  String status,  String? nextMatchId,  int? nextMatchSlot,  String? loserNextMatchId,  int? loserNextSlot,  int? team1Score,  int? team2Score,  int? penaltyTeam1,  int? penaltyTeam2)  $default,) {final _that = this;
switch (_that) {
case _BracketMatch():
return $default(_that.id,_that.round,_that.roundName,_that.matchNumber,_that.bracketPosition,_that.team1Id,_that.team2Id,_that.winnerId,_that.team1,_that.team2,_that.winner,_that.isBye,_that.status,_that.nextMatchId,_that.nextMatchSlot,_that.loserNextMatchId,_that.loserNextSlot,_that.team1Score,_that.team2Score,_that.penaltyTeam1,_that.penaltyTeam2);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int round,  String? roundName,  int matchNumber,  int bracketPosition,  String? team1Id,  String? team2Id,  String? winnerId,  Team? team1,  Team? team2,  Team? winner,  bool isBye,  String status,  String? nextMatchId,  int? nextMatchSlot,  String? loserNextMatchId,  int? loserNextSlot,  int? team1Score,  int? team2Score,  int? penaltyTeam1,  int? penaltyTeam2)?  $default,) {final _that = this;
switch (_that) {
case _BracketMatch() when $default != null:
return $default(_that.id,_that.round,_that.roundName,_that.matchNumber,_that.bracketPosition,_that.team1Id,_that.team2Id,_that.winnerId,_that.team1,_that.team2,_that.winner,_that.isBye,_that.status,_that.nextMatchId,_that.nextMatchSlot,_that.loserNextMatchId,_that.loserNextSlot,_that.team1Score,_that.team2Score,_that.penaltyTeam1,_that.penaltyTeam2);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BracketMatch implements BracketMatch {
  const _BracketMatch({required this.id, required this.round, this.roundName, required this.matchNumber, required this.bracketPosition, this.team1Id, this.team2Id, this.winnerId, this.team1, this.team2, this.winner, this.isBye = false, this.status = 'scheduled', this.nextMatchId, this.nextMatchSlot, this.loserNextMatchId, this.loserNextSlot, this.team1Score, this.team2Score, this.penaltyTeam1, this.penaltyTeam2});
  factory _BracketMatch.fromJson(Map<String, dynamic> json) => _$BracketMatchFromJson(json);

@override final  String id;
@override final  int round;
@override final  String? roundName;
@override final  int matchNumber;
@override final  int bracketPosition;
@override final  String? team1Id;
@override final  String? team2Id;
@override final  String? winnerId;
@override final  Team? team1;
@override final  Team? team2;
@override final  Team? winner;
@override@JsonKey() final  bool isBye;
@override@JsonKey() final  String status;
@override final  String? nextMatchId;
@override final  int? nextMatchSlot;
@override final  String? loserNextMatchId;
@override final  int? loserNextSlot;
@override final  int? team1Score;
@override final  int? team2Score;
@override final  int? penaltyTeam1;
@override final  int? penaltyTeam2;

/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BracketMatchCopyWith<_BracketMatch> get copyWith => __$BracketMatchCopyWithImpl<_BracketMatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BracketMatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BracketMatch&&(identical(other.id, id) || other.id == id)&&(identical(other.round, round) || other.round == round)&&(identical(other.roundName, roundName) || other.roundName == roundName)&&(identical(other.matchNumber, matchNumber) || other.matchNumber == matchNumber)&&(identical(other.bracketPosition, bracketPosition) || other.bracketPosition == bracketPosition)&&(identical(other.team1Id, team1Id) || other.team1Id == team1Id)&&(identical(other.team2Id, team2Id) || other.team2Id == team2Id)&&(identical(other.winnerId, winnerId) || other.winnerId == winnerId)&&(identical(other.team1, team1) || other.team1 == team1)&&(identical(other.team2, team2) || other.team2 == team2)&&(identical(other.winner, winner) || other.winner == winner)&&(identical(other.isBye, isBye) || other.isBye == isBye)&&(identical(other.status, status) || other.status == status)&&(identical(other.nextMatchId, nextMatchId) || other.nextMatchId == nextMatchId)&&(identical(other.nextMatchSlot, nextMatchSlot) || other.nextMatchSlot == nextMatchSlot)&&(identical(other.loserNextMatchId, loserNextMatchId) || other.loserNextMatchId == loserNextMatchId)&&(identical(other.loserNextSlot, loserNextSlot) || other.loserNextSlot == loserNextSlot)&&(identical(other.team1Score, team1Score) || other.team1Score == team1Score)&&(identical(other.team2Score, team2Score) || other.team2Score == team2Score)&&(identical(other.penaltyTeam1, penaltyTeam1) || other.penaltyTeam1 == penaltyTeam1)&&(identical(other.penaltyTeam2, penaltyTeam2) || other.penaltyTeam2 == penaltyTeam2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,round,roundName,matchNumber,bracketPosition,team1Id,team2Id,winnerId,team1,team2,winner,isBye,status,nextMatchId,nextMatchSlot,loserNextMatchId,loserNextSlot,team1Score,team2Score,penaltyTeam1,penaltyTeam2]);

@override
String toString() {
  return 'BracketMatch(id: $id, round: $round, roundName: $roundName, matchNumber: $matchNumber, bracketPosition: $bracketPosition, team1Id: $team1Id, team2Id: $team2Id, winnerId: $winnerId, team1: $team1, team2: $team2, winner: $winner, isBye: $isBye, status: $status, nextMatchId: $nextMatchId, nextMatchSlot: $nextMatchSlot, loserNextMatchId: $loserNextMatchId, loserNextSlot: $loserNextSlot, team1Score: $team1Score, team2Score: $team2Score, penaltyTeam1: $penaltyTeam1, penaltyTeam2: $penaltyTeam2)';
}


}

/// @nodoc
abstract mixin class _$BracketMatchCopyWith<$Res> implements $BracketMatchCopyWith<$Res> {
  factory _$BracketMatchCopyWith(_BracketMatch value, $Res Function(_BracketMatch) _then) = __$BracketMatchCopyWithImpl;
@override @useResult
$Res call({
 String id, int round, String? roundName, int matchNumber, int bracketPosition, String? team1Id, String? team2Id, String? winnerId, Team? team1, Team? team2, Team? winner, bool isBye, String status, String? nextMatchId, int? nextMatchSlot, String? loserNextMatchId, int? loserNextSlot, int? team1Score, int? team2Score, int? penaltyTeam1, int? penaltyTeam2
});


@override $TeamCopyWith<$Res>? get team1;@override $TeamCopyWith<$Res>? get team2;@override $TeamCopyWith<$Res>? get winner;

}
/// @nodoc
class __$BracketMatchCopyWithImpl<$Res>
    implements _$BracketMatchCopyWith<$Res> {
  __$BracketMatchCopyWithImpl(this._self, this._then);

  final _BracketMatch _self;
  final $Res Function(_BracketMatch) _then;

/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? round = null,Object? roundName = freezed,Object? matchNumber = null,Object? bracketPosition = null,Object? team1Id = freezed,Object? team2Id = freezed,Object? winnerId = freezed,Object? team1 = freezed,Object? team2 = freezed,Object? winner = freezed,Object? isBye = null,Object? status = null,Object? nextMatchId = freezed,Object? nextMatchSlot = freezed,Object? loserNextMatchId = freezed,Object? loserNextSlot = freezed,Object? team1Score = freezed,Object? team2Score = freezed,Object? penaltyTeam1 = freezed,Object? penaltyTeam2 = freezed,}) {
  return _then(_BracketMatch(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,roundName: freezed == roundName ? _self.roundName : roundName // ignore: cast_nullable_to_non_nullable
as String?,matchNumber: null == matchNumber ? _self.matchNumber : matchNumber // ignore: cast_nullable_to_non_nullable
as int,bracketPosition: null == bracketPosition ? _self.bracketPosition : bracketPosition // ignore: cast_nullable_to_non_nullable
as int,team1Id: freezed == team1Id ? _self.team1Id : team1Id // ignore: cast_nullable_to_non_nullable
as String?,team2Id: freezed == team2Id ? _self.team2Id : team2Id // ignore: cast_nullable_to_non_nullable
as String?,winnerId: freezed == winnerId ? _self.winnerId : winnerId // ignore: cast_nullable_to_non_nullable
as String?,team1: freezed == team1 ? _self.team1 : team1 // ignore: cast_nullable_to_non_nullable
as Team?,team2: freezed == team2 ? _self.team2 : team2 // ignore: cast_nullable_to_non_nullable
as Team?,winner: freezed == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as Team?,isBye: null == isBye ? _self.isBye : isBye // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,nextMatchId: freezed == nextMatchId ? _self.nextMatchId : nextMatchId // ignore: cast_nullable_to_non_nullable
as String?,nextMatchSlot: freezed == nextMatchSlot ? _self.nextMatchSlot : nextMatchSlot // ignore: cast_nullable_to_non_nullable
as int?,loserNextMatchId: freezed == loserNextMatchId ? _self.loserNextMatchId : loserNextMatchId // ignore: cast_nullable_to_non_nullable
as String?,loserNextSlot: freezed == loserNextSlot ? _self.loserNextSlot : loserNextSlot // ignore: cast_nullable_to_non_nullable
as int?,team1Score: freezed == team1Score ? _self.team1Score : team1Score // ignore: cast_nullable_to_non_nullable
as int?,team2Score: freezed == team2Score ? _self.team2Score : team2Score // ignore: cast_nullable_to_non_nullable
as int?,penaltyTeam1: freezed == penaltyTeam1 ? _self.penaltyTeam1 : penaltyTeam1 // ignore: cast_nullable_to_non_nullable
as int?,penaltyTeam2: freezed == penaltyTeam2 ? _self.penaltyTeam2 : penaltyTeam2 // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res>? get team1 {
    if (_self.team1 == null) {
    return null;
  }

  return $TeamCopyWith<$Res>(_self.team1!, (value) {
    return _then(_self.copyWith(team1: value));
  });
}/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res>? get team2 {
    if (_self.team2 == null) {
    return null;
  }

  return $TeamCopyWith<$Res>(_self.team2!, (value) {
    return _then(_self.copyWith(team2: value));
  });
}/// Create a copy of BracketMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res>? get winner {
    if (_self.winner == null) {
    return null;
  }

  return $TeamCopyWith<$Res>(_self.winner!, (value) {
    return _then(_self.copyWith(winner: value));
  });
}
}


/// @nodoc
mixin _$BracketRound {

 int get round; String get name; List<BracketMatch> get matches;
/// Create a copy of BracketRound
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BracketRoundCopyWith<BracketRound> get copyWith => _$BracketRoundCopyWithImpl<BracketRound>(this as BracketRound, _$identity);

  /// Serializes this BracketRound to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BracketRound&&(identical(other.round, round) || other.round == round)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.matches, matches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,round,name,const DeepCollectionEquality().hash(matches));

@override
String toString() {
  return 'BracketRound(round: $round, name: $name, matches: $matches)';
}


}

/// @nodoc
abstract mixin class $BracketRoundCopyWith<$Res>  {
  factory $BracketRoundCopyWith(BracketRound value, $Res Function(BracketRound) _then) = _$BracketRoundCopyWithImpl;
@useResult
$Res call({
 int round, String name, List<BracketMatch> matches
});




}
/// @nodoc
class _$BracketRoundCopyWithImpl<$Res>
    implements $BracketRoundCopyWith<$Res> {
  _$BracketRoundCopyWithImpl(this._self, this._then);

  final BracketRound _self;
  final $Res Function(BracketRound) _then;

/// Create a copy of BracketRound
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? round = null,Object? name = null,Object? matches = null,}) {
  return _then(_self.copyWith(
round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,matches: null == matches ? _self.matches : matches // ignore: cast_nullable_to_non_nullable
as List<BracketMatch>,
  ));
}

}


/// Adds pattern-matching-related methods to [BracketRound].
extension BracketRoundPatterns on BracketRound {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BracketRound value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BracketRound() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BracketRound value)  $default,){
final _that = this;
switch (_that) {
case _BracketRound():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BracketRound value)?  $default,){
final _that = this;
switch (_that) {
case _BracketRound() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int round,  String name,  List<BracketMatch> matches)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BracketRound() when $default != null:
return $default(_that.round,_that.name,_that.matches);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int round,  String name,  List<BracketMatch> matches)  $default,) {final _that = this;
switch (_that) {
case _BracketRound():
return $default(_that.round,_that.name,_that.matches);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int round,  String name,  List<BracketMatch> matches)?  $default,) {final _that = this;
switch (_that) {
case _BracketRound() when $default != null:
return $default(_that.round,_that.name,_that.matches);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BracketRound implements BracketRound {
  const _BracketRound({required this.round, required this.name, final  List<BracketMatch> matches = const []}): _matches = matches;
  factory _BracketRound.fromJson(Map<String, dynamic> json) => _$BracketRoundFromJson(json);

@override final  int round;
@override final  String name;
 final  List<BracketMatch> _matches;
@override@JsonKey() List<BracketMatch> get matches {
  if (_matches is EqualUnmodifiableListView) return _matches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matches);
}


/// Create a copy of BracketRound
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BracketRoundCopyWith<_BracketRound> get copyWith => __$BracketRoundCopyWithImpl<_BracketRound>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BracketRoundToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BracketRound&&(identical(other.round, round) || other.round == round)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._matches, _matches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,round,name,const DeepCollectionEquality().hash(_matches));

@override
String toString() {
  return 'BracketRound(round: $round, name: $name, matches: $matches)';
}


}

/// @nodoc
abstract mixin class _$BracketRoundCopyWith<$Res> implements $BracketRoundCopyWith<$Res> {
  factory _$BracketRoundCopyWith(_BracketRound value, $Res Function(_BracketRound) _then) = __$BracketRoundCopyWithImpl;
@override @useResult
$Res call({
 int round, String name, List<BracketMatch> matches
});




}
/// @nodoc
class __$BracketRoundCopyWithImpl<$Res>
    implements _$BracketRoundCopyWith<$Res> {
  __$BracketRoundCopyWithImpl(this._self, this._then);

  final _BracketRound _self;
  final $Res Function(_BracketRound) _then;

/// Create a copy of BracketRound
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? round = null,Object? name = null,Object? matches = null,}) {
  return _then(_BracketRound(
round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,matches: null == matches ? _self._matches : matches // ignore: cast_nullable_to_non_nullable
as List<BracketMatch>,
  ));
}


}


/// @nodoc
mixin _$TieSheetEntry {

 String get teamId; int get slot; int? get seed; Team? get team;
/// Create a copy of TieSheetEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TieSheetEntryCopyWith<TieSheetEntry> get copyWith => _$TieSheetEntryCopyWithImpl<TieSheetEntry>(this as TieSheetEntry, _$identity);

  /// Serializes this TieSheetEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TieSheetEntry&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.seed, seed) || other.seed == seed)&&(identical(other.team, team) || other.team == team));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamId,slot,seed,team);

@override
String toString() {
  return 'TieSheetEntry(teamId: $teamId, slot: $slot, seed: $seed, team: $team)';
}


}

/// @nodoc
abstract mixin class $TieSheetEntryCopyWith<$Res>  {
  factory $TieSheetEntryCopyWith(TieSheetEntry value, $Res Function(TieSheetEntry) _then) = _$TieSheetEntryCopyWithImpl;
@useResult
$Res call({
 String teamId, int slot, int? seed, Team? team
});


$TeamCopyWith<$Res>? get team;

}
/// @nodoc
class _$TieSheetEntryCopyWithImpl<$Res>
    implements $TieSheetEntryCopyWith<$Res> {
  _$TieSheetEntryCopyWithImpl(this._self, this._then);

  final TieSheetEntry _self;
  final $Res Function(TieSheetEntry) _then;

/// Create a copy of TieSheetEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? teamId = null,Object? slot = null,Object? seed = freezed,Object? team = freezed,}) {
  return _then(_self.copyWith(
teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as int,seed: freezed == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as int?,team: freezed == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as Team?,
  ));
}
/// Create a copy of TieSheetEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res>? get team {
    if (_self.team == null) {
    return null;
  }

  return $TeamCopyWith<$Res>(_self.team!, (value) {
    return _then(_self.copyWith(team: value));
  });
}
}


/// Adds pattern-matching-related methods to [TieSheetEntry].
extension TieSheetEntryPatterns on TieSheetEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TieSheetEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TieSheetEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TieSheetEntry value)  $default,){
final _that = this;
switch (_that) {
case _TieSheetEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TieSheetEntry value)?  $default,){
final _that = this;
switch (_that) {
case _TieSheetEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String teamId,  int slot,  int? seed,  Team? team)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TieSheetEntry() when $default != null:
return $default(_that.teamId,_that.slot,_that.seed,_that.team);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String teamId,  int slot,  int? seed,  Team? team)  $default,) {final _that = this;
switch (_that) {
case _TieSheetEntry():
return $default(_that.teamId,_that.slot,_that.seed,_that.team);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String teamId,  int slot,  int? seed,  Team? team)?  $default,) {final _that = this;
switch (_that) {
case _TieSheetEntry() when $default != null:
return $default(_that.teamId,_that.slot,_that.seed,_that.team);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TieSheetEntry implements TieSheetEntry {
  const _TieSheetEntry({required this.teamId, required this.slot, this.seed, this.team});
  factory _TieSheetEntry.fromJson(Map<String, dynamic> json) => _$TieSheetEntryFromJson(json);

@override final  String teamId;
@override final  int slot;
@override final  int? seed;
@override final  Team? team;

/// Create a copy of TieSheetEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TieSheetEntryCopyWith<_TieSheetEntry> get copyWith => __$TieSheetEntryCopyWithImpl<_TieSheetEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TieSheetEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TieSheetEntry&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.seed, seed) || other.seed == seed)&&(identical(other.team, team) || other.team == team));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamId,slot,seed,team);

@override
String toString() {
  return 'TieSheetEntry(teamId: $teamId, slot: $slot, seed: $seed, team: $team)';
}


}

/// @nodoc
abstract mixin class _$TieSheetEntryCopyWith<$Res> implements $TieSheetEntryCopyWith<$Res> {
  factory _$TieSheetEntryCopyWith(_TieSheetEntry value, $Res Function(_TieSheetEntry) _then) = __$TieSheetEntryCopyWithImpl;
@override @useResult
$Res call({
 String teamId, int slot, int? seed, Team? team
});


@override $TeamCopyWith<$Res>? get team;

}
/// @nodoc
class __$TieSheetEntryCopyWithImpl<$Res>
    implements _$TieSheetEntryCopyWith<$Res> {
  __$TieSheetEntryCopyWithImpl(this._self, this._then);

  final _TieSheetEntry _self;
  final $Res Function(_TieSheetEntry) _then;

/// Create a copy of TieSheetEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teamId = null,Object? slot = null,Object? seed = freezed,Object? team = freezed,}) {
  return _then(_TieSheetEntry(
teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as int,seed: freezed == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as int?,team: freezed == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as Team?,
  ));
}

/// Create a copy of TieSheetEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res>? get team {
    if (_self.team == null) {
    return null;
  }

  return $TeamCopyWith<$Res>(_self.team!, (value) {
    return _then(_self.copyWith(team: value));
  });
}
}


/// @nodoc
mixin _$TieSheet {

 String get id; String get tournamentId; String get name; String get type; String get seedingMethod; int get bracketSize; int get totalRounds; bool get thirdPlaceMatch; bool get isPublished; bool get isLocked; DateTime? get generatedAt; DateTime? get createdAt;// Present on detail endpoint only
 List<TieSheetEntry> get entries; List<BracketRound> get rounds;
/// Create a copy of TieSheet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TieSheetCopyWith<TieSheet> get copyWith => _$TieSheetCopyWithImpl<TieSheet>(this as TieSheet, _$identity);

  /// Serializes this TieSheet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TieSheet&&(identical(other.id, id) || other.id == id)&&(identical(other.tournamentId, tournamentId) || other.tournamentId == tournamentId)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.seedingMethod, seedingMethod) || other.seedingMethod == seedingMethod)&&(identical(other.bracketSize, bracketSize) || other.bracketSize == bracketSize)&&(identical(other.totalRounds, totalRounds) || other.totalRounds == totalRounds)&&(identical(other.thirdPlaceMatch, thirdPlaceMatch) || other.thirdPlaceMatch == thirdPlaceMatch)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.entries, entries)&&const DeepCollectionEquality().equals(other.rounds, rounds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tournamentId,name,type,seedingMethod,bracketSize,totalRounds,thirdPlaceMatch,isPublished,isLocked,generatedAt,createdAt,const DeepCollectionEquality().hash(entries),const DeepCollectionEquality().hash(rounds));

@override
String toString() {
  return 'TieSheet(id: $id, tournamentId: $tournamentId, name: $name, type: $type, seedingMethod: $seedingMethod, bracketSize: $bracketSize, totalRounds: $totalRounds, thirdPlaceMatch: $thirdPlaceMatch, isPublished: $isPublished, isLocked: $isLocked, generatedAt: $generatedAt, createdAt: $createdAt, entries: $entries, rounds: $rounds)';
}


}

/// @nodoc
abstract mixin class $TieSheetCopyWith<$Res>  {
  factory $TieSheetCopyWith(TieSheet value, $Res Function(TieSheet) _then) = _$TieSheetCopyWithImpl;
@useResult
$Res call({
 String id, String tournamentId, String name, String type, String seedingMethod, int bracketSize, int totalRounds, bool thirdPlaceMatch, bool isPublished, bool isLocked, DateTime? generatedAt, DateTime? createdAt, List<TieSheetEntry> entries, List<BracketRound> rounds
});




}
/// @nodoc
class _$TieSheetCopyWithImpl<$Res>
    implements $TieSheetCopyWith<$Res> {
  _$TieSheetCopyWithImpl(this._self, this._then);

  final TieSheet _self;
  final $Res Function(TieSheet) _then;

/// Create a copy of TieSheet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tournamentId = null,Object? name = null,Object? type = null,Object? seedingMethod = null,Object? bracketSize = null,Object? totalRounds = null,Object? thirdPlaceMatch = null,Object? isPublished = null,Object? isLocked = null,Object? generatedAt = freezed,Object? createdAt = freezed,Object? entries = null,Object? rounds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tournamentId: null == tournamentId ? _self.tournamentId : tournamentId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,seedingMethod: null == seedingMethod ? _self.seedingMethod : seedingMethod // ignore: cast_nullable_to_non_nullable
as String,bracketSize: null == bracketSize ? _self.bracketSize : bracketSize // ignore: cast_nullable_to_non_nullable
as int,totalRounds: null == totalRounds ? _self.totalRounds : totalRounds // ignore: cast_nullable_to_non_nullable
as int,thirdPlaceMatch: null == thirdPlaceMatch ? _self.thirdPlaceMatch : thirdPlaceMatch // ignore: cast_nullable_to_non_nullable
as bool,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<TieSheetEntry>,rounds: null == rounds ? _self.rounds : rounds // ignore: cast_nullable_to_non_nullable
as List<BracketRound>,
  ));
}

}


/// Adds pattern-matching-related methods to [TieSheet].
extension TieSheetPatterns on TieSheet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TieSheet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TieSheet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TieSheet value)  $default,){
final _that = this;
switch (_that) {
case _TieSheet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TieSheet value)?  $default,){
final _that = this;
switch (_that) {
case _TieSheet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tournamentId,  String name,  String type,  String seedingMethod,  int bracketSize,  int totalRounds,  bool thirdPlaceMatch,  bool isPublished,  bool isLocked,  DateTime? generatedAt,  DateTime? createdAt,  List<TieSheetEntry> entries,  List<BracketRound> rounds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TieSheet() when $default != null:
return $default(_that.id,_that.tournamentId,_that.name,_that.type,_that.seedingMethod,_that.bracketSize,_that.totalRounds,_that.thirdPlaceMatch,_that.isPublished,_that.isLocked,_that.generatedAt,_that.createdAt,_that.entries,_that.rounds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tournamentId,  String name,  String type,  String seedingMethod,  int bracketSize,  int totalRounds,  bool thirdPlaceMatch,  bool isPublished,  bool isLocked,  DateTime? generatedAt,  DateTime? createdAt,  List<TieSheetEntry> entries,  List<BracketRound> rounds)  $default,) {final _that = this;
switch (_that) {
case _TieSheet():
return $default(_that.id,_that.tournamentId,_that.name,_that.type,_that.seedingMethod,_that.bracketSize,_that.totalRounds,_that.thirdPlaceMatch,_that.isPublished,_that.isLocked,_that.generatedAt,_that.createdAt,_that.entries,_that.rounds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tournamentId,  String name,  String type,  String seedingMethod,  int bracketSize,  int totalRounds,  bool thirdPlaceMatch,  bool isPublished,  bool isLocked,  DateTime? generatedAt,  DateTime? createdAt,  List<TieSheetEntry> entries,  List<BracketRound> rounds)?  $default,) {final _that = this;
switch (_that) {
case _TieSheet() when $default != null:
return $default(_that.id,_that.tournamentId,_that.name,_that.type,_that.seedingMethod,_that.bracketSize,_that.totalRounds,_that.thirdPlaceMatch,_that.isPublished,_that.isLocked,_that.generatedAt,_that.createdAt,_that.entries,_that.rounds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TieSheet implements TieSheet {
  const _TieSheet({required this.id, required this.tournamentId, required this.name, this.type = 'single_elimination', this.seedingMethod = 'random', required this.bracketSize, required this.totalRounds, this.thirdPlaceMatch = false, this.isPublished = false, this.isLocked = false, this.generatedAt, this.createdAt, final  List<TieSheetEntry> entries = const [], final  List<BracketRound> rounds = const []}): _entries = entries,_rounds = rounds;
  factory _TieSheet.fromJson(Map<String, dynamic> json) => _$TieSheetFromJson(json);

@override final  String id;
@override final  String tournamentId;
@override final  String name;
@override@JsonKey() final  String type;
@override@JsonKey() final  String seedingMethod;
@override final  int bracketSize;
@override final  int totalRounds;
@override@JsonKey() final  bool thirdPlaceMatch;
@override@JsonKey() final  bool isPublished;
@override@JsonKey() final  bool isLocked;
@override final  DateTime? generatedAt;
@override final  DateTime? createdAt;
// Present on detail endpoint only
 final  List<TieSheetEntry> _entries;
// Present on detail endpoint only
@override@JsonKey() List<TieSheetEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

 final  List<BracketRound> _rounds;
@override@JsonKey() List<BracketRound> get rounds {
  if (_rounds is EqualUnmodifiableListView) return _rounds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rounds);
}


/// Create a copy of TieSheet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TieSheetCopyWith<_TieSheet> get copyWith => __$TieSheetCopyWithImpl<_TieSheet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TieSheetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TieSheet&&(identical(other.id, id) || other.id == id)&&(identical(other.tournamentId, tournamentId) || other.tournamentId == tournamentId)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.seedingMethod, seedingMethod) || other.seedingMethod == seedingMethod)&&(identical(other.bracketSize, bracketSize) || other.bracketSize == bracketSize)&&(identical(other.totalRounds, totalRounds) || other.totalRounds == totalRounds)&&(identical(other.thirdPlaceMatch, thirdPlaceMatch) || other.thirdPlaceMatch == thirdPlaceMatch)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._entries, _entries)&&const DeepCollectionEquality().equals(other._rounds, _rounds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tournamentId,name,type,seedingMethod,bracketSize,totalRounds,thirdPlaceMatch,isPublished,isLocked,generatedAt,createdAt,const DeepCollectionEquality().hash(_entries),const DeepCollectionEquality().hash(_rounds));

@override
String toString() {
  return 'TieSheet(id: $id, tournamentId: $tournamentId, name: $name, type: $type, seedingMethod: $seedingMethod, bracketSize: $bracketSize, totalRounds: $totalRounds, thirdPlaceMatch: $thirdPlaceMatch, isPublished: $isPublished, isLocked: $isLocked, generatedAt: $generatedAt, createdAt: $createdAt, entries: $entries, rounds: $rounds)';
}


}

/// @nodoc
abstract mixin class _$TieSheetCopyWith<$Res> implements $TieSheetCopyWith<$Res> {
  factory _$TieSheetCopyWith(_TieSheet value, $Res Function(_TieSheet) _then) = __$TieSheetCopyWithImpl;
@override @useResult
$Res call({
 String id, String tournamentId, String name, String type, String seedingMethod, int bracketSize, int totalRounds, bool thirdPlaceMatch, bool isPublished, bool isLocked, DateTime? generatedAt, DateTime? createdAt, List<TieSheetEntry> entries, List<BracketRound> rounds
});




}
/// @nodoc
class __$TieSheetCopyWithImpl<$Res>
    implements _$TieSheetCopyWith<$Res> {
  __$TieSheetCopyWithImpl(this._self, this._then);

  final _TieSheet _self;
  final $Res Function(_TieSheet) _then;

/// Create a copy of TieSheet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tournamentId = null,Object? name = null,Object? type = null,Object? seedingMethod = null,Object? bracketSize = null,Object? totalRounds = null,Object? thirdPlaceMatch = null,Object? isPublished = null,Object? isLocked = null,Object? generatedAt = freezed,Object? createdAt = freezed,Object? entries = null,Object? rounds = null,}) {
  return _then(_TieSheet(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tournamentId: null == tournamentId ? _self.tournamentId : tournamentId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,seedingMethod: null == seedingMethod ? _self.seedingMethod : seedingMethod // ignore: cast_nullable_to_non_nullable
as String,bracketSize: null == bracketSize ? _self.bracketSize : bracketSize // ignore: cast_nullable_to_non_nullable
as int,totalRounds: null == totalRounds ? _self.totalRounds : totalRounds // ignore: cast_nullable_to_non_nullable
as int,thirdPlaceMatch: null == thirdPlaceMatch ? _self.thirdPlaceMatch : thirdPlaceMatch // ignore: cast_nullable_to_non_nullable
as bool,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<TieSheetEntry>,rounds: null == rounds ? _self._rounds : rounds // ignore: cast_nullable_to_non_nullable
as List<BracketRound>,
  ));
}


}


/// @nodoc
mixin _$Pairing {

 String? get team1Id; String? get team2Id;
/// Create a copy of Pairing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PairingCopyWith<Pairing> get copyWith => _$PairingCopyWithImpl<Pairing>(this as Pairing, _$identity);

  /// Serializes this Pairing to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Pairing&&(identical(other.team1Id, team1Id) || other.team1Id == team1Id)&&(identical(other.team2Id, team2Id) || other.team2Id == team2Id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team1Id,team2Id);

@override
String toString() {
  return 'Pairing(team1Id: $team1Id, team2Id: $team2Id)';
}


}

/// @nodoc
abstract mixin class $PairingCopyWith<$Res>  {
  factory $PairingCopyWith(Pairing value, $Res Function(Pairing) _then) = _$PairingCopyWithImpl;
@useResult
$Res call({
 String? team1Id, String? team2Id
});




}
/// @nodoc
class _$PairingCopyWithImpl<$Res>
    implements $PairingCopyWith<$Res> {
  _$PairingCopyWithImpl(this._self, this._then);

  final Pairing _self;
  final $Res Function(Pairing) _then;

/// Create a copy of Pairing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? team1Id = freezed,Object? team2Id = freezed,}) {
  return _then(_self.copyWith(
team1Id: freezed == team1Id ? _self.team1Id : team1Id // ignore: cast_nullable_to_non_nullable
as String?,team2Id: freezed == team2Id ? _self.team2Id : team2Id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Pairing].
extension PairingPatterns on Pairing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Pairing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Pairing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Pairing value)  $default,){
final _that = this;
switch (_that) {
case _Pairing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Pairing value)?  $default,){
final _that = this;
switch (_that) {
case _Pairing() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? team1Id,  String? team2Id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Pairing() when $default != null:
return $default(_that.team1Id,_that.team2Id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? team1Id,  String? team2Id)  $default,) {final _that = this;
switch (_that) {
case _Pairing():
return $default(_that.team1Id,_that.team2Id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? team1Id,  String? team2Id)?  $default,) {final _that = this;
switch (_that) {
case _Pairing() when $default != null:
return $default(_that.team1Id,_that.team2Id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Pairing implements Pairing {
  const _Pairing({this.team1Id, this.team2Id});
  factory _Pairing.fromJson(Map<String, dynamic> json) => _$PairingFromJson(json);

@override final  String? team1Id;
@override final  String? team2Id;

/// Create a copy of Pairing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PairingCopyWith<_Pairing> get copyWith => __$PairingCopyWithImpl<_Pairing>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PairingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Pairing&&(identical(other.team1Id, team1Id) || other.team1Id == team1Id)&&(identical(other.team2Id, team2Id) || other.team2Id == team2Id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team1Id,team2Id);

@override
String toString() {
  return 'Pairing(team1Id: $team1Id, team2Id: $team2Id)';
}


}

/// @nodoc
abstract mixin class _$PairingCopyWith<$Res> implements $PairingCopyWith<$Res> {
  factory _$PairingCopyWith(_Pairing value, $Res Function(_Pairing) _then) = __$PairingCopyWithImpl;
@override @useResult
$Res call({
 String? team1Id, String? team2Id
});




}
/// @nodoc
class __$PairingCopyWithImpl<$Res>
    implements _$PairingCopyWith<$Res> {
  __$PairingCopyWithImpl(this._self, this._then);

  final _Pairing _self;
  final $Res Function(_Pairing) _then;

/// Create a copy of Pairing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? team1Id = freezed,Object? team2Id = freezed,}) {
  return _then(_Pairing(
team1Id: freezed == team1Id ? _self.team1Id : team1Id // ignore: cast_nullable_to_non_nullable
as String?,team2Id: freezed == team2Id ? _self.team2Id : team2Id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
