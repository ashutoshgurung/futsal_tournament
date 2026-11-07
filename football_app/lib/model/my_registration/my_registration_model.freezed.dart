// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_registration_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MyRegistrationModel {

 String get id; String get tournamentName; String get teamName; String get location; DateTime get tournamentDate; DateTime get registeredAt; String get registrationStatus; String get paymentStatus; String get captainName; String get captainPhone; String get registrationFee; List<String> get players;
/// Create a copy of MyRegistrationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyRegistrationModelCopyWith<MyRegistrationModel> get copyWith => _$MyRegistrationModelCopyWithImpl<MyRegistrationModel>(this as MyRegistrationModel, _$identity);

  /// Serializes this MyRegistrationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyRegistrationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tournamentName, tournamentName) || other.tournamentName == tournamentName)&&(identical(other.teamName, teamName) || other.teamName == teamName)&&(identical(other.location, location) || other.location == location)&&(identical(other.tournamentDate, tournamentDate) || other.tournamentDate == tournamentDate)&&(identical(other.registeredAt, registeredAt) || other.registeredAt == registeredAt)&&(identical(other.registrationStatus, registrationStatus) || other.registrationStatus == registrationStatus)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.captainName, captainName) || other.captainName == captainName)&&(identical(other.captainPhone, captainPhone) || other.captainPhone == captainPhone)&&(identical(other.registrationFee, registrationFee) || other.registrationFee == registrationFee)&&const DeepCollectionEquality().equals(other.players, players));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tournamentName,teamName,location,tournamentDate,registeredAt,registrationStatus,paymentStatus,captainName,captainPhone,registrationFee,const DeepCollectionEquality().hash(players));

@override
String toString() {
  return 'MyRegistrationModel(id: $id, tournamentName: $tournamentName, teamName: $teamName, location: $location, tournamentDate: $tournamentDate, registeredAt: $registeredAt, registrationStatus: $registrationStatus, paymentStatus: $paymentStatus, captainName: $captainName, captainPhone: $captainPhone, registrationFee: $registrationFee, players: $players)';
}


}

