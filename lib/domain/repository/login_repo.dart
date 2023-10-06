import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'api/api.dart';

class LoginRepo {
  API api = API();

  Future<Response> login(String email) async {
    var body ={
      "email": email,
    };
    try {
      Response response =
      await api.sendRequest.post("/auth/staff-login",
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: jsonEncode(body));
      return response;
    } catch (ex) {
      rethrow;
    }
  }
  Future<Response> otp(String otpId,int otp) async {
    var body ={
      "otpId": otpId,
      "otp": otp
    };
    try {
      Response response =
      await api.sendRequest.post("/auth/otp",
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: jsonEncode(body));
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}
