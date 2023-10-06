import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:maintenance_admin/domain/models/cleaners_response.dart';
import 'package:maintenance_admin/domain/models/unassigned_response_model.dart';

import 'api/api.dart';

class UnassignedRepo {
  API api = API();

  Future<List<UnassignedJobsResponse>> unassignedJobs(String token) async {
    try {
      Response response =
      await api.sendRequest.get("/cleaning/non-assigned-jobs",
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          }));

      return (response.data as List)
          .map((x) => UnassignedJobsResponse.fromJson(x))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

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

  Future<void> confirmJob(int jobId,int staffId,String token) async {
    var body ={
      "jobId": jobId,
      "staffId": staffId
    };
    try {
      await api.sendRequest.post("/cleaning/assign-job",
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          }),
          data: jsonEncode(body));
    } catch (ex) {
      rethrow;
    }
  }

}
