// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:e_commerce_frontend/scr/presentation/screens/checkout_card_screen/checkout_card_screen.dart'
    as _i1;
import 'package:e_commerce_frontend/scr/presentation/screens/checkout_complete_screen/checkout_complete_screen.dart'
    as _i2;
import 'package:e_commerce_frontend/scr/presentation/screens/checkout_screen/checkout_screen.dart'
    as _i3;
import 'package:e_commerce_frontend/scr/presentation/screens/create_new_password_screen/create_new_password_screen.dart'
    as _i4;
import 'package:e_commerce_frontend/scr/presentation/screens/forgot_password_screen/forgot_password_screen.dart'
    as _i5;
import 'package:e_commerce_frontend/scr/presentation/screens/login_screen/login_screen.dart'
    as _i6;
import 'package:e_commerce_frontend/scr/presentation/screens/my_info_screen/my_info_screen.dart'
    as _i7;
import 'package:e_commerce_frontend/scr/presentation/screens/my_order_screen/my_order_screen.dart'
    as _i8;
import 'package:e_commerce_frontend/scr/presentation/screens/my_wishlist_screen/my_wishlist_screen.dart'
    as _i9;
import 'package:e_commerce_frontend/scr/presentation/screens/notification_screen/notification_screen.dart'
    as _i10;
import 'package:e_commerce_frontend/scr/presentation/screens/order_info_delivered_screen/order_info_delivered_screen.dart'
    as _i11;
import 'package:e_commerce_frontend/scr/presentation/screens/order_info_screen/order_info_screen.dart'
    as _i12;
import 'package:e_commerce_frontend/scr/presentation/screens/profile_setting_screen/profile_setting_screen.dart'
    as _i13;
import 'package:e_commerce_frontend/scr/presentation/screens/sign_up_screen/sign_up_screen.dart'
    as _i14;
import 'package:e_commerce_frontend/scr/presentation/screens/splash_screen/splash_screen.dart'
    as _i15;
import 'package:e_commerce_frontend/scr/presentation/screens/verification_code_screen/verification_code_screen.dart'
    as _i16;
import 'package:flutter/material.dart' as _i18;

/// generated route for
/// [_i1.CheckoutCardScreen]
class CheckoutCardRoute extends _i17.PageRouteInfo<void> {
  const CheckoutCardRoute({List<_i17.PageRouteInfo>? children})
    : super(CheckoutCardRoute.name, initialChildren: children);

  static const String name = 'CheckoutCardRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i1.CheckoutCardScreen();
    },
  );
}

/// generated route for
/// [_i2.CheckoutCompleteScreen]
class CheckoutCompleteRoute extends _i17.PageRouteInfo<void> {
  const CheckoutCompleteRoute({List<_i17.PageRouteInfo>? children})
    : super(CheckoutCompleteRoute.name, initialChildren: children);

  static const String name = 'CheckoutCompleteRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i2.CheckoutCompleteScreen();
    },
  );
}

/// generated route for
/// [_i3.CheckoutScreen]
class CheckoutRoute extends _i17.PageRouteInfo<void> {
  const CheckoutRoute({List<_i17.PageRouteInfo>? children})
    : super(CheckoutRoute.name, initialChildren: children);

  static const String name = 'CheckoutRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i3.CheckoutScreen();
    },
  );
}

/// generated route for
/// [_i4.CreateNewPasswordScreen]
class CreateNewPasswordRoute extends _i17.PageRouteInfo<void> {
  const CreateNewPasswordRoute({List<_i17.PageRouteInfo>? children})
    : super(CreateNewPasswordRoute.name, initialChildren: children);

  static const String name = 'CreateNewPasswordRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i4.CreateNewPasswordScreen();
    },
  );
}

/// generated route for
/// [_i5.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i17.PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({_i18.Key? key, List<_i17.PageRouteInfo>? children})
    : super(
        ForgotPasswordRoute.name,
        args: ForgotPasswordRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'ForgotPasswordRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotPasswordRouteArgs>(
        orElse: () => const ForgotPasswordRouteArgs(),
      );
      return _i5.ForgotPasswordScreen(key: args.key);
    },
  );
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'ForgotPasswordRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.LoginScreen]
class LoginRoute extends _i17.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i18.Key? key, List<_i17.PageRouteInfo>? children})
    : super(
        LoginRoute.name,
        args: LoginRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'LoginRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i6.LoginScreen(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.MyInfoScreen]
class MyInfoRoute extends _i17.PageRouteInfo<void> {
  const MyInfoRoute({List<_i17.PageRouteInfo>? children})
    : super(MyInfoRoute.name, initialChildren: children);

  static const String name = 'MyInfoRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i7.MyInfoScreen();
    },
  );
}

