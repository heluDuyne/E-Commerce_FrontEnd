// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:e_commerce_frontend/scr/presentation/screens/login_screen/login_screen.dart'
    as _i1;
import 'package:e_commerce_frontend/scr/presentation/screens/sign_up_screen/sign_up_screen.dart'
    as _i2;
import 'package:flutter/material.dart' as _i4;

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i3.PageRouteInfo<void> {
  const LoginRoute({List<_i3.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return _i1.LoginScreen();
    },
  );
}

/// generated route for
/// [_i2.SignUpScreen]
class SignUpRoute extends _i3.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({_i4.Key? key, List<_i3.PageRouteInfo>? children})
    : super(
        SignUpRoute.name,
        args: SignUpRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'SignUpRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignUpRouteArgs>(
        orElse: () => const SignUpRouteArgs(),
      );
      return _i2.SignUpScreen(key: args.key);
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
