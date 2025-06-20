// ignore_for_file: constant_identifier_names

class API {
  // static const BASE_URL =
  //     'http://ec2-3-106-228-237.ap-southeast-2.compute.amazonaws.com/api';
  static const BASE_URL = 'http://10.0.2.2:8080/api';

  static const OAUTH = '/oauth/auth/';
  static const LOGIN = '/user/login/';
  static const SIGNUP = '/user/sign-up/';

  static const VERIFY_EMAIL = '/verify/verify-email/';
  static const RESEND_VERIFICATION_CODE = '/verify/resend-verification-code/';

  static const USER = '/user/me/';

  static const PRODUCT = '/product/products/generic';
}
