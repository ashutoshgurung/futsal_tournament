// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organizer_register_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrganizerRegisterEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizerRegisterEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrganizerRegisterEvent()';
}


}

/// @nodoc
class $OrganizerRegisterEventCopyWith<$Res>  {
$OrganizerRegisterEventCopyWith(OrganizerRegisterEvent _, $Res Function(OrganizerRegisterEvent) __);
}


/// Adds pattern-matching-related methods to [OrganizerRegisterEvent].
extension OrganizerRegisterEventPatterns on OrganizerRegisterEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OrganizerRegisterSubmitted value)?  submitted,TResult Function( OrganizerPasswordVisibilityToggled value)?  passwordVisibilityToggled,TResult Function( OrganizerTermsChanged value)?  termsChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OrganizerRegisterSubmitted() when submitted != null:
return submitted(_that);case OrganizerPasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled(_that);case OrganizerTermsChanged() when termsChanged != null:
return termsChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OrganizerRegisterSubmitted value)  submitted,required TResult Function( OrganizerPasswordVisibilityToggled value)  passwordVisibilityToggled,required TResult Function( OrganizerTermsChanged value)  termsChanged,}){
final _that = this;
switch (_that) {
case OrganizerRegisterSubmitted():
return submitted(_that);case OrganizerPasswordVisibilityToggled():
return passwordVisibilityToggled(_that);case OrganizerTermsChanged():
return termsChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OrganizerRegisterSubmitted value)?  submitted,TResult? Function( OrganizerPasswordVisibilityToggled value)?  passwordVisibilityToggled,TResult? Function( OrganizerTermsChanged value)?  termsChanged,}){
final _that = this;
switch (_that) {
case OrganizerRegisterSubmitted() when submitted != null:
return submitted(_that);case OrganizerPasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled(_that);case OrganizerTermsChanged() when termsChanged != null:
return termsChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String organizationName,  String contactEmail,  String logoUrl,  String userName,  String email,  String password)?  submitted,TResult Function()?  passwordVisibilityToggled,TResult Function( bool agreed)?  termsChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OrganizerRegisterSubmitted() when submitted != null:
return submitted(_that.organizationName,_that.contactEmail,_that.logoUrl,_that.userName,_that.email,_that.password);case OrganizerPasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled();case OrganizerTermsChanged() when termsChanged != null:
return termsChanged(_that.agreed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String organizationName,  String contactEmail,  String logoUrl,  String userName,  String email,  String password)  submitted,required TResult Function()  passwordVisibilityToggled,required TResult Function( bool agreed)  termsChanged,}) {final _that = this;
switch (_that) {
case OrganizerRegisterSubmitted():
return submitted(_that.organizationName,_that.contactEmail,_that.logoUrl,_that.userName,_that.email,_that.password);case OrganizerPasswordVisibilityToggled():
return passwordVisibilityToggled();case OrganizerTermsChanged():
return termsChanged(_that.agreed);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String organizationName,  String contactEmail,  String logoUrl,  String userName,  String email,  String password)?  submitted,TResult? Function()?  passwordVisibilityToggled,TResult? Function( bool agreed)?  termsChanged,}) {final _that = this;
switch (_that) {
case OrganizerRegisterSubmitted() when submitted != null:
return submitted(_that.organizationName,_that.contactEmail,_that.logoUrl,_that.userName,_that.email,_that.password);case OrganizerPasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled();case OrganizerTermsChanged() when termsChanged != null:
return termsChanged(_that.agreed);case _:
  return null;

}
}

}

/// @nodoc


class OrganizerRegisterSubmitted implements OrganizerRegisterEvent {
  const OrganizerRegisterSubmitted({required this.organizationName, required this.contactEmail, required this.logoUrl, required this.userName, required this.email, required this.password});
  

 final  String organizationName;
 final  String contactEmail;
 final  String logoUrl;
 final  String userName;
 final  String email;
 final  String password;

/// Create a copy of OrganizerRegisterEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganizerRegisterSubmittedCopyWith<OrganizerRegisterSubmitted> get copyWith => _$OrganizerRegisterSubmittedCopyWithImpl<OrganizerRegisterSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizerRegisterSubmitted&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,organizationName,contactEmail,logoUrl,userName,email,password);

@override
String toString() {
  return 'OrganizerRegisterEvent.submitted(organizationName: $organizationName, contactEmail: $contactEmail, logoUrl: $logoUrl, userName: $userName, email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $OrganizerRegisterSubmittedCopyWith<$Res> implements $OrganizerRegisterEventCopyWith<$Res> {
  factory $OrganizerRegisterSubmittedCopyWith(OrganizerRegisterSubmitted value, $Res Function(OrganizerRegisterSubmitted) _then) = _$OrganizerRegisterSubmittedCopyWithImpl;
@useResult
$Res call({
 String organizationName, String contactEmail, String logoUrl, String userName, String email, String password
});




}
/// @nodoc
class _$OrganizerRegisterSubmittedCopyWithImpl<$Res>
    implements $OrganizerRegisterSubmittedCopyWith<$Res> {
  _$OrganizerRegisterSubmittedCopyWithImpl(this._self, this._then);

  final OrganizerRegisterSubmitted _self;
  final $Res Function(OrganizerRegisterSubmitted) _then;

/// Create a copy of OrganizerRegisterEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? organizationName = null,Object? contactEmail = null,Object? logoUrl = null,Object? userName = null,Object? email = null,Object? password = null,}) {
  return _then(OrganizerRegisterSubmitted(
organizationName: null == organizationName ? _self.organizationName : organizationName // ignore: cast_nullable_to_non_nullable
as String,contactEmail: null == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String,logoUrl: null == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OrganizerPasswordVisibilityToggled implements OrganizerRegisterEvent {
  const OrganizerPasswordVisibilityToggled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizerPasswordVisibilityToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrganizerRegisterEvent.passwordVisibilityToggled()';
}


}




/// @nodoc


class OrganizerTermsChanged implements OrganizerRegisterEvent {
  const OrganizerTermsChanged(this.agreed);
  

 final  bool agreed;

/// Create a copy of OrganizerRegisterEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganizerTermsChangedCopyWith<OrganizerTermsChanged> get copyWith => _$OrganizerTermsChangedCopyWithImpl<OrganizerTermsChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizerTermsChanged&&(identical(other.agreed, agreed) || other.agreed == agreed));
}


@override
int get hashCode => Object.hash(runtimeType,agreed);

@override
String toString() {
  return 'OrganizerRegisterEvent.termsChanged(agreed: $agreed)';
}


}

/// @nodoc
abstract mixin class $OrganizerTermsChangedCopyWith<$Res> implements $OrganizerRegisterEventCopyWith<$Res> {
  factory $OrganizerTermsChangedCopyWith(OrganizerTermsChanged value, $Res Function(OrganizerTermsChanged) _then) = _$OrganizerTermsChangedCopyWithImpl;
@useResult
$Res call({
 bool agreed
});




}
/// @nodoc
class _$OrganizerTermsChangedCopyWithImpl<$Res>
    implements $OrganizerTermsChangedCopyWith<$Res> {
  _$OrganizerTermsChangedCopyWithImpl(this._self, this._then);

  final OrganizerTermsChanged _self;
  final $Res Function(OrganizerTermsChanged) _then;

/// Create a copy of OrganizerRegisterEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? agreed = null,}) {
  return _then(OrganizerTermsChanged(
null == agreed ? _self.agreed : agreed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
