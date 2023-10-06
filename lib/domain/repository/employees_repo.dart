import 'dart:io';

import 'package:dio/dio.dart';
import 'package:maintenance_admin/domain/models/cleaners_response.dart';

import 'api/api.dart';

class EmployeesRepo {
  API api = API();


  Future<List<CleanersResponse>> cleaners(String token) async {
    try {
      Response response =
      await api.sendRequest.get("/cleaning/cleaners",
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          }));
      return (response.data as List)
          .map((x) => CleanersResponse.fromJson(x))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }
}
