// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthEvents {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) loginWithEmail,
    required TResult Function(String nickname, String password) signUpWithemail,
    required TResult Function(SocialAuthType type) socialAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String password)? loginWithEmail,
    TResult? Function(String nickname, String password)? signUpWithemail,
    TResult? Function(SocialAuthType type)? socialAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? loginWithEmail,
    TResult Function(String nickname, String password)? signUpWithemail,
    TResult Function(SocialAuthType type)? socialAuth,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginWithEmail value) loginWithEmail,
    required TResult Function(SignUpWithEmail value) signUpWithemail,
    required TResult Function(SocialAuth value) socialAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginWithEmail value)? loginWithEmail,
    TResult? Function(SignUpWithEmail value)? signUpWithemail,
    TResult? Function(SocialAuth value)? socialAuth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginWithEmail value)? loginWithEmail,
    TResult Function(SignUpWithEmail value)? signUpWithemail,
    TResult Function(SocialAuth value)? socialAuth,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventsCopyWith<$Res> {
  factory $AuthEventsCopyWith(
          AuthEvents value, $Res Function(AuthEvents) then) =
      _$AuthEventsCopyWithImpl<$Res, AuthEvents>;
}

/// @nodoc
class _$AuthEventsCopyWithImpl<$Res, $Val extends AuthEvents>
    implements $AuthEventsCopyWith<$Res> {
  _$AuthEventsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoginWithEmailCopyWith<$Res> {
  factory _$$LoginWithEmailCopyWith(
          _$LoginWithEmail value, $Res Function(_$LoginWithEmail) then) =
      __$$LoginWithEmailCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$LoginWithEmailCopyWithImpl<$Res>
    extends _$AuthEventsCopyWithImpl<$Res, _$LoginWithEmail>
    implements _$$LoginWithEmailCopyWith<$Res> {
  __$$LoginWithEmailCopyWithImpl(
      _$LoginWithEmail _value, $Res Function(_$LoginWithEmail) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$LoginWithEmail(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginWithEmail implements LoginWithEmail {
  const _$LoginWithEmail({required this.email, required this.password});

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvents.loginWithEmail(email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginWithEmail &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginWithEmailCopyWith<_$LoginWithEmail> get copyWith =>
      __$$LoginWithEmailCopyWithImpl<_$LoginWithEmail>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) loginWithEmail,
    required TResult Function(String nickname, String password) signUpWithemail,
    required TResult Function(SocialAuthType type) socialAuth,
  }) {
    return loginWithEmail(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String password)? loginWithEmail,
    TResult? Function(String nickname, String password)? signUpWithemail,
    TResult? Function(SocialAuthType type)? socialAuth,
  }) {
    return loginWithEmail?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? loginWithEmail,
    TResult Function(String nickname, String password)? signUpWithemail,
    TResult Function(SocialAuthType type)? socialAuth,
    required TResult orElse(),
  }) {
    if (loginWithEmail != null) {
      return loginWithEmail(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginWithEmail value) loginWithEmail,
    required TResult Function(SignUpWithEmail value) signUpWithemail,
    required TResult Function(SocialAuth value) socialAuth,
  }) {
    return loginWithEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginWithEmail value)? loginWithEmail,
    TResult? Function(SignUpWithEmail value)? signUpWithemail,
    TResult? Function(SocialAuth value)? socialAuth,
  }) {
    return loginWithEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginWithEmail value)? loginWithEmail,
    TResult Function(SignUpWithEmail value)? signUpWithemail,
    TResult Function(SocialAuth value)? socialAuth,
    required TResult orElse(),
  }) {
    if (loginWithEmail != null) {
      return loginWithEmail(this);
    }
    return orElse();
  }
}

abstract class LoginWithEmail implements AuthEvents {
  const factory LoginWithEmail(
      {required final String email,
      required final String password}) = _$LoginWithEmail;

