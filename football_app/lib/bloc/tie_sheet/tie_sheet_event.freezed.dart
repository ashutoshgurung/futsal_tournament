// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tie_sheet_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TieSheetEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TieSheetEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TieSheetEvent()';
}


}

/// @nodoc
class $TieSheetEventCopyWith<$Res>  {
$TieSheetEventCopyWith(TieSheetEvent _, $Res Function(TieSheetEvent) __);
}


/// Adds pattern-matching-related methods to [TieSheetEvent].
extension TieSheetEventPatterns on TieSheetEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TieSheetListRequested value)?  listRequested,TResult Function( TieSheetDetailRequested value)?  detailRequested,TResult Function( TieSheetGenerateSubmitted value)?  generateSubmitted,TResult Function( TieSheetManualSubmitted value)?  manualSubmitted,TResult Function( TieSheetPairingsReplaced value)?  pairingsReplaced,TResult Function( TieSheetMetaUpdated value)?  metaUpdated,TResult Function( TieSheetDeleted value)?  deleted,TResult Function( TieSheetMessageConsumed value)?  messageConsumed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TieSheetListRequested() when listRequested != null:
return listRequested(_that);case TieSheetDetailRequested() when detailRequested != null:
return detailRequested(_that);case TieSheetGenerateSubmitted() when generateSubmitted != null:
return generateSubmitted(_that);case TieSheetManualSubmitted() when manualSubmitted != null:
return manualSubmitted(_that);case TieSheetPairingsReplaced() when pairingsReplaced != null:
return pairingsReplaced(_that);case TieSheetMetaUpdated() when metaUpdated != null:
return metaUpdated(_that);case TieSheetDeleted() when deleted != null:
return deleted(_that);case TieSheetMessageConsumed() when messageConsumed != null:
return messageConsumed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TieSheetListRequested value)  listRequested,required TResult Function( TieSheetDetailRequested value)  detailRequested,required TResult Function( TieSheetGenerateSubmitted value)  generateSubmitted,required TResult Function( TieSheetManualSubmitted value)  manualSubmitted,required TResult Function( TieSheetPairingsReplaced value)  pairingsReplaced,required TResult Function( TieSheetMetaUpdated value)  metaUpdated,required TResult Function( TieSheetDeleted value)  deleted,required TResult Function( TieSheetMessageConsumed value)  messageConsumed,}){
final _that = this;
switch (_that) {
case TieSheetListRequested():
return listRequested(_that);case TieSheetDetailRequested():
return detailRequested(_that);case TieSheetGenerateSubmitted():
return generateSubmitted(_that);case TieSheetManualSubmitted():
return manualSubmitted(_that);case TieSheetPairingsReplaced():
return pairingsReplaced(_that);case TieSheetMetaUpdated():
return metaUpdated(_that);case TieSheetDeleted():
return deleted(_that);case TieSheetMessageConsumed():
return messageConsumed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TieSheetListRequested value)?  listRequested,TResult? Function( TieSheetDetailRequested value)?  detailRequested,TResult? Function( TieSheetGenerateSubmitted value)?  generateSubmitted,TResult? Function( TieSheetManualSubmitted value)?  manualSubmitted,TResult? Function( TieSheetPairingsReplaced value)?  pairingsReplaced,TResult? Function( TieSheetMetaUpdated value)?  metaUpdated,TResult? Function( TieSheetDeleted value)?  deleted,TResult? Function( TieSheetMessageConsumed value)?  messageConsumed,}){
final _that = this;
switch (_that) {
case TieSheetListRequested() when listRequested != null:
return listRequested(_that);case TieSheetDetailRequested() when detailRequested != null:
return detailRequested(_that);case TieSheetGenerateSubmitted() when generateSubmitted != null:
return generateSubmitted(_that);case TieSheetManualSubmitted() when manualSubmitted != null:
return manualSubmitted(_that);case TieSheetPairingsReplaced() when pairingsReplaced != null:
return pairingsReplaced(_that);case TieSheetMetaUpdated() when metaUpdated != null:
return metaUpdated(_that);case TieSheetDeleted() when deleted != null:
return deleted(_that);case TieSheetMessageConsumed() when messageConsumed != null:
return messageConsumed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String tournamentId)?  listRequested,TResult Function( String id)?  detailRequested,TResult Function( String tournamentId,  String? name,  String seedingMethod,  List<String> seeds,  bool thirdPlaceMatch)?  generateSubmitted,TResult Function( String tournamentId,  String? name,  List<Pairing> pairings,  bool thirdPlaceMatch)?  manualSubmitted,TResult Function( String id,  List<Pairing> pairings,  bool? thirdPlaceMatch)?  pairingsReplaced,TResult Function( String id,  String? name,  bool? isPublished,  bool? isLocked)?  metaUpdated,TResult Function( String id)?  deleted,TResult Function()?  messageConsumed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TieSheetListRequested() when listRequested != null:
return listRequested(_that.tournamentId);case TieSheetDetailRequested() when detailRequested != null:
return detailRequested(_that.id);case TieSheetGenerateSubmitted() when generateSubmitted != null:
return generateSubmitted(_that.tournamentId,_that.name,_that.seedingMethod,_that.seeds,_that.thirdPlaceMatch);case TieSheetManualSubmitted() when manualSubmitted != null:
return manualSubmitted(_that.tournamentId,_that.name,_that.pairings,_that.thirdPlaceMatch);case TieSheetPairingsReplaced() when pairingsReplaced != null:
return pairingsReplaced(_that.id,_that.pairings,_that.thirdPlaceMatch);case TieSheetMetaUpdated() when metaUpdated != null:
return metaUpdated(_that.id,_that.name,_that.isPublished,_that.isLocked);case TieSheetDeleted() when deleted != null:
return deleted(_that.id);case TieSheetMessageConsumed() when messageConsumed != null:
return messageConsumed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String tournamentId)  listRequested,required TResult Function( String id)  detailRequested,required TResult Function( String tournamentId,  String? name,  String seedingMethod,  List<String> seeds,  bool thirdPlaceMatch)  generateSubmitted,required TResult Function( String tournamentId,  String? name,  List<Pairing> pairings,  bool thirdPlaceMatch)  manualSubmitted,required TResult Function( String id,  List<Pairing> pairings,  bool? thirdPlaceMatch)  pairingsReplaced,required TResult Function( String id,  String? name,  bool? isPublished,  bool? isLocked)  metaUpdated,required TResult Function( String id)  deleted,required TResult Function()  messageConsumed,}) {final _that = this;
switch (_that) {
case TieSheetListRequested():
return listRequested(_that.tournamentId);case TieSheetDetailRequested():
return detailRequested(_that.id);case TieSheetGenerateSubmitted():
return generateSubmitted(_that.tournamentId,_that.name,_that.seedingMethod,_that.seeds,_that.thirdPlaceMatch);case TieSheetManualSubmitted():
return manualSubmitted(_that.tournamentId,_that.name,_that.pairings,_that.thirdPlaceMatch);case TieSheetPairingsReplaced():
return pairingsReplaced(_that.id,_that.pairings,_that.thirdPlaceMatch);case TieSheetMetaUpdated():
return metaUpdated(_that.id,_that.name,_that.isPublished,_that.isLocked);case TieSheetDeleted():
return deleted(_that.id);case TieSheetMessageConsumed():
return messageConsumed();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String tournamentId)?  listRequested,TResult? Function( String id)?  detailRequested,TResult? Function( String tournamentId,  String? name,  String seedingMethod,  List<String> seeds,  bool thirdPlaceMatch)?  generateSubmitted,TResult? Function( String tournamentId,  String? name,  List<Pairing> pairings,  bool thirdPlaceMatch)?  manualSubmitted,TResult? Function( String id,  List<Pairing> pairings,  bool? thirdPlaceMatch)?  pairingsReplaced,TResult? Function( String id,  String? name,  bool? isPublished,  bool? isLocked)?  metaUpdated,TResult? Function( String id)?  deleted,TResult? Function()?  messageConsumed,}) {final _that = this;
switch (_that) {
case TieSheetListRequested() when listRequested != null:
return listRequested(_that.tournamentId);case TieSheetDetailRequested() when detailRequested != null:
return detailRequested(_that.id);case TieSheetGenerateSubmitted() when generateSubmitted != null:
return generateSubmitted(_that.tournamentId,_that.name,_that.seedingMethod,_that.seeds,_that.thirdPlaceMatch);case TieSheetManualSubmitted() when manualSubmitted != null:
return manualSubmitted(_that.tournamentId,_that.name,_that.pairings,_that.thirdPlaceMatch);case TieSheetPairingsReplaced() when pairingsReplaced != null:
return pairingsReplaced(_that.id,_that.pairings,_that.thirdPlaceMatch);case TieSheetMetaUpdated() when metaUpdated != null:
return metaUpdated(_that.id,_that.name,_that.isPublished,_that.isLocked);case TieSheetDeleted() when deleted != null:
return deleted(_that.id);case TieSheetMessageConsumed() when messageConsumed != null:
return messageConsumed();case _:
  return null;

}
}

}

