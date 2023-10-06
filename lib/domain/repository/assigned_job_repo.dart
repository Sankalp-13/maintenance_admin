import 'dart:io';
import 'package:dio/dio.dart';
import 'package:maintenance_admin/domain/models/assigned_response_model.dart';
import 'api/api.dart';

class AssignedRepo {
  API api = API();

  Future<List<AssignedJobResponse>> assignedJobs(String token) async {
    try {
      Response response =
      await api.sendRequest.get("/cleaning/assigned-jobs",
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          }));

      return (response.data as List)
          .map((x) => AssignedJobResponse.fromJson(x))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<AssignedJobResponse>> completedJobs(String token) async {
    try {
      Response response =
      await api.sendRequest.get("/cleaning/completed-jobs",
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          }));

      return (response.data as List)
          .map((x) => AssignedJobResponse.fromJson(x))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

}
