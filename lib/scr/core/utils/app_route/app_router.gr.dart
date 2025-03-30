// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:e_commerce_frontend/scr/presentation/screens/create_new_password_screen/create_new_password_screen.dart'
    as _i1;
import 'package:e_commerce_frontend/scr/presentation/screens/forgot_password_screen/forgot_password_screen.dart'
    as _i2;

/// generated route for
/// [_i2.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i6.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i6.PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute({List<_i6.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {

    },
  );
}



  static const String name = 'SignUpRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.SignUpScreen();
    },
  );
}

/// generated route for
/// [_i5.VerificationCodeScreen]
class VerificationCodeRoute extends _i6.PageRouteInfo<void> {
  const VerificationCodeRoute({List<_i6.PageRouteInfo>? children})
    : super(VerificationCodeRoute.name, initialChildren: children);

  static const String name = 'VerificationCodeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {

    },
  );
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final _i4.Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}
