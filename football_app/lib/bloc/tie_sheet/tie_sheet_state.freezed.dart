// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tie_sheet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TieSheetState {

 TieSheetStatus get listStatus; TieSheetStatus get detailStatus; TieSheetStatus get submitStatus; List<TieSheet> get sheets; TieSheet? get selected; TieSheetAction get lastAction; String? get errorMessage;
/// Create a copy of TieSheetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TieSheetStateCopyWith<TieSheetState> get copyWith => _$TieSheetStateCopyWithImpl<TieSheetState>(this as TieSheetState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TieSheetState&&(identical(other.listStatus, listStatus) || other.listStatus == listStatus)&&(identical(other.detailStatus, detailStatus) || other.detailStatus == detailStatus)&&(identical(other.submitStatus, submitStatus) || other.submitStatus == submitStatus)&&const DeepCollectionEquality().equals(other.sheets, sheets)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.lastAction, lastAction) || other.lastAction == lastAction)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,listStatus,detailStatus,submitStatus,const DeepCollectionEquality().hash(sheets),selected,lastAction,errorMessage);

@override
String toString() {
  return 'TieSheetState(listStatus: $listStatus, detailStatus: $detailStatus, submitStatus: $submitStatus, sheets: $sheets, selected: $selected, lastAction: $lastAction, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TieSheetStateCopyWith<$Res>  {
  factory $TieSheetStateCopyWith(TieSheetState value, $Res Function(TieSheetState) _then) = _$TieSheetStateCopyWithImpl;
@useResult
$Res call({
 TieSheetStatus listStatus, TieSheetStatus detailStatus, TieSheetStatus submitStatus, List<TieSheet> sheets, TieSheet? selected, TieSheetAction lastAction, String? errorMessage
});


$TieSheetCopyWith<$Res>? get selected;

}
/// @nodoc
class _$TieSheetStateCopyWithImpl<$Res>
    implements $TieSheetStateCopyWith<$Res> {
  _$TieSheetStateCopyWithImpl(this._self, this._then);

  final TieSheetState _self;
  final $Res Function(TieSheetState) _then;

/// Create a copy of TieSheetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listStatus = null,Object? detailStatus = null,Object? submitStatus = null,Object? sheets = null,Object? selected = freezed,Object? lastAction = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
listStatus: null == listStatus ? _self.listStatus : listStatus // ignore: cast_nullable_to_non_nullable
as TieSheetStatus,detailStatus: null == detailStatus ? _self.detailStatus : detailStatus // ignore: cast_nullable_to_non_nullable
as TieSheetStatus,submitStatus: null == submitStatus ? _self.submitStatus : submitStatus // ignore: cast_nullable_to_non_nullable
as TieSheetStatus,sheets: null == sheets ? _self.sheets : sheets // ignore: cast_nullable_to_non_nullable
as List<TieSheet>,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as TieSheet?,lastAction: null == lastAction ? _self.lastAction : lastAction // ignore: cast_nullable_to_non_nullable
as TieSheetAction,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TieSheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TieSheetCopyWith<$Res>? get selected {
    if (_self.selected == null) {
    return null;
  }

  return $TieSheetCopyWith<$Res>(_self.selected!, (value) {
    return _then(_self.copyWith(selected: value));
  });
}
}