/// @nodoc


class TieSheetListRequested implements TieSheetEvent {
  const TieSheetListRequested(this.tournamentId);
  

 final  String tournamentId;

/// Create a copy of TieSheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TieSheetListRequestedCopyWith<TieSheetListRequested> get copyWith => _$TieSheetListRequestedCopyWithImpl<TieSheetListRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TieSheetListRequested&&(identical(other.tournamentId, tournamentId) || other.tournamentId == tournamentId));
}


@override
int get hashCode => Object.hash(runtimeType,tournamentId);

@override
String toString() {
  return 'TieSheetEvent.listRequested(tournamentId: $tournamentId)';
}


}

/// @nodoc
abstract mixin class $TieSheetListRequestedCopyWith<$Res> implements $TieSheetEventCopyWith<$Res> {
  factory $TieSheetListRequestedCopyWith(TieSheetListRequested value, $Res Function(TieSheetListRequested) _then) = _$TieSheetListRequestedCopyWithImpl;
@useResult
$Res call({
 String tournamentId
});




}
/// @nodoc
class _$TieSheetListRequestedCopyWithImpl<$Res>
    implements $TieSheetListRequestedCopyWith<$Res> {
  _$TieSheetListRequestedCopyWithImpl(this._self, this._then);

  final TieSheetListRequested _self;
  final $Res Function(TieSheetListRequested) _then;

/// Create a copy of TieSheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tournamentId = null,}) {
  return _then(TieSheetListRequested(
null == tournamentId ? _self.tournamentId : tournamentId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TieSheetDetailRequested implements TieSheetEvent {
  const TieSheetDetailRequested(this.id);
  

 final  String id;

/// Create a copy of TieSheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TieSheetDetailRequestedCopyWith<TieSheetDetailRequested> get copyWith => _$TieSheetDetailRequestedCopyWithImpl<TieSheetDetailRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TieSheetDetailRequested&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'TieSheetEvent.detailRequested(id: $id)';
}


}

/// @nodoc
abstract mixin class $TieSheetDetailRequestedCopyWith<$Res> implements $TieSheetEventCopyWith<$Res> {
  factory $TieSheetDetailRequestedCopyWith(TieSheetDetailRequested value, $Res Function(TieSheetDetailRequested) _then) = _$TieSheetDetailRequestedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$TieSheetDetailRequestedCopyWithImpl<$Res>
    implements $TieSheetDetailRequestedCopyWith<$Res> {
  _$TieSheetDetailRequestedCopyWithImpl(this._self, this._then);

  final TieSheetDetailRequested _self;
  final $Res Function(TieSheetDetailRequested) _then;

/// Create a copy of TieSheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(TieSheetDetailRequested(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TieSheetGenerateSubmitted implements TieSheetEvent {
  const TieSheetGenerateSubmitted({required this.tournamentId, this.name, this.seedingMethod = 'random', final  List<String> seeds = const [], this.thirdPlaceMatch = false}): _seeds = seeds;
  

 final  String tournamentId;
 final  String? name;
@JsonKey() final  String seedingMethod;
 final  List<String> _seeds;
@JsonKey() List<String> get seeds {
  if (_seeds is EqualUnmodifiableListView) return _seeds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_seeds);
}

@JsonKey() final  bool thirdPlaceMatch;

/// Create a copy of TieSheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TieSheetGenerateSubmittedCopyWith<TieSheetGenerateSubmitted> get copyWith => _$TieSheetGenerateSubmittedCopyWithImpl<TieSheetGenerateSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TieSheetGenerateSubmitted&&(identical(other.tournamentId, tournamentId) || other.tournamentId == tournamentId)&&(identical(other.name, name) || other.name == name)&&(identical(other.seedingMethod, seedingMethod) || other.seedingMethod == seedingMethod)&&const DeepCollectionEquality().equals(other._seeds, _seeds)&&(identical(other.thirdPlaceMatch, thirdPlaceMatch) || other.thirdPlaceMatch == thirdPlaceMatch));
}


@override
int get hashCode => Object.hash(runtimeType,tournamentId,name,seedingMethod,const DeepCollectionEquality().hash(_seeds),thirdPlaceMatch);

@override
String toString() {
  return 'TieSheetEvent.generateSubmitted(tournamentId: $tournamentId, name: $name, seedingMethod: $seedingMethod, seeds: $seeds, thirdPlaceMatch: $thirdPlaceMatch)';
}


}

/// @nodoc
abstract mixin class $TieSheetGenerateSubmittedCopyWith<$Res> implements $TieSheetEventCopyWith<$Res> {
  factory $TieSheetGenerateSubmittedCopyWith(TieSheetGenerateSubmitted value, $Res Function(TieSheetGenerateSubmitted) _then) = _$TieSheetGenerateSubmittedCopyWithImpl;
@useResult
$Res call({
 String tournamentId, String? name, String seedingMethod, List<String> seeds, bool thirdPlaceMatch
});




}
/// @nodoc
class _$TieSheetGenerateSubmittedCopyWithImpl<$Res>
    implements $TieSheetGenerateSubmittedCopyWith<$Res> {
  _$TieSheetGenerateSubmittedCopyWithImpl(this._self, this._then);

  final TieSheetGenerateSubmitted _self;
  final $Res Function(TieSheetGenerateSubmitted) _then;

/// Create a copy of TieSheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tournamentId = null,Object? name = freezed,Object? seedingMethod = null,Object? seeds = null,Object? thirdPlaceMatch = null,}) {
  return _then(TieSheetGenerateSubmitted(
tournamentId: null == tournamentId ? _self.tournamentId : tournamentId // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,seedingMethod: null == seedingMethod ? _self.seedingMethod : seedingMethod // ignore: cast_nullable_to_non_nullable
as String,seeds: null == seeds ? _self._seeds : seeds // ignore: cast_nullable_to_non_nullable
as List<String>,thirdPlaceMatch: null == thirdPlaceMatch ? _self.thirdPlaceMatch : thirdPlaceMatch // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class TieSheetManualSubmitted implements TieSheetEvent {
  const TieSheetManualSubmitted({required this.tournamentId, this.name, required final  List<Pairing> pairings, this.thirdPlaceMatch = false}): _pairings = pairings;
  

 final  String tournamentId;
 final  String? name;
 final  List<Pairing> _pairings;
 List<Pairing> get pairings {
  if (_pairings is EqualUnmodifiableListView) return _pairings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pairings);
}

@JsonKey() final  bool thirdPlaceMatch;

/// Create a copy of TieSheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TieSheetManualSubmittedCopyWith<TieSheetManualSubmitted> get copyWith => _$TieSheetManualSubmittedCopyWithImpl<TieSheetManualSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TieSheetManualSubmitted&&(identical(other.tournamentId, tournamentId) || other.tournamentId == tournamentId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._pairings, _pairings)&&(identical(other.thirdPlaceMatch, thirdPlaceMatch) || other.thirdPlaceMatch == thirdPlaceMatch));
}


@override
int get hashCode => Object.hash(runtimeType,tournamentId,name,const DeepCollectionEquality().hash(_pairings),thirdPlaceMatch);

@override
String toString() {
  return 'TieSheetEvent.manualSubmitted(tournamentId: $tournamentId, name: $name, pairings: $pairings, thirdPlaceMatch: $thirdPlaceMatch)';
}


}

/// @nodoc
abstract mixin class $TieSheetManualSubmittedCopyWith<$Res> implements $TieSheetEventCopyWith<$Res> {
  factory $TieSheetManualSubmittedCopyWith(TieSheetManualSubmitted value, $Res Function(TieSheetManualSubmitted) _then) = _$TieSheetManualSubmittedCopyWithImpl;
@useResult
$Res call({
 String tournamentId, String? name, List<Pairing> pairings, bool thirdPlaceMatch
});




}
/// @nodoc
class _$TieSheetManualSubmittedCopyWithImpl<$Res>
    implements $TieSheetManualSubmittedCopyWith<$Res> {
  _$TieSheetManualSubmittedCopyWithImpl(this._self, this._then);

  final TieSheetManualSubmitted _self;
  final $Res Function(TieSheetManualSubmitted) _then;

/// Create a copy of TieSheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tournamentId = null,Object? name = freezed,Object? pairings = null,Object? thirdPlaceMatch = null,}) {
  return _then(TieSheetManualSubmitted(
tournamentId: null == tournamentId ? _self.tournamentId : tournamentId // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,pairings: null == pairings ? _self._pairings : pairings // ignore: cast_nullable_to_non_nullable
as List<Pairing>,thirdPlaceMatch: null == thirdPlaceMatch ? _self.thirdPlaceMatch : thirdPlaceMatch // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class TieSheetPairingsReplaced implements TieSheetEvent {
  const TieSheetPairingsReplaced({required this.id, required final  List<Pairing> pairings, this.thirdPlaceMatch}): _pairings = pairings;
  

 final  String id;
 final  List<Pairing> _pairings;
 List<Pairing> get pairings {
  if (_pairings is EqualUnmodifiableListView) return _pairings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pairings);
}

 final  bool? thirdPlaceMatch;

/// Create a copy of TieSheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TieSheetPairingsReplacedCopyWith<TieSheetPairingsReplaced> get copyWith => _$TieSheetPairingsReplacedCopyWithImpl<TieSheetPairingsReplaced>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TieSheetPairingsReplaced&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._pairings, _pairings)&&(identical(other.thirdPlaceMatch, thirdPlaceMatch) || other.thirdPlaceMatch == thirdPlaceMatch));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_pairings),thirdPlaceMatch);

@override
String toString() {
  return 'TieSheetEvent.pairingsReplaced(id: $id, pairings: $pairings, thirdPlaceMatch: $thirdPlaceMatch)';
}


}

/// @nodoc
abstract mixin class $TieSheetPairingsReplacedCopyWith<$Res> implements $TieSheetEventCopyWith<$Res> {
  factory $TieSheetPairingsReplacedCopyWith(TieSheetPairingsReplaced value, $Res Function(TieSheetPairingsReplaced) _then) = _$TieSheetPairingsReplacedCopyWithImpl;
@useResult
$Res call({
 String id, List<Pairing> pairings, bool? thirdPlaceMatch
});




}
/// @nodoc
class _$TieSheetPairingsReplacedCopyWithImpl<$Res>
    implements $TieSheetPairingsReplacedCopyWith<$Res> {
  _$TieSheetPairingsReplacedCopyWithImpl(this._self, this._then);

  final TieSheetPairingsReplaced _self;
  final $Res Function(TieSheetPairingsReplaced) _then;

/// Create a copy of TieSheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? pairings = null,Object? thirdPlaceMatch = freezed,}) {
  return _then(TieSheetPairingsReplaced(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,pairings: null == pairings ? _self._pairings : pairings // ignore: cast_nullable_to_non_nullable
as List<Pairing>,thirdPlaceMatch: freezed == thirdPlaceMatch ? _self.thirdPlaceMatch : thirdPlaceMatch // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

/// @nodoc


class TieSheetMetaUpdated implements TieSheetEvent {
  const TieSheetMetaUpdated({required this.id, this.name, this.isPublished, this.isLocked});
  

 final  String id;
 final  String? name;
 final  bool? isPublished;
 final  bool? isLocked;

/// Create a copy of TieSheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TieSheetMetaUpdatedCopyWith<TieSheetMetaUpdated> get copyWith => _$TieSheetMetaUpdatedCopyWithImpl<TieSheetMetaUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TieSheetMetaUpdated&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,isPublished,isLocked);

@override
String toString() {
  return 'TieSheetEvent.metaUpdated(id: $id, name: $name, isPublished: $isPublished, isLocked: $isLocked)';
}


}

/// @nodoc
abstract mixin class $TieSheetMetaUpdatedCopyWith<$Res> implements $TieSheetEventCopyWith<$Res> {
  factory $TieSheetMetaUpdatedCopyWith(TieSheetMetaUpdated value, $Res Function(TieSheetMetaUpdated) _then) = _$TieSheetMetaUpdatedCopyWithImpl;
@useResult
$Res call({
 String id, String? name, bool? isPublished, bool? isLocked
});




}
/// @nodoc
class _$TieSheetMetaUpdatedCopyWithImpl<$Res>
    implements $TieSheetMetaUpdatedCopyWith<$Res> {
  _$TieSheetMetaUpdatedCopyWithImpl(this._self, this._then);

  final TieSheetMetaUpdated _self;
  final $Res Function(TieSheetMetaUpdated) _then;

/// Create a copy of TieSheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? isPublished = freezed,Object? isLocked = freezed,}) {
  return _then(TieSheetMetaUpdated(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,isPublished: freezed == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool?,isLocked: freezed == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

/// @nodoc


class TieSheetDeleted implements TieSheetEvent {
  const TieSheetDeleted(this.id);
  

 final  String id;

/// Create a copy of TieSheetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TieSheetDeletedCopyWith<TieSheetDeleted> get copyWith => _$TieSheetDeletedCopyWithImpl<TieSheetDeleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TieSheetDeleted&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'TieSheetEvent.deleted(id: $id)';
}


}

/// @nodoc
abstract mixin class $TieSheetDeletedCopyWith<$Res> implements $TieSheetEventCopyWith<$Res> {
  factory $TieSheetDeletedCopyWith(TieSheetDeleted value, $Res Function(TieSheetDeleted) _then) = _$TieSheetDeletedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$TieSheetDeletedCopyWithImpl<$Res>
    implements $TieSheetDeletedCopyWith<$Res> {
  _$TieSheetDeletedCopyWithImpl(this._self, this._then);

  final TieSheetDeleted _self;
  final $Res Function(TieSheetDeleted) _then;

/// Create a copy of TieSheetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(TieSheetDeleted(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TieSheetMessageConsumed implements TieSheetEvent {
  const TieSheetMessageConsumed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TieSheetMessageConsumed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TieSheetEvent.messageConsumed()';
}


}




// dart format on