/// generated route for
/// [_i8.MyOrderScreen]
class MyOrderRoute extends _i17.PageRouteInfo<void> {
  const MyOrderRoute({List<_i17.PageRouteInfo>? children})
    : super(MyOrderRoute.name, initialChildren: children);

  static const String name = 'MyOrderRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i8.MyOrderScreen();
    },
  );
}

/// generated route for
/// [_i9.MyWishlistScreen]
class MyWishlistRoute extends _i17.PageRouteInfo<void> {
  const MyWishlistRoute({List<_i17.PageRouteInfo>? children})
    : super(MyWishlistRoute.name, initialChildren: children);

  static const String name = 'MyWishlistRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i9.MyWishlistScreen();
    },
  );
}

/// generated route for
/// [_i10.NotificationScreen]
class NotificationRoute extends _i17.PageRouteInfo<void> {
  const NotificationRoute({List<_i17.PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i10.NotificationScreen();
    },
  );
}

/// generated route for
/// [_i11.OrderInfoDeliveredScreen]
class OrderInfoDeliveredRoute
    extends _i17.PageRouteInfo<OrderInfoDeliveredRouteArgs> {
  OrderInfoDeliveredRoute({
    _i18.Key? key,
    required String orderNumber,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         OrderInfoDeliveredRoute.name,
         args: OrderInfoDeliveredRouteArgs(key: key, orderNumber: orderNumber),
         initialChildren: children,
       );

  static const String name = 'OrderInfoDeliveredRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderInfoDeliveredRouteArgs>();
      return _i11.OrderInfoDeliveredScreen(
        key: args.key,
        orderNumber: args.orderNumber,
      );
    },
  );
}

class OrderInfoDeliveredRouteArgs {
  const OrderInfoDeliveredRouteArgs({this.key, required this.orderNumber});

  final _i18.Key? key;

  final String orderNumber;

  @override
  String toString() {
    return 'OrderInfoDeliveredRouteArgs{key: $key, orderNumber: $orderNumber}';
  }
}

/// generated route for
/// [_i12.OrderInfoScreen]
class OrderInfoRoute extends _i17.PageRouteInfo<OrderInfoRouteArgs> {
  OrderInfoRoute({
    _i18.Key? key,
    required String orderNumber,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         OrderInfoRoute.name,
         args: OrderInfoRouteArgs(key: key, orderNumber: orderNumber),
         initialChildren: children,
       );

  static const String name = 'OrderInfoRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderInfoRouteArgs>();
      return _i12.OrderInfoScreen(key: args.key, orderNumber: args.orderNumber);
    },
  );
}

class OrderInfoRouteArgs {
  const OrderInfoRouteArgs({this.key, required this.orderNumber});

  final _i18.Key? key;

  final String orderNumber;

  @override
  String toString() {
    return 'OrderInfoRouteArgs{key: $key, orderNumber: $orderNumber}';
  }
}

/// generated route for
/// [_i13.ProfileSettingScreen]
class ProfileSettingRoute extends _i17.PageRouteInfo<void> {
  const ProfileSettingRoute({List<_i17.PageRouteInfo>? children})
    : super(ProfileSettingRoute.name, initialChildren: children);

  static const String name = 'ProfileSettingRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i13.ProfileSettingScreen();
    },
  );
}

/// generated route for
/// [_i14.SignUpScreen]
class SignUpRoute extends _i17.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({_i18.Key? key, List<_i17.PageRouteInfo>? children})
    : super(
        SignUpRoute.name,
        args: SignUpRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'SignUpRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignUpRouteArgs>(
        orElse: () => const SignUpRouteArgs(),
      );
      return _i14.SignUpScreen(key: args.key);
    },
  );
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.SplashScreen]
class SplashRoute extends _i17.PageRouteInfo<void> {
  const SplashRoute({List<_i17.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i15.SplashScreen();
    },
  );
}

/// generated route for
/// [_i16.VerificationCodeScreen]
class VerificationCodeRoute
    extends _i17.PageRouteInfo<VerificationCodeRouteArgs> {
  VerificationCodeRoute({
    required String email,
    _i18.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         VerificationCodeRoute.name,
         args: VerificationCodeRouteArgs(email: email, key: key),
         initialChildren: children,
       );

  static const String name = 'VerificationCodeRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VerificationCodeRouteArgs>();
      return _i16.VerificationCodeScreen(email: args.email, key: args.key);
    },
  );
}

class VerificationCodeRouteArgs {
  const VerificationCodeRouteArgs({required this.email, this.key});

  final String email;

  final _i18.Key? key;

  @override
  String toString() {
    return 'VerificationCodeRouteArgs{email: $email, key: $key}';
  }
}
