// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_verification_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmailVerificationState {

 BaseState<MessageEntity>? get emailVerificationState; BaseState<MessageEntity>? get resendCodeState; int get resetToken;
/// Create a copy of EmailVerificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailVerificationStateCopyWith<EmailVerificationState> get copyWith => _$EmailVerificationStateCopyWithImpl<EmailVerificationState>(this as EmailVerificationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerificationState&&(identical(other.emailVerificationState, emailVerificationState) || other.emailVerificationState == emailVerificationState)&&(identical(other.resendCodeState, resendCodeState) || other.resendCodeState == resendCodeState)&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken));
}


@override
int get hashCode => Object.hash(runtimeType,emailVerificationState,resendCodeState,resetToken);

@override
String toString() {
  return 'EmailVerificationState(emailVerificationState: $emailVerificationState, resendCodeState: $resendCodeState, resetToken: $resetToken)';
}


}

/// @nodoc
abstract mixin class $EmailVerificationStateCopyWith<$Res>  {
  factory $EmailVerificationStateCopyWith(EmailVerificationState value, $Res Function(EmailVerificationState) _then) = _$EmailVerificationStateCopyWithImpl;
@useResult
$Res call({
 BaseState<MessageEntity>? emailVerificationState, BaseState<MessageEntity>? resendCodeState, int resetToken
});




}
/// @nodoc
class _$EmailVerificationStateCopyWithImpl<$Res>
    implements $EmailVerificationStateCopyWith<$Res> {
  _$EmailVerificationStateCopyWithImpl(this._self, this._then);

  final EmailVerificationState _self;
  final $Res Function(EmailVerificationState) _then;

/// Create a copy of EmailVerificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? emailVerificationState = freezed,Object? resendCodeState = freezed,Object? resetToken = null,}) {
  return _then(_self.copyWith(
emailVerificationState: freezed == emailVerificationState ? _self.emailVerificationState : emailVerificationState // ignore: cast_nullable_to_non_nullable
as BaseState<MessageEntity>?,resendCodeState: freezed == resendCodeState ? _self.resendCodeState : resendCodeState // ignore: cast_nullable_to_non_nullable
as BaseState<MessageEntity>?,resetToken: null == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [EmailVerificationState].
extension EmailVerificationStatePatterns on EmailVerificationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmailVerificationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailVerificationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmailVerificationState value)  $default,){
final _that = this;
switch (_that) {
case _EmailVerificationState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmailVerificationState value)?  $default,){
final _that = this;
switch (_that) {
case _EmailVerificationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BaseState<MessageEntity>? emailVerificationState,  BaseState<MessageEntity>? resendCodeState,  int resetToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailVerificationState() when $default != null:
return $default(_that.emailVerificationState,_that.resendCodeState,_that.resetToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BaseState<MessageEntity>? emailVerificationState,  BaseState<MessageEntity>? resendCodeState,  int resetToken)  $default,) {final _that = this;
switch (_that) {
case _EmailVerificationState():
return $default(_that.emailVerificationState,_that.resendCodeState,_that.resetToken);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BaseState<MessageEntity>? emailVerificationState,  BaseState<MessageEntity>? resendCodeState,  int resetToken)?  $default,) {final _that = this;
switch (_that) {
case _EmailVerificationState() when $default != null:
return $default(_that.emailVerificationState,_that.resendCodeState,_that.resetToken);case _:
  return null;

}
}

}

/// @nodoc


class _EmailVerificationState implements EmailVerificationState {
  const _EmailVerificationState({this.emailVerificationState, this.resendCodeState, this.resetToken = 0});
  

@override final  BaseState<MessageEntity>? emailVerificationState;
@override final  BaseState<MessageEntity>? resendCodeState;
@override@JsonKey() final  int resetToken;

/// Create a copy of EmailVerificationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailVerificationStateCopyWith<_EmailVerificationState> get copyWith => __$EmailVerificationStateCopyWithImpl<_EmailVerificationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailVerificationState&&(identical(other.emailVerificationState, emailVerificationState) || other.emailVerificationState == emailVerificationState)&&(identical(other.resendCodeState, resendCodeState) || other.resendCodeState == resendCodeState)&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken));
}


@override
int get hashCode => Object.hash(runtimeType,emailVerificationState,resendCodeState,resetToken);

@override
String toString() {
  return 'EmailVerificationState(emailVerificationState: $emailVerificationState, resendCodeState: $resendCodeState, resetToken: $resetToken)';
}


}

/// @nodoc
abstract mixin class _$EmailVerificationStateCopyWith<$Res> implements $EmailVerificationStateCopyWith<$Res> {
  factory _$EmailVerificationStateCopyWith(_EmailVerificationState value, $Res Function(_EmailVerificationState) _then) = __$EmailVerificationStateCopyWithImpl;
@override @useResult
$Res call({
 BaseState<MessageEntity>? emailVerificationState, BaseState<MessageEntity>? resendCodeState, int resetToken
});




}
/// @nodoc
class __$EmailVerificationStateCopyWithImpl<$Res>
    implements _$EmailVerificationStateCopyWith<$Res> {
  __$EmailVerificationStateCopyWithImpl(this._self, this._then);

  final _EmailVerificationState _self;
  final $Res Function(_EmailVerificationState) _then;

/// Create a copy of EmailVerificationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? emailVerificationState = freezed,Object? resendCodeState = freezed,Object? resetToken = null,}) {
  return _then(_EmailVerificationState(
emailVerificationState: freezed == emailVerificationState ? _self.emailVerificationState : emailVerificationState // ignore: cast_nullable_to_non_nullable
as BaseState<MessageEntity>?,resendCodeState: freezed == resendCodeState ? _self.resendCodeState : resendCodeState // ignore: cast_nullable_to_non_nullable
as BaseState<MessageEntity>?,resetToken: null == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
