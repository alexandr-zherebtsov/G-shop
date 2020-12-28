import 'package:dio/dio.dart';
import 'package:g_shop/generated/locator.dart';

class DioManager {
  final _flavor = locator<Flavor>();

  static Dio _dioInstance;
  static const BAD_REQUEST_ERROR_CODE = 400;
  static const UNAUTHORIZED_ERROR_CODE = 401;
  static const FORBIDDEN_ERROR_CODE = 403;
  static const NOT_FOUND_ERROR_CODE = 404;
  static const INTERNAL_SERVER_ERROR_CODE = 500;
  static const SERVER_DO_NOT_WORK = 503;

  String temporaryToken;
}