/// @nodoc
abstract mixin class $MyRegistrationModelCopyWith<$Res>  {
  factory $MyRegistrationModelCopyWith(MyRegistrationModel value, $Res Function(MyRegistrationModel) _then) = _$MyRegistrationModelCopyWithImpl;
@useResult
$Res call({
 String id, String tournamentName, String teamName, String location, DateTime tournamentDate, DateTime registeredAt, String registrationStatus, String paymentStatus, String captainName, String captainPhone, String registrationFee, List<String> players
});




}
/// @nodoc
class _$MyRegistrationModelCopyWithImpl<$Res>
    implements $MyRegistrationModelCopyWith<$Res> {
  _$MyRegistrationModelCopyWithImpl(this._self, this._then);

  final MyRegistrationModel _self;
  final $Res Function(MyRegistrationModel) _then;

/// Create a copy of MyRegistrationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tournamentName = null,Object? teamName = null,Object? location = null,Object? tournamentDate = null,Object? registeredAt = null,Object? registrationStatus = null,Object? paymentStatus = null,Object? captainName = null,Object? captainPhone = null,Object? registrationFee = null,Object? players = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tournamentName: null == tournamentName ? _self.tournamentName : tournamentName // ignore: cast_nullable_to_non_nullable
as String,teamName: null == teamName ? _self.teamName : teamName // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,tournamentDate: null == tournamentDate ? _self.tournamentDate : tournamentDate // ignore: cast_nullable_to_non_nullable
as DateTime,registeredAt: null == registeredAt ? _self.registeredAt : registeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,registrationStatus: null == registrationStatus ? _self.registrationStatus : registrationStatus // ignore: cast_nullable_to_non_nullable
as String,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,captainName: null == captainName ? _self.captainName : captainName // ignore: cast_nullable_to_non_nullable
as String,captainPhone: null == captainPhone ? _self.captainPhone : captainPhone // ignore: cast_nullable_to_non_nullable
as String,registrationFee: null == registrationFee ? _self.registrationFee : registrationFee // ignore: cast_nullable_to_non_nullable
as String,players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [MyRegistrationModel].
extension MyRegistrationModelPatterns on MyRegistrationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyRegistrationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyRegistrationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyRegistrationModel value)  $default,){
final _that = this;
switch (_that) {
case _MyRegistrationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyRegistrationModel value)?  $default,){
final _that = this;
switch (_that) {
case _MyRegistrationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tournamentName,  String teamName,  String location,  DateTime tournamentDate,  DateTime registeredAt,  String registrationStatus,  String paymentStatus,  String captainName,  String captainPhone,  String registrationFee,  List<String> players)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyRegistrationModel() when $default != null:
return $default(_that.id,_that.tournamentName,_that.teamName,_that.location,_that.tournamentDate,_that.registeredAt,_that.registrationStatus,_that.paymentStatus,_that.captainName,_that.captainPhone,_that.registrationFee,_that.players);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tournamentName,  String teamName,  String location,  DateTime tournamentDate,  DateTime registeredAt,  String registrationStatus,  String paymentStatus,  String captainName,  String captainPhone,  String registrationFee,  List<String> players)  $default,) {final _that = this;
switch (_that) {
case _MyRegistrationModel():
return $default(_that.id,_that.tournamentName,_that.teamName,_that.location,_that.tournamentDate,_that.registeredAt,_that.registrationStatus,_that.paymentStatus,_that.captainName,_that.captainPhone,_that.registrationFee,_that.players);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tournamentName,  String teamName,  String location,  DateTime tournamentDate,  DateTime registeredAt,  String registrationStatus,  String paymentStatus,  String captainName,  String captainPhone,  String registrationFee,  List<String> players)?  $default,) {final _that = this;
switch (_that) {
case _MyRegistrationModel() when $default != null:
return $default(_that.id,_that.tournamentName,_that.teamName,_that.location,_that.tournamentDate,_that.registeredAt,_that.registrationStatus,_that.paymentStatus,_that.captainName,_that.captainPhone,_that.registrationFee,_that.players);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyRegistrationModel implements MyRegistrationModel {
  const _MyRegistrationModel({required this.id, required this.tournamentName, required this.teamName, required this.location, required this.tournamentDate, required this.registeredAt, required this.registrationStatus, required this.paymentStatus, required this.captainName, required this.captainPhone, required this.registrationFee, required final  List<String> players}): _players = players;
  factory _MyRegistrationModel.fromJson(Map<String, dynamic> json) => _$MyRegistrationModelFromJson(json);

@override final  String id;
@override final  String tournamentName;
@override final  String teamName;
@override final  String location;
@override final  DateTime tournamentDate;
@override final  DateTime registeredAt;
@override final  String registrationStatus;
@override final  String paymentStatus;
@override final  String captainName;
@override final  String captainPhone;
@override final  String registrationFee;
 final  List<String> _players;
@override List<String> get players {
  if (_players is EqualUnmodifiableListView) return _players;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_players);
}


/// Create a copy of MyRegistrationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyRegistrationModelCopyWith<_MyRegistrationModel> get copyWith => __$MyRegistrationModelCopyWithImpl<_MyRegistrationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyRegistrationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyRegistrationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tournamentName, tournamentName) || other.tournamentName == tournamentName)&&(identical(other.teamName, teamName) || other.teamName == teamName)&&(identical(other.location, location) || other.location == location)&&(identical(other.tournamentDate, tournamentDate) || other.tournamentDate == tournamentDate)&&(identical(other.registeredAt, registeredAt) || other.registeredAt == registeredAt)&&(identical(other.registrationStatus, registrationStatus) || other.registrationStatus == registrationStatus)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.captainName, captainName) || other.captainName == captainName)&&(identical(other.captainPhone, captainPhone) || other.captainPhone == captainPhone)&&(identical(other.registrationFee, registrationFee) || other.registrationFee == registrationFee)&&const DeepCollectionEquality().equals(other._players, _players));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tournamentName,teamName,location,tournamentDate,registeredAt,registrationStatus,paymentStatus,captainName,captainPhone,registrationFee,const DeepCollectionEquality().hash(_players));

@override
String toString() {
  return 'MyRegistrationModel(id: $id, tournamentName: $tournamentName, teamName: $teamName, location: $location, tournamentDate: $tournamentDate, registeredAt: $registeredAt, registrationStatus: $registrationStatus, paymentStatus: $paymentStatus, captainName: $captainName, captainPhone: $captainPhone, registrationFee: $registrationFee, players: $players)';
}


}

/// @nodoc
abstract mixin class _$MyRegistrationModelCopyWith<$Res> implements $MyRegistrationModelCopyWith<$Res> {
  factory _$MyRegistrationModelCopyWith(_MyRegistrationModel value, $Res Function(_MyRegistrationModel) _then) = __$MyRegistrationModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String tournamentName, String teamName, String location, DateTime tournamentDate, DateTime registeredAt, String registrationStatus, String paymentStatus, String captainName, String captainPhone, String registrationFee, List<String> players
});




}
/// @nodoc
class __$MyRegistrationModelCopyWithImpl<$Res>
    implements _$MyRegistrationModelCopyWith<$Res> {
  __$MyRegistrationModelCopyWithImpl(this._self, this._then);

  final _MyRegistrationModel _self;
  final $Res Function(_MyRegistrationModel) _then;

/// Create a copy of MyRegistrationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tournamentName = null,Object? teamName = null,Object? location = null,Object? tournamentDate = null,Object? registeredAt = null,Object? registrationStatus = null,Object? paymentStatus = null,Object? captainName = null,Object? captainPhone = null,Object? registrationFee = null,Object? players = null,}) {
  return _then(_MyRegistrationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tournamentName: null == tournamentName ? _self.tournamentName : tournamentName // ignore: cast_nullable_to_non_nullable
as String,teamName: null == teamName ? _self.teamName : teamName // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,tournamentDate: null == tournamentDate ? _self.tournamentDate : tournamentDate // ignore: cast_nullable_to_non_nullable
as DateTime,registeredAt: null == registeredAt ? _self.registeredAt : registeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,registrationStatus: null == registrationStatus ? _self.registrationStatus : registrationStatus // ignore: cast_nullable_to_non_nullable
as String,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,captainName: null == captainName ? _self.captainName : captainName // ignore: cast_nullable_to_non_nullable
as String,captainPhone: null == captainPhone ? _self.captainPhone : captainPhone // ignore: cast_nullable_to_non_nullable
as String,registrationFee: null == registrationFee ? _self.registrationFee : registrationFee // ignore: cast_nullable_to_non_nullable
as String,players: null == players ? _self._players : players // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
