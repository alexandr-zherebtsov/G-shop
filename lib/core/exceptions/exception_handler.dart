import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:g_shop/core/exceptions/exception_manager.dart';
import 'package:g_shop/core/managers/dio_manager.dart';
import 'package:g_shop/ui/utils/other_utils.dart';

void handleErrorApp(DioError error, JsonDecoder _decoder, {bool fromHomeOrSelected = false}) async {
  print(error.response.statusCode);
  if (error.error is SocketException)
    showSnackBar("SocketException", isError: true);
  else if (error.type == DioErrorType.RECEIVE_TIMEOUT ||
      error.type == DioErrorType.SEND_TIMEOUT ||
      error.type == DioErrorType.CONNECT_TIMEOUT) {
    showSnackBar("Internet connection", isError: true);
  } else if (error.response != null &&
      error.response.statusCode != null &&
      exceptions.containsKey(error.response.statusCode)) {
    if (error.response.statusCode == DioManager.UNAUTHORIZED_ERROR_CODE) {
      showSnackBar("UNAUTHORIZED_ERROR_CODE", isError: true);
    }
    if (error.response.statusCode == DioManager.INTERNAL_SERVER_ERROR_CODE) {
      showSnackBar("INTERNAL_SERVER_ERROR_CODE", isError: true);
    }
    if (error.response.statusCode == DioManager.BAD_REQUEST_ERROR_CODE) {
      showSnackBar("BAD_REQUEST_ERROR_CODE", isError: true);
    }
    if (error.response.statusCode == DioManager.SERVER_DO_NOT_WORK) {
      showSnackBar("SERVER_DO_NOT_WORK", isError: true);
    }
  }
}