  String get email;
  String get password;
  @JsonKey(ignore: true)
  _$$LoginWithEmailCopyWith<_$LoginWithEmail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignUpWithEmailCopyWith<$Res> {
  factory _$$SignUpWithEmailCopyWith(
          _$SignUpWithEmail value, $Res Function(_$SignUpWithEmail) then) =
      __$$SignUpWithEmailCopyWithImpl<$Res>;
  @useResult
  $Res call({String nickname, String password});
}

/// @nodoc
class __$$SignUpWithEmailCopyWithImpl<$Res>
    extends _$AuthEventsCopyWithImpl<$Res, _$SignUpWithEmail>
    implements _$$SignUpWithEmailCopyWith<$Res> {
  __$$SignUpWithEmailCopyWithImpl(
      _$SignUpWithEmail _value, $Res Function(_$SignUpWithEmail) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
    Object? password = null,
  }) {
    return _then(_$SignUpWithEmail(
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SignUpWithEmail implements SignUpWithEmail {
  const _$SignUpWithEmail({required this.nickname, required this.password});

  @override
  final String nickname;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvents.signUpWithemail(nickname: $nickname, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpWithEmail &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nickname, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpWithEmailCopyWith<_$SignUpWithEmail> get copyWith =>
      __$$SignUpWithEmailCopyWithImpl<_$SignUpWithEmail>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) loginWithEmail,
    required TResult Function(String nickname, String password) signUpWithemail,
    required TResult Function(SocialAuthType type) socialAuth,
  }) {
    return signUpWithemail(nickname, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String password)? loginWithEmail,
    TResult? Function(String nickname, String password)? signUpWithemail,
    TResult? Function(SocialAuthType type)? socialAuth,
  }) {
    return signUpWithemail?.call(nickname, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? loginWithEmail,
    TResult Function(String nickname, String password)? signUpWithemail,
    TResult Function(SocialAuthType type)? socialAuth,
    required TResult orElse(),
  }) {
    if (signUpWithemail != null) {
      return signUpWithemail(nickname, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginWithEmail value) loginWithEmail,
    required TResult Function(SignUpWithEmail value) signUpWithemail,
    required TResult Function(SocialAuth value) socialAuth,
  }) {
    return signUpWithemail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginWithEmail value)? loginWithEmail,
    TResult? Function(SignUpWithEmail value)? signUpWithemail,
    TResult? Function(SocialAuth value)? socialAuth,
  }) {
    return signUpWithemail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginWithEmail value)? loginWithEmail,
    TResult Function(SignUpWithEmail value)? signUpWithemail,
    TResult Function(SocialAuth value)? socialAuth,
    required TResult orElse(),
  }) {
    if (signUpWithemail != null) {
      return signUpWithemail(this);
    }
    return orElse();
  }
}

abstract class SignUpWithEmail implements AuthEvents {
  const factory SignUpWithEmail(
      {required final String nickname,
      required final String password}) = _$SignUpWithEmail;

  String get nickname;
  String get password;
  @JsonKey(ignore: true)
  _$$SignUpWithEmailCopyWith<_$SignUpWithEmail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SocialAuthCopyWith<$Res> {
  factory _$$SocialAuthCopyWith(
          _$SocialAuth value, $Res Function(_$SocialAuth) then) =
      __$$SocialAuthCopyWithImpl<$Res>;
  @useResult
  $Res call({SocialAuthType type});
}

/// @nodoc
class __$$SocialAuthCopyWithImpl<$Res>
    extends _$AuthEventsCopyWithImpl<$Res, _$SocialAuth>
    implements _$$SocialAuthCopyWith<$Res> {
  __$$SocialAuthCopyWithImpl(
      _$SocialAuth _value, $Res Function(_$SocialAuth) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_$SocialAuth(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SocialAuthType,
    ));
  }
}

/// @nodoc

class _$SocialAuth implements SocialAuth {
  const _$SocialAuth({required this.type});

  @override
  final SocialAuthType type;

  @override
  String toString() {
    return 'AuthEvents.socialAuth(type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialAuth &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialAuthCopyWith<_$SocialAuth> get copyWith =>
      __$$SocialAuthCopyWithImpl<_$SocialAuth>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) loginWithEmail,
    required TResult Function(String nickname, String password) signUpWithemail,
    required TResult Function(SocialAuthType type) socialAuth,
  }) {
    return socialAuth(type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String password)? loginWithEmail,
    TResult? Function(String nickname, String password)? signUpWithemail,
    TResult? Function(SocialAuthType type)? socialAuth,
  }) {
    return socialAuth?.call(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? loginWithEmail,
    TResult Function(String nickname, String password)? signUpWithemail,
    TResult Function(SocialAuthType type)? socialAuth,
    required TResult orElse(),
  }) {
    if (socialAuth != null) {
      return socialAuth(type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginWithEmail value) loginWithEmail,
    required TResult Function(SignUpWithEmail value) signUpWithemail,
    required TResult Function(SocialAuth value) socialAuth,
  }) {
    return socialAuth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginWithEmail value)? loginWithEmail,
    TResult? Function(SignUpWithEmail value)? signUpWithemail,
    TResult? Function(SocialAuth value)? socialAuth,
  }) {
    return socialAuth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginWithEmail value)? loginWithEmail,
    TResult Function(SignUpWithEmail value)? signUpWithemail,
    TResult Function(SocialAuth value)? socialAuth,
    required TResult orElse(),
  }) {
    if (socialAuth != null) {
      return socialAuth(this);
    }
    return orElse();
  }
}

abstract class SocialAuth implements AuthEvents {
  const factory SocialAuth({required final SocialAuthType type}) = _$SocialAuth;

  SocialAuthType get type;
  @JsonKey(ignore: true)
  _$$SocialAuthCopyWith<_$SocialAuth> get copyWith =>
      throw _privateConstructorUsedError;
}
