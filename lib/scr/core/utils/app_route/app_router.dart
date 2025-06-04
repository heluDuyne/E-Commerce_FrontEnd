import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_frontend/scr/core/utils/app_route/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page),
    AutoRoute(page: CreateNewPasswordRoute.page),
    AutoRoute(page: VerificationCodeRoute.page),
    AutoRoute(page: CheckoutCardRoute.page),
    AutoRoute(page: CheckoutCompleteRoute.page),
<<<<<<< HEAD
<<<<<<< HEAD
    AutoRoute(page: MyOrderRoute.page),
    AutoRoute(page: OrderInfoRoute.page),
    AutoRoute(page: MyInfoRoute.page),
    AutoRoute(page: ProfileSettingRoute.page),
    AutoRoute(page: OrderInfoDeliveredRoute.page),
    AutoRoute(page: WelcomeRoute.page),
    AutoRoute(page: IntroRoute.page),
=======
    AutoRoute(page: MyOrderRoute.page, initial: true),
    AutoRoute(page: OrderInfoRoute.page),
    AutoRoute(page: MyInfoRoute.page),
    AutoRoute(page: OrderInfoDeliveredRoute.page),
>>>>>>> 4ccd20e (.imp new screens)
=======
    AutoRoute(page: MyOrderRoute.page),
    AutoRoute(page: OrderInfoRoute.page),
    AutoRoute(page: MyInfoRoute.page),
    AutoRoute(page: OrderInfoDeliveredRoute.page),
    AutoRoute(page:ProductFoundRoute.page, initial: true )
>>>>>>> 31ee4c1 ( imp. new screens)
  ];
}