/// Adds pattern-matching-related methods to [TieSheetState].
extension TieSheetStatePatterns on TieSheetState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TieSheetState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TieSheetState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TieSheetState value)  $default,){
final _that = this;
switch (_that) {
case _TieSheetState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TieSheetState value)?  $default,){
final _that = this;
switch (_that) {
case _TieSheetState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TieSheetStatus listStatus,  TieSheetStatus detailStatus,  TieSheetStatus submitStatus,  List<TieSheet> sheets,  TieSheet? selected,  TieSheetAction lastAction,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TieSheetState() when $default != null:
return $default(_that.listStatus,_that.detailStatus,_that.submitStatus,_that.sheets,_that.selected,_that.lastAction,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TieSheetStatus listStatus,  TieSheetStatus detailStatus,  TieSheetStatus submitStatus,  List<TieSheet> sheets,  TieSheet? selected,  TieSheetAction lastAction,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TieSheetState():
return $default(_that.listStatus,_that.detailStatus,_that.submitStatus,_that.sheets,_that.selected,_that.lastAction,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TieSheetStatus listStatus,  TieSheetStatus detailStatus,  TieSheetStatus submitStatus,  List<TieSheet> sheets,  TieSheet? selected,  TieSheetAction lastAction,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TieSheetState() when $default != null:
return $default(_that.listStatus,_that.detailStatus,_that.submitStatus,_that.sheets,_that.selected,_that.lastAction,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TieSheetState extends TieSheetState {
  const _TieSheetState({this.listStatus = TieSheetStatus.initial, this.detailStatus = TieSheetStatus.initial, this.submitStatus = TieSheetStatus.initial, final  List<TieSheet> sheets = const [], this.selected, this.lastAction = TieSheetAction.none, this.errorMessage}): _sheets = sheets,super._();
  

@override@JsonKey() final  TieSheetStatus listStatus;
@override@JsonKey() final  TieSheetStatus detailStatus;
@override@JsonKey() final  TieSheetStatus submitStatus;
 final  List<TieSheet> _sheets;
@override@JsonKey() List<TieSheet> get sheets {
  if (_sheets is EqualUnmodifiableListView) return _sheets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sheets);
}

@override final  TieSheet? selected;
@override@JsonKey() final  TieSheetAction lastAction;
@override final  String? errorMessage;

/// Create a copy of TieSheetState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TieSheetStateCopyWith<_TieSheetState> get copyWith => __$TieSheetStateCopyWithImpl<_TieSheetState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TieSheetState&&(identical(other.listStatus, listStatus) || other.listStatus == listStatus)&&(identical(other.detailStatus, detailStatus) || other.detailStatus == detailStatus)&&(identical(other.submitStatus, submitStatus) || other.submitStatus == submitStatus)&&const DeepCollectionEquality().equals(other._sheets, _sheets)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.lastAction, lastAction) || other.lastAction == lastAction)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,listStatus,detailStatus,submitStatus,const DeepCollectionEquality().hash(_sheets),selected,lastAction,errorMessage);

@override
String toString() {
  return 'TieSheetState(listStatus: $listStatus, detailStatus: $detailStatus, submitStatus: $submitStatus, sheets: $sheets, selected: $selected, lastAction: $lastAction, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TieSheetStateCopyWith<$Res> implements $TieSheetStateCopyWith<$Res> {
  factory _$TieSheetStateCopyWith(_TieSheetState value, $Res Function(_TieSheetState) _then) = __$TieSheetStateCopyWithImpl;
@override @useResult
$Res call({
 TieSheetStatus listStatus, TieSheetStatus detailStatus, TieSheetStatus submitStatus, List<TieSheet> sheets, TieSheet? selected, TieSheetAction lastAction, String? errorMessage
});


@override $TieSheetCopyWith<$Res>? get selected;

}
/// @nodoc
class __$TieSheetStateCopyWithImpl<$Res>
    implements _$TieSheetStateCopyWith<$Res> {
  __$TieSheetStateCopyWithImpl(this._self, this._then);

  final _TieSheetState _self;
  final $Res Function(_TieSheetState) _then;

/// Create a copy of TieSheetState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listStatus = null,Object? detailStatus = null,Object? submitStatus = null,Object? sheets = null,Object? selected = freezed,Object? lastAction = null,Object? errorMessage = freezed,}) {
  return _then(_TieSheetState(
listStatus: null == listStatus ? _self.listStatus : listStatus // ignore: cast_nullable_to_non_nullable
as TieSheetStatus,detailStatus: null == detailStatus ? _self.detailStatus : detailStatus // ignore: cast_nullable_to_non_nullable
as TieSheetStatus,submitStatus: null == submitStatus ? _self.submitStatus : submitStatus // ignore: cast_nullable_to_non_nullable
as TieSheetStatus,sheets: null == sheets ? _self._sheets : sheets // ignore: cast_nullable_to_non_nullable
as List<TieSheet>,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as TieSheet?,lastAction: null == lastAction ? _self.lastAction : lastAction // ignore: cast_nullable_to_non_nullable
as TieSheetAction,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TieSheetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TieSheetCopyWith<$Res>? get selected {
    if (_self.selected == null) {
    return null;
  }

  return $TieSheetCopyWith<$Res>(_self.selected!, (value) {
    return _then(_self.copyWith(selected: value));
  });
}
}

// dart format on
